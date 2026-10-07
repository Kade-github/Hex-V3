package kade.hex.objects.freeplay;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Paths;
import funkin.data.song.SongData.SongMetadata;
import funkin.play.song.Song;
import funkin.play.song.Song.SongDifficulty;
import funkin.util.Constants;
import kade.hex.objects.BetterAtlasText;

class CapsuleLeft extends FlxSpriteGroup
{
  var time:Float = 0;
  var startTime:Float = -1;
  var slideDone:Bool = false;

  var startBump:Float = -1;
  var bumping:Bool = false;

  var offsetMap:Map<Int, Int> = new Map();
  var savedYOffsets:Map<Int, Float> = new Map();

  var songTitle:BetterAtlasText;
  var songArtist:BetterAtlasText;

  var songDiff:DifficultySelect;
  var starDisplay:StarDisplay;

  var originText:BetterAtlasText;
  var bpmText:BetterAtlasText;
  var percentageText:BetterAtlasText;

  var scoreText:HexScoreText;
  var versionTag:FlxSprite;
  var tagShown:Bool = false;
  var tagProgress:Float = 0;

  public var title(get, set):String;

  // Difficulty indices the current song actually has a chart for.
  public var validDiffs:Array<Int> = [0, 1, 2];

  var maxDiff(get, never):Int;

  function get_maxDiff():Int
  {
    return validDiffs[validDiffs.length - 1];
  }

  function get_title():String
  {
    return songTitle.text;
  }

  function set_title(value:String):String
  {
    songTitle.text = value;
    return value;
  }

  public var artist(get, set):String;

  function get_artist():String
  {
    return songArtist.text;
  }

  function set_artist(value:String):String
  {
    songArtist.text = value;
    return value;
  }

  public var onComplete:Void->Void = null;

  public function tween():Void
  {
    startTime = time;
    slideDone = false;
  }

  public function resetMembers():Void
  {
    for (sprite in members)
    {
      sprite.x = -FlxG.width;
    }
  }

  function addSeperator(width:Int = 0, offset:Int = 25):Void
  {
    var last:FlxSprite = members[members.length - 1];
    var sep:FlxSprite = new FlxSprite(0, last.y + last.height + offset);
    sep.loadGraphic(Paths.image("ui/hex/hex_freeplay/line"));
    sep.scrollFactor.set();
    sep.scale.set(0.75, 0.75);
    sep.updateHitbox();

    if (width > 0)
    {
      sep.setGraphicSize(width, Std.int(sep.height));
      sep.updateHitbox();
    }
    add(sep);

    offsetMap.set(members.length - 1, 15);
  }

  public function setDifficulty(diff:Int):Void
  {
    if (validDiffs.indexOf(diff) != -1)
    {
      songDiff.diffIndex = diff;
      return;
    }

    // Nearest difficulty at or below the requested one, so erect falls back to hard.
    songDiff.diffIndex = validDiffs[0];

    for (valid in validDiffs)
    {
      if (valid <= diff) songDiff.diffIndex = valid;
    }
  }

  public function shiftDifficulty(dir:Int):Void
  {
    var pos:Int = validDiffs.indexOf(songDiff.diffIndex);

    if (pos == -1) pos = 0;
    else pos = (pos + dir + validDiffs.length) % validDiffs.length;

    songDiff.diffIndex = validDiffs[pos];
  }

  public function getDifficulty():Int
  {
    return songDiff.diffIndex;
  }

  public function bumpDifficulty(diff:SongDifficulty):Void
  {
    if (diff == null)
    {
      title = "No Difficulty";
      artist = "No Artist";
      songDiff.fakeDiff(songDiff.diffIndex);
      return;
    }
    if (title == "No Difficulty")
    {
      bump();
      title = diff.songName;
      artist = diff.songArtist;
    }

    songDiff.setDifficulty(songDiff.diffIndex, diff.difficultyRating, maxDiff);
    starDisplay.setDifficulty(diff.difficultyRating);
  }

  public function setSongDifficultyNumber(diff:SongDifficulty):Void
  {
    songDiff.setNum(diff.difficultyRating);
    starDisplay.setDifficulty(diff.difficultyRating);
  }

  public function setScore(score:Int):Void
  {
    scoreText.score = score;
  }

  public function setVersionTag(show:Bool, instant:Bool = false):Void
  {
    tagShown = show;
    if (!show && instant)
    {
      tagProgress = 0;
      versionTag.visible = false;
    }
  }

  public function setBadge(rank:Int):Void
  {
    scoreText.set_badge_rank(rank);
  }

  // The song can carry extra variations (like "new"), those hold their own name and bpm.
  function getDefaultMetadata(song:Song):SongMetadata
  {
    var metadata:Array<SongMetadata> = song.getRawMetadata();

    for (i in 0...metadata.length)
    {
      if (metadata[i].variation == Constants.DEFAULT_VARIATION) return metadata[i];
    }

    return metadata[0];
  }

  public function setSong(song:Song, diff:SongDifficulty, origin:String, percentage:Float):Void
  {
    if (song == null)
    {
      title = "No Song";
      artist = "No Artist";
      songDiff.setNum(0);
      return;
    }
    if (diff == null)
    {
      title = "No Difficulty";
      artist = "No Artist";
      songDiff.setNum(0);
      return;
    }

    bump();

    var data:SongMetadata = getDefaultMetadata(song);

    if (data.songName == null || data.songName == "") title = "Unknown Title";
    else title = data.songName;
    if (data.artist == null || data.artist == "") artist = "Unknown Artist";
    else artist = data.artist;

    originText.text = StringTools.replace(origin, "(Freeplay)", "");
    bpmText.text = Std.string(Math.round(data.timeChanges[0].bpm));
    percentageText.text = Std.string(Math.round(percentage * 100)) + "%";

    songDiff.setDifficulty(songDiff.diffIndex, diff.difficultyRating, maxDiff);
    starDisplay.setDifficulty(diff.difficultyRating);
  }

  function bump():Void
  {
    startBump = time;
    bumping = true;
  }

  public function new()
  {
    super();

    add(new Border(true));

    songTitle = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 105, "R.A.M");
    songTitle.setCharOffset("g", 0, 8);
    songTitle.setCharOffset("p", 0, 8);
    songTitle.setCharOffset("y", 0, 8);
    songTitle.setCharOffset("j", 0, 8);
    songTitle.setCharOffset("'", 1, -32);
    songTitle.setCharOffset("p", 0, 8);
    songTitle.scale.set(0.7, 0.7);
    songTitle.letterSpacing = -4;

    offsetMap.set(1, 30);

    add(songTitle);

    songArtist = new BetterAtlasText(Paths.image("ui/fonts/hex_artist"), Paths.xml("ui/fonts/hex_artist"), 0, 150, "YingYang48");
    songArtist.setCharOffset("g", 0, 8);
    songArtist.letterSpacing = -2;

    offsetMap.set(2, 20);

    add(songArtist);

    addSeperator(420, 50);

    members[members.length - 1].y -= 5;

    var difficultyText:FlxSprite = new FlxSprite(0, 240);
    difficultyText.loadGraphic(Paths.image("ui/hex/hex_freeplay/difficulty"));
    difficultyText.scrollFactor.set();
    difficultyText.scale.set(0.65, 0.65);
    difficultyText.updateHitbox();
    add(difficultyText);

    offsetMap.set(4, 20);

    songDiff = new DifficultySelect();
    add(songDiff);
    songDiff.y = 240;
    songDiff.scrollFactor.set();

    offsetMap.set(5, 280);

    starDisplay = new StarDisplay();
    add(starDisplay);
    starDisplay.y = 275;

    offsetMap.set(6, 20);

    addSeperator(468);

    members[members.length - 1].y += 25;

    var misc:FlxSprite = new FlxSprite(0, 400);
    misc.loadGraphic(Paths.image("ui/hex/hex_freeplay/misc"));
    misc.scale.set(0.69, 0.69);
    misc.scrollFactor.set();
    misc.updateHitbox();
    add(misc);

    offsetMap.set(8, 20);

    originText = new BetterAtlasText(Paths.image("ui/fonts/hex_misc"), Paths.xml("ui/fonts/hex_misc"), 0, 452, "Week X");
    add(originText);
    offsetMap.set(9, 23);
    originText.letterSpacing = -2;

    bpmText = new BetterAtlasText(Paths.image("ui/fonts/hex_misc"), Paths.xml("ui/fonts/hex_misc"), 0, 452, "0");
    add(bpmText);
    offsetMap.set(10, 190);
    bpmText.letterSpacing = -2;

    percentageText = new BetterAtlasText(Paths.image("ui/fonts/hex_misc"), Paths.xml("ui/fonts/hex_misc"), 0, 452, "0%");
    add(percentageText);
    offsetMap.set(11, 335);
    percentageText.letterSpacing = -2;

    addSeperator(510, 40);

    var highScoreText:FlxSprite = new FlxSprite(0, 530);
    highScoreText.loadGraphic(Paths.image("ui/hex/hex_freeplay/highscore"));
    highScoreText.scrollFactor.set();
    highScoreText.scale.set(0.69, 0.69);
    highScoreText.updateHitbox();
    add(highScoreText);

    offsetMap.set(members.length - 1, 20);

    scoreText = new HexScoreText();
    var last:FlxSprite = members[members.length - 1];
    scoreText.y = last.y + last.height - 5;
    add(scoreText);

    offsetMap.set(members.length - 1, 20);

    // Kept last so the index based offsets above stay the same, its x follows the title in update.
    versionTag = new FlxSprite(0, 112);
    versionTag.loadGraphic(Paths.image("ui/hex/hex_freeplay/tag2026"));
    versionTag.scrollFactor.set();
    versionTag.scale.set(0.8, 0.8);
    versionTag.updateHitbox();
    versionTag.visible = false;
    versionTag.alpha = 0;
    add(versionTag);

    for (i in 0...members.length)
    {
      savedYOffsets.set(i, members[i].y);
      if (!offsetMap.exists(i)) offsetMap.set(i, 0);
    }
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
    time += elapsed;

    if (startTime < 0) return;

    if (bumping)
    {
      var sinceBump:Float = time - startBump;
      if (sinceBump < 0.25)
      {
        var ease:Float = FlxEase.circOut(Math.min(1, sinceBump / 0.25));
        var lift:Float = FlxMath.lerp(10, 0, ease);
        for (i in 1...members.length)
        {
          members[i].y = savedYOffsets.get(i) - lift;
        }
      }
      else
      {
        for (i in 1...members.length)
        {
          members[i].y = savedYOffsets.get(i);
        }
        bumping = false;
      }
    }

    var diff:Float = time - startTime;

    if (!slideDone)
    {
      for (i in 0...members.length)
      {
        var sprite:FlxSprite = members[i];
        var speed:Float = i == 0 ? 1.5 : 0.8 + (i * 0.05);
        var d:Float = diff;
        if (i != 0)
        {
          if (d < 0.25) continue;
          d -= 0.25;
        }
        sprite.x = FlxMath.lerp(-FlxG.width, offsetMap.get(i), FlxEase.circOut(Math.min(1, d * speed)));
      }

      if (diff > 2.6)
      {
        for (i in 0...members.length)
        {
          members[i].x = offsetMap.get(i);
        }
        slideDone = true;
      }
    }

    tagProgress = FlxMath.bound(tagProgress + (tagShown ? elapsed : -elapsed) / 0.3, 0, 1);

    // Rises with a bounce on the way in, dips back down before dropping on the way out.
    var tagDrop:Float = tagShown ? 1 - FlxEase.backOut(tagProgress) : FlxEase.backIn(1 - tagProgress);

    versionTag.visible = tagProgress > 0;
    versionTag.alpha = tagProgress;
    versionTag.x = songTitle.x + songTitle.getTextWidth() + 12;
    versionTag.y = songTitle.y + (songTitle.getLineHeight() - versionTag.height) / 2 + tagDrop * 20;

    if (diff > 2.5 && onComplete != null)
    {
      onComplete();
      onComplete = null;
    }
  }
}
