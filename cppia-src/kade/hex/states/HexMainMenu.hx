package kade.hex.states;

import kade.hex.util.HexPurge;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.ui.MusicBeatState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.objects.mainmenu.CityScape;
import kade.hex.objects.mainmenu.HexTitle;
import kade.hex.util.HexTouch;

/**
 * The main menu state for the VS Hex mod.
 */
class HexMainMenu extends MusicBeatState
{
  var bg:FlxSprite;

  var shouldSkip:Bool = false;
  var hasPlayedSkip:Bool = false;

  var personaSelection:PersonaSelection;
  var invertShader:FlxRuntimeShader;

  var swirly:FlxRuntimeShader;
  var realTime:Float = 0;
  var swirlTime:Float = 0;

  var logo:FlxSprite;
  var title:HexTitle;
  var city:CityScape;

  var behind_bg:FlxSprite;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;

  var controlsText:FlxSprite;

  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var selectionSprite:FlxSprite;

  var transition:HexTransitional;

  var startTween:Float = 0;
  var tweenBars:Bool = false;
  var tweenText:Bool = false;

  public var selectionIndex:Int = 0;

  var selectionImages:Array<FlxSprite> = [];
  var selected:Bool = false;
  var invertIntensity:Float = 0;

  var playedTrans:Bool = false;
  var changedRenderSizeX:Float = 1;

  public function new()
  {
    trace("HexMainMenu: new() called");
    super();
  }

  static final QUADS:Array<Array<Float>> = [
    [576, 220, 900, 271, 898, 344, 548, 281],
    [607, 294, 890, 343, 869, 400, 608, 346],
    [618, 354, 858, 403, 830, 464, 606, 407],
    [597, 408, 838, 465, 807, 525, 584, 460],
    [589, 468, 812, 525, 777, 585, 557, 518],
    [578, 526, 786, 585, 748, 645, 540, 576]
  ];

  public function setPersonaQuadByIndex():Void
  {
    var q:Array<Float> = QUADS[selectionIndex];
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

  static var booted:Bool = false;

  var hopping:Bool = false;

  public function skipTitle():Void
  {
    shouldSkip = true;
    booted = true;
  }

  public function select():Void
  {
    var image:FlxSprite = selectionImages[selectionIndex];
    image.alpha = 1;
    image.shader = invertShader;
    selected = true;
    invertIntensity = 1;
  }

  override public function create():Void
  {
    trace("HexMainMenu: create() called");
    super.create();

    if (!booted)
    {
      booted = true;
      hopping = true;
      HexPurge.next();
      FlxG.switchState(function() return new HexMainMenu());
      return;
    }

    personaSelection = new PersonaSelection();
    personaSelection.initShader();

    add(personaSelection);

    invertShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/better_invertColor")));

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 1);
    swirly.setFloatArray("uColor1", [1.0, 1.0, 1.0]);
    swirly.setFloatArray("uColor2", [0.251, 0.965, 0.937]);
    swirly.setFloat("uIntensity", 5.0);

    behind_bg = new FlxSprite(0, 0);
    behind_bg.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    add(behind_bg);

    behind_bg.shader = swirly;

    city = new CityScape();
    add(city);

    city.onComplete = function()
    {
      startTween = realTime;
      tweenBars = true;
    };

    bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image("ui/hex/main-menu/basketball"));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.scrollFactor.set();
    bg.updateHitbox();
    add(bg);

    topBar = new FlxSprite(0, -50);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    topBar.scrollFactor.set();
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    bottomBar.scrollFactor.set();
    add(bottomBar);

    controlsText = new FlxSprite(-75, FlxG.height - 45);
    controlsText.loadGraphic(Paths.image("ui/hex/main-menu/controls-text"));
    controlsText.scale.set(0.75, 0.75);
    controlsText.alpha = 0;
    controlsText.scrollFactor.set();
    add(controlsText);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/main-menu/circles/circleTop"));
    topCircle.scrollFactor.set();
    add(topCircle);

    topCircle.scale.set(0.75, 0.75);

    topCircle.x = -topCircle.width * 0.18;
    topCircle.y = -topCircle.height;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/main-menu/circles/circleBottom"));
    bottomCircle.scrollFactor.set();
    add(bottomCircle);

    bottomCircle.scale.set(0.75, 0.75);

    bottomCircle.x = FlxG.width - bottomCircle.width * 0.85;
    bottomCircle.y = FlxG.height + bottomCircle.height;

    selectionSprite = new FlxSprite(-320, -180);
    selectionSprite.loadGraphic(Paths.image("ui/hex/main-menu/selection"));
    selectionSprite.setGraphicSize(FlxG.width, FlxG.height);
    selectionSprite.alpha = 0;
    selectionSprite.scrollFactor.set();
    add(selectionSprite);

    logo = new FlxSprite(-30, 0);
    logo.loadGraphic(Paths.image("ui/hex/main-menu/title/logo"));
    logo.scrollFactor.set();
    add(logo);

    logo.scale.set(0.75, 0.75);

    logo.y = FlxG.height - (logo.height + 30);
    logo.alpha = 0;

    var menuOptions:Array<String> = ["storymode", "freeplay", "gallery", "jukebox", "options", "credits"];
    for (i in 0...menuOptions.length)
    {
      var img:FlxSprite = new FlxSprite(-320, -180);
      img.loadGraphic(Paths.image("ui/hex/main-menu/selection-" + menuOptions[i]));
      img.setGraphicSize(FlxG.width, FlxG.height);
      img.alpha = 0;
      img.scrollFactor.set();
      add(img);
      selectionImages.push(img);
    }

    FunkinSound.load(Paths.music("ui/hex/music/title-theme/title-theme"));

    if (!shouldSkip)
    {
      title = new HexTitle();
      add(title);

      title.onComplete = function()
      {
        FunkinSound.playMusic("ui/hex/music/title-theme/title-theme",
          {
            startingVolume: 0,
            overrideExisting: true,
            restartTrack: true,
            loop: true,
            persist: true,
          });

        FlxG.sound.music.fadeIn(3);

        city.tween();
      };

      FlxG.camera.flash(0xFF000000, 6, function()
      {
        title.showLogo();
      });

      FunkinSound.playMusic("ui/hex/music/title-ambi/title-ambi",
        {
          startingVolume: 0,
          overrideExisting: true,
          restartTrack: true,
          loop: true,
        });

      FlxG.sound.music.fadeIn(3);
    }
    transition = new HexTransitional();
    add(transition);
    transition.forceOut();

    if (shouldSkip)
    {
      city.forceComplete();
      transition.forceIn();
    }

    setPersonaQuadByIndex();
    forceQuadUpdate();
  }

  override public function update(elapsed:Float):Void
  {
    if (hopping) return;

    HexTouch.update();
    HexTouch.controls(controlsText, "main-menu/controls-text");
    super.update(elapsed);

    if (changedRenderSizeX != FlxG.scaleMode.scale.x)
    {
      changedRenderSizeX = FlxG.scaleMode.scale.x;
      setPersonaQuadByIndex();
      forceQuadUpdate();
    }

    realTime += elapsed;
    swirlTime += elapsed * 0.45;

    if (shouldSkip && !hasPlayedSkip && realTime >= 0.02)
    {
      hasPlayedSkip = true;
      transition.transitionOut();
      transition.onComplete = function(out:Bool)
      {
        if (FlxG.sound.music == null || !FlxG.sound.music.playing)
        {
          FunkinSound.playMusic("ui/hex/music/title-theme/title-theme",
            {
              startingVolume: 0,
              overrideExisting: true,
              restartTrack: true,
              loop: true,
              persist: true,
            });

          FlxG.sound.music.fadeIn(3);
        }
      };
    }

    personaSelection.updateShader(elapsed);

    if (swirly != null) swirly.setFloat("uTime", swirlTime);

    if (tweenBars)
    {
      var diff:Float = realTime - startTween;
      var ease:Float = FlxEase.circOut(Math.min(1, diff * 1.25));

      topBar.y = FlxMath.lerp(-50, 0, ease);
      bottomBar.y = FlxMath.lerp(FlxG.height, FlxG.height - 50, ease);

      topCircle.y = FlxMath.lerp(-topCircle.height, -topCircle.height * 0.13, ease);
      bottomCircle.y = FlxMath.lerp(FlxG.height + bottomCircle.height, FlxG.height - bottomCircle.height * 0.85, ease);

      if (diff > 0.8)
      {
        tweenBars = false;
        tweenText = true;
        startTween = realTime;
      }
    }

    if (tweenText)
    {
      var diff:Float = realTime - startTween;

      if (!personaSelection.enabled) personaSelection.enabled = true;

      var t:Float = Math.min(1, diff * 1.25);
      controlsText.alpha = t;
      logo.alpha = t;
      selectionSprite.alpha = t;

      if (diff > 0.8)
      {
        personaSelection.mix = Math.min(1, (diff - 0.8) * 1.25);

        if (diff > 1.6) tweenText = false;
      }
    }

    if (!shouldSkip && !title.complete) return;

    if (!selected && selectionSprite.alpha >= 1)
    {
      if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
      {
        if (!tweenBars && !tweenText)
        {
          if (FlxG.keys.justPressed.UP)
          {
            selectionIndex--;
            if (selectionIndex < 0) selectionIndex = 5;
          }
          else if (FlxG.keys.justPressed.DOWN)
          {
            selectionIndex++;
            if (selectionIndex > 5) selectionIndex = 0;
          }

          FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));

          setPersonaQuadByIndex();
        }
      }

      var tappedIndex:Int = (!tweenBars && !tweenText) ? HexTouch.tappedQuad(QUADS) : -1;
      if (tappedIndex != -1 && tappedIndex != selectionIndex)
      {
        selectionIndex = tappedIndex;
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.ENTER || tappedIndex != -1)
      {
        select();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
      }
    }
    else if (selected)
    {
      personaSelection.mix = FlxMath.lerp(personaSelection.mix, 0, 0.5 * FlxG.elapsed * 60);
      invertIntensity = FlxMath.lerp(invertIntensity, 0, 0.09 * FlxG.elapsed * 60);

      if (invertIntensity < 0.01) invertIntensity = 0;

      invertShader.setFloat("uIntensity", invertIntensity);

      topCircle.y = FlxMath.lerp(topCircle.y, -topCircle.height, 0.07 * FlxG.elapsed * 40);
      bottomCircle.y = FlxMath.lerp(bottomCircle.y, FlxG.height + bottomCircle.height, 0.07 * FlxG.elapsed * 40);

      if (invertIntensity <= 0 && !playedTrans)
      {
        playedTrans = true;
        transition.transitionIn();
        transition.onComplete = function(out:Bool)
        {
          switch (selectionIndex)
          {
            case 0:
              HexPurge.next();
              var story:HexStoryMenu = new HexStoryMenu();
              FlxG.switchState(function() return story);
            case 1:
              HexPurge.next();
              var freeplay:HexFreeplay = new HexFreeplay();
              FlxG.switchState(function() return freeplay);
            case 2:
              HexPurge.next();
              var gallery:HexGallery = new HexGallery();
              FlxG.switchState(function() return gallery);
            case 3:
              HexPurge.next();
              var jukebox:HexJukebox = new HexJukebox();
              FlxG.switchState(function() return jukebox);
            case 4:
              HexPurge.next();
              var options:HexOptions = new HexOptions();
              FlxG.switchState(function() return options);
            case 5:
              HexPurge.next();
              var credits:HexCredits = new HexCredits();
              FlxG.switchState(function() return credits);
            default:
              var image:FlxSprite = selectionImages[selectionIndex];
              image.shader = null;

              playedTrans = false;
              tweenBars = true;
              startTween = realTime;
              selected = false;
              transition.transitionOut();
              transition.onComplete = null;
          }
        };
      }
    }
  }
}
