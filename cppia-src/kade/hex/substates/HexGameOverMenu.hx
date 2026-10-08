package kade.hex.substates;

import kade.hex.util.HexPurge;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.Preferences;
import funkin.play.PlayState;
import funkin.play.PlayStatePlaylist;
import funkin.ui.MusicBeatSubState;
import kade.hex.menus.Anim;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.states.HexFreeplay;
import kade.hex.util.HexTouch;

class HexGameOverMenu extends MusicBeatSubState
{
  var doFlash:Bool = true;
  var theBlackVoid:FlxSprite;
  var timer:Float = 0;
  var speed:Float = 0.5;

  var personaSelection:PersonaSelection;

  public var trans:HexTransitional;

  var music:FunkinSound;

  var retryButton:FunkinSprite;
  var retryScreen:FlxSprite;
  var quitButton:FlxText;

  var percentageText:FlxText;
  public var percentage:Float = 0;

  var gameOverScreen:FlxSprite;

  var selectedIndex:Int = 0;

  var playedMusic:Bool = false;
  var fadeOut:Bool = false;
  var chosen:Bool = false;
  var retryTimer:Float = 0;

  public function new()
  {
    super();
  }

  static final QUADS:Array<Array<Float>> = [
    [949, 400, 995, 345, 1047, 390, 955, 436],
    [1107, 407, 1138, 355, 1186, 384, 1147, 423]
  ];

  public function setPersonaQuadByIndex():Void
  {
    var q:Array<Float> = QUADS[selectedIndex];
    if (q != null) setPersonaQuad(q[0], q[1], q[2], q[3], q[4], q[5], q[6], q[7]);
  }

  public function forceQuadUpdate():Void
  {
    personaSelection.lerpPos = personaSelection.pos;
  }

  public function setPersonaQuad(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float):Void
  {
    var sx:Float = FlxG.scaleMode.scale.x;
    var sy:Float = FlxG.scaleMode.scale.y;
    personaSelection.pos = [[x1 * sx, y1 * sy], [x2 * sx, y2 * sy], [x3 * sx, y3 * sy], [x4 * sx, y4 * sy]];
  }

  function flipColor():Void
  {
    if (theBlackVoid.color == FlxColor.fromRGB(0, 120, 215)) theBlackVoid.color = FlxColor.BLACK;
    else theBlackVoid.color = FlxColor.fromRGB(0, 120, 215);
  }

  override public function create():Void
  {
    super.create();

    music = FunkinSound.load(Paths.music("ui/hex/music/gameOverHex/gameOverHex"), 1.0, true);

    theBlackVoid = new FlxSprite(0, 0);
    theBlackVoid.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    add(theBlackVoid);
    theBlackVoid.color = FlxColor.BLACK;

    gameOverScreen = new FlxSprite(0, 0, Paths.image("ui/hex/gameover_hex/screen"));
    add(gameOverScreen);
    gameOverScreen.visible = false;

    retryScreen = new FlxSprite(0, 0, Paths.image("ui/hex/gameover_hex/screenRetry"));
    add(retryScreen);
    retryScreen.visible = false;
    retryScreen.alpha = 0;

    var trimPercentage:Int = Math.floor(percentage * 100);

    percentageText = new FlxText(135, FlxG.height - 325, 0, trimPercentage + "% complete");
    percentageText.setFormat(Paths.font("ui/fonts/SegoeUI.ttf"), 24, FlxColor.WHITE, "left");
    add(percentageText);
    percentageText.visible = false;

    retryButton = FunkinSprite.createSparrow((FlxG.width / 2) + 315, FlxG.height - 345, "ui/hex/gameover_hex/retry");
    Anim.addByPrefix(retryButton, "idle", "retryStatic", 24, false);
    Anim.addByPrefix(retryButton, "press", "retrySelected", 24, false);
    Anim.play(retryButton, "idle");
    retryButton.alpha = 0;

    add(retryButton);

    quitButton = new FlxText(retryButton.x + 145, retryButton.y - 10, 0, "Quit");
    quitButton.setFormat(Paths.font("ui/fonts/SegoeUI.ttf"), 36, FlxColor.WHITE, "left");
    quitButton.alpha = 0;
    add(quitButton);

    personaSelection = new PersonaSelection();
    add(personaSelection);
    personaSelection.initShader(cameras[0]);
    personaSelection.enabled = false;

    personaSelection.color1 = [0, 120, 215];
    personaSelection.color3 = [255, 255, 255];

    doFlash = Preferences.flashingLights;
    timer = 0;
    speed = 0.75;

    if (!doFlash)
    {
      gameOverScreen.alpha = 0;
      percentageText.alpha = 0;
    }

    setPersonaQuadByIndex();
    forceQuadUpdate();

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/hex_gameover_loss"), 1, onSoundComplete);

    add(trans);
    trans.cameras = [camera];
  }

  function onSoundComplete():Void
  {
    music.play();

    playedMusic = true;
    personaSelection.mix = 0;
    personaSelection.enabled = true;
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update();
    super.update(elapsed);

    personaSelection.updateShader(elapsed);

    if (playedMusic && retryButton.alpha < 1 && !fadeOut)
    {
      retryButton.alpha += elapsed;
      quitButton.alpha += elapsed;
      personaSelection.mix += elapsed;
    }
    else if (playedMusic && !fadeOut && !chosen)
    {
      if (FlxG.keys.justPressed.LEFT)
      {
        selectedIndex--;
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        if (selectedIndex < 0) selectedIndex = 1;
        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.RIGHT)
      {
        selectedIndex++;
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        if (selectedIndex > 1) selectedIndex = 0;
        setPersonaQuadByIndex();
      }

      var tappedIndex:Int = HexTouch.tappedQuad(QUADS);
      if (tappedIndex != -1 && tappedIndex != selectedIndex)
      {
        selectedIndex = tappedIndex;
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.ENTER || tappedIndex != -1)
      {
        switch (selectedIndex)
        {
          case 0:
            music.stop();
            fadeOut = true;
            Anim.play(retryButton, "press");
            retryButton.offset.set(320, 345);
            personaSelection.enabled = false;
            FunkinSound.playOnce(Paths.sound("ui/hex/sounds/hex_gameover_pressed"));
          case 1:
            FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
            music.fadeOut(0.5);
            if (!PlayStatePlaylist.isStoryMode)
            {
              chosen = true;
              personaSelection.enabled = false;
              trans.transitionIn();
              trans.onComplete = function(out:Bool)
              {
                var freeplay:HexFreeplay = new HexFreeplay();
                freeplay.gatherSongs();

                var diffId:Int = 2;
                switch (PlayState.instance.currentDifficulty)
                {
                  case "easy":
                    diffId = 0;
                  case "normal":
                    diffId = 1;
                }

                freeplay.select_song_by_id(PlayState.instance.currentSong.id);
                freeplay.savedDiff = diffId;
                freeplay.useNewVariation = PlayState.instance.currentVariation == "new";
                HexPurge.next(true);
                FlxG.switchState(function() return freeplay);
              };
            }
        }
      }
    }
    else if (fadeOut)
    {
      retryButton.alpha -= elapsed * 1.5;
      if (retryButton.alpha < 0.25)
      {
        retryScreen.visible = true;
        retryScreen.alpha += elapsed;
        if (retryScreen.alpha >= 1)
        {
          retryScreen.alpha = 1;
          retryTimer += elapsed;
          if (retryTimer > 2.6 && !trans._inTween)
          {
            trans.transitionIn();
            trans.onComplete = function(out:Bool)
            {
              PlayState.instance.needsReset = true;
              close();
            };
          }
        }
      }
      quitButton.alpha -= elapsed * 4;
      personaSelection.mix -= elapsed * 4;

      gameOverScreen.alpha -= elapsed * 4;
      percentageText.alpha -= elapsed * 4;

      var color:FlxColor = theBlackVoid.color;
      if (color.blue > 0 || color.green > 0)
      {
        var g:Int = Std.int(FlxMath.lerp(color.green, 0, elapsed * 4));
        var b:Int = Std.int(FlxMath.lerp(color.blue, 0, elapsed * 4));
        theBlackVoid.color = FlxColor.fromRGB(0, g, b);
      }
      else
      {
        theBlackVoid.color = FlxColor.BLACK;
      }
    }

    if (fadeOut) return;

    if (speed > 0)
    {
      if (doFlash)
      {
        timer += elapsed;
        speed -= elapsed * 0.5;
        var tSpeed:Float = 0.4 - (0.4 * (1 - (speed / 0.85)));
        if (timer >= Math.max(tSpeed, 0.06))
        {
          flipColor();
          timer = 0;
        }
      }
      else
      {
        speed -= elapsed * 0.5;
        var t:Float = 1 - (speed / 0.75);
        if (t > 1) t = 1;
        var g:Int = Std.int(FlxMath.lerp(0, 120, t));
        var b:Int = Std.int(FlxMath.lerp(0, 215, t));
        theBlackVoid.color = FlxColor.fromRGB(0, g, b);
      }
    }
    else if (!gameOverScreen.visible)
    {
      percentageText.visible = true;
      gameOverScreen.visible = true;
    }
    else
    {
      theBlackVoid.color = FlxColor.fromRGB(0, 120, 215);
      if (gameOverScreen.alpha < 1)
      {
        gameOverScreen.alpha += elapsed * 0.5;
        percentageText.alpha += elapsed * 0.5;
      }
    }
  }

  override public function destroy():Void
  {
    if (trans != null)
    {
      remove(trans);
      trans.onComplete = null;
      trans = null;
    }

    if (camera != null) camera.filters = [];
    super.destroy();
  }
}
