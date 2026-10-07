package kade.hex.objects.story;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.data.song.SongRegistry;
import funkin.data.story.level.LevelRegistry;
import funkin.play.PlayStatePlaylist;
import funkin.play.song.Song;
import funkin.save.Save;
import funkin.save.Save.SaveScoreData;
import funkin.ui.story.Level;
import funkin.ui.transition.LoadingState;
import funkin.util.Constants;
import kade.hex.objects.BetterAtlasText;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.states.HexDialogueState;
import kade.hex.util.HexTouch;

/**
 * The difficulty and vocal version popup in the story menu.
 */
class StoryPopUp extends FlxSpriteGroup
{
  var diffSelection:FlxSprite;
  var newVocalSelection:FlxSprite;

  var easy:FlxSprite;
  var normal:FlxSprite;
  var hard:FlxSprite;

  var newVocal:FlxSprite;
  var oldVocal:FlxSprite;

  var highscoreText:BetterAtlasText;

  var selectionIndex:Int = 0;

  public var personaSelection:PersonaSelection;
  public var transitional:HexTransitional;

  public var reliquishedControl:Bool = false;

  public var weekSelectionIndex:Int = 0;
  public var useNewVocalSelection:Bool = false;
  var levels:Array<String> = ["Week X", "Weekend X", "Event Week"];
  var difficulties:Array<String> = ["easy", "normal", "hard"];

  public var highscore(default, set):Int = 0;

  function set_highscore(value:Int):Int
  {
    highscore = value;
    highscoreText.text = "Highscore: " + value;
    return value;
  }

  static final QUADS:Array<Array<Float>> = [
    [279, 347, 342, 269, 450, 325, 360, 375],
    [525, 360, 604, 269, 749, 309, 668, 375],
    [814, 338, 903, 272, 978, 322, 896, 380],
    [342, 497, 452, 441, 549, 475, 450, 520],
    [695, 497, 805, 441, 902, 475, 803, 520]
  ];

  function setPersonaQuadByIndex(offset:Int = 0):Void
  {
    var levelScore:Null<SaveScoreData> = Save.instance.getLevelScore(levels[weekSelectionIndex], difficulties[selectionIndex]);
    if (levelScore != null) highscore = levelScore.score;
    else highscore = 0;

    var q:Array<Float> = QUADS[selectionIndex + offset];
    if (q != null) setPersonaQuad(q[0], q[1], q[2], q[3], q[4], q[5], q[6], q[7]);
  }

  public function goBack():Void
  {
    if (reliquishedControl || !(diffSelection.visible || newVocalSelection.visible)) return;

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    if (newVocalSelection.visible)
    {
      showDifficultySelection();
      return;
    }
    reliquishedControl = true;
  }

  function tapSelection(quads:Array<Array<Float>>, offset:Int):Void
  {
    var tappedIndex:Int = HexTouch.tappedQuad(quads);
    if (tappedIndex == -1)
    {
      if (HexTouch.tapped() && !HexTouch.overlaps(offset == 0 ? diffSelection : newVocalSelection)) goBack();
      return;
    }

    if (tappedIndex != selectionIndex)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      selectionIndex = tappedIndex;
      setPersonaQuadByIndex(offset);
      return;
    }

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    acceptSelection();
  }

  function forceQuadUpdate():Void
  {
    personaSelection.lerpPos = personaSelection.pos;
  }

  function setPersonaQuad(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float):Void
  {
    var sx:Float = FlxG.scaleMode.scale.x;
    var sy:Float = FlxG.scaleMode.scale.y;
    personaSelection.pos = [[x1 * sx, y1 * sy], [x2 * sx, y2 * sy], [x3 * sx, y3 * sy], [x4 * sx, y4 * sy]];
  }

  public function new()
  {
    super();

    diffSelection = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/difficultyWindow"));
    newVocalSelection = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/songWindow"));

    diffSelection.x = FlxG.width / 2 - diffSelection.width / 2;
    diffSelection.y = FlxG.height / 2 - diffSelection.height / 2;

    newVocalSelection.x = FlxG.width / 2 - newVocalSelection.width / 2;
    newVocalSelection.y = FlxG.height / 2 - newVocalSelection.height / 2;

    easy = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/textEasy"));
    normal = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/textNormal"));
    hard = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/textHard"));

    highscoreText = new BetterAtlasText(Paths.image("ui/fonts/hex_default"), Paths.xml("ui/fonts/hex_default"), 0, 455, "Highscore:");
    highscoreText.alignment = "CENTER";
    highscoreText.setCharOffset("g", 0, 8);

    easy.x = diffSelection.x + 250;
    easy.y = diffSelection.y + 100;

    normal.x = easy.x + easy.width;
    normal.y = easy.y + 8;

    hard.x = normal.x + normal.width;
    hard.y = normal.y;

    highscoreText.x = diffSelection.x + diffSelection.width / 2;
    highscoreText.y = diffSelection.y + diffSelection.height - 170;

    newVocal = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/textNew"));
    oldVocal = new FlxSprite().loadGraphic(Paths.image("ui/hex/story-menu/textOld"));

    oldVocal.x = newVocalSelection.x + 235;

    newVocal.x = oldVocal.x + oldVocal.width - 120;
    newVocal.y = newVocalSelection.y + 350;
    oldVocal.y = newVocal.y;

    add(diffSelection);
    add(newVocalSelection);
    add(easy);
    add(normal);
    add(hard);
    add(newVocal);
    add(oldVocal);
    add(highscoreText);

    for (sprite in members)
    {
      sprite.scale.set(0.67, 0.67);
      sprite.alpha = 0;
      sprite.visible = false;
    }
  }

  var diffSelectionIndex:Int = 0;

  public function showDifficultySelection():Void
  {
    selectionIndex = 2;
    setPersonaQuadByIndex();
    forceQuadUpdate();
    diffSelection.visible = true;
    newVocalSelection.visible = false;

    easy.visible = true;
    normal.visible = true;
    hard.visible = true;

    newVocal.visible = false;
    oldVocal.visible = false;

    highscoreText.visible = true;

    easy.alpha = 0;
    normal.alpha = 0;
    hard.alpha = 0;

    diffSelection.alpha = 0;
    highscoreText.alpha = 0;
    reliquishedControl = false;
  }

  public function showVocalSelection():Void
  {
    diffSelectionIndex = selectionIndex;
    selectionIndex = 0;
    setPersonaQuadByIndex(3);
    forceQuadUpdate();
    diffSelection.visible = false;
    newVocalSelection.visible = true;

    easy.visible = false;
    normal.visible = false;
    hard.visible = false;

    newVocal.visible = true;
    oldVocal.visible = true;
    highscoreText.visible = false;

    newVocal.alpha = 0;
    oldVocal.alpha = 0;
    newVocalSelection.alpha = 0;
    reliquishedControl = false;
  }

  function startLevel():Void
  {
    var level:Null<Level> = LevelRegistry.instance.fetchEntry(levels[weekSelectionIndex]);
    if (level == null)
    {
      trace("[ERROR] Level not found: " + levels[weekSelectionIndex]);
      return;
    }

    PlayStatePlaylist.playlistSongIds = level.getSongs();
    PlayStatePlaylist.isStoryMode = true;
    PlayStatePlaylist.campaignScore = 0;

    HexDialogueState.resetProgress();

    var targetSong:String = PlayStatePlaylist.playlistSongIds.shift();
    var songEntry:Null<Song> = SongRegistry.instance.fetchEntry(targetSong, {variation: Constants.DEFAULT_VARIATION});

    if (songEntry == null)
    {
      trace("[ERROR] Song not found: " + targetSong);
      return;
    }

    PlayStatePlaylist.campaignId = levels[weekSelectionIndex];
    PlayStatePlaylist.campaignTitle = level.getTitle();
    PlayStatePlaylist.campaignDifficulty = difficulties[diffSelectionIndex];

    var targetVariation:String = songEntry.getFirstValidVariation(PlayStatePlaylist.campaignDifficulty);
    if (useNewVocalSelection) targetVariation = "new";

    personaSelection.mix = 0;

    var song:Song = songEntry;
    var useNew:Bool = useNewVocalSelection;
    transitional.transitionIn();
    transitional.onComplete = function(out:Bool)
    {
      LoadingState.loadPlayState(
        {
          targetSong: song,
          targetDifficulty: PlayStatePlaylist.campaignDifficulty,
          targetVariation: targetVariation,
          targetInstrumental: useNew ? "new" : ""
        }, true);
    };
  }

  function acceptSelection():Void
  {
    if (newVocalSelection.visible)
    {
      useNewVocalSelection = selectionIndex == 1;
      startLevel();
      return;
    }
    diffSelectionIndex = selectionIndex;
    if (weekSelectionIndex <= 1) showVocalSelection();
    else startLevel();
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (diffSelection.visible || newVocalSelection.visible)
    {
      if (FlxG.keys.justPressed.ESCAPE)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        if (newVocalSelection.visible)
        {
          showDifficultySelection();
          return;
        }
        reliquishedControl = true;
      }
    }

    if (!reliquishedControl)
    {
      if (diffSelection.visible && diffSelection.alpha >= 1) tapSelection(QUADS.slice(0, 3), 0);
      else if (newVocalSelection.visible && newVocalSelection.alpha >= 1) tapSelection(QUADS.slice(3, 5), 3);
    }

    if (diffSelection.visible)
    {
      if (FlxG.keys.justPressed.LEFT)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        selectionIndex = (selectionIndex - 1 + 3) % 3;
        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.RIGHT)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        selectionIndex = (selectionIndex + 1) % 3;
        setPersonaQuadByIndex();
      }

      if (FlxG.keys.justPressed.ENTER)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        acceptSelection();
      }
    }
    else if (newVocalSelection.visible)
    {
      if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        selectionIndex = 1 - selectionIndex;
        setPersonaQuadByIndex(3);
      }

      if (FlxG.keys.justPressed.ENTER)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        acceptSelection();
      }
    }

    if (reliquishedControl)
    {
      for (sprite in members)
      {
        if (!sprite.visible) continue;
        sprite.alpha -= elapsed * 4;
        if (sprite.alpha <= 0)
        {
          sprite.alpha = 0;
          sprite.visible = false;
        }
      }
    }
    else
    {
      for (sprite in members)
      {
        if (sprite.visible && sprite.alpha < 1)
        {
          sprite.alpha += elapsed * 4;
          if (sprite.alpha > 1) sprite.alpha = 1;
        }
      }
    }
  }
}
