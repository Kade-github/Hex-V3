package kade.hex.substates;

import kade.hex.util.HexPurge;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.data.song.SongRegistry;
import funkin.play.PlayState;
import funkin.play.PlayStatePlaylist;
import funkin.ui.MusicBeatSubState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.states.HexFreeplay;
import kade.hex.states.HexStoryMenu;
import kade.hex.util.HexTouch;

class HexPauseMenu extends MusicBeatSubState
{
  public static var reset:Bool = false;
  public var trans:HexTransitional;
  var shaderTime:Float = 0;
  var personaSelection:PersonaSelection;
  var swirly:FlxRuntimeShader;

  var music:FunkinSound;

  var blackRect:FlxSprite;
  var circleBottomLeft:FlxSprite;
  var circleBottomRight:FlxSprite;
  var circleTopLeft:FlxSprite;
  var circleTopRight:FlxSprite;

  var leftFill:FlxSprite;
  var leftBorder:FlxSprite;

  var selectedIndex:Int = 0;
  var page:Int = 0;
  var doingIntro:Bool = true;
  var reverseIntro:Bool = false;

  var menuItems:FlxSprite;
  var menuItems_practice:FlxSprite;

  var diffMenuItems:FlxSprite;
  var diffMenuTechItems:FlxSprite;

  var introTimer:Float = 0;

  var diffLocked:Bool = false;

  public function new()
  {
    super();
  }

  static final QUADS:Array<Array<Array<Float>>> = [
    [
      [35, 140, 301, 107, 327, 190, 34, 221],
      [30, 232, 466, 205, 486, 300, 35, 312],
      [33, 328, 587, 312, 598, 418, 31, 403],
      [32, 421, 653, 435, 659, 531, 28, 489],
      [36, 506, 434, 537, 431, 628, 32, 587]
    ],
    [
      [30, 173, 18, 257, 230, 250, 237, 155],
      [33, 275, 29, 355, 306, 358, 303, 252],
      [38, 374, 29, 445, 219, 453, 226, 362],
      [33, 462, 26, 537, 204, 555, 208, 469]
    ],
    [
      [24, 134, 30, 216, 218, 204, 217, 113],
      [30, 226, 24, 303, 301, 300, 301, 206],
      [34, 315, 32, 396, 225, 400, 240, 316],
      [33, 414, 26, 493, 370, 518, 376, 415],
      [37, 507, 27, 581, 207, 610, 215, 512]
    ]
  ];

  public function setPersonaQuadByIndex():Void
  {
    var q:Array<Float> = QUADS[page][selectedIndex];
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

  function changeDifficulty(diff:String):Void
  {
    var ps:PlayState = PlayState.instance;
    ps.currentSong = SongRegistry.instance.fetchEntry(ps.currentSong.id.toLowerCase(), {variation: ps.currentChart.variation});

    PlayStatePlaylist.campaignScore = 0;
    PlayStatePlaylist.campaignDifficulty = diff;

    ps.previousDifficulty = ps.currentDifficulty;
    ps.currentDifficulty = PlayStatePlaylist.campaignDifficulty;

    ps.needsReset = true;

    close();
  }

  function select():Void
  {
    if (page == 1 || page == 2)
    {
      if (page == 1 && selectedIndex == 3)
      {
        page = 0;
        selectedIndex = 2;
        setPersonaQuadByIndex();
        forceQuadUpdate();
        menuItems.visible = true;
        diffMenuItems.visible = false;
        return;
      }

      if (page == 2 && selectedIndex == 4)
      {
        page = 0;
        selectedIndex = 2;
        setPersonaQuadByIndex();
        forceQuadUpdate();
        menuItems.visible = true;
        diffMenuTechItems.visible = false;
        return;
      }

      var diff:String = "hard";
      switch (selectedIndex)
      {
        case 0:
          diff = "easy";
        case 1:
          diff = "normal";
        case 2:
          diff = "hard";
        case 3:
          diff = "technical";
      }
      personaSelection.enabled = false;
      trans.transitionIn();
      trans.onComplete = function(out:Bool)
      {
        changeDifficulty(diff);
      };
      return;
    }

    switch (selectedIndex)
    {
      case 0:
        introTimer = 0;
        doingIntro = true;
        reverseIntro = true;
        music.fadeOut(0.25);
      case 1:
        music.fadeOut(0.25);
        personaSelection.enabled = false;
        trans.transitionIn();
        trans.onComplete = function(out:Bool)
        {
          PlayState.instance.needsReset = true;
          close();
        };
      case 2:
        if (diffLocked) return;
        page = 1;
        if (PlayState.instance.currentSong.id == "rightpace") page = 2;
        selectedIndex = 0;
        setPersonaQuadByIndex();
        forceQuadUpdate();
        switch (page)
        {
          case 1:
            menuItems.visible = false;
            diffMenuItems.visible = true;
          case 2:
            menuItems.visible = false;
            diffMenuTechItems.visible = true;
        }
        return;
      case 3:
        PlayState.instance.isPracticeMode = !PlayState.instance.isPracticeMode;
        menuItems.visible = menuItems_practice.visible;
        menuItems_practice.visible = !menuItems_practice.visible;
      case 4:
        music.fadeOut(0.25);
        personaSelection.enabled = false;
        trans.transitionIn();
        if (PlayStatePlaylist.isStoryMode)
        {
          trans.onComplete = function(out:Bool)
          {
            HexPurge.next(true);
            var story:HexStoryMenu = new HexStoryMenu();
            FlxG.switchState(function() return story);
          };
        }
        else
        {
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
              case "technical":
                diffId = 3;
              case "erect":
                diffId = 4;
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

  override public function create():Void
  {
    super.create();

    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));

    music = FunkinSound.load(Paths.music("ui/hex/music/hex-pause/hex-pause"), 0, true);
    music.play();
    music.fadeIn();

    personaSelection = new PersonaSelection();
    add(personaSelection);
    personaSelection.initShader(cameras[0]);
    personaSelection.enabled = true;
    blackRect = new FlxSprite(0, 0);
    blackRect.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackRect.scrollFactor.set();
    blackRect.alpha = 0;
    add(blackRect);

    leftFill = new FlxSprite(-300, -200);
    keep(leftFill, "windowLeftNoBorder");
    leftFill.scale.set(0.7, 0.7);
    leftFill.scrollFactor.set();
    add(leftFill);

    leftFill.alpha = 0.2;
    leftFill.color = 0x000000;

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.6);
    swirly.setFloatArray("uColor1", [0.471, 0.741, 0.753]);
    swirly.setFloatArray("uColor2", [0.0, 0.510, 0.612]);
    swirly.setFloat("uIntensity", 35.0);

    leftFill.shader = swirly;

    leftBorder = new FlxSprite(-300, -200);
    keep(leftBorder, "borderLeft");
    leftBorder.scale.set(0.7, 0.7);
    leftBorder.scrollFactor.set();
    add(leftBorder);

    circleBottomLeft = new FlxSprite(-50, FlxG.height - 180);
    keep(circleBottomLeft, "circleBottomLeft");
    circleBottomLeft.scale.set(0.8, 0.8);
    circleBottomLeft.scrollFactor.set();
    add(circleBottomLeft);

    circleBottomRight = new FlxSprite(FlxG.width - 120, FlxG.height - 180);
    keep(circleBottomRight, "circleBottomRight");
    circleBottomRight.scale.set(0.8, 0.8);
    circleBottomRight.scrollFactor.set();
    add(circleBottomRight);

    circleTopLeft = new FlxSprite(-30, -25);
    keep(circleTopLeft, "circleTopLeft");
    circleTopLeft.scale.set(0.8, 0.8);
    circleTopLeft.scrollFactor.set();
    add(circleTopLeft);

    circleTopRight = new FlxSprite(FlxG.width - 235, -25);
    keep(circleTopRight, "circleTopRight");
    circleTopRight.scale.set(0.8, 0.8);
    circleTopRight.scrollFactor.set();
    add(circleTopRight);

    menuItems = new FlxSprite(0, 0);
    keep(menuItems, "menuItems");
    add(menuItems);

    menuItems_practice = new FlxSprite(0, 0);
    keep(menuItems_practice, "menuItemsDisablePractice");
    menuItems_practice.visible = false;
    add(menuItems_practice);

    diffMenuItems = new FlxSprite(0, 0);
    keep(diffMenuItems, "menuDiffs");
    diffMenuItems.visible = false;
    add(diffMenuItems);

    diffMenuTechItems = new FlxSprite(0, 0);
    keep(diffMenuTechItems, "menuDiffsTech");
    diffMenuTechItems.visible = false;
    add(diffMenuTechItems);

    diffLocked = PlayState.instance.currentDifficulty == "erect" || PlayState.instance.currentSong.id == "eye2eye";
    if (diffLocked)
    {
      greyDiffRow(menuItems);
      greyDiffRow(menuItems_practice);
    }

    if (PlayState.instance.isPracticeMode)
    {
      menuItems.visible = false;
      menuItems_practice.visible = true;
    }

    setPersonaQuadByIndex();

    leftFill.offset.set(500, 0);
    leftBorder.offset.set(500, 0);
    circleBottomLeft.offset.set(0, -500);
    circleBottomRight.offset.set(0, -500);
    circleTopLeft.offset.set(0, 500);
    circleTopRight.offset.set(0, 500);
    menuItems.offset.set(500, 0);
    menuItems_practice.offset.set(500, 0);
    diffMenuItems.offset.set(500, 0);
    diffMenuTechItems.offset.set(500, 0);

    add(trans);
    trans.cameras = [camera];
  }

  static final IMAGES:Array<String> = [
    "windowLeftNoBorder", "borderLeft", "circleBottomLeft", "circleBottomRight", "circleTopLeft", "circleTopRight", "menuItems",
    "menuItemsDisablePractice", "menuDiffs", "menuDiffsTech"
  ];

  static inline final DIM_ROW:String = "#pragma header
    uniform float uTop;
    uniform float uBottom;
    uniform float uRight;

    void main() {
        vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
        if (openfl_TextureCoordv.y >= uTop && openfl_TextureCoordv.y <= uBottom && openfl_TextureCoordv.x <= uRight)
            color *= 0.35;
        gl_FragColor = color;
    }";

  public static function warm():Void
  {
    for (name in IMAGES)
    {
      var art = FlxG.bitmap.add(Paths.image("ui/hex/hex_pause/" + name));
      if (art != null) art.destroyOnNoUse = false;
    }

    var tune:FunkinSound = FunkinSound.load(Paths.music("ui/hex/music/hex-pause/hex-pause"), 0, true);
    if (tune != null) tune.destroy();
  }

  function keep(spr:FlxSprite, name:String):Void
  {
    spr.loadGraphic(Paths.image("ui/hex/hex_pause/" + name));
    if (spr.graphic != null) spr.graphic.destroyOnNoUse = false;
  }

  function greyDiffRow(spr:FlxSprite):Void
  {
    var dim:FlxRuntimeShader = new FlxRuntimeShader(DIM_ROW);
    dim.setFloat("uTop", 310 / spr.frameHeight);
    dim.setFloat("uBottom", 420 / spr.frameHeight);
    dim.setFloat("uRight", 640 / spr.frameWidth);
    spr.shader = dim;
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update();
    super.update(elapsed);

    shaderTime += elapsed;
    swirly.setFloat("uTime", shaderTime / 4);

    personaSelection.updateShader(elapsed);

    if (doingIntro)
    {
      introTimer += elapsed;

      var t:Float = introTimer / 0.5;

      if (reverseIntro)
      {
        t = 1 - (introTimer / 0.45);

        var pt:Float = introTimer / 0.15;
        if (pt > 1) pt = 1;
        personaSelection.mix = FlxMath.lerp(1, 0, pt);
      }

      var rt:Float = t;

      if (t > 1) t = 1;

      var easeVal:Float = FlxEase.circOut(t);

      blackRect.alpha = FlxMath.lerp(0, 0.85, easeVal);

      var slideX:Float = FlxMath.lerp(800, 0, easeVal);
      var slideDown:Float = FlxMath.lerp(-800, 0, easeVal);
      var slideUp:Float = FlxMath.lerp(800, 0, easeVal);

      leftFill.offset.x = slideX;
      leftBorder.offset.x = slideX;
      circleBottomLeft.offset.y = slideDown;
      circleBottomRight.offset.y = slideDown;
      circleTopLeft.offset.y = slideUp;
      circleTopRight.offset.y = slideUp;
      menuItems.offset.x = slideX;
      menuItems_practice.offset.x = slideX;
      diffMenuItems.offset.x = slideX;
      diffMenuTechItems.offset.x = slideX;

      if (rt >= 1 || rt <= -0.45)
      {
        if (!reverseIntro)
        {
          personaSelection.mix = FlxMath.lerp(0, 1, (rt - 1) / 0.25);

          if (rt >= 1.25)
          {
            personaSelection.mix = 1;
            doingIntro = false;
            setPersonaQuadByIndex();
            forceQuadUpdate();
          }
        }
        else
        {
          doingIntro = false;
        }
      }
      return;
    }

    if (reverseIntro)
    {
      close();
      return;
    }

    if (trans != null && !trans.complete) return;

    var wrap:Int = page == 1 ? 3 : 4;

    if (FlxG.keys.justPressed.DOWN)
    {
      selectedIndex += 1;
      if (selectedIndex > wrap) selectedIndex = 0;
      if (page == 0 && diffLocked && selectedIndex == 2) selectedIndex = 3;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setPersonaQuadByIndex();
    }
    else if (FlxG.keys.justPressed.UP)
    {
      selectedIndex -= 1;
      if (selectedIndex < 0) selectedIndex = wrap;
      if (page == 0 && diffLocked && selectedIndex == 2) selectedIndex = 1;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setPersonaQuadByIndex();
    }

    var tappedIndex:Int = HexTouch.tappedQuad(QUADS[page]);
    if (page == 0 && diffLocked && tappedIndex == 2) tappedIndex = -1;

    if (tappedIndex != -1 && tappedIndex != selectedIndex)
    {
      selectedIndex = tappedIndex;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setPersonaQuadByIndex();
    }
    else if (FlxG.keys.justPressed.ENTER || tappedIndex != -1)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
      select();
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
