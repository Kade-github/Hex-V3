package kade.hex.substates;

import kade.hex.util.HexPurge;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.play.PlayState;
import funkin.play.PlayStatePlaylist;
import funkin.ui.MusicBeatSubState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.states.HexFreeplay;
import kade.hex.util.HexTouch;

class HexEvilGameOver extends MusicBeatSubState
{
  var funnyMan:FunkinSprite;
  var flashSprite:FlxSprite;
  var topBlack:FlxSprite;
  var theBlackVoid:FlxSprite;
  var timer:Float = 0;
  var revealFor:Float = 0.4;
  var revealAt:Float = 0;

  var personaSelection:PersonaSelection;

  public var trans:HexTransitional;

  var music:FunkinSound;

  var retryButton:FunkinSprite;
  var quitButton:FunkinSprite;

  var gameOverScreen:FlxSprite;

  var selectedIndex:Int = 0;

  var tvNoise:FlxRuntimeShader;

  var playedMusic:Bool = false;
  var fadeOut:Bool = false;
  var chosen:Bool = false;
  var startClipping:Bool = false;
  var lilDelay:Float = 0;

  public function new()
  {
    super();
  }

  static final QUADS:Array<Array<Float>> = [
    [1005, 245, 1118, 265, 1064, 327, 995, 276],
    [1018, 362, 1080, 388, 1044, 422, 1006, 410]
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

  override public function create():Void
  {
    super.create();

    music = FunkinSound.load(Paths.music("ui/hex/music/ransomwareMusic/ransomwareMusic"), 1.0, true);

    theBlackVoid = new FlxSprite(0, 0);
    theBlackVoid.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    add(theBlackVoid);
    theBlackVoid.color = FlxColor.BLACK;

    topBlack = new FlxSprite(0, 0);
    topBlack.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    topBlack.alpha = 0;

    flashSprite = new FlxSprite(0, 0);
    flashSprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    flashSprite.alpha = 0;
    flashSprite.color = 0xFFDE2962;

    funnyMan = FunkinSprite.create(0, 0, "ui/hex/gameover_hex_evil/flash");
    funnyMan.alpha = 0;

    tvNoise = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/tv_noise_curved")));
    tvNoise.setFloat("scanIntensity", 0.2);
    tvNoise.setFloat("crtCurvature", 0.3);

    funnyMan.shader = tvNoise;

    gameOverScreen = new FlxSprite(0, 0, Paths.image("ui/hex/gameover_hex_evil/text"));
    add(gameOverScreen);
    gameOverScreen.clipRect = FlxRect.get(0, 0, gameOverScreen.width, 0);
    gameOverScreen.visible = false;

    retryButton = FunkinSprite.create((FlxG.width / 2) + 370, FlxG.height - 445, "ui/hex/gameover_hex_evil/retry");
    retryButton.alpha = 0;
    add(retryButton);

    quitButton = FunkinSprite.create(retryButton.x, retryButton.y + 100, "ui/hex/gameover_hex_evil/quit");
    quitButton.alpha = 0;
    add(quitButton);

    personaSelection = new PersonaSelection();
    add(personaSelection);
    personaSelection.initShader(cameras[0]);
    personaSelection.mix = 0;

    personaSelection.color1 = [0, 0, 0];
    personaSelection.color2 = [222, 41, 98];
    personaSelection.color3 = [0, 0, 0];

    setPersonaQuadByIndex();
    forceQuadUpdate();

    gameOverScreen.visible = true;

    trans.noSound = true;

    add(funnyMan);
    add(flashSprite);
    add(topBlack);

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/evil_death"));

    add(trans);
    trans.cameras = [camera];
  }

  function onSoundComplete():Void
  {
    trans.transitionIn();
    trans.noSound = false;
    trans.onComplete = function(out:Bool)
    {
      PlayState.instance.needsReset = true;
      close();
    };
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update();
    super.update(elapsed);
    tvNoise.setFloat("iTime", timer);
    timer += elapsed;

    if (timer >= 0.5 && timer < 0.6) startClipping = true;
    personaSelection.updateShader(elapsed);

    if (startClipping)
    {
      var clipRect:FlxRect = gameOverScreen.clipRect;

      revealAt += elapsed;

      var t:Float = revealFor <= 0 ? 1 : revealAt / revealFor;
      if (t > 1) t = 1;

      clipRect.height = Math.ceil(gameOverScreen.height * t);
      gameOverScreen.clipRect = clipRect;

      if (t >= 1)
      {
        lilDelay += elapsed;
        if (lilDelay < 0.75) return;

        startClipping = false;
        music.play();
        personaSelection.enabled = true;
        playedMusic = true;
      }
    }

    if (flashSprite.alpha > 0)
    {
      flashSprite.alpha -= elapsed * 0.5;
      if (flashSprite.alpha < 0) flashSprite.alpha = 0;
    }
    if (flashSprite.alpha <= 0 && !quitButton.visible && playedMusic)
    {
      topBlack.alpha += elapsed * 0.32;
      if (topBlack.alpha > 1) topBlack.alpha = 1;
    }
    if (playedMusic && retryButton.alpha < 1 && !fadeOut)
    {
      retryButton.alpha += elapsed * 2;
      quitButton.alpha += elapsed * 2;
      personaSelection.mix += elapsed * 2;
      if (retryButton.alpha >= 1)
      {
        retryButton.alpha = 1;
        quitButton.alpha = 1;
        personaSelection.mix = 1;
      }
    }
    else if (playedMusic && !fadeOut && !chosen)
    {
      if (FlxG.keys.justPressed.UP)
      {
        selectedIndex--;
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        if (selectedIndex < 0) selectedIndex = 1;
        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.DOWN)
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
            chosen = true;
            music.stop();
            personaSelection.enabled = false;
            gameOverScreen.visible = false;
            retryButton.visible = false;
            quitButton.visible = false;
            funnyMan.alpha = 1;
            flashSprite.alpha = 1;
            FunkinSound.playOnce(Paths.sound("ui/hex/sounds/hex_gameover_evil_pressed"), 1, onSoundComplete);
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
