package kade.hex.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import funkin.Paths;
import funkin.Paths.PathsFunction;
import funkin.Assets;
import funkin.audio.FunkinSound;
import funkin.data.song.SongRegistry;
import funkin.data.story.level.LevelRegistry;
import funkin.graphics.FunkinCamera;
import funkin.graphics.FunkinSprite;
import funkin.play.PlayStatePlaylist;
import funkin.play.scoring.Scoring;
import funkin.play.scoring.Scoring.ScoringRank;
import funkin.play.song.Song;
import funkin.play.song.Song.SongDifficulty;
import funkin.save.Save;
import funkin.save.Save.SaveScoreData;
import funkin.ui.MusicBeatState;
import funkin.ui.story.Level;
import funkin.ui.transition.LoadingState;
import kade.hex.menus.Anim;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.freeplay.CapsuleLeft;
import kade.hex.objects.freeplay.CapsuleRight;
import kade.hex.objects.freeplay.FreeplayPopUp;
import kade.hex.objects.freeplay.HexSort;
import kade.hex.util.HexTouch;

class HexFreeplay extends MusicBeatState
{
  var bg:FlxSprite;
  var scaryBG:FlxSprite;
  var transition:HexTransitional;
  var hasPlayedIn:Bool = false;

  var originIds:Array<String> = [];
  public var origins:Array<String> = [];
  public var songs:Array<Song> = [];

  // The songs the current filter lets through, rebuilt only when the filter or the list changes.
  var visibleSongs:Array<Song> = [];

  public var savedDiff:Int = 2;

  public static var lastSongId:String = null;
  public static var lastDiff:Int = -1;
  public static var lastNewVariation:Bool = false;

  var logoOffsets:Map<String, Array<Int>> = [
    "dunk" => [0, -24],
    "ram" => [0, -52],
    "hello-world" => [0, -32],
    "glitcher" => [0, -32],
    "encore" => [-16, -4],
    "cooling" => [-4, -60],
    "detected" => [4, -36],
    "java" => [0, -28],
    "lcd" => [0, 16],
    "glitcher-remix" => [0, -16],
    "thatretrosong" => [-4, -16],
    "eye2eye" => [4, -4],
    "rightpace" => [4, 0],
    "bombs-n-combs" => [-4, 12],
    "lan" => [-8, -48],
    "hexcript" => [-12, -36],
    "headbasher" => [12, -8],
    "tangerine" => [-20, 0]
  ];

  var stickerSongs:Map<String, Int> = new Map();
  var stickerArray:Array<FlxSprite> = [];

  // 0 = all, 1 = Week X, 2 = Weekend X, 3 = Event X, 4 = Freeplay Exclusive
  public var filter(default, set):Int = 0;

  var diffIds:Array<String> = ["easy", "normal", "hard", "technical", "erect"];
  var diffVariations:Array<String> = ["default", "default", "default", "default", "erect"];

  // Levels that shipped with a "new" version of their songs.
  var versionLevels:Array<String> = ["Week X", "Week X Encore", "Weekend X", "Weekend X Freeplay"];
  var levelOrder:Array<String> = ["Week X", "Week X Encore", "Weekend X", "Weekend X Freeplay", "Event Week", "Event Week Freeplay"];

  var songIndex:Int = 0;

  var currentSong(get, never):Song;
  var currentDifficulty(get, never):SongDifficulty;

  var circleStart:Float = 0;

  var circleIn:Bool = false;
  var circleOut:Bool = false;

  var capsuleLeft:CapsuleLeft;
  var capsuleRight:CapsuleRight;

  var theTv:FunkinSprite;
  var theScaryTV:FunkinSprite;
  var tvDiff:FunkinSprite;
  var logo:FunkinSprite;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;
  var controlsText:FlxSprite;
  var controlsTop:FlxSprite;
  var freeplayWatermark:FlxSprite;
  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var realTime:Float = 0;

  var camPopUp:FunkinCamera;
  var popUp:FreeplayPopUp;

  public var useNewVariation:Bool = false;

  var changeSticker:Bool = true;
  var intoSong:Bool = false;
  var isTransitioning:Bool = false;
  var noticeJustClosed:Bool = false;

  var previewTimers:Array<FlxTimer> = [];

  var usedStickers:Array<String> = [];
  var stickerPaths:Array<String> = [];

  public function new()
  {
    super();
  }

  public function select_song_by_id(songId:String):Void
  {
    for (i in 0...songs.length)
    {
      if (songs[i].id == songId)
      {
        songIndex = i;
        return;
      }
    }
  }

  public function get_diff_id():String
  {
    var index:Int = capsuleLeft.getDifficulty();
    if (index < 0 || index >= diffIds.length) index = 0;
    return diffIds[index];
  }

  public function get_diff_variation():String
  {
    var index:Int = capsuleLeft.getDifficulty();
    if (index < 0 || index >= diffVariations.length) index = 0;
    return diffVariations[index];
  }

  // Which difficulty indices a song actually ships a chart for.
  public function getValidDiffs(song:Song):Array<Int>
  {
    var valid:Array<Int> = [];

    if (song != null)
    {
      for (i in 0...diffIds.length)
      {
        if (song.getDifficulty(diffIds[i], diffVariations[i]) != null) valid.push(i);
      }
    }

    if (valid.length == 0) valid = [2];

    return valid;
  }

  public function get_song_score():Null<SaveScoreData>
  {
    if (currentSong == null || currentDifficulty == null) return null;

    return Save.instance.getSongScore(currentSong.id, get_diff_id(), get_score_variation());
  }

  // The variation scores and the tag are read from, "new" only when the song has one.
  public function get_score_variation():String
  {
    if (useNewVariation && has_new_version()) return "new";
    return get_diff_variation();
  }

  // Only the V toggle animates the tag out, anything else hides it right away.
  function refresh_version(animateOut:Bool = false):Void
  {
    capsuleLeft.setVersionTag(useNewVariation && has_new_version(), !animateOut);
    var songScore:Null<SaveScoreData> = get_song_score();
    capsuleLeft.setScore(songScore != null ? songScore.score : 0);
    set_badge_rank();
  }

  public function get_clear_percentage():Float
  {
    if (currentSong == null || currentDifficulty == null) return 0.0;

    var songScore:Null<SaveScoreData> = get_song_score();
    if (songScore == null) return 0.0;

    return Scoring.tallyCompletion(songScore.tallies);
  }

  public function set_badge_rank():Void
  {
    var rank:Null<ScoringRank> = Save.instance.getSongRank(currentSong.id, get_diff_id(), get_score_variation());
    if (rank == null)
    {
      capsuleLeft.setBadge(-1);
      return;
    }

    var rankValue:Int = -1;
    switch (rank)
    {
      case PERFECT_GOLD:
        rankValue = 5;
      case PERFECT:
        rankValue = 4;
      case EXCELLENT:
        rankValue = 3;
      case GREAT:
        rankValue = 2;
      case GOOD:
        rankValue = 1;
      case SHIT:
        rankValue = 0;
    }
    capsuleLeft.setBadge(rankValue);
  }

  public function get_current_sticker():FlxSprite
  {
    if (currentSong == null) return null;

    var idx:Null<Int> = stickerSongs.get(currentSong.id);
    if (idx == null) return null;
    return stickerArray[idx];
  }

  public function set_capsule_song(sound:Bool = true):Void
  {
    Anim.play(theTv, "trans", true);
    Anim.play(theScaryTV, "trans", true);

    if (sound) FunkinSound.playOnce(Paths.sound("ui/hex/sounds/tvStaticSelect"), 0.8);

    theScaryTV.visible = currentSong.id == "eye2eye";

    capsuleLeft.validDiffs = getValidDiffs(currentSong);
    capsuleLeft.setDifficulty(capsuleLeft.getDifficulty());

    capsuleLeft.setSong(currentSong, currentDifficulty, get_origin(), get_clear_percentage());
    refresh_version();

    var sticker:FlxSprite = get_current_sticker();
    if (sticker != null)
    {
      sticker.x = theTv.x + (theTv.width / 2) + 100;
      sticker.y = theTv.y + theTv.height - (sticker.height / 2) - 350;
      if (changeSticker)
      {
        sticker.alpha = 0;
        changeSticker = false;
      }
    }

    if (!sound)
    {
      logo.alpha = 1;
      if (sticker != null) sticker.alpha = 1;
      Anim.finish(theTv);
      Anim.finish(theScaryTV);
    }
  }

  function set_filter(value:Int):Int
  {
    filter = value;
    songIndex = 0;
    rebuildVisible();
    capsuleRight.allSort.setSelected(filter);
    if (currentSong == null)
    {
      FlxG.log.warn("No songs available for selection with the current filter.");
      return value;
    }
    isTransitioning = true;

    logo.alpha = 0;

    set_capsule_song(true);
    return value;
  }

  public function get_origin():String
  {
    if (currentSong == null) return "";
    if (filter == 0) return origins[songIndex];

    switch (filter)
    {
      case 1:
        return "Week X";
      case 2:
        return "Weekend X";
      case 3:
        return "Event X";
      case 4:
        return "Freeplay";
    }

    return "";
  }

  public function get_current_level_id():String
  {
    if (currentSong == null) return "";

    return originIds[songs.indexOf(currentSong)];
  }

  public function has_new_version():Bool
  {
    if (currentSong == null) return false;

    if (!versionLevels.contains(get_current_level_id())) return false;

    var newDifficulty:Null<SongDifficulty> = currentSong.getDifficulty(get_diff_id(), "new");
    return newDifficulty != null && newDifficulty.variation == "new";
  }

  function filterSong(index:Int):Bool
  {
    if (filter == 0) return true;

    var origin:String = origins[index];

    switch (filter)
    {
      case 1:
        return StringTools.contains(origin, "Week X");
      case 2:
        return StringTools.contains(origin, "Weekend X");
      case 3:
        return StringTools.contains(origin, "Event X");
      case 4:
        return StringTools.contains(origin, "Freeplay");
    }

    return false;
  }

  function rebuildVisible():Void
  {
    visibleSongs = [];
    for (i in 0...songs.length)
    {
      if (filterSong(i)) visibleSongs.push(songs[i]);
    }
  }

  function get_currentSong():Song
  {
    if (visibleSongs.length == 0) return null;

    return visibleSongs[songIndex % visibleSongs.length];
  }

  function get_currentDifficulty():SongDifficulty
  {
    var song:Song = currentSong;
    if (song == null) return null;

    var diffId:String = get_diff_id();
    var diff:Null<SongDifficulty> = song.getDifficulty(diffId, get_diff_variation());

    if (diff == null)
    {
      capsuleLeft.setDifficulty(capsuleLeft.validDiffs[0]);
      diffId = get_diff_id();
      diff = song.getDifficulty(diffId, get_diff_variation());
    }

    if (!Anim.has(tvDiff, diffId))
    {
      tvDiff.visible = false;
    }
    else if (Anim.name(tvDiff) != diffId || !tvDiff.visible)
    {
      tvDiff.visible = true;
      Anim.play(tvDiff, diffId, true);
      if (diffId == "erect") tvDiff.offset.set(7, 7);
      else tvDiff.offset.set(0, 0);
    }

    if (useNewVariation && has_new_version())
    {
      var newDiff:Null<SongDifficulty> = song.getDifficulty(diffId, "new");
      if (newDiff != null) diff = newDiff;
    }

    return diff;
  }

  public function gatherSongs():Void
  {
    songs = [];
    origins = [];
    originIds = [];

    var levelIds:Array<String> = levelOrder.copy();
    for (levelId in LevelRegistry.instance.listSortedLevelIds())
    {
      if (!levelIds.contains(levelId)) levelIds.push(levelId);
    }

    for (levelId in levelIds)
    {
      var level:Null<Level> = LevelRegistry.instance.fetchEntry(levelId);
      if (level == null) continue;

      @:privateAccess
      var data = level._data;

      if (!StringTools.startsWith(data.name, "(Hex) ")) continue;

      for (songId in data.songs)
      {
        var song:Null<Song> = SongRegistry.instance.fetchEntry(songId, {variation: "default"});
        if (song != null && !songs.contains(song))
        {
          var culledName:String = StringTools.replace(data.name, "(Hex) ", "");
          origins.push(culledName);
          originIds.push(levelId);
          songs.push(song);
        }
      }
    }

    rebuildVisible();
  }

  function getStickerPath(songId:String):String
  {
    switch (songId)
    {
      case "detected":
        return "stickersBfIris";
      case "glitcher-remix":
        return "stickersBfIris";
      case "thatretrosong":
        return "stickersHexRichard";
      case "eye2eye":
        return "stickersHexIris";
      case "rightpace":
        return "stickersHex";
      case "bombs-n-combs":
        return "stickersHexWhittyCarol";
      case "lan":
        return "stickersHexCyrixStatic";
      case "headbasher":
        return "stickersBfHexSlasher";
      case "tangerine":
        return "stickersBfCoda";
      default:
        return "stickersBfHex";
    }
  }

  function setStickers():Void
  {
    for (song in songs)
    {
      var path:String = getStickerPath(song.id);

      if (usedStickers.contains(path))
      {
        for (sticker in stickerArray)
        {
          if (stickerPaths[stickerArray.indexOf(sticker)] == path)
          {
            stickerArray.push(sticker);
            stickerSongs.set(song.id, stickerArray.indexOf(sticker));
            stickerPaths.push(path);
            break;
          }
        }
        continue;
      }

      var sticker:FlxSprite = new FlxSprite();
      sticker.loadGraphic(Paths.image("ui/hex/hex_freeplay/stickers/" + path));
      sticker.scale.set(0.5, 0.5);
      sticker.scrollFactor.set();
      sticker.updateHitbox();
      sticker.visible = false;

      stickerPaths.push(path);
      usedStickers.push(path);
      stickerArray.push(sticker);
      stickerSongs.set(song.id, stickerArray.length - 1);
    }
  }

  override public function create():Void
  {
    super.create();

    gatherSongs();
    setStickers();

    if (lastSongId != null)
    {
      select_song_by_id(lastSongId);
      if (lastDiff >= 0) savedDiff = lastDiff;
      useNewVariation = lastNewVariation;
    }

    bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image("ui/hex/hex_freeplay/bg"));
    add(bg);
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.scrollFactor.set();
    bg.updateHitbox();

    scaryBG = new FlxSprite(0, 0);
    scaryBG.alpha = 0;
    scaryBG.loadGraphic(Paths.image("ui/hex/hex_freeplay/bgEye"));
    add(scaryBG);
    scaryBG.setGraphicSize(FlxG.width, FlxG.height);
    scaryBG.scrollFactor.set();
    scaryBG.updateHitbox();

    theTv = FunkinSprite.createSparrow(570, 30, "ui/hex/hex_freeplay/tv");
    add(theTv);
    theTv.scale.set(0.65, 0.65);
    theTv.scrollFactor.set();
    theTv.updateHitbox();

    Anim.addByPrefix(theTv, "idle", "tv.png", 24, true);
    Anim.addByPrefix(theTv, "trans", "tvSongTransition", 24, false);
    Anim.addByPrefix(theTv, "select", "tvSongSelection", 24, false);
    Anim.play(theTv, "idle");

    Anim.onFinish(theTv, tvAnimFinish);

    theScaryTV = FunkinSprite.createSparrow(theTv.x, theTv.y, "ui/hex/hex_freeplay/tvIris");
    theScaryTV.scale.set(0.65, 0.65);
    theScaryTV.scrollFactor.set();
    theScaryTV.updateHitbox();
    add(theScaryTV);

    Anim.addByPrefix(theScaryTV, "idle", "tvIris.png", 24, true);
    Anim.addByPrefix(theScaryTV, "trans", "tvIrisSongTransition", 24, false);
    Anim.addByPrefix(theScaryTV, "select", "tvIrisSongSelection", 24, false);
    Anim.play(theScaryTV, "idle");
    theScaryTV.visible = false;

    logo = FunkinSprite.createSparrow(theTv.x + (theTv.width / 2) - 10, theTv.y + 20, "ui/hex/hex_freeplay/songlogos");

    Anim.addByPrefix(logo, "bit", "bit", 24, true);
    Anim.addByPrefix(logo, "bombs-n-combs", "bombs-n-combs", 24, true);
    Anim.addByPrefix(logo, "cooling", "cooling", 24, true);
    Anim.addByPrefix(logo, "encore", "encore", 24, true);
    Anim.addByPrefix(logo, "detected", "detected", 24, true);
    Anim.addByPrefix(logo, "dunk", "dunk", 24, true);
    Anim.addByPrefix(logo, "eye2eye", "eye2eye", 24, true);
    Anim.addByPrefix(logo, "glitcher", "glitcher-reg", 24, true);
    Anim.addByPrefix(logo, "glitcher-remix", "glitcher-remix", 24, true);
    Anim.addByPrefix(logo, "headbasher", "headbasher", 24, true);
    Anim.addByPrefix(logo, "hello-world", "hello-world", 24, true);
    Anim.addByPrefix(logo, "hexcript", "hexcript", 24, true);
    Anim.addByPrefix(logo, "java", "java", 24, true);
    Anim.addByPrefix(logo, "jumpin", "jumpin", 24, true);
    Anim.addByPrefix(logo, "lan", "lan", 24, true);
    Anim.addByPrefix(logo, "lcd", "lcd", 24, true);
    Anim.addByPrefix(logo, "ram", "ram", 24, true);
    Anim.addByPrefix(logo, "rightpace", "right-pace", 24, true);
    Anim.addByPrefix(logo, "tangerine", "tangerine", 24, true);
    Anim.addByPrefix(logo, "thatretrosong", "that-retro-song", 24, true);

    add(logo);
    logo.scale.set(0.65, 0.65);
    logo.x -= 250;
    logo.y += 180;
    logo.alpha = 0;
    logo.scrollFactor.set();

    tvDiff = FunkinSprite.createSparrow(theTv.x + (theTv.width / 2) - 30, theTv.y + 320, "ui/hex/hex_freeplay/df_text");
    tvDiff.scale.set(0.65, 0.65);
    add(tvDiff);

    Anim.addByPrefix(tvDiff, "easy", "easySelect", 24, false);
    Anim.addByPrefix(tvDiff, "normal", "normSelect", 24, false);
    Anim.addByPrefix(tvDiff, "hard", "hardSelect", 24, false);
    Anim.addByPrefix(tvDiff, "technical", "techSelect", 24, false);
    Anim.addByPrefix(tvDiff, "erect", "erectSelect", 24, false);

    Anim.play(tvDiff, "hard");

    capsuleLeft = new CapsuleLeft();
    add(capsuleLeft);

    capsuleRight = new CapsuleRight();
    add(capsuleRight);

    capsuleLeft.resetMembers();
    capsuleRight.resetMembers();

    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    topBar.scrollFactor.set();
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    bottomBar.scrollFactor.set();
    add(bottomBar);

    controlsText = new FlxSprite(10, FlxG.height - 34);
    controlsText.loadGraphic(Paths.image("ui/hex/hex_freeplay/controlsText"));
    controlsText.scrollFactor.set();
    controlsText.scale.set(0.6, 0.6);
    controlsText.updateHitbox();
    controlsText.alpha = 0;
    add(controlsText);

    freeplayWatermark = new FlxSprite(0, 8);
    freeplayWatermark.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplay"));
    freeplayWatermark.scrollFactor.set();
    freeplayWatermark.scale.set(0.75, 0.75);
    freeplayWatermark.updateHitbox();
    freeplayWatermark.alpha = 0;
    add(freeplayWatermark);

    freeplayWatermark.x = FlxG.width - (freeplayWatermark.width + 18);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/hex_freeplay/circleTop"));
    topCircle.scrollFactor.set();
    add(topCircle);

    topCircle.scale.set(0.7, 0.7);

    topCircle.x = -topCircle.width * 0.18;
    topCircle.y = -topCircle.height;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/hex_freeplay/circleBot"));
    bottomCircle.scrollFactor.set();
    add(bottomCircle);

    bottomCircle.scale.set(0.7, 0.7);

    bottomCircle.x = FlxG.width - bottomCircle.width * 0.85;
    bottomCircle.y = FlxG.height + bottomCircle.height + 35;

    controlsTop = new FlxSprite();
    controlsTop.loadGraphic(Paths.image("ui/hex/hex_freeplay/controlsText-mobileTop"));
    controlsTop.scrollFactor.set();
    controlsTop.scale.set(0.6, 0.6);
    controlsTop.updateHitbox();
    controlsTop.alpha = 0;
    controlsTop.visible = false;
    insert(members.indexOf(topCircle), controlsTop);

    var circleRight:Float = topCircle.x + topCircle.width * (1 + topCircle.scale.x) * 0.5;
    controlsTop.x = circleRight + (freeplayWatermark.x - circleRight - controlsTop.width) * 0.5;
    controlsTop.y = (topBar.height - controlsTop.height) * 0.5;

    var addedStickers:Array<FlxSprite> = [];
    for (sticker in stickerArray)
    {
      if (!addedStickers.contains(sticker))
      {
        add(sticker);
        addedStickers.push(sticker);
      }
    }

    transition = new HexTransitional();
    add(transition);
    transition.forceIn();

    camPopUp = new FunkinCamera();
    camPopUp.bgColor = 0x00000000;
    FlxG.cameras.add(camPopUp, false);

    popUp = new FreeplayPopUp();
    add(popUp);
    popUp.cameras = [camPopUp];
    popUp.onClose = onNoticeClosed;

    var options:Dynamic = Save.instance.getModOptions("hex");
    if (options.seenVersionNotice != true) popUp.show();

    if (songs.length <= 0)
    {
      FlxG.log.warn("No songs available for selection.");
      return;
    }

    capsuleLeft.validDiffs = getValidDiffs(currentSong);
    capsuleLeft.setDifficulty(savedDiff);
    set_capsule_song(false);
    isTransitioning = true;
  }

  function circleInAnim():Void
  {
    circleIn = true;
    circleOut = false;
    circleStart = realTime;
  }

  function circleOutAnim():Void
  {
    circleOut = true;
    circleIn = false;
    circleStart = realTime;
  }

  function selectSong():Void
  {
    PlayStatePlaylist.isStoryMode = false;
    PlayStatePlaylist.campaignId = originIds[songIndex];

    lastSongId = currentSong.id;
    lastDiff = capsuleLeft.getDifficulty();
    lastNewVariation = useNewVariation;

    var diffId:String = get_diff_id();
    // Null keeps the default resolution, only the version toggle forces a variation.
    var useNew:Bool = useNewVariation && has_new_version();
    var targetVariation:String = null;
    if (useNew) targetVariation = "new";
    else if (get_diff_variation() != "default") targetVariation = get_diff_variation();

    LoadingState.loadPlayState(
      {
        targetSong: currentSong,
        targetDifficulty: diffId,
        targetVariation: targetVariation,
        targetInstrumental: useNew ? "new" : "",
        practiceMode: false,
        minimalMode: false
      }, true);
  }

  function startSong():Void
  {
    circleOutAnim();
    intoSong = true;
    logo.alpha = 0;
    isTransitioning = true;
    Anim.play(theTv, "select", true);
    Anim.play(theScaryTV, "select", true);
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    FunkinSound.playOnce(Paths.sound("ui/main-menu/confirm-menu"));
    playJingle();
  }

  function onNoticeClosed():Void
  {
    var options:Dynamic = Save.instance.getModOptions("hex");
    noticeJustClosed = true;
    options.seenVersionNotice = true;
    Save.instance.setModOptions("hex", options);
  }

  function toggleVersion(quiet:Bool = false):Void
  {
    if (!has_new_version()) return;

    useNewVariation = !useNewVariation;
    capsuleLeft.setSong(currentSong, currentDifficulty, get_origin(), get_clear_percentage());
    refresh_version(true);
    playSongPreview(0.5);
    if (!quiet) FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
  }

  function playJingle():Void
  {
    var path:String = Paths.sound("ui/hex/sounds/jingles/" + currentSong.id + "Jingle");
    if (!Assets.exists(path)) return;

    FunkinSound.playOnce(path, 0.8);
  }

  function tvAnimFinish(animationName:String):Void
  {
    if (animationName == "trans")
    {
      playSongPreview();
      var id:String = currentSong.id;
      Anim.play(logo, id, true);
      var off:Array<Int> = logoOffsets.get(id);
      logo.offset.set(off != null ? off[0] : 0, off != null ? off[1] : 0);
      var currentSticker:FlxSprite = get_current_sticker();
      if (currentSticker != null) currentSticker.visible = true;
      isTransitioning = false;
    }
    if (intoSong)
    {
      transition.transitionIn();

      transition.onComplete = function(out:Bool)
      {
        selectSong();
      };
    }
  }

  function cancelPreviewTimers():Void
  {
    for (timer in previewTimers)
    {
      if (timer != null) timer.cancel();
    }
    previewTimers = [];

    if (FlxG.sound.music != null) FlxG.sound.music.stop();
  }

  function previewInstrumentalId():String
  {
    if (useNewVariation && has_new_version()) return "new";
    return currentSong.getBaseInstrumentalId(get_diff_id(), get_diff_variation()) ?? "";
  }

  var previewInstrumental:String = null;

  function playSongPreview(fadeTime:Float = 2):Void
  {
    cancelPreviewTimers();

    var baseInstrumentalId:String = previewInstrumentalId();
    previewInstrumental = baseInstrumentalId;
    FunkinSound.playMusic(currentSong.id,
      {
        startingVolume: 0.0,
        overrideExisting: true,
        restartTrack: true,
        // The music metadata is not alongside the audio file so this cannot work.
        mapTimeChanges: false,
        pathsFunction: PathsFunction.INST,
        suffix: baseInstrumentalId != "" ? "-" + baseInstrumentalId : "",
        partialParams:
          {
            loadPartial: true,
            start: 0,
            end: 0.2
          },
        onLoad: function()
        {
          FlxG.sound.music.fadeIn(fadeTime, 0, 0.8);

          var fadeStart:Float = (FlxG.sound.music.length / 1000) - 2;

          previewTimers.push(new FlxTimer().start(fadeStart, function(_)
          {
            FlxG.sound.music.fadeOut(2, 0);
          }));

          previewTimers.push(new FlxTimer().start(fadeStart, function(_)
          {
            playSongPreview();
          }));
        },
      });
  }

  function onCome(out:Bool):Void
  {
    circleInAnim();

    capsuleLeft.tween();
    capsuleRight.tween();
  }

  function stepSong(dir:Int):Void
  {
    var oldSticker:FlxSprite = get_current_sticker();

    songIndex += dir;
    if (oldSticker != null) oldSticker.visible = false;
    changeSticker = true;
    if (songIndex < 0) songIndex = songs.length - 1;
    if (songIndex >= songs.length) songIndex = 0;
    set_capsule_song(true);
    isTransitioning = true;
    logo.alpha = 0;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
  }

  function stepDifficulty(dir:Int):Void
  {
    capsuleLeft.shiftDifficulty(dir);
    capsuleLeft.bumpDifficulty(currentDifficulty);
    capsuleLeft.setSong(currentSong, currentDifficulty, get_origin(), get_clear_percentage());
    refresh_version();
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));

    if (!isTransitioning && previewInstrumental != null && previewInstrumentalId() != previewInstrumental) playSongPreview(0.5);
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    HexTouch.controls(controlsText, "hex_freeplay/controlsText");
    controlsTop.visible = HexTouch.active;
    controlsTop.alpha = controlsText.alpha;
    super.update(elapsed);

    realTime += elapsed;

    if (!hasPlayedIn && realTime > 0.02)
    {
      hasPlayedIn = true;
      transition.transitionOut();
      transition.onComplete = onCome;
    }

    var song:Song = currentSong;
    var currentSticker:FlxSprite = get_current_sticker();

    if (currentSticker != null && currentSticker.visible && currentSticker.alpha < 1)
    {
      currentSticker.alpha = FlxMath.lerp(currentSticker.alpha, 1, 0.05 * FlxG.elapsed * 50);
    }

    if (song != null)
    {
      var scary:Bool = song.id == "eye2eye";
      if (scaryBG.alpha < 1 && scary) scaryBG.alpha += 0.08 * FlxG.elapsed * 60;
      else if (scaryBG.alpha > 0 && !scary) scaryBG.alpha -= 0.08 * FlxG.elapsed * 60;
    }

    if (!isTransitioning && logo.alpha < 1) logo.alpha += 0.02 * FlxG.elapsed * 60;

    if (logo.alpha > 1) logo.alpha = 1;

    if (circleIn)
    {
      freeplayWatermark.alpha = FlxMath.lerp(freeplayWatermark.alpha, 1, 0.1 * FlxG.elapsed * 50);
      controlsText.alpha = FlxMath.lerp(controlsText.alpha, 1, 0.1 * FlxG.elapsed * 50);
      var ease:Float = FlxEase.circOut(Math.min(1, (realTime - circleStart) * 2));
      topCircle.y = FlxMath.lerp(-topCircle.height, -20, ease);
      bottomCircle.y = FlxMath.lerp(FlxG.height, FlxG.height - (bottomCircle.height - 70), ease);
      if (realTime - circleStart > 0.5) circleIn = false;
    }
    else if (circleOut)
    {
      var ease:Float = FlxEase.circIn(Math.min(1, (realTime - circleStart) * 2));
      topCircle.y = FlxMath.lerp(-20, -topCircle.height, ease);
      bottomCircle.y = FlxMath.lerp(FlxG.height - (bottomCircle.height - 70), FlxG.height, ease);
      if (realTime - circleStart > 0.5) circleOut = false;
    }

    if (!Anim.finished(theTv) && Anim.name(theTv) == "trans" && Anim.frameIndex(theTv) >= 66) Anim.finish(theTv);

    if (noticeJustClosed)
    {
      noticeJustClosed = false;
      return;
    }

    if (popUp.isOpen || intoSong) return;

    if (FlxG.keys.justPressed.LEFT || HexTouch.justSwipedRight) stepDifficulty(-1);
    else if (FlxG.keys.justPressed.RIGHT || HexTouch.justSwipedLeft) stepDifficulty(1);

    if (FlxG.keys.justPressed.UP || HexTouch.justSwipedDown) stepSong(-1);
    else if (FlxG.keys.justPressed.DOWN || HexTouch.justSwipedUp) stepSong(1);

    if (FlxG.keys.justPressed.W) logo.offset.y += 4;
    else if (FlxG.keys.justPressed.S) logo.offset.y -= 4;

    if (FlxG.keys.justPressed.A) logo.offset.x += 4;
    else if (FlxG.keys.justPressed.D) logo.offset.x -= 4;

    if (FlxG.keys.justPressed.Q && song != null)
    {
      trace("Logo Offset: '" + song.id + "' => [" + logo.offset.x + ", " + logo.offset.y + "],");
    }

    var tapped:Bool = HexTouch.tapped();
    var sort:HexSort = capsuleRight.allSort;
    var tappedSortLeft:Bool = tapped && (HexTouch.overlaps(sort.leftArrow) || HexTouch.overlaps(sort.leftSort));
    var tappedSortRight:Bool = tapped && !tappedSortLeft && (HexTouch.overlaps(sort.rightArrow) || HexTouch.overlaps(sort.rightSort));

    if (FlxG.keys.justPressed.F || tappedSortRight) stepFilter(1);
    else if (tappedSortLeft) stepFilter(-1);

    if (FlxG.keys.justPressed.V) toggleVersion();

    holdTv(elapsed);

    var tappedStart:Bool = tapped && !tappedSortLeft && !tappedSortRight && HexTouch.overlaps(theTv) && !overSortRow();

    if (FlxG.keys.justPressed.ENTER || tappedStart) startSong();

    if (FlxG.keys.justPressed.ESCAPE) goBack();
  }

  function overSortRow():Bool
  {
    if (HexTouch.touch == null) return false;

    var sort:HexSort = capsuleRight.allSort;
    var touchX:Float = HexTouch.touch.gameX;
    var touchY:Float = HexTouch.touch.gameY;

    return touchX >= sort.leftArrow.x - 20
      && touchX <= sort.rightArrow.x + sort.rightArrow.width + 20
      && touchY >= sort.leftSort.y - 20
      && touchY <= sort.leftSort.y + sort.leftSort.height + 20;
  }

  static inline final HOLD_TIME:Float = 1;
  static inline final HOLD_DELAY:Float = 0.25;

  var holdTime:Float = 0;
  var holdDone:Bool = false;
  var holdSound:FunkinSound = null;
  var shakeX:Float = 0;
  var shakeY:Float = 0;

  function shakeTv(toX:Float, toY:Float):Void
  {
    var byX:Float = toX - shakeX;
    var byY:Float = toY - shakeY;
    if (byX == 0 && byY == 0) return;

    shakeX = toX;
    shakeY = toY;

    theTv.x += byX;
    theTv.y += byY;
    theScaryTV.x += byX;
    theScaryTV.y += byY;
    tvDiff.x += byX;
    tvDiff.y += byY;
    logo.x += byX;
    logo.y += byY;

    for (i in 0...stickerArray.length)
    {
      var sticker:FlxSprite = stickerArray[i];
      if (stickerArray.indexOf(sticker) != i) continue;

      sticker.x += byX;
      sticker.y += byY;
    }
  }

  function holdTv(elapsed:Float):Void
  {
    if (!HexTouch.pressed) holdDone = false;

    var held:Bool = HexTouch.pressed
      && !holdDone
      && Math.abs(HexTouch.dragX) < 20
      && Math.abs(HexTouch.dragY) < 20
      && HexTouch.overlaps(theTv)
      && !overSortRow()
      && has_new_version();

    if (!held)
    {
      if (holdTime >= HOLD_DELAY && holdSound != null) holdSound.stop();

      holdTime = 0;
      shakeTv(0, 0);
      return;
    }

    var shaking:Bool = holdTime >= HOLD_DELAY;
    holdTime += elapsed;

    if (holdTime >= HOLD_TIME)
    {
      holdDone = true;
      holdTime = 0;
      shakeTv(0, 0);
      FlxG.camera.flash(0xFFFFFFFF, 0.5);
      toggleVersion(true);
      return;
    }

    if (holdTime < HOLD_DELAY) return;

    if (!shaking)
    {
      if (holdSound == null) holdSound = FunkinSound.load(Paths.sound("ui/hex/sounds/mobile_version"));
      if (holdSound != null) holdSound.play(true);
    }

    var t:Float = (holdTime - HOLD_DELAY) / (HOLD_TIME - HOLD_DELAY);
    var reach:Float = 1 + 11 * t * t * t;
    shakeTv(FlxG.random.float(-reach, reach), FlxG.random.float(-reach, reach));
  }

  function stepFilter(dir:Int):Void
  {
    var tempFilter:Int = (filter + dir + 5) % 5;
    var oldSticker:FlxSprite = get_current_sticker();
    if (oldSticker != null) oldSticker.visible = false;
    changeSticker = true;
    filter = tempFilter;
  }

  function goBack():Void
  {
    if (popUp.isOpen || intoSong) return;

    transition.transitionIn();

    transition.onComplete = function(out:Bool)
    {
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 1;
      FlxG.switchState(function() return mm);
    };
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    super.destroy();
  }
}
