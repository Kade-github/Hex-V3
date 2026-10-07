package kade.hex.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.ui.MusicBeatState;
import kade.hex.menus.objects.credits.CreditPage;
import kade.hex.menus.objects.credits.CreditPagePast;
import kade.hex.objects.HexTransitional;
import kade.hex.util.HexTouch;

/**
 * The credits state for Hex.
 */
class HexCredits extends MusicBeatState
{
  static inline var PAGE_BASE_Y:Float = 165;
  static inline var PAGE_BUMP_AMOUNT:Float = 30;

  var pageBump:Float = 0;

  var bg:FlxSprite;

  var swirly:FlxRuntimeShader;
  var swirlTime:Float = 0;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;

  var controlsText:FlxSprite;
  var controlsPastText:FlxSprite;

  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var invertShader:FlxRuntimeShader;

  var transition:HexTransitional;

  var header:FunkinSprite;
  var headerPast:FunkinSprite;

  var arrowLeft:FunkinSprite;
  var arrowRight:FunkinSprite;

  var creditPages:Array<CreditPage> = [];

  public var selectionIndex:Int = 0;

  var hasPlayedIn:Bool = false;

  var shouldInvert:Bool = false;
  var invertIntensity:Float = 0;

  public function new()
  {
    super();
  }

  function buildPages():Void
  {
    creditPages = [
      new CreditPage("ui/hex/hex_credits/artYing", "YingYang48", "Creator, Artist, Composer,\nCharter, Animator", "https://www.youtube.com/@YingYang48"),
      new CreditPage("ui/hex/hex_credits/artKade", "KadeDev", "Co-Director, Programmer,\nComposer, Charter", "https://www.youtube.com/@KadeDev"),
      new CreditPage("ui/hex/hex_credits/artAmalgamat", "Amalgamat", "Animator", "https://x.com/Amalgamat4"),
      new CreditPage("ui/hex/hex_credits/artZhye", "Zhye", "Animator", "https://x.com/zhye_xyz"),
      new CreditPage("ui/hex/hex_credits/artSum", "Sumandgames", "Animator", "https://x.com/SUMANDGAMES"),
      new CreditPage("ui/hex/hex_credits/artWishy", "Wishyseven", "Animator", "https://x.com/wishyseven"),
      new CreditPage("ui/hex/hex_credits/artRechi", "Rechi", "Animator", "https://x.com/RechiTv"),
      new CreditPage("ui/hex/hex_credits/artSugar", "Sugarratio", "Animator", "https://x.com/SugarRatio"),
      new CreditPage("ui/hex/hex_credits/artTenzu", "Tenzalt", "Animator", "https://x.com/Tenzalt"),
      new CreditPage("ui/hex/hex_credits/artKixel", "Kixel", "Animator", "https://x.com/KixelArt"),
      new CreditPage("ui/hex/hex_credits/artNadie", "Nadieberries", "3D Modeler", "https://x.com/moe_2003x"),
      new CreditPage("ui/hex/hex_credits/artKoniro", "KoniroArt", "Artist, Animator", "https://x.com/KoniroArt"),
      new CreditPage("ui/hex/hex_credits/artSock", "Sock.clip", "Artist", "https://x.com/sockdotclip"),
      new CreditPage("ui/hex/hex_credits/artCerw", "CerwCerw", "Animator", "https://x.com/cerwcerw"),
      new CreditPage("ui/hex/hex_credits/artRecd", "RecD", "Voice Actor", "https://x.com/RecDTRH"),
      new CreditPagePast([
        {name: "DJCat", role: "Artist"},
        {name: "Moro", role: "Animator"},
        {name: "TaroNuke", role: "Modchart Director"},
        {name: "JZBoy", role: "Animator"},
        {name: "Mamipipo", role: "Animator"}
      ], [
        {x: -15, y: 0},
        {x: 250, y: 0},
        {x: 110, y: 125},
        {x: -30, y: 300},
        {x: 230, y: 300}
      ])
    ];
  }

  function setSelectionIndex(index:Int, bump:Bool = true):Void
  {
    if (index < 0) index = creditPages.length - 1;
    if (index >= creditPages.length) index = 0;

    var past:Bool = index == creditPages.length - 1;
    headerPast.alpha = past ? 1 : 0;
    controlsPastText.alpha = past ? 1 : 0;
    header.alpha = past ? 0 : 1;
    controlsText.alpha = past ? 0 : 1;

    selectionIndex = index;

    for (i in 0...creditPages.length)
    {
      creditPages[i].visible = (i == selectionIndex);
      creditPages[i].y = PAGE_BASE_Y;
    }

    creditPages[selectionIndex].invertShader = invertShader;

    if (bump)
    {
      pageBump = PAGE_BUMP_AMOUNT;
      invertColors(1.0);
    }
  }

  override public function create():Void
  {
    super.create();

    invertShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/better_invertColor")));

    bg = FunkinSprite.create(0, 0, "ui/hex/hex_credits/bg");
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    add(bg);

    var bgCover:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_credits/bgCover");
    add(bgCover);

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.8);
    swirly.setFloatArray("uColor1", [0.808, 0.263, 0.196]);
    swirly.setFloatArray("uColor2", [0.91, 0.478, 0.184]);
    swirly.setFloat("uIntensity", 30.0);

    var borderInside:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_credits/windowRightNoBorder");
    add(borderInside);

    borderInside.shader = swirly;

    var borderRight:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_credits/windowRightBorder");
    add(borderRight);

    borderInside.x = FlxG.width - borderInside.width;
    borderInside.y = 0;

    bgCover.x = FlxG.width - bgCover.width;
    bgCover.y = 0;

    borderRight.x = borderInside.x + 30;
    borderRight.y = 0;

    header = FunkinSprite.create(0, 0, "ui/hex/hex_credits/seperatorV3");
    add(header);

    header.x = FlxG.width - header.width - 25;
    header.y = 75;

    headerPast = FunkinSprite.create(0, 0, "ui/hex/hex_credits/seperatorPast");
    add(headerPast);

    headerPast.x = FlxG.width - headerPast.width - 25;
    headerPast.y = 75;

    buildPages();

    for (page in creditPages)
    {
      add(page);
      page.x = FlxG.width - 375;
      page.y = 165;
      page.visible = false;
    }

    arrowLeft = FunkinSprite.create(0, 0, "ui/hex/hex_credits/miniArrow");
    add(arrowLeft);

    arrowLeft.x = borderInside.x + 85;
    arrowLeft.y = FlxG.height / 2 - arrowLeft.height / 2;

    arrowRight = FunkinSprite.create(0, 0, "ui/hex/hex_credits/miniArrow");
    add(arrowRight);

    arrowRight.x = FlxG.width - arrowRight.width - 20;
    arrowRight.y = FlxG.height / 2 - arrowRight.height / 2;

    arrowRight.angle = 180;
    arrowRight.flipY = true;

    arrowLeft.x += 15;
    arrowLeft.y += 10;
    arrowRight.x += 15;
    arrowRight.y += 10;

    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(bottomBar);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/hex_credits/circleTop"));
    add(topCircle);

    topCircle.x = 0;
    topCircle.y = 0;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/hex_credits/circleBottom"));
    add(bottomCircle);

    bottomCircle.x = FlxG.width - bottomCircle.width;
    bottomCircle.y = FlxG.height - bottomCircle.height;

    controlsText = new FlxSprite(15, FlxG.height - 40);
    controlsText.loadGraphic(Paths.image("ui/hex/hex_credits/controls"));
    add(controlsText);

    controlsPastText = new FlxSprite(15, FlxG.height - 40);
    controlsPastText.loadGraphic(Paths.image("ui/hex/hex_credits/controlsPast"));
    add(controlsPastText);

    var creditsWatermark:FunkinSprite = FunkinSprite.create(FlxG.width - 10, 10, "ui/hex/hex_credits/menuIdentifier");
    creditsWatermark.x = FlxG.width - (creditsWatermark.width + 18);
    add(creditsWatermark);

    transition = new HexTransitional();
    add(transition);
    transition.forceIn();

    bottomBar.zIndex = 200;
    topBar.zIndex = 200;
    topCircle.zIndex = 200;
    bottomCircle.zIndex = 200;
    controlsText.zIndex = 200;
    controlsPastText.zIndex = 200;
    transition.zIndex = 200;

    controlsPastText.alpha = 0;
    headerPast.alpha = 0;

    setSelectionIndex(0);
  }

  function flashArrow(pressed:FlxSprite, other:FlxSprite):Void
  {
    pressed.shader = invertShader;
    other.shader = null;
  }

  function invertColors(intensity:Float):Void
  {
    shouldInvert = true;
    invertIntensity = intensity;
    invertShader.setFloat("uIntensity", invertIntensity);
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    HexTouch.controls(controlsText, "hex_credits/controls");
    super.update(elapsed);

    if (shouldInvert)
    {
      invertIntensity = FlxMath.lerp(invertIntensity, 0, 0.3 * elapsed * 60);

      if (invertIntensity < 0.01)
      {
        shouldInvert = false;
        invertIntensity = 0;
      }

      invertShader.setFloat("uIntensity", invertIntensity);
    }

    if (pageBump > 0)
    {
      pageBump = FlxMath.lerp(pageBump, 0, 0.25 * elapsed * 60);
      if (pageBump < 0.1) pageBump = 0;
    }
    creditPages[selectionIndex].y = PAGE_BASE_Y + pageBump;

    swirlTime += elapsed;
    swirly.setFloat("uTime", swirlTime * 0.2);

    if (!hasPlayedIn && swirlTime > 0.1)
    {
      hasPlayedIn = true;
      transition.transitionOut();
    }

    if (FlxG.keys.justPressed.ESCAPE) goBack();

    var tappedLeft:Bool = HexTouch.tappedObject(arrowLeft);
    var tappedRight:Bool = !tappedLeft && HexTouch.tappedObject(arrowRight);

    if (FlxG.keys.justPressed.LEFT || HexTouch.justSwipedRight || tappedLeft)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setSelectionIndex(selectionIndex - 1);
      flashArrow(arrowLeft, arrowRight);
    }
    else if (FlxG.keys.justPressed.RIGHT || HexTouch.justSwipedLeft || tappedRight)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setSelectionIndex(selectionIndex + 1);
      flashArrow(arrowRight, arrowLeft);
    }
    else if (FlxG.keys.justPressed.ENTER || HexTouch.tappedObject(creditPages[selectionIndex])) creditPages[selectionIndex].openLink();
  }

  function goBack():Void
  {
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    transition.transitionIn();

    transition.onComplete = function(out:Bool)
    {
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 5;
      FlxG.switchState(function() return mm);
    };
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    super.destroy();
  }
}
