package kade.hex.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinCamera;
import funkin.ui.MusicBeatState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.objects.story.StoryMenuItem;
import kade.hex.objects.story.StoryPopUp;
import kade.hex.util.HexTouch;
import openfl.filters.ShaderFilter;

/**
 * The story menu for Hex.
 */
class HexStoryMenu extends MusicBeatState
{
  var storyMenuItems:Array<StoryMenuItem>;

  var blurShader:FlxRuntimeShader;
  var selectionItems:Array<FlxSprite>;

  var bg:FlxSprite;

  var personaSelection:PersonaSelection;
  var transition:HexTransitional;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;
  var bottomText:FlxSprite;

  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var swirly1:FlxRuntimeShader;
  var swirly2:FlxRuntimeShader;

  public static var lastWeek:Int = 0;

  var selectionIndex:Int = 0;

  var popUp:StoryPopUp;

  var camBehind:FunkinCamera;
  var camInfront:FunkinCamera;

  var _lastSelectionIndex:Int = -1;

  var hasPlayedIn:Bool = false;
  var shaderTime:Float = 0;
  var fadedIn:Bool = false;

  var lerpBlurTime:Float = 0;
  var lastLerpBlur:Float = 0;
  var lerpBlurTarget:Float = 0;
  var currentBlur:Float = 0;

  var refade:Bool = false;
  var acceptInput:Bool = false;
  var mixTime:Float = 0;

  public function new()
  {
    super();
  }

  public function setPersonaQuadByIndex(ignoreBounce:Bool = false):Void
  {
    for (i in 0...storyMenuItems.length)
    {
      if (i == selectionIndex)
      {
        if (_lastSelectionIndex != selectionIndex)
        {
          if (!ignoreBounce) storyMenuItems[i].bounce();
          _lastSelectionIndex = selectionIndex;
        }
        storyMenuItems[i].select();
      }
      else
      {
        storyMenuItems[i].deselect();
      }
    }

    switch (selectionIndex)
    {
      case 0:
        setPersonaQuad(109, 616, 226, 579, 348, 616, 214, 662);
      case 1:
        setPersonaQuad(489, 654, 596, 572, 798, 607, 634, 664);
      case 2:
        setPersonaQuad(909, 657, 999, 565, 1141, 612, 1029, 666);
    }
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

    camBehind = new FunkinCamera();
    camInfront = new FunkinCamera();

    FlxG.cameras.reset(camBehind);
    FlxG.cameras.add(camInfront, false);

    if (FlxG.sound.music == null || !FlxG.sound.music.playing)
    {
      FunkinSound.playMusic("ui/hex/music/title-theme/title-theme",
        {
          overrideExisting: true,
          restartTrack: true,
          loop: true,
          persist: true,
        });
    }

    camInfront.bgColor = 0x00000000;

    bg = new FlxSprite(0, 0, Paths.image("ui/hex/story-menu/bg"));
    bg.scale.set(0.68, 0.68);
    bg.x = bg.width * -0.17;
    bg.y = bg.height * -0.16;
    add(bg);

    blurShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/real_gaus_blur")));
    blurShader.setFloat("uSize", 0);
    blurShader.setFloat("uDirections", 12);
    blurShader.setFloat("uQuality", 4);

    swirly1 = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly1.setFloat("uTime", 0);
    swirly1.setFloat("uMix", 0.5);
    swirly1.setFloatArray("uColor1", [0.420, 0.459, 0.843]);
    swirly1.setFloatArray("uColor2", [0.278, 0.075, 0.671]);
    swirly1.setFloat("uIntensity", 8.0);

    swirly2 = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly2.setFloat("uTime", 0);
    swirly2.setFloat("uMix", 1);
    swirly2.setFloatArray("uColor1", [1.0, 1.0, 1.0]);
    swirly2.setFloatArray("uColor2", [0.251, 0.965, 0.937]);
    swirly2.setFloat("uIntensity", 5.0);

    var hextravaganza:StoryMenuItem = new StoryMenuItem("ui/hex/story-menu/hextravaganzaUnselected", "ui/hex/story-menu/hextravaganzaSelected");
    var hexexperience:StoryMenuItem = new StoryMenuItem("ui/hex/story-menu/hexperienceUnselected", "ui/hex/story-menu/hexperienceSelected");
    var hexcess:StoryMenuItem = new StoryMenuItem("ui/hex/story-menu/hexcessUnselected", "ui/hex/story-menu/hexcessSelected");

    storyMenuItems = [hextravaganza, hexexperience, hexcess];

    hextravaganza.scale.set(0.65, 0.65);
    hexexperience.scale.set(0.65, 0.65);
    hexcess.scale.set(0.65, 0.65);

    hextravaganza.x = -40;
    hextravaganza.y = -40;

    hexexperience.x = 335;
    hexexperience.y = -70;

    hexcess.x = 705;
    hexcess.y = -40;

    add(hextravaganza);
    add(hexexperience);
    add(hexcess);

    var windowBottom:FlxSprite = new FlxSprite(0, FlxG.height - 220, Paths.image("ui/hex/story-menu/windowBottomNoBorder"));
    windowBottom.scale.set(0.78, 0.78);
    windowBottom.scrollFactor.set();
    windowBottom.x -= windowBottom.width * 0.20;
    add(windowBottom);

    windowBottom.shader = swirly1;

    var windowBottomBorder:FlxSprite = new FlxSprite(0, FlxG.height - 220, Paths.image("ui/hex/story-menu/borderBottom"));
    windowBottomBorder.scale.set(0.78, 0.78);
    add(windowBottomBorder);
    windowBottomBorder.scrollFactor.set();
    windowBottomBorder.x -= windowBottomBorder.width * 0.20;
    windowBottomBorder.y += 10;

    var weekx:FlxSprite = new FlxSprite(0, FlxG.height - 220, Paths.image("ui/hex/story-menu/textWeekX"));
    var weekendX:FlxSprite = new FlxSprite(0, FlxG.height - 220, Paths.image("ui/hex/story-menu/textWeekendX"));
    var eventX:FlxSprite = new FlxSprite(0, FlxG.height - 220, Paths.image("ui/hex/story-menu/textEventX"));

    weekx.scale.set(0.7, 0.7);
    weekendX.scale.set(0.7, 0.7);
    eventX.scale.set(0.7, 0.7);

    weekx.scrollFactor.set();
    weekendX.scrollFactor.set();
    eventX.scrollFactor.set();

    weekx.x = 64;
    weekx.y = FlxG.height - 150;

    weekendX.x = 380;
    weekendX.y = weekx.y;

    eventX.x = 840;
    eventX.y = weekx.y;

    add(weekx);
    add(weekendX);
    add(eventX);

    selectionItems = [weekx, weekendX, eventX];

    selectionIndex = lastWeek;
    if (selectionIndex < 0 || selectionIndex >= selectionItems.length) selectionIndex = 0;

    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    topBar.scrollFactor.set();
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    bottomBar.scrollFactor.set();
    add(bottomBar);

    var topText:FlxSprite = new FlxSprite(FlxG.width - 222, 10, Paths.image("ui/hex/story-menu/menuIdentifier"));
    topText.scale.set(0.75, 0.75);
    topText.scrollFactor.set();
    add(topText);

    bottomText = new FlxSprite(-95, FlxG.height - 45, Paths.image("ui/hex/story-menu/controlsText"));
    bottomText.scale.set(0.75, 0.75);
    bottomText.scrollFactor.set();
    add(bottomText);

    topCircle = new FlxSprite(0, 0, Paths.image("ui/hex/story-menu/circleTop"));
    topCircle.scrollFactor.set();
    add(topCircle);

    topCircle.scale.set(0.68, 0.68);

    topCircle.x = -topCircle.width * 0.17;
    topCircle.y = -topCircle.height * 0.18;

    bottomCircle = new FlxSprite(0, 0, Paths.image("ui/hex/story-menu/circleBottom"));
    bottomCircle.scrollFactor.set();
    add(bottomCircle);

    bottomCircle.scale.set(0.8, 0.8);

    bottomCircle.x = FlxG.width - bottomCircle.width * 0.90;
    bottomCircle.y = FlxG.height - bottomCircle.height * 0.87;
    bottomCircle.y += 20;

    popUp = new StoryPopUp();
    add(popUp);

    popUp.cameras = [camInfront];

    topCircle.cameras = [camInfront];
    bottomCircle.cameras = [camInfront];
    topBar.cameras = [camInfront];
    bottomBar.cameras = [camInfront];
    bottomText.cameras = [camInfront];
    topText.cameras = [camInfront];

    personaSelection = new PersonaSelection();
    personaSelection.initShader(camInfront);
    FlxG.camera.filters = [new ShaderFilter(blurShader), personaSelection._internalShaderFilter];
    add(personaSelection);

    popUp.personaSelection = personaSelection;
    transition = new HexTransitional();
    add(transition);

    popUp.transitional = transition;

    transition.cameras = [camInfront];

    transition.forceIn();

    setPersonaQuadByIndex(true);
  }

  function setBlurTarget(target:Float):Void
  {
    lastLerpBlur = currentBlur;
    currentBlur = target;
    lerpBlurTarget = target;
    lerpBlurTime = 0;
  }

  function acceptSelection():Void
  {
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    setBlurTarget(10);
    popUp.weekSelectionIndex = selectionIndex;
    lastWeek = selectionIndex;
    popUp.showDifficultySelection();
    acceptInput = false;
    mixTime = 0;
    personaSelection.mix = 0;
    refade = true;
  }

  function goBack():Void
  {
    if (!acceptInput)
    {
      popUp.goBack();
      return;
    }

    transition.transitionIn();
    personaSelection.mix = 0;
    personaSelection.enabled = false;

    transition.onComplete = function(out:Bool)
    {
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 0;
      FlxG.switchState(function() return mm);
    };
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    super.destroy();
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    if (HexTouch.backButton != null) HexTouch.backButton.setPosition(20, 10);
    HexTouch.controls(bottomText, "story-menu/controlsText");
    super.update(elapsed);

    shaderTime += elapsed;

    lerpBlurTime += elapsed;
    var blurLerp:Float = FlxMath.lerp(lastLerpBlur, lerpBlurTarget, Math.min(lerpBlurTime / 0.5, 1));
    blurShader.setFloat("uSize", blurLerp);

    if (!hasPlayedIn && shaderTime > 0.02)
    {
      hasPlayedIn = true;
      transition.transitionOut();
    }

    if (shaderTime > 0.2 && !fadedIn)
    {
      if (!personaSelection.enabled) personaSelection.enabled = true;

      var mixTween:Float = Math.min(shaderTime - 0.2, 0.5) / 0.5;
      personaSelection.mix = mixTween;

      if (mixTween >= 1)
      {
        personaSelection.mix = 1;
        fadedIn = true;
        acceptInput = true;
      }
    }

    if (fadedIn && !acceptInput && popUp.reliquishedControl)
    {
      personaSelection.mix = 0;
      mixTime = 0;
      setBlurTarget(0);
      acceptInput = true;
      refade = true;

      setPersonaQuadByIndex(true);
      forceQuadUpdate();
      return;
    }

    if (personaSelection.mix < 1 && refade)
    {
      mixTime += elapsed;
      var mixTween:Float = Math.min(mixTime - 0.2, 0.5) / 0.5;
      personaSelection.mix = mixTween;

      if (mixTween >= 1)
      {
        personaSelection.mix = 1;
        refade = false;
      }
    }

    if (acceptInput)
    {
      var tappedIndex:Int = HexTouch.tapped() ? Std.int(HexTouch.touch.gameX / (FlxG.width / selectionItems.length)) : -1;
      if (tappedIndex >= selectionItems.length) tappedIndex = selectionItems.length - 1;

      if (FlxG.keys.justPressed.LEFT || HexTouch.justSwipedLeft)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        if (selectionIndex > 0) selectionIndex--;
        else selectionIndex = selectionItems.length - 1;

        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.RIGHT || HexTouch.justSwipedRight)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        if (selectionIndex < selectionItems.length - 1) selectionIndex++;
        else selectionIndex = 0;

        setPersonaQuadByIndex();
      }
      else if (tappedIndex != -1 && tappedIndex != selectionIndex)
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        selectionIndex = tappedIndex;

        setPersonaQuadByIndex();
      }
      else if (FlxG.keys.justPressed.ENTER || tappedIndex != -1)
      {
        acceptSelection();
      }
      else if (FlxG.keys.justPressed.ESCAPE)
      {
        goBack();
      }
    }

    if (swirly1 != null) swirly1.setFloat("uTime", shaderTime);
    if (swirly2 != null) swirly2.setFloat("uTime", shaderTime);

    personaSelection.updateShader(elapsed);
  }
}
