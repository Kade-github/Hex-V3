package kade.hex.states;

import kade.hex.util.HexPurge;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import funkin.Assets;
import funkin.Paths;
import funkin.assets.FunkinAssetCache;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.ui.MusicBeatState;
import kade.hex.objects.BetterAtlasText;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.util.HexTouch;

/**
 * The jukebox state for Hex.
 */
class HexJukebox extends MusicBeatState
{
  static inline var PAGE_MUSIC:Int = 0;
  static inline var PAGE_PLAYER:Int = 1;

  static inline var WINDOW_SLIDE_TIME:Float = 0.5;

  static inline var BORDER_OFFSET:Float = -8;

  static inline var WAVE_SPREAD:Float = 0.5;
  static inline var ITEM_IN_TIME:Float = 0.6;
  static inline var ITEM_OUT_TIME:Float = 0.45;
  static inline var ITEM_IN_DISTANCE:Float = 400;
  static inline var ITEM_OUT_DISTANCE:Float = 400;

  static inline var MODE_HIDDEN:Int = 0;
  static inline var MODE_IN:Int = 1;
  static inline var MODE_OUT:Int = 2;

  static var ALBUMS:Array<String> = ["Hextravaganza", "Hexperience", "Hexcess"];

  static var ALBUM_SONGS:Array<Array<String>> = [
    ["Dunk", "R.A.M.", "Hello World", "Glitcher", "Encore"],
    ["Cooling", "Detected", "Glitcher (Remix)", "Java", "LCD", "Hectic", "Reboot", "R.O.M."],
    [
      "B.I.T.", "Jumpin'", "Headbasher", "Bombs & Combs", "LAN", "HEXcript", "Tangerine", "That Retro Song", "Eye2Eye", "Right Pace",
      "Dunk (2026 Ver.)", "R.A.M. (2026 Ver.)", "Hello World (2026 Ver.)", "Glitcher (2026 Ver.)", "Encore (2026 Ver.)",
      "Cooling (2026 Ver.)", "Detected (2026 Ver.)", "Java (2026 Ver.)", "LCD (2026 Ver.)", "B.I.T. (Remix)",
      "Reminiscing (Title Screen)", "Keyclicker (Menu Theme)", "Standby (Pause Theme)", "Bluescreen (Game Over)", "Ransomware (Slasher's Game Over)",
      "Results (Perfect)", "Results (Excellent)", "Results (Good)", "Results (Shit)"
    ]
  ];


  // Audio for each song, lined up with ALBUM_SONGS: "instrumental|vocal,vocal|artist" as paths
  static var ALBUM_TRACKS:Array<Array<String>> = [
    [
      "gameplay/songs/dunk/Inst|gameplay/songs/dunk/Voices-bf,gameplay/songs/dunk/Voices-hex",
      "gameplay/songs/ram/Inst|gameplay/songs/ram/Voices-bf,gameplay/songs/ram/Voices-hex",
      "gameplay/songs/hello-world/Inst|gameplay/songs/hello-world/Voices-bf,gameplay/songs/hello-world/Voices-hex",
      "gameplay/songs/glitcher/Inst|gameplay/songs/glitcher/Voices-bf,gameplay/songs/glitcher/Voices-hex",
      "gameplay/songs/encore/Inst|gameplay/songs/encore/Voices-bf,gameplay/songs/encore/Voices-hex"
    ],
    [
      "gameplay/songs/cooling/Inst|gameplay/songs/cooling/Voices-bf,gameplay/songs/cooling/Voices-hex",
      "gameplay/songs/detected/Inst|gameplay/songs/detected/Voices-bf,gameplay/songs/detected/Voices-hex",
      "gameplay/songs/glitcher-remix/Inst|gameplay/songs/glitcher-remix/Voices-bf,gameplay/songs/glitcher-remix/Voices-hex",
      "gameplay/songs/java/Inst|gameplay/songs/java/Voices-bf,gameplay/songs/java/Voices-hex",
      "gameplay/songs/lcd/Inst|gameplay/songs/lcd/Voices-bf,gameplay/songs/lcd/Voices-hex",
      "ui/hex/music/hectic|",
      "ui/hex/music/reboot/Reboot|",
      "gameplay/hex/story/music/rom|"
    ],
    [
      "gameplay/songs/bit/Inst|gameplay/songs/bit/Voices-bfbit,gameplay/songs/bit/Voices-hexbit",
      "gameplay/songs/jumpin/Inst|gameplay/songs/jumpin/Voices-bf-jumpin1,gameplay/songs/jumpin/Voices-hex-jumpin1",
      "gameplay/songs/headbasher/Inst|gameplay/songs/headbasher/Voices-bf-hb-1,gameplay/songs/headbasher/Voices-slasher",
      "gameplay/songs/bombs-n-combs/Inst|gameplay/songs/bombs-n-combs/Voices-hex-bombs,gameplay/songs/bombs-n-combs/Voices-whitty",
      "gameplay/songs/lan/Inst|gameplay/songs/lan/Voices-cyrix,gameplay/songs/lan/Voices-hex-lan",
      "gameplay/songs/hexcript/Inst|gameplay/songs/hexcript/Voices-bf-hexware,gameplay/songs/hexcript/Voices-hex-hexware|YingYang48 ft. KadeDevl;",
      "gameplay/songs/tangerine/Inst|gameplay/songs/tangerine/Voices-bf,gameplay/songs/tangerine/Voices-dad",
      "gameplay/songs/thatretrosong/Inst|gameplay/songs/thatretrosong/Voices-hexretro,gameplay/songs/thatretrosong/Voices-rich",
      "gameplay/songs/eye2eye/Inst|gameplay/songs/eye2eye/Voices-hex,gameplay/songs/eye2eye/Voices-iris",
      "gameplay/songs/rightpace/Inst|gameplay/songs/rightpace/Voices-bf,gameplay/songs/rightpace/Voices-hex-rightpace",
      "gameplay/songs/dunk/Inst-new|gameplay/songs/dunk/Voices-bf-new,gameplay/songs/dunk/Voices-hex-new",
      "gameplay/songs/ram/Inst-new|gameplay/songs/ram/Voices-bf-new,gameplay/songs/ram/Voices-hex-new",
      "gameplay/songs/hello-world/Inst-new|gameplay/songs/hello-world/Voices-bf-new,gameplay/songs/hello-world/Voices-hex-new",
      "gameplay/songs/glitcher/Inst-new|gameplay/songs/glitcher/Voices-bf-new,gameplay/songs/glitcher/Voices-hex-new",
      "gameplay/songs/encore/Inst-new|gameplay/songs/encore/Voices-bf-new,gameplay/songs/encore/Voices-hex-new",
      "gameplay/songs/cooling/Inst-new|gameplay/songs/cooling/Voices-bf-new,gameplay/songs/cooling/Voices-hex-new",
      "gameplay/songs/detected/Inst-new|gameplay/songs/detected/Voices-bf-new,gameplay/songs/detected/Voices-hex-new",
      "gameplay/songs/java/Inst-new|gameplay/songs/java/Voices-bf-new,gameplay/songs/java/Voices-hex-new",
      "gameplay/songs/lcd/Inst-new|gameplay/songs/lcd/Voices-bf-new,gameplay/songs/lcd/Voices-hex-new",
      "gameplay/songs/bit/Inst-erect|gameplay/songs/bit/Voices-bfbit-erect,gameplay/songs/bit/Voices-hexbit-erect",
      "ui/hex/music/title-ambi/title-ambi|",
      "ui/hex/music/title-theme/title-theme|",
      "ui/hex/music/hex-pause/hex-pause|",
      "ui/hex/music/gameOverHex/gameOverHex|",
      "ui/hex/music/ransomwareMusic/ransomwareMusic||KadeDevl ft. YingYang48",
      "gameplay/playable-characters/hex/results/music/Results_Perfect|",
      "gameplay/playable-characters/hex/results/music/Results_Excellent|",
      "gameplay/playable-characters/hex/results/music/Results_Normal|",
      "gameplay/playable-characters/hex/results/music/Results_Shit|"
    ]
  ];

  static inline var DEFAULT_ARTIST:String = "YingYang48";

  // The time that elapses before a track is considered for restart after pressing back.
  static inline var RESTART_AFTER:Float = 3000;

  static inline var VOCAL_DRIFT:Float = 20;

  static inline var BUTTON_LIST:Int = 0;
  static inline var BUTTON_BACK:Int = 1;
  static inline var BUTTON_PLAY:Int = 2;
  static inline var BUTTON_FORWARD:Int = 3;
  static inline var BUTTON_VOCALS:Int = 4;

  static var PLAYER_BUTTONS:Array<String> = ["buttonList", "buttonBackward", "buttonPlay", "buttonForward", "buttonVocals"];
  static var PLAYER_BUTTON_X:Array<Float> = [96, 186, 303, 379, 481];
  static inline var PLAYER_BUTTON_BOTTOM:Float = 645;
  static inline var PLAYER_TEXT_CENTER:Float = 329;
  static inline var SCALED_TEXT_NUDGE:Float = 7;

  static inline var TITLE_Y:Float = 450;
  static inline var ARTIST_Y:Float = 505;
  static inline var TITLE_Y_SUB:Float = 442;
  static inline var SUBTITLE_Y:Float = 500;
  static inline var ARTIST_Y_SUB:Float = 518;
  static inline var SUBTITLE_SCALE:Float = 0.55;

  static inline var MIC_MUTED_ALPHA:Float = 0.6;
  static inline var MIC_NONE_ALPHA:Float = 0.3;

  static inline var TRACK_OUT_TIME:Float = 0.18;
  static inline var TRACK_IN_TIME:Float = 0.35;
  static inline var TRACK_OUT_DRIFT:Float = -30;
  static inline var TRACK_IN_DISTANCE:Float = 80;

  static inline var SELECT_TOP:Float = 571;
  static inline var SELECT_BOTTOM:Float = 653;
  static inline var SELECT_PAD:Float = 8;

  static var SELECT_SKEW:Array<Array<Float>> = [[-8, 10], [10, -9], [7, 4], [9, -7]];

  static inline var HEADER_CENTER:Float = 513;
  static inline var HEADER_Y:Float = 96;
  static inline var HEADER_SCALE:Float = 0.81;

  static inline var ROW_X:Float = 930;
  static inline var ROW_TOP:Float = 180;
  static inline var ROW_STEP:Float = 50;
  static inline var ROW_SLANT:Float = 0.6;
  static inline var LIST_BOTTOM:Float = 665;

  static inline var ROW_LIMIT:Float = 1215;
  static inline var ROW_HEIGHT:Float = 47;
  static inline var PLAYING_ICON_DROP:Float = 1;
  static inline var PLAYING_ICON_GAP:Float = 15;

  static inline var ROW_CLIP_BLEED:Float = 30;

  static inline var ROW_EDGE_FADE:Float = 70;

  static inline var SLIDE_SPEED:Float = 60;
  static inline var SLIDE_WAIT:Float = 1.2;

  static inline var LIST_SELECT_PAD:Float = 8;
  static inline var LIST_SELECT_TOP:Float = -4;
  static inline var LIST_SELECT_BOTTOM:Float = 4;
  static inline var LIST_SELECT_SHIFT_X:Float = 8;
  static inline var LIST_SELECT_SHIFT_Y:Float = 8;

  static var CIRCLE_EDGE:Array<Float> = [138, 110, 91, 77, 64, 54, 45, 37, 30, 24, 19, 14, 11, 7, 5, 3, 1, 1, 0, 1, 1, 3];
  static inline var CIRCLE_GAP:Float = 4;

  static inline var SCROLL_X:Float = 639;
  static inline var SCROLL_Y:Float = 197;

  var bg:FlxSprite;

  var swirly:FlxRuntimeShader;

  var windowInside:FunkinSprite;
  var windowBorder:FunkinSprite;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;

  var controlsText:FlxSprite;

  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var transition:HexTransitional;

  var realTime:Float = 0;
  var hasPlayedIn:Bool = false;
  var leaving:Bool = false;

  var windowRestX:Float = 0;
  var windowSlideStart:Float = -1;

  var pageItems:Array<Array<FlxSprite>> = [[], []];
  var pageSpots:Array<Array<Array<Float>>> = [[], []];
  var pageMode:Array<Int> = [MODE_HIDDEN, MODE_HIDDEN];
  var pageStart:Array<Float> = [0, 0];

  var pageInStart:Array<Float> = [0, 0];

  var page:Int = PAGE_MUSIC;
  var nextPage:Int = -1;

  // The waiting album index
  var pendingAlbum:Int = 0;

  var albumIndex:Int = 0;
  var albumHeader:BetterAtlasText;
  var rows:Array<BetterAtlasText> = [];
  var rowSlide:Array<Float> = [];

  var rowReserve:Array<Float> = [];
  var songIndex:Int = 0;
  var slideStart:Float = 0;
  var listScroll:Float = 0;
  var scrollLine:FunkinSprite;
  var scrollCircle:FunkinSprite;
  var playingIcon:FunkinSprite;

  var playingAlbum:Int = -1;
  var playingSong:Int = -1;

  // The track the player shows. Until something has played it follows the list's selection.
  var trackAlbum:Int = 0;
  var trackSong:Int = 0;
  var everPlayed:Bool = false;

  var inst:FunkinSound = null;
  var vocals:Array<FunkinSound> = [];
  var paused:Bool = false;
  var vocalsOn:Bool = true;
  var trackEnded:Bool = false;

  var loadToken:Int = 0;
  var loading:Bool = false;
  var forceSyncFrames:Int = 0;

  var trackAnimStart:Float = -1;
  var trackAnimSwapped:Bool = false;
  var trackAnimCover:Bool = false;

  var trackAnimDir:Int = 1;
  var trackAnimMoving:Int = 1;
  var shownAlbum:Int = -1;

  var invertShader:FlxRuntimeShader;
  var invertIntensity:Float = 0;

  var playerCover:FunkinSprite;
  var songTitle:BetterAtlasText;
  var songArtist:BetterAtlasText;
  var songSubtitle:BetterAtlasText;
  var playerButtons:Array<FunkinSprite> = [];

  var personaSelection:PersonaSelection;
  var buttonIndex:Int = BUTTON_PLAY;
  var lastSelectMove:Float = -1;

  public function new()
  {
    super();
  }

  var wasAutoPause:Bool = true;
  var focusedVolume:Float = 1;
  var unfocused:Bool = false;

  override public function create():Void
  {
    super.create();

    wasAutoPause = FlxG.autoPause;
    FlxG.autoPause = false;

    personaSelection = new PersonaSelection();
    personaSelection.initShader();
    add(personaSelection);

    invertShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/better_invertColor")));
    invertShader.setFloat("uIntensity", 0);

    bg = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/bg");
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    add(bg);

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.8);
    swirly.setFloatArray("uColor1", [0.620, 0.514, 0.831]);
    swirly.setFloatArray("uColor2", [0.416, 0.353, 0.753]);
    swirly.setFloat("uIntensity", 30.0);

    windowInside = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/windowRightNoBorder");
    add(windowInside);

    windowInside.shader = swirly;
    windowRestX = FlxG.width - windowInside.width;

    windowBorder = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/borderRight");
    add(windowBorder);

    placeWindow(FlxG.width);

    buildMusicPage();
    buildPlayerPage();

    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(bottomBar);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/hex_jukebox/circleTop"));
    add(topCircle);

    topCircle.x = 0;
    topCircle.y = 0;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/hex_jukebox/circleBottom"));
    add(bottomCircle);

    bottomCircle.x = FlxG.width - bottomCircle.width;
    bottomCircle.y = FlxG.height - bottomCircle.height;

    controlsText = new FlxSprite(15, FlxG.height - 40);
    add(controlsText);
    setControls();

    var jukeboxWatermark:FunkinSprite = FunkinSprite.create(FlxG.width - 10, 10, "ui/hex/hex_jukebox/menuIdentifier");
    jukeboxWatermark.x = FlxG.width - (jukeboxWatermark.width + 18);
    add(jukeboxWatermark);

    transition = new HexTransitional();
    add(transition);
    transition.forceIn();

    bottomBar.zIndex = 200;
    topBar.zIndex = 200;
    topCircle.zIndex = 200;
    bottomCircle.zIndex = 200;
    controlsText.zIndex = 200;
    transition.zIndex = 200;

    layoutList(0);
    placePages(FlxG.width);
  }

  function makeText(font:String, scale:Float, spacing:Float):BetterAtlasText
  {
    var text:BetterAtlasText = new BetterAtlasText(Paths.image("ui/fonts/" + font), Paths.xml("ui/fonts/" + font), 0, 0, "");
    text.setCharOffset("g", 0, 8);
    text.setCharOffset("p", 0, 8);
    text.setCharOffset("y", 0, 8);
    text.setCharOffset("j", 0, 8);
    text.scale.set(scale, scale);
    text.letterSpacing = spacing;

    if (font == "hex_songtitle") text.setCharOffset("'", 0, 21);
    if (font == "hex_artist") text.setCharOffset("'", 0, -15);
    if (font == "hex_title") text.setCharOffset("'", 1, -32);

    return text;
  }

  function addBar(x:Float, y:Float, width:Float):Void
  {
    var line:FlxSprite = new FlxSprite();
    line.loadGraphic(Paths.image("ui/hex/hex_freeplay/line"));
    line.scale.set(0.75, 0.75);
    line.updateHitbox();
    line.setGraphicSize(Std.int(width), Std.int(line.height));
    line.updateHitbox();
    addItem(PAGE_MUSIC, line, x, y, line.height);
  }

  function buildMusicPage():Void
  {
    addBar(393, 69, 300);

    albumHeader = makeText("hex_songtitle", HEADER_SCALE, -2);
    addItem(PAGE_MUSIC, albumHeader, 0, HEADER_Y, albumHeader.getLineHeight());

    addBar(334, 148, 300);

    scrollLine = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/scrollLine");
    addItem(PAGE_MUSIC, scrollLine, SCROLL_X, SCROLL_Y, scrollLine.height);

    scrollCircle = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/scrollCircle");
    addItem(PAGE_MUSIC, scrollCircle, SCROLL_X + (scrollLine.width - scrollCircle.width) / 2, SCROLL_Y, scrollCircle.height);

    spotOf(PAGE_MUSIC, scrollCircle)[4] = SCROLL_Y + scrollLine.height;

    playingIcon = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_jukebox/spectrumIcon");
    playingIcon.animation.addByPrefix("idle", "spectrumIcon", 24, true);
    playingIcon.animation.play("idle");
    playingIcon.scale.set(0.8, 0.8);
    playingIcon.updateHitbox();
    addItem(PAGE_MUSIC, playingIcon, 0, 0, playingIcon.height);

    buildRows();
  }

  function buildRows():Void
  {
    for (row in rows)
    {
      removeItem(PAGE_MUSIC, row);
      row.destroy();
    }
    rows = [];
    rowSlide = [];
    rowReserve = [];

    var songs:Array<String> = ALBUM_SONGS[albumIndex];
    for (i in 0...songs.length)
    {
      var row:BetterAtlasText = makeText("hex_artist", 1, -2);
      row.text = (i + 1) + ". " + songs[i];
      addItem(PAGE_MUSIC, row, 0, 0, row.getLineHeight());
      rows.push(row);
      rowSlide.push(0);
      rowReserve.push(0);
    }

    albumHeader.text = ALBUMS[albumIndex];

    albumHeader.origin.set(0, 0);
    spotOf(PAGE_MUSIC, albumHeader)[0] = HEADER_CENTER - albumHeader.getTextWidth() / 2;
  }

  function buildPlayerPage():Void
  {
    playerCover = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/cover" + ALBUMS[albumIndex]);
    addItem(PAGE_PLAYER, playerCover, 148, 80, playerCover.height);

    songTitle = makeText("hex_title", 0.7, -4);
    addItem(PAGE_PLAYER, songTitle, 0, TITLE_Y, songTitle.getLineHeight());

    songSubtitle = makeText("hex_songtitle", SUBTITLE_SCALE, -2);
    addItem(PAGE_PLAYER, songSubtitle, 0, SUBTITLE_Y, songSubtitle.getLineHeight());

    songArtist = makeText("hex_artist", 1, -2);
    addItem(PAGE_PLAYER, songArtist, 0, ARTIST_Y, songArtist.getLineHeight());

    showTrack();

    for (i in 0...PLAYER_BUTTONS.length)
    {
      var button:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_jukebox/" + PLAYER_BUTTONS[i]);
      addItem(PAGE_PLAYER, button, PLAYER_BUTTON_X[i], PLAYER_BUTTON_BOTTOM - button.height, button.height);
      playerButtons.push(button);
    }
  }

  function setSong(title:String, artist:String):Void
  {
    var subtitle:String = "";
    var cut:Int = title.indexOf(" (");
    if (cut != -1)
    {
      subtitle = title.substr(cut + 1);
      title = title.substr(0, cut);
    }

    songTitle.text = title;
    songSubtitle.text = subtitle;
    songArtist.text = artist;
    songTitle.origin.set(0, 0);
    songSubtitle.origin.set(0, 0);

    var hasSub:Bool = subtitle != "";
    var titleSpot:Array<Float> = spotOf(PAGE_PLAYER, songTitle);
    var subSpot:Array<Float> = spotOf(PAGE_PLAYER, songSubtitle);
    var artistSpot:Array<Float> = spotOf(PAGE_PLAYER, songArtist);

    titleSpot[0] = centeredX(songTitle, title) + SCALED_TEXT_NUDGE;
    titleSpot[1] = hasSub ? TITLE_Y_SUB : TITLE_Y;
    subSpot[0] = PLAYER_TEXT_CENTER - songSubtitle.getTextWidth() / 2 + SCALED_TEXT_NUDGE;
    artistSpot[0] = PLAYER_TEXT_CENTER - songArtist.getTextWidth() / 2;
    artistSpot[1] = hasSub ? ARTIST_Y_SUB : ARTIST_Y;
  }

  static var TITLE_PUNCT_PAD:Map<String, Float> = ["." => 14, "," => 14, "'" => 14, "-" => 3];

  function centeredX(text:BetterAtlasText, str:String):Float
  {
    var width:Float = text.getTextWidth();
    var lead:Float = 0;
    var trail:Float = 0;

    if (str.length > 0)
    {
      var first:Null<Float> = TITLE_PUNCT_PAD.get(str.charAt(0));
      var last:Null<Float> = TITLE_PUNCT_PAD.get(str.charAt(str.length - 1));
      if (first != null) lead = first * text.scale.x;
      if (last != null) trail = last * text.scale.x;
    }

    return PLAYER_TEXT_CENTER - (width - lead - trail) / 2 - lead;
  }

  function spotOf(which:Int, spr:FlxSprite):Array<Float>
  {
    return pageSpots[which][pageItems[which].indexOf(spr)];
  }

  function addItem(which:Int, spr:FlxSprite, x:Float, y:Float, height:Float):Void
  {
    spr.visible = false;
    if (topBar != null) insert(members.indexOf(topBar), spr);
    else add(spr);
    pageItems[which].push(spr);
    pageSpots[which].push([x, y, height, 1, -1, 0]);
  }

  function removeItem(which:Int, spr:FlxSprite):Void
  {
    var at:Int = pageItems[which].indexOf(spr);
    if (at == -1) return;

    pageItems[which].splice(at, 1);
    pageSpots[which].splice(at, 1);
    remove(spr, true);
  }

  function setControls():Void
  {
    controlsText.setPosition(15, FlxG.height - 40);
    controlsText.offset.set(0, 0);
    controlsText.loadGraphic(Paths.image(page == PAGE_MUSIC ? "ui/hex/hex_jukebox/controlsTextList" : "ui/hex/hex_jukebox/controlsTextPlayer"));
    controlsText.ID = 0;

    controlsTouch = HexTouch.active;
    if (controlsTouch) HexTouch.controls(controlsText, "hex_jukebox/controlsTextList");
  }

  var controlsTouch:Bool = false;

  function placeWindow(x:Float):Void
  {
    windowInside.x = x;
    windowInside.y = 0;
    windowBorder.x = x + BORDER_OFFSET;
    windowBorder.y = 0;
  }

  function rowX(screenY:Float):Float
  {
    return ROW_X - (screenY - ROW_TOP) * ROW_SLANT;
  }

  function rowRoom(i:Int):Float
  {
    return rowWidth(rowTop(i)) - rowReserve[i];
  }

  function rowWidth(top:Float):Float
  {
    var right:Float = Math.min(ROW_LIMIT, circleLeftAt(top + ROW_HEIGHT) - CIRCLE_GAP);
    return right - rowX(top);
  }

  function rowTop(i:Int):Float
  {
    return ROW_TOP + i * ROW_STEP - listScroll;
  }

  function slideFor(overflow:Float):Float
  {
    if (overflow <= 0) return 0;

    var travel:Float = overflow / SLIDE_SPEED;
    var cycle:Float = SLIDE_WAIT * 2 + travel * 2;
    var t:Float = (realTime - slideStart) % cycle;

    if (t < SLIDE_WAIT) return 0;
    t -= SLIDE_WAIT;
    if (t < travel) return overflow * FlxEase.sineInOut(t / travel);
    t -= travel;
    if (t < SLIDE_WAIT) return overflow;
    t -= SLIDE_WAIT;
    return overflow * (1 - FlxEase.sineInOut(t / travel));
  }

  function layoutList(elapsed:Float):Void
  {
    var last:Int = rows.length - 1;
    var selTop:Float = ROW_TOP + songIndex * ROW_STEP;
    var target:Float = listScroll;
    if (selTop - target < ROW_TOP) target = selTop - ROW_TOP;
    if (selTop + ROW_STEP - target > LIST_BOTTOM) target = selTop + ROW_STEP - LIST_BOTTOM;
    listScroll = elapsed <= 0 ? target : FlxMath.lerp(listScroll, target, Math.min(1, 12 * elapsed));

    playingIcon.visible = false;
    spotOf(PAGE_MUSIC, playingIcon)[3] = 0;

    for (i in 0...rows.length)
    {
      var row:BetterAtlasText = rows[i];
      var spot:Array<Float> = spotOf(PAGE_MUSIC, row);
      var top:Float = rowTop(i);
      var left:Float = rowX(top);
      var width:Float = row.getTextWidth();

      var iconSpace:Float = playingIcon.width + PLAYING_ICON_GAP * 2;
      var playing:Bool = albumIndex == playingAlbum && i == playingSong;
      var reserve:Float = playing && width + iconSpace > rowWidth(top) ? iconSpace : 0;
      rowReserve[i] = elapsed <= 0 ? reserve : FlxMath.lerp(rowReserve[i], reserve, Math.min(1, 12 * elapsed));

      // Only the selected name slides
      rowSlide[i] = i == songIndex ? slideFor(width - rowRoom(i)) : 0;

      spot[0] = left - rowSlide[i] - windowRestX;
      spot[1] = top;

      // Rows fade in and out at the ends of the list
      var fade:Float = ROW_STEP * 0.5;
      var fadeTop:Float = (top - (ROW_TOP - fade)) / fade;
      var fadeBottom:Float = (LIST_BOTTOM + fade - (top + spot[2])) / fade;
      spot[3] = FlxMath.bound(Math.min(fadeTop, fadeBottom), 0, 1);

      if (albumIndex == playingAlbum && i == playingSong && spot[3] > 0)
      {
        var iconSpot:Array<Float> = spotOf(PAGE_MUSIC, playingIcon);
        iconSpot[0] = left + Math.min(width, rowRoom(i)) + PLAYING_ICON_GAP - windowRestX;
        iconSpot[1] = top + (ROW_HEIGHT - playingIcon.height) / 2 + PLAYING_ICON_DROP;
        iconSpot[3] = spot[3];
      }
    }

    var circleSpot:Array<Float> = spotOf(PAGE_MUSIC, scrollCircle);
    var along:Float = last <= 0 ? 0 : songIndex / last;
    circleSpot[1] = SCROLL_Y + (scrollLine.height - scrollCircle.height) * along;
  }

  function clipRows():Void
  {
    for (i in 0...rows.length)
    {
      var row:BetterAtlasText = rows[i];
      var left:Float = row.x + rowSlide[i] - ROW_CLIP_BLEED;
      var width:Float = rowRoom(i) + ROW_CLIP_BLEED;
      if (row.clipRect == null) row.clipRect = FlxRect.get();
      row.clipRect.set(left, row.y - 20, width, spotOf(PAGE_MUSIC, row)[2] + 40);
      row.clipRect = row.clipRect;
      row.updateClipRects();

      fadeRowEdges(row, i);
    }
  }

  function fadeRowEdges(row:BetterAtlasText, i:Int):Void
  {
    var top:Float = rowTop(i);
    var room:Float = rowRoom(i);
    var clipped:Bool = row.getTextWidth() > room;

    var start:Float = row.x + rowSlide[i];

    var remaining:Float = row.getTextWidth() - room - rowSlide[i];
    var toEnd:Float = Math.min(Math.max(remaining, 0) / ROW_EDGE_FADE, 1);
    var rightEdge:Float = start + room + ROW_EDGE_FADE * (1 - toEnd);

    var slid:Float = Math.min(rowSlide[i] / ROW_EDGE_FADE, 1);
    var leftEdge:Float = start - ROW_CLIP_BLEED - ROW_EDGE_FADE * (1 - slid);

    for (glyph in row.children)
    {
      if (glyph == null) continue;

      if (!clipped)
      {
        glyph.localAlpha = 1;
        continue;
      }

      var center:Float = row.x + glyph.localX + glyph.width / 2;
      var fromRight:Float = (rightEdge - center) / ROW_EDGE_FADE;
      var fromLeft:Float = (center - leftEdge) / ROW_EDGE_FADE;
      glyph.localAlpha = FlxMath.bound(Math.min(fromRight, fromLeft), 0, 1);
    }
  }

  function waveDelay(spot:Array<Float>):Float
  {
    var bottom:Float = spot[4] >= 0 ? spot[4] : spot[1] + spot[2];
    return FlxMath.bound((FlxG.height - bottom) / FlxG.height, 0, 1) * WAVE_SPREAD;
  }

  function progress(start:Float, delay:Float, length:Float):Float
  {
    return FlxMath.bound((realTime - start - delay) / length, 0, 1);
  }

  function slideIn(which:Int):Void
  {
    pageMode[which] = MODE_IN;
    pageStart[which] = realTime;
    pageInStart[which] = realTime;
  }

  function slideOut(which:Int):Void
  {
    pageMode[which] = MODE_OUT;
    pageStart[which] = realTime;
  }

  function placePages(windowX:Float):Void
  {
    for (which in 0...pageItems.length)
    {
      var items:Array<FlxSprite> = pageItems[which];
      var spots:Array<Array<Float>> = pageSpots[which];
      var mode:Int = pageMode[which];

      for (i in 0...items.length)
      {
        var spr:FlxSprite = items[i];
        var spot:Array<Float> = spots[i];
        var off:Float = 0;

        spr.visible = mode != MODE_HIDDEN && spot[3] > 0;
        spr.y = spot[1];

        if (mode == MODE_IN)
        {
          var t:Float = progress(pageStart[which], waveDelay(spot), ITEM_IN_TIME);
          off = FlxMath.lerp(ITEM_IN_DISTANCE, 0, FlxEase.circOut(t));
          spr.alpha = t * spot[3];
        }
        else if (mode == MODE_OUT)
        {
          var delay:Float = waveDelay(spot);
          var leaveAt:Float = pageStart[which] + delay;
          var tIn:Float = FlxMath.bound((Math.min(realTime, leaveAt) - pageInStart[which] - delay) / ITEM_IN_TIME, 0, 1);
          var fromOff:Float = FlxMath.lerp(ITEM_IN_DISTANCE, 0, FlxEase.circOut(tIn));

          var t:Float = progress(pageStart[which], delay, ITEM_OUT_TIME);
          off = FlxMath.lerp(fromOff, ITEM_OUT_DISTANCE, FlxEase.circIn(t));
          spr.alpha = FlxMath.lerp(tIn, 0, t) * spot[3];
        }

        spr.x = windowX + spot[0] + spot[5] + off;
      }

      if (mode == MODE_OUT && realTime - pageStart[which] >= WAVE_SPREAD + ITEM_OUT_TIME)
      {
        pageMode[which] = MODE_HIDDEN;

        if (which == PAGE_MUSIC && pendingAlbum != 0)
        {
          applyAlbum(pendingAlbum);
          pendingAlbum = 0;
          slideIn(PAGE_MUSIC);
        }
        else if (nextPage != -1)
        {
          page = nextPage;
          nextPage = -1;
          setControls();
          slideIn(page);
        }
      }
    }
  }

  function skewed(left:Float, top:Float, right:Float, bottom:Float):Array<Array<Float>>
  {
    var sx:Float = FlxG.scaleMode.scale.x;
    var sy:Float = FlxG.scaleMode.scale.y;
    var corners:Array<Array<Float>> = [[left, top], [right, top], [right, bottom], [left, bottom]];
    var quad:Array<Array<Float>> = [];
    for (i in 0...4)
      quad.push([(corners[i][0] + SELECT_SKEW[i][0]) * sx, (corners[i][1] + SELECT_SKEW[i][1]) * sy]);
    return quad;
  }

  function circleLeftAt(y:Float):Float
  {
    var local:Float = (y - bottomCircle.y) / 10;
    if (local < 0) return FlxG.width;

    var at:Int = Std.int(Math.min(local, CIRCLE_EDGE.length - 1));
    var next:Int = Std.int(Math.min(at + 1, CIRCLE_EDGE.length - 1));
    var edge:Float = FlxMath.lerp(CIRCLE_EDGE[at], CIRCLE_EDGE[next], local - at);
    return bottomCircle.x + edge;
  }

  function avoidCircle(quad:Array<Array<Float>>):Array<Array<Float>>
  {
    var sx:Float = FlxG.scaleMode.scale.x;
    var sy:Float = FlxG.scaleMode.scale.y;

    var sep:FlxSprite = pageItems[PAGE_MUSIC][pageItems[PAGE_MUSIC].indexOf(albumHeader) + 1];
    var top:Float = (sep.y + sep.height) * sy;
    var bottom:Float = bottomBar.y * sy;
    for (corner in quad)
      corner[1] = FlxMath.bound(corner[1], top, bottom);

    for (i in [1, 2])
    {
      var limit:Float = (circleLeftAt(quad[i][1] / sy) - CIRCLE_GAP) * sx;
      if (quad[i][0] > limit) quad[i][0] = limit;
    }
    return quad;
  }

  function selectionQuad():Array<Array<Float>>
  {
    if (page == PAGE_MUSIC)
    {
      var row:BetterAtlasText = rows[songIndex];
      var slide:Float = rowSlide[songIndex];
      var left:Float = row.x + slide + LIST_SELECT_SHIFT_X;
      var shown:Float = Math.min(row.getTextWidth(), rowRoom(songIndex));
      var top:Float = row.y + LIST_SELECT_SHIFT_Y;
      var bottom:Float = top + spotOf(PAGE_MUSIC, row)[2];

      var reach:Float = LIST_SELECT_PAD + Math.min(slide, ROW_CLIP_BLEED);
      return avoidCircle(skewed(left - reach, top + LIST_SELECT_TOP, left + shown + LIST_SELECT_PAD, bottom + LIST_SELECT_BOTTOM));
    }

    var button:FunkinSprite = playerButtons[buttonIndex];
    return skewed(button.x - SELECT_PAD, SELECT_TOP, button.x + button.width + SELECT_PAD, SELECT_BOTTOM);
  }

  function placeSelection():Void
  {
    var showing:Bool = !leaving && nextPage == -1 && pendingAlbum == 0 && pageMode[page] == MODE_IN;
    if (showing && !personaSelection.enabled) personaSelection.enabled = true;
    var rate:Float = leaving ? 0.5 : 0.3;
    personaSelection.mix = FlxMath.lerp(personaSelection.mix, showing ? 1 : 0, rate * FlxG.elapsed * 60);

    if (lastSelectMove >= 0 && realTime - lastSelectMove < 0.09) return;

    var quad:Array<Array<Float>> = selectionQuad();
    personaSelection.lerpPos = quad;
    personaSelection.pos = quad;
  }

  function moveButton(dir:Int):Void
  {
    buttonIndex += dir;
    if (buttonIndex < 0) buttonIndex = playerButtons.length - 1;
    if (buttonIndex >= playerButtons.length) buttonIndex = 0;

    if (buttonIndex == BUTTON_VOCALS && !micUsable())
    {
      buttonIndex += dir;
      if (buttonIndex < 0) buttonIndex = playerButtons.length - 1;
      if (buttonIndex >= playerButtons.length) buttonIndex = 0;
    }

    personaSelection.pos = selectionQuad();
    lastSelectMove = realTime;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
  }

  static inline var HOLD_DELAY:Float = 0.35;
  static inline var HOLD_REPEAT:Float = 0.07;

  var holdTime:Float = 0;
  var holdNext:Float = 0;

  function holdScroll(elapsed:Float):Void
  {
    var dir:Int = FlxG.keys.pressed.UP ? -1 : (FlxG.keys.pressed.DOWN ? 1 : 0);
    if (dir == 0 || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
    {
      holdTime = 0;
      holdNext = HOLD_DELAY;
      return;
    }

    holdTime += elapsed;
    while (holdTime >= holdNext)
    {
      holdNext += HOLD_REPEAT;
      moveSong(dir, false);
    }
  }

  function moveSong(dir:Int, wrap:Bool = true):Void
  {
    var next:Int = songIndex + dir;
    if (wrap)
    {
      if (next < 0) next = rows.length - 1;
      if (next >= rows.length) next = 0;
    }
    else if (next < 0 || next >= rows.length) return;

    songIndex = next;
    slideStart = realTime;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"), wrap ? 1.0 : 0.5);
  }

  function trackSpec(album:Int, song:Int):Array<String>
  {
    return ALBUM_TRACKS[album][song].split("|");
  }

  function trackHasAudio(album:Int, song:Int):Bool
  {
    var spec:Array<String> = trackSpec(album, song);
    return spec[0] != "" && Assets.exists(Paths.sound(spec[0]));
  }

  function trackHasVocals(album:Int, song:Int):Bool
  {
    var spec:Array<String> = trackSpec(album, song);
    return spec.length > 1 && spec[1] != "";
  }

  function showTrack():Void
  {
    var onScreen:Bool = page == PAGE_PLAYER && nextPage == -1 && pageMode[PAGE_PLAYER] == MODE_IN;
    if (!onScreen)
    {
      applyTrack();
      return;
    }

    trackAnimStart = realTime;
    trackAnimSwapped = false;
    trackAnimMoving = trackAnimDir;
    trackAnimCover = shownAlbum != trackAlbum;
    refreshButtons();
  }

  function applyTrack():Void
  {
    shownAlbum = trackAlbum;

    var spec:Array<String> = trackSpec(trackAlbum, trackSong);
    var artist:String = spec.length > 2 && spec[2] != "" ? spec[2] : DEFAULT_ARTIST;

    playerCover.loadTexture("ui/hex/hex_jukebox/cover" + ALBUMS[trackAlbum]);
    setSong(ALBUM_SONGS[trackAlbum][trackSong], artist);
    refreshButtons();
  }

  var trackPaths:Array<String> = [];

  function release(sound:FunkinSound, path:String):Void
  {
    if (sound == null) return;

    @:privateAccess
    var raw = sound._sound;

    sound.destroy();

    if (path == null || trackPaths.indexOf(path) != -1) return;

    var cached:String = Paths.sound(path) + ".partial-0-1";
    if (FunkinAssetCache.instance.removeSound(cached) && raw != null) raw.close();
  }

  function stopTrack():Void
  {
    var paths:Array<String> = trackPaths;
    var loadedPaths:Array<String> = trackLoaded;
    trackPaths = [];
    trackLoaded = [];

    if (inst != null)
    {
      inst.onComplete = null;
      inst.stop();
      release(inst, loadedPaths.length > 0 ? loadedPaths[0] : null);
      inst = null;
    }

    for (i in 0...vocals.length)
    {
      vocals[i].stop();
      release(vocals[i], i + 1 < loadedPaths.length ? loadedPaths[i + 1] : null);
    }
    vocals = [];

    trackEnded = false;
    loadToken++;
    loading = false;
  }

  function playTrack(album:Int, song:Int):Bool
  {
    if (!trackHasAudio(album, song))
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/bzzt"));
      return false;
    }

    stopTrack();

    if (FlxG.sound.music != null) FlxG.sound.music.stop();

    var spec:Array<String> = trackSpec(album, song);

    var paths:Array<String> = [spec[0]];
    if (trackHasVocals(album, song))
    {
      for (path in spec[1].split(","))
      {
        if (Assets.exists(Paths.sound(path))) paths.push(path);
      }
    }

    loadTrack(paths);

    trackAlbum = album;
    trackSong = song;
    playingAlbum = album;
    playingSong = song;
    everPlayed = true;
    paused = false;

    showTrack();
    return true;
  }

  function loadTrack(paths:Array<String>):Void
  {
    var token:Int = loadToken;
    var loaded:Array<FunkinSound> = [for (path in paths) null];
    var remaining:Int = paths.length;
    loading = true;
    trackPaths = paths.copy();
    trackLoaded = [];

    for (i in 0...paths.length)
    {
      var volume:Float = i == 0 || vocalsOn ? 1.0 : 0.0;
      var onEnd:Void->Void = i == 0 ? function() trackEnded = true : null;

      FunkinSound.loadPartial(Paths.sound(paths[i]), 0, 1, volume, false, false, false, onEnd).future.onComplete(function(sound:FunkinSound)
      {
        if (token != loadToken)
        {
          release(sound, paths[i]);
          return;
        }

        loaded[i] = sound;
        remaining--;
        if (remaining == 0) startLoaded(loaded, paths);
      });
    }
  }

  var trackLoaded:Array<String> = [];

  function startLoaded(loaded:Array<FunkinSound>, paths:Array<String>):Void
  {
    loading = false;

    if (loaded[0] == null)
    {
      trackPaths = [];
      for (i in 0...loaded.length)
        release(loaded[i], paths[i]);
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/bzzt"));
      refreshButtons();
      return;
    }

    inst = loaded[0];
    trackLoaded = [paths[0]];
    for (i in 1...loaded.length)
    {
      if (loaded[i] == null) continue;

      vocals.push(loaded[i]);
      trackLoaded.push(paths[i]);
    }

    inst.volume = 0;
    inst.play();
    for (voice in vocals)
    {
      voice.volume = 0;
      voice.play();
    }

    inst.time = 0;
    inst.volume = 1.0;
    for (voice in vocals)
    {
      voice.time = 0;
      voice.volume = vocalsOn ? 1.0 : 0.0;
    }
    forceSyncFrames = 3;

    paused = false;
    refreshButtons();
  }

  function stepTrack(dir:Int):Void
  {
    var count:Int = ALBUM_SONGS[trackAlbum].length;
    var next:Int = trackSong;
    for (i in 0...count)
    {
      next = (next + dir + count) % count;
      if (trackHasAudio(trackAlbum, next))
      {
        trackAnimDir = dir < 0 ? -1 : 1;
        playTrack(trackAlbum, next);
        trackAnimDir = 1;
        return;
      }
    }
  }

  function trackBack():Void
  {
    if (inst != null && inst.time > RESTART_AFTER)
    {
      inst.time = 0;
      forceSyncFrames = 3;
      return;
    }

    stepTrack(-1);
  }

  function togglePlay():Void
  {
    if (loading) return;

    if (inst == null)
    {
      playTrack(trackAlbum, trackSong);
      return;
    }

    paused = !paused;

    if (paused)
    {
      inst.pause();
      for (voice in vocals)
        voice.pause();
    }
    else
    {
      inst.resume();
      for (voice in vocals)
        voice.resume();
      forceSyncFrames = 3;
    }

    refreshButtons();
  }

  function toggleVocals():Void
  {
    if (!micUsable()) return;

    vocalsOn = !vocalsOn;
    for (voice in vocals)
      voice.volume = vocalsOn ? 1.0 : 0.0;

    refreshButtons();
  }

  function syncVocals(force:Bool = false):Void
  {
    if (inst == null || paused) return;

    for (voice in vocals)
    {
      if (force || Math.abs(voice.time - inst.time) > VOCAL_DRIFT) voice.time = inst.time;
    }
  }

  function micUsable():Bool
  {
    return trackHasVocals(trackAlbum, trackSong);
  }

  function refreshButtons():Void
  {
    if (playerButtons.length < PLAYER_BUTTONS.length) return;

    var play:FunkinSprite = playerButtons[BUTTON_PLAY];
    var running:Bool = loading || (inst != null && !paused);
    play.loadTexture("ui/hex/hex_jukebox/" + (running ? "buttonPause" : "buttonPlay"));

    var playSpot:Array<Float> = spotOf(PAGE_PLAYER, play);
    playSpot[0] = PLAYER_BUTTON_X[BUTTON_PLAY] + (56 - play.width) / 2;
    playSpot[1] = PLAYER_BUTTON_BOTTOM - play.height;
    playSpot[2] = play.height;

    var mic:FunkinSprite = playerButtons[BUTTON_VOCALS];
    mic.color = micUsable() ? 0xFFFFFFFF : 0xFF7F7F7F;
    spotOf(PAGE_PLAYER, mic)[3] = !micUsable() ? MIC_NONE_ALPHA : (vocalsOn ? 1 : MIC_MUTED_ALPHA);

    if (buttonIndex == BUTTON_VOCALS && !micUsable()) buttonIndex = BUTTON_FORWARD;
  }

  function pressButton():Void
  {
    flashButton(playerButtons[buttonIndex]);
    var skipping:Bool = buttonIndex == BUTTON_BACK || buttonIndex == BUTTON_FORWARD;
    FunkinSound.playOnce(Paths.sound(skipping ? "ui/hex/sounds/title_select" : "ui/hex/sounds/title_click"));

    switch (buttonIndex)
    {
      case BUTTON_LIST:
        switchPage();
      case BUTTON_BACK:
        trackBack();
      case BUTTON_PLAY:
        togglePlay();
      case BUTTON_FORWARD:
        stepTrack(1);
      case BUTTON_VOCALS:
        toggleVocals();
    }
  }

  function trackAnimItems():Array<FlxSprite>
  {
    var items:Array<FlxSprite> = [songTitle, songSubtitle, songArtist];
    if (trackAnimCover) items.push(playerCover);
    return items;
  }

  function updateTrackAnim():Void
  {
    if (trackAnimStart < 0) return;

    var t:Float = realTime - trackAnimStart;
    var drift:Float = 0;
    var alpha:Float = 1;

    if (t < TRACK_OUT_TIME)
    {
      var k:Float = FlxEase.quadIn(t / TRACK_OUT_TIME);
      drift = TRACK_OUT_DRIFT * k * trackAnimMoving;
      alpha = 1 - k;
    }
    else
    {
      if (!trackAnimSwapped)
      {
        trackAnimSwapped = true;
        applyTrack();
      }

      var k:Float = Math.min((t - TRACK_OUT_TIME) / TRACK_IN_TIME, 1);
      drift = FlxMath.lerp(TRACK_IN_DISTANCE * trackAnimMoving, 0, FlxEase.circOut(k));
      alpha = k;

      if (k >= 1) trackAnimStart = -1;
    }

    for (item in trackAnimItems())
    {
      var spot:Array<Float> = spotOf(PAGE_PLAYER, item);
      spot[5] = drift;
      spot[3] = alpha;
    }
  }

  function flashButton(button:FlxSprite):Void
  {
    for (other in playerButtons)
      other.shader = null;

    button.shader = invertShader;
    invertIntensity = 1;
    invertShader.setFloat("uIntensity", invertIntensity);
  }

  function updateInvert(elapsed:Float):Void
  {
    if (invertIntensity <= 0) return;

    invertIntensity = FlxMath.lerp(invertIntensity, 0, 0.3 * elapsed * 60);
    if (invertIntensity < 0.01) invertIntensity = 0;
    invertShader.setFloat("uIntensity", invertIntensity);
  }

  function updatePlayback():Void
  {
    if (trackEnded)
    {
      trackEnded = false;
      stepTrack(1);
    }

    syncVocals(forceSyncFrames > 0);
    if (forceSyncFrames > 0) forceSyncFrames--;

    playingIcon.animation.paused = inst == null || paused;

    if (!everPlayed && (trackAlbum != albumIndex || trackSong != songIndex) && pendingAlbum == 0)
    {
      trackAlbum = albumIndex;
      trackSong = songIndex;
      showTrack();
    }
  }

  function confirmSong():Void
  {
    if (!playTrack(albumIndex, songIndex)) return;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));

    buttonIndex = BUTTON_PLAY;
    switchPage();
  }

  function switchPage():Void
  {
    if (nextPage != -1) return;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
    nextPage = page == PAGE_MUSIC ? PAGE_PLAYER : PAGE_MUSIC;
    slideOut(page);
  }

  function changeAlbum(dir:Int):Void
  {
    pendingAlbum = dir;
    slideOut(PAGE_MUSIC);
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
  }

  function applyAlbum(dir:Int):Void
  {
    albumIndex += dir;
    if (albumIndex < 0) albumIndex = ALBUMS.length - 1;
    if (albumIndex >= ALBUMS.length) albumIndex = 0;

    songIndex = 0;
    listScroll = 0;
    slideStart = realTime;
    buildRows();
    layoutList(0);
  }

  override public function onFocusLost():Void
  {
    super.onFocusLost();
    unfocused = true;
  }

  override public function onFocus():Void
  {
    super.onFocus();
    unfocused = false;
    forceSyncFrames = 3;
  }

  override public function destroy():Void
  {
    FlxG.autoPause = wasAutoPause;
    stopTrack();
    HexTouch.clear();
    super.destroy();
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    if (HexTouch.backButton != null) HexTouch.backButton.setPosition(20, 10);
    if (controlsTouch != HexTouch.active) setControls();
    super.update(elapsed);

    if (unfocused) FlxG.sound.volume = focusedVolume;
    else focusedVolume = FlxG.sound.volume;

    realTime += elapsed;
    swirly.setFloat("uTime", realTime * 0.2);

    if (!hasPlayedIn && realTime > 0.1)
    {
      hasPlayedIn = true;
      transition.transitionOut();

      windowSlideStart = realTime;
      slideIn(page);
    }

    var windowX:Float = windowRestX;
    if (windowSlideStart < 0) windowX = FlxG.width;
    else windowX = FlxMath.lerp(FlxG.width, windowRestX, FlxEase.circOut(progress(windowSlideStart, 0, WINDOW_SLIDE_TIME)));

    albumHeader.origin.set(0, 0);
    songTitle.origin.set(0, 0);
    songSubtitle.origin.set(0, 0);
    layoutList(elapsed);
    placeWindow(windowX);
    placePages(windowX);
    clipRows();
    placeSelection();
    personaSelection.updateShader(elapsed);
    updatePlayback();
    updateTrackAnim();
    updateInvert(elapsed);

    if (leaving || !hasPlayedIn) return;

    if (FlxG.keys.justPressed.ESCAPE)
    {
      goBack();
      return;
    }

    if (FlxG.keys.justPressed.SHIFT && pendingAlbum == 0) switchPage();

    if (nextPage != -1 || pendingAlbum != 0) return;

    if (page == PAGE_MUSIC)
    {
      if (FlxG.keys.justPressed.LEFT || HexTouch.justSwipedRight) changeAlbum(-1);
      else if (FlxG.keys.justPressed.RIGHT || HexTouch.justSwipedLeft) changeAlbum(1);

      if (FlxG.keys.justPressed.UP) moveSong(-1);
      else if (FlxG.keys.justPressed.DOWN) moveSong(1);

      holdScroll(elapsed);

      if (FlxG.keys.justPressed.ENTER || touchList()) confirmSong();
    }
    else
    {
      if (FlxG.keys.justPressed.LEFT) moveButton(-1);
      else if (FlxG.keys.justPressed.RIGHT) moveButton(1);

      if (FlxG.keys.justPressed.ENTER || touchButtons()) pressButton();
    }
  }

  var dragSteps:Int = 0;

  function goBack():Void
  {
    if (leaving || !hasPlayedIn) return;

    if (page == PAGE_PLAYER)
    {
      if (nextPage == -1 && pendingAlbum == 0) switchPage();
      return;
    }

    leaving = true;
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    transition.transitionIn();

    transition.onComplete = function(out:Bool)
    {
      stopTrack();
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 3;
      HexPurge.next();
      FlxG.switchState(function() return mm);
    };
  }

  function touchList():Bool
  {
    if (HexTouch.touch == null) return false;

    if (HexTouch.touch.justPressed) dragSteps = 0;

    if (HexTouch.pressed)
    {
      var steps:Int = Std.int(-HexTouch.dragY / ROW_STEP);
      while (dragSteps != steps)
      {
        var dir:Int = steps > dragSteps ? 1 : -1;
        dragSteps += dir;
        moveSong(dir, false);
      }
      return false;
    }

    if (!HexTouch.tapped()) return false;

    var touchX:Float = HexTouch.touch.gameX;
    var touchY:Float = HexTouch.touch.gameY;

    for (i in 0...rows.length)
    {
      var top:Float = rowTop(i);
      if (top < ROW_TOP - ROW_STEP * 0.5 || top + ROW_STEP > LIST_BOTTOM + ROW_STEP * 0.5) continue;
      if (touchY < top || touchY > top + ROW_STEP) continue;
      if (touchX < rows[i].x - 20 || touchX > rows[i].x + rowRoom(i) + 20) continue;

      if (i == songIndex) return true;

      songIndex = i;
      slideStart = realTime;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      return false;
    }
    return false;
  }

  function touchButtons():Bool
  {
    if (!HexTouch.tapped()) return false;

    for (i in 0...playerButtons.length)
    {
      if (!HexTouch.overlaps(playerButtons[i])) continue;
      if (i == BUTTON_VOCALS && !micUsable()) return false;
      if (i == buttonIndex) return true;

      buttonIndex = i;
      personaSelection.pos = selectionQuad();
      lastSelectMove = realTime;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      return false;
    }
    return false;
  }
}
