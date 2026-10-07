package kade.hex.states;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.video.FunkinVideoSprite;
import funkin.ui.MusicBeatSubState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.dialogue.CastEntry;
import kade.hex.objects.dialogue.DialogueCommand;
import kade.hex.objects.dialogue.HexDialogueParser;
import kade.hex.objects.dialogue.SlideEntry;
import kade.hex.util.HexTouch;

/**
 * The story dialogue screen, running both the cutscene and sprite modes.
 */
class HexDialogueState extends MusicBeatSubState
{
  static var STORY:String = "gameplay/hex/story/";

  static var TOP_BAR_H:Int = 106;
  static var BOTTOM_BAR_Y:Int = 613;
  static var BOTTOM_BAR_H:Int = 107;
  static var CUT_Y:Int = 106;
  static var BAR_BLEED:Int = 4;

  static var WINDOW_X:Int = 272;
  static var WINDOW_Y:Int = 155;
  static var LINE_Y:Int = 314;

  static var SPRITE_SCALE:Float = 0.95;
  static var SPRITE_FLOOR_Y:Int = 655;
  static var SPRITE_RIGHT_DROP:Int = 12;

  static var SPRITE_WONDER_DROP:Int = 20;
  static var SPRITE_HEX_DROP:Int = 12;

  static var CAST_SPOTS:Array<Array<Float>> = [[640], [430, 830], [285, 640, 985]];
  static var CAST_POOL:Int = 4;

  static var BG_TINT:Int = 0xFF4A4C60;
  static var SWIRL_DARKEN:Float = 0.8;

  static var SLIDE_UP:Int = 30;
  static var SLIDE_RATE:Float = 0.17;
  static var CAST_RATE:Float = 0.085;

  static var BOP_UP:Int = 26;
  static var BOP_RATE:Float = 0.2;

  static var PICTURE_RATE:Float = 0.045;
  static var PICTURE_HOLD:Float = 1.3;
  static var LINE_AFTER_SCENE:Float = 0.55;

  static var CAST_EXIT_DROP:Int = 150;
  static var CAST_EXIT_TIME:Float = 0.5;

  static var MUSIC_FADE:Float = 1.2;
  static var SCREEN_FADE:Float = 0.9;

  static var AUTO_HOLD:Float = 1.4;

  static var TEXT_SIZE:Int = 28;
  static var TEXT_SAFE_W:Int = 880;
  static var TEXT_GAP:Int = 8;
  static var TAG_GAP:Int = 4;

  public static var played:Array<String> = [];

  public static function resetProgress():Void
  {
    played = [];
  }

  public var dialogueId:String = null;
  public var cutsceneFolder:String = "weekX_CUT";
  public var endedOnSong:Bool = false;

  var commands:Array<DialogueCommand> = [];
  var cmdIndex:Int = 0;

  var warmed:Array<FlxGraphic> = [];

  var mode:String = "sprite";
  var finished:Bool = false;

  var scene:FlxSprite;
  var bgFull:FlxSprite;
  var swirlBg:FlxSprite;
  var window:FlxSprite;
  var middleLine:FlxSprite;
  var cutPanel:FlxSprite;
  var cutOld:FlxSprite;
  var windowOld:FlxSprite;

  var slides:Array<SlideEntry> = [];
  var cutAnim:SlideEntry;
  var cutOldAnim:SlideEntry;
  var winAnim:SlideEntry;
  var winOldAnim:SlideEntry;

  var castSpr:Array<FlxSprite> = [];
  var castAnim:Array<SlideEntry> = [];
  var castTag:Array<String> = [];
  var onStage:Array<CastEntry> = [];
  var litId:String = null;
  var speakTick:Float = 0;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;
  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;
  var nametag:FlxSprite;
  var colon:FlxText;
  var measurer:FlxText;
  var text:FlxTypeText;

  var transition:HexTransitional;
  var swirl:FlxRuntimeShader;
  var shaderTime:Float = 0;

  var music:FlxSound;
  var loopedSfx:FlxSound;
  var musicVolume:Float = 0.8;
  var musicLoop:Bool = true;

  var video:FunkinVideoSprite = null;
  var videoPlaying:Bool = false;
  var primedVideo:Int = -1;

  var typing:Bool = false;
  var fullLine:String = "";
  var barCenter:Float = 0;

  var pictureHold:Float = 0;
  var pendingPose:String = null;
  var pendingLine:DialogueCommand = null;
  var pendingBg:String = null;
  var currentBg:String = null;

  var overlayLowered:Bool = false;
  var modeWiping:Bool = false;
  var modeWipeShut:Bool = false;
  var modeWipeTo:String = null;
  var modeWipeTag:String = null;
  var castExit:Float = 0;
  var lineHold:Float = 0;

  var swirlNow:Array<Float> = [0.204, 0.247, 0.541, 0.137, 0.157, 0.349];
  var swirlTarget:Array<Float> = [0.204, 0.247, 0.541, 0.137, 0.157, 0.349];
  var waitTimer:Float = 0;
  var startDelay:Float = 0;
  var scriptDelay:Float = 0;

  var screenFade:FlxSprite;
  var fadeTarget:Float = 0;
  var fadeFrom:Float = 0;
  var fadeTime:Float = 999;
  var fadeHolding:Bool = false;
  var autoPlay:Bool = false;
  var autoTimer:Float = 0;

  // uColor1 then uColor2 for bg_normal_1 through bg_normal_10.
  var swirlColors:Array<Array<Float>> = [
    [0.671, 0.741, 0.929, 0.455, 0.565, 0.812],
    [0.024, 0.000, 0.220, 0.027, 0.078, 0.361],
    [0.435, 0.592, 0.988, 0.608, 0.718, 0.980],
    [0.349, 0.000, 0.051, 0.761, 0.020, 0.153],
    [0.322, 0.702, 0.859, 0.059, 0.451, 0.725],
    [0.427, 0.071, 0.020, 0.200, 0.020, 0.008],
    [0.980, 0.976, 0.871, 0.996, 0.596, 0.514],
    [0.204, 0.247, 0.541, 0.137, 0.157, 0.349],
    [0.204, 0.247, 0.541, 0.137, 0.157, 0.349],
    [0.592, 0.098, 0.196, 0.067, 0.008, 0.020]
  ];

  public function new()
  {
    super();
  }

  override public function create():Void
  {
    super.create();

    if (FlxG.sound.music != null) FlxG.sound.music.pause();

    scene = new FlxSprite(0, 0);
    scene.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    add(scene);

    bgFull = new FlxSprite(0, 0);
    bgFull.color = BG_TINT;
    bgFull.visible = false;
    add(bgFull);

    swirlBg = new FlxSprite(0, 0);
    swirlBg.makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
    swirl = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirl.setFloat("uTime", 0);
    swirl.setFloat("uMix", 0.55);
    swirl.setFloat("uIntensity", 8.0);
    swirl.setFloatArray("uColor1", [0.204, 0.247, 0.541]);
    swirl.setFloatArray("uColor2", [0.137, 0.157, 0.349]);
    swirlBg.shader = swirl;
    add(swirlBg);

    middleLine = new FlxSprite(0, LINE_Y, Paths.image(STORY + "spriteMode/middleLine"));
    middleLine.visible = false;
    add(middleLine);

    cutOld = new FlxSprite(0, CUT_Y);
    cutOld.visible = false;
    add(cutOld);

    cutPanel = new FlxSprite(0, CUT_Y);
    cutPanel.visible = false;
    add(cutPanel);

    windowOld = new FlxSprite(WINDOW_X, WINDOW_Y);
    windowOld.visible = false;
    add(windowOld);

    window = new FlxSprite(WINDOW_X, WINDOW_Y);
    window.visible = false;
    add(window);

    for (i in 0...CAST_POOL)
    {
      var spr:FlxSprite = new FlxSprite(0, 0);
      spr.visible = false;
      add(spr);
      castSpr.push(spr);
      castAnim.push(track(spr));
    }

    cutAnim = track(cutPanel);
    cutOldAnim = track(cutOld);
    winAnim = track(window);
    winOldAnim = track(windowOld);

    topBar = new FlxSprite(-BAR_BLEED, -BAR_BLEED);
    topBar.makeGraphic(FlxG.width + BAR_BLEED * 2, TOP_BAR_H + BAR_BLEED, 0xFF000000);
    add(topBar);

    bottomBar = new FlxSprite(-BAR_BLEED, BOTTOM_BAR_Y);
    bottomBar.makeGraphic(FlxG.width + BAR_BLEED * 2, BOTTOM_BAR_H + BAR_BLEED, 0xFF000000);
    add(bottomBar);

    nametag = new FlxSprite(0, 0);
    nametag.visible = false;
    add(nametag);

    colon = new FlxText(0, 0, 0, ":");
    colon.setFormat(Paths.font("ui/fonts/Arista.ttf"), TEXT_SIZE, 0xFFFFFFFF, "left");
    colon.visible = false;
    add(colon);

    measurer = new FlxText(0, 0, 0, "");
    measurer.setFormat(Paths.font("ui/fonts/Arista.ttf"), TEXT_SIZE, 0xFFFFFFFF, "left");
    measurer.visible = false;
    add(measurer);

    text = new FlxTypeText(0, 0, 0, "", TEXT_SIZE);
    text.setFormat(Paths.font("ui/fonts/Arista.ttf"), TEXT_SIZE, 0xFFFFFFFF, "left");
    add(text);

    screenFade = new FlxSprite(0, 0);
    screenFade.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    screenFade.alpha = 0;
    screenFade.visible = false;
    add(screenFade);

    transition = new HexTransitional();
    transition.forceIn();

    topCircle = new FlxSprite(0, 0, Paths.image(STORY + "circleTop"));
    topCircle.scale.set(0.975, 0.975);
    topCircle.updateHitbox();
    topCircle.x = 0;
    topCircle.y = 0;
    add(topCircle);

    bottomCircle = new FlxSprite(0, 0, Paths.image(STORY + "circleBottom"));
    bottomCircle.scale.set(1.275, 1.275);
    bottomCircle.updateHitbox();
    bottomCircle.x = FlxG.width - bottomCircle.width;
    bottomCircle.y = FlxG.height - bottomCircle.height;
    add(bottomCircle);

    add(transition);

    barCenter = BOTTOM_BAR_Y + BOTTOM_BAR_H / 2;

    loadScript();
    preloadImages();
    primeScene();
    primeVideo();
    startDelay = 0.5;
    scriptDelay = 0.45;

    if (camera != null)
    {
      var cam = camera;
      forEach(function(basic:FlxBasic)
      {
        basic.cameras = [cam];
      }, true);
    }
  }

  function track(spr:FlxSprite):SlideEntry
  {
    var entry:SlideEntry = new SlideEntry(spr, SLIDE_RATE);
    slides.push(entry);
    return entry;
  }

  function place(entry:SlideEntry, x:Float, y:Float):Void
  {
    entry.baseX = x;
    entry.baseY = y;
    entry.offX = 0;
    entry.offY = 0;
    entry.tgtX = 0;
    entry.tgtY = 0;
    entry.rate = SLIDE_RATE;
    entry.alphaNow = 1;
    entry.alphaTgt = 1;
    entry.spr.x = x;
    entry.spr.y = y;
    entry.spr.alpha = 1;
  }

  function stepSlides(elapsed:Float):Void
  {
    for (a in slides)
    {
      var t:Float = Math.min(a.rate * elapsed * 60, 1);
      a.offX = FlxMath.lerp(a.offX, a.tgtX, t);
      a.offY = FlxMath.lerp(a.offY, a.tgtY, t);
      a.alphaNow = FlxMath.lerp(a.alphaNow, a.alphaTgt, t);
      a.spr.x = a.baseX + a.offX;
      a.spr.y = a.baseY + a.offY;
      a.spr.alpha = a.alphaNow;
    }

    if (cutOld.visible && cutOld.x + cutOld.width < 0) cutOld.visible = false;
    if (windowOld.visible && windowOld.x + windowOld.width < 0) windowOld.visible = false;
    for (i in 0...castSpr.length)
    {
      if (castSpr[i].visible && castAnim[i].alphaTgt <= 0 && castAnim[i].alphaNow < 0.02) castSpr[i].visible = false;
    }
  }

  function beginModeWipe(next:String, tag:String):Void
  {
    modeWiping = true;
    modeWipeTo = next;
    modeWipeTag = tag;
    pictureHold = 999;

    transition.noSound = true;
    transition.transitionIn();
    transition.onComplete = function(out:Bool)
    {
      if (out) return;

      transition.onComplete = null;

      modeWipeShut = true;
    };
  }

  function finishModeWipe():Void
  {
    modeWipeShut = false;

    setMode(modeWipeTo);

    var show:String = modeWipeTag;
    if (show == null && pendingLine != null) show = pendingLine.tag;

    applyTagInstant(show);

    modeWiping = false;
    transition.transitionOut();
    transition.noSound = false;

    flushPending();
    if (lineHold <= 0) step();
  }

  function applyTagInstant(tag:String):Void
  {
    if (tag == null) return;

    if (HexDialogueParser.isCutTag(tag)) setPanel(tag);
    else if (HexDialogueParser.isBackgroundTag(tag)) setBackground(tag, true);
    else setPose(tag);
  }

  function startPendingBg():Void
  {
    castExit = 0;
    if (pendingBg == null) return;

    var bg:String = pendingBg;
    pendingBg = null;
    applyBackground(bg, false);
  }

  function flushPending():Void
  {
    pictureHold = 0;

    if (pendingPose != null)
    {
      var pose:String = pendingPose;
      pendingPose = null;
      applyPose(pose);
    }

    if (pendingLine != null) lineHold = LINE_AFTER_SCENE;
  }

  function flushLine():Void
  {
    lineHold = 0;
    if (pendingLine == null) return;

    var line:DialogueCommand = pendingLine;
    pendingLine = null;
    renderLine(line);
  }

  function finishPicture():Void
  {
    startPendingBg();

    for (a in slides)
    {
      a.offX = a.tgtX;
      a.offY = a.tgtY;
      a.alphaNow = a.alphaTgt;
      a.spr.x = a.baseX + a.offX;
      a.spr.y = a.baseY + a.offY;
      a.spr.alpha = a.alphaNow;
    }

    cutOld.visible = false;
    windowOld.visible = false;

    flushPending();
    flushLine();
  }

  function clearCast():Void
  {
    for (entry in onStage)
      sendAway(castSpr[entry.pool], castAnim[entry.pool]);

    onStage = [];
    litId = null;
  }

  function dropCast():Void
  {
    for (i in 0...castSpr.length)
    {
      castSpr[i].visible = false;
      castAnim[i].offX = 0;
      castAnim[i].offY = 0;
      castAnim[i].tgtX = 0;
      castAnim[i].tgtY = 0;
      castAnim[i].alphaNow = 1;
      castAnim[i].alphaTgt = 1;
    }

    onStage = [];
    litId = null;
  }

  function castIndex(id:String):Int
  {
    for (i in 0...onStage.length)
    {
      if (onStage[i].id == id) return i;
    }
    return -1;
  }

  function poolFree():Int
  {
    var spare:Int = -1;

    for (i in 0...castSpr.length)
    {
      var taken:Bool = false;

      for (entry in onStage)
      {
        if (entry.pool == i) taken = true;
      }

      if (taken) continue;

      if (!castSpr[i].visible) return i;

      if (spare == -1) spare = i;
    }

    return spare == -1 ? 0 : spare;
  }

  function layoutCast():Void
  {
    if (onStage.length == 0) return;

    var spots:Array<Float> = CAST_SPOTS[onStage.length - 1];

    for (i in 0...onStage.length)
    {
      var spr:FlxSprite = castSpr[onStage[i].pool];
      var anim:SlideEntry = castAnim[onStage[i].pool];

      var restX:Float = spots[i] - spr.width / 2;
      var floor:Float = SPRITE_FLOOR_Y;
      if (onStage[i].id == "BF") floor += SPRITE_RIGHT_DROP;
      if (onStage[i].id == "BF" && castTag[onStage[i].pool] != null && castTag[onStage[i].pool].indexOf("_WONDER") != -1) floor += SPRITE_WONDER_DROP;
      else if (onStage[i].id == "HX") floor += SPRITE_HEX_DROP;

      anim.offX = (anim.baseX + anim.offX) - restX;
      anim.offY = (anim.baseY + anim.offY) - (floor - spr.height);
      anim.baseX = restX;
      anim.baseY = floor - spr.height;
      anim.tgtX = 0;
      anim.tgtY = 0;
      anim.rate = CAST_RATE;
    }
  }

  function sendAway(spr:FlxSprite, anim:SlideEntry):Void
  {
    if (!spr.visible) return;

    anim.tgtY = CAST_EXIT_DROP;
    anim.alphaTgt = 0;
    anim.rate = CAST_RATE;
  }

  function sendOffLeft(live:FlxSprite, old:FlxSprite, oldAnim:SlideEntry):Void
  {
    if (live.graphic == null || !live.visible) return;

    old.loadGraphicFromSprite(live);
    old.visible = true;

    oldAnim.baseX = live.x;
    oldAnim.baseY = live.y;
    oldAnim.offX = 0;
    oldAnim.offY = 0;
    oldAnim.alphaNow = 1;
    oldAnim.alphaTgt = 1;
    oldAnim.rate = PICTURE_RATE;
    oldAnim.tgtX = -(live.x + live.width + 40);
    oldAnim.tgtY = 0;

    old.x = oldAnim.baseX;
    old.y = oldAnim.baseY;
    old.alpha = 1;
  }

  function preloadImages():Void
  {
    var folder:String = cutsceneFolder;
    for (cmd in commands)
    {
      if (cmd.type == "directive" && cmd.name == "cutscenes") folder = cmd.value;
    }

    var seen:Map<String, Bool> = new Map();

    for (cmd in commands)
    {
      var tag:String = cmd.tag;
      if (tag == null) continue;

      if (HexDialogueParser.isCutTag(tag))
      {
        cacheImage(STORY + "cutsceneMode/" + folder + "/" + tag.toUpperCase(), seen);
      }
      else if (HexDialogueParser.isBackgroundTag(tag))
      {
        cacheImage(STORY + "spriteMode/" + tag, seen);
        cacheImage(STORY + "spriteMode/windowBG" + trailingNumber(tag), seen);
      }
      else
      {
        var pose:String = HexDialogueParser.folderForTag(tag);
        if (pose != null) cacheImage(STORY + "spriteMode/sprites/" + pose + "/" + tag, seen);
      }
    }
  }

  function cacheImage(key:String, seen:Map<String, Bool>):Void
  {
    if (seen.exists(key)) return;
    seen.set(key, true);

    var path:String = Paths.image(key);
    if (!Assets.exists(path)) return;
    var warm:FlxSprite = new FlxSprite();
    warm.loadGraphic(path);

    if (warm.graphic != null)
    {
      warm.graphic.persist = true;
      warm.graphic.destroyOnNoUse = false;
      warmed.push(warm.graphic);

      warm.draw();

      var context = FlxG.game.stage.context3D;
      if (warm.graphic.bitmap != null && context != null) warm.graphic.bitmap.getTexture(context);
    }

    warm.destroy();
  }

  function goBack():Void
  {
    if (finished || scriptDelay > 0) return;

    if (videoPlaying) endVideo();
    else if (waitTimer <= 0) skipToEnd();
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    videoPlaying = false;
    if (video != null)
    {
      video.destroy();
      video = null;
    }

    super.destroy();

    for (graphic in warmed)
    {
      if (graphic == null) continue;

      graphic.persist = false;
      graphic.destroyOnNoUse = true;
      FlxG.bitmap.remove(graphic);
    }

    warmed = [];
  }

  function primeVideo():Void
  {
    for (i in 0...commands.length)
    {
      var cmd:DialogueCommand = commands[i];

      if (cmd.type != "directive") return;

      if (cmd.name == "playvideo")
      {
        primedVideo = i;
        startVideo(cmd.value);
        return;
      }
    }
  }

  function applySwirlColors():Void
  {
    swirl.setFloatArray("uColor1", [swirlNow[0], swirlNow[1], swirlNow[2]]);
    swirl.setFloatArray("uColor2", [swirlNow[3], swirlNow[4], swirlNow[5]]);
  }

  function primeScene():Void
  {
    for (cmd in commands)
    {
      if (cmd.type == "directive" && cmd.name == "cutscenes") cutsceneFolder = cmd.value;
    }

    var opensSprite:Bool = true;
    var bgTag:String = null;
    var cutTag:String = null;

    for (cmd in commands)
    {
      if (cmd.type == "mode") opensSprite = cmd.mode == "sprite";

      if (HexDialogueParser.isBackgroundTag(cmd.tag))
      {
        bgTag = cmd.tag;
        break;
      }

      if (HexDialogueParser.isCutTag(cmd.tag))
      {
        cutTag = cmd.tag;
        break;
      }
    }

    if (cutTag != null)
    {
      mode = "cutscene";
      setPanel(cutTag);
      return;
    }

    if (bgTag == null) return;

    var index:Int = trailingNumber(bgTag);
    if (index >= 1 && index <= swirlColors.length)
    {
      var c:Array<Float> = swirlColors[index - 1];
      for (j in 0...6)
      {
        swirlNow[j] = c[j] * SWIRL_DARKEN;
        swirlTarget[j] = swirlNow[j];
      }
      applySwirlColors();
    }

    if (!opensSprite) return;

    mode = "sprite";
    applyBackground(bgTag, true);
    middleLine.visible = true;
  }

  function loadScript():Void
  {
    if (dialogueId == null) return;

    var path:String = Paths.txt(STORY + "dialogue/" + dialogueId);
    if (!Assets.exists(path))
    {
      trace("[HexDialogue] missing script " + path);
      return;
    }

    commands = HexDialogueParser.parse(Assets.getText(path));
    trace("[HexDialogue] " + dialogueId + " parsed into " + commands.length + " commands");
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    super.update(elapsed);

    shaderTime += elapsed;
    if (swirl != null)
    {
      swirl.setFloat("uTime", shaderTime);

      var ct:Float = Math.min(PICTURE_RATE * elapsed * 60, 1);
      for (i in 0...6)
        swirlNow[i] = FlxMath.lerp(swirlNow[i], swirlTarget[i], ct);

      applySwirlColors();
    }

    if (modeWipeShut && !finished) finishModeWipe();

    stepSlides(elapsed);
    stepScreenFade(elapsed);

    if (castExit > 0)
    {
      castExit -= elapsed;
      if (castExit <= 0) startPendingBg();
    }

    if (pictureHold > 0 && !modeWiping)
    {
      pictureHold -= elapsed;
      if (pictureHold <= 0) flushPending();
    }
    else if (lineHold > 0)
    {
      lineHold -= elapsed;
      if (lineHold <= 0) flushLine();
    }

    if (startDelay > 0)
    {
      startDelay -= elapsed;
      if (startDelay <= 0) transition.transitionOut();
      return;
    }

    if (scriptDelay > 0)
    {
      scriptDelay -= elapsed;
      if (scriptDelay <= 0)
      {
        lowerOverlay();
        step();
      }
      return;
    }

    if (finished) return;

    if (videoPlaying)
    {
      if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE || HexTouch.tapped()) endVideo();

      return;
    }

    if (typing && text.text.length >= fullLine.length)
    {
      typing = false;
      if (autoPlay) autoTimer = AUTO_HOLD;
    }

    text.y = FlxMath.lerp(text.y, barCenter - text.height / 2, Math.min(0.22 * elapsed * 60, 1));

    if (waitTimer > 0)
    {
      waitTimer -= elapsed;
      if (waitTimer <= 0) step();
      return;
    }

    if (FlxG.keys.justPressed.ESCAPE)
    {
      skipToEnd();
      return;
    }

    if (modeWiping || fadeHolding) return;

    if (pictureHold > 0 || lineHold > 0)
    {
      if (!autoPlay && (FlxG.keys.justPressed.ANY || HexTouch.tapped())) finishPicture();
      return;
    }

    if (autoPlay)
    {
      if (autoTimer > 0)
      {
        autoTimer -= elapsed;
        if (autoTimer <= 0) step();
      }

      return;
    }

    if (FlxG.keys.justPressed.ANY || HexTouch.tapped())
    {
      if (typing)
      {
        text.skip();
        typing = false;
      }
      else
      {
        FunkinSound.playOnce(Paths.sound(STORY + "sounds/click"), 0.7);
        step();
      }
    }
  }

  function step():Void
  {
    while (cmdIndex < commands.length)
    {
      var cmd:DialogueCommand = commands[cmdIndex];
      cmdIndex++;

      switch (cmd.type)
      {
        case "mode":
          if (mode != cmd.mode)
          {
            beginModeWipe(cmd.mode, cmd.tag);
            return;
          }

          setMode(cmd.mode);
          if (cmd.tag != null) applyTag(cmd.tag);
        case "tag":
          applyTag(cmd.tag);
        case "directive":
          if (cmdIndex - 1 == primedVideo)
          {
            primedVideo = -1;
            if (videoPlaying) return;
          }
          else
          {
            runDirective(cmd.name, cmd.value);
            if (cmd.name == "wait" || fadeHolding || videoPlaying) return;
          }
        case "blackscreen":
          showBlackScreen();
        case "clearsprites":
          dropCast();
        case "startsong":
          finish(true);
          return;
        case "backtomenu":
          finish(false);
          return;
        case "line":
          showLine(cmd);
          return;
      }
    }

    finish(true);
  }

  function showLine(cmd:DialogueCommand):Void
  {
    if (cmd.tag != null) applyTag(cmd.tag);

    if (pictureHold > 0)
    {
      pendingLine = cmd;
      return;
    }

    renderLine(cmd);
  }

  function renderLine(cmd:DialogueCommand):Void
  {
    var code:String = cmd.who;
    var voice:String = voiceFor(code, cmd.tag);

    var plate:String = nametagFor(code, cmd.tag);
    var tagPath:String = plate == null ? null : Paths.image(STORY + "nametag" + plate);
    var named:Bool = tagPath != null && Assets.exists(tagPath);
    if (named)
    {
      nametag.loadGraphic(tagPath);
      nametag.updateHitbox();
    }

    nametag.visible = named;
    colon.visible = named;

    var voicePath:String = voice == null ? null : Paths.sound(STORY + "sounds/" + voice);
    if (voicePath != null && Assets.exists(voicePath)) FunkinSound.playOnce(voicePath, 0.7);
    else FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"), 0.7);

    fullLine = cmd.text;
    layoutLine(named);

    text.resetText(fullLine);
    text.start(0.035, true);
    typing = true;

    text.y = barCenter - text.height / 2;
  }

  function layoutLine(named:Bool):Void
  {
    var lead:Float = named ? nametag.width + TAG_GAP + colon.width + TEXT_GAP : 0;

    var lines:Array<String> = wrapText(fullLine, TEXT_SAFE_W - lead);
    fullLine = lines.join("\n");

    var widest:Float = 0;
    for (line in lines)
    {
      measurer.text = line;
      if (measurer.width > widest) widest = measurer.width;
    }

    text.fieldWidth = widest + 4;
    text.text = fullLine;

    var total:Float = lead + text.fieldWidth;
    var startX:Float = (FlxG.width - total) / 2;

    text.x = startX + lead;

    nametag.x = startX;
    nametag.y = barCenter - nametag.height / 2;
    colon.x = startX + nametag.width + TAG_GAP;
    colon.y = barCenter - colon.height / 2;
  }

  function wrapText(line:String, maxWidth:Float):Array<String>
  {
    var lines:Array<String> = [];

    var segments:Array<String> = StringTools.replace(line, "\\n", "\n").split("\n");

    for (segment in segments)
    {
      var words:Array<String> = StringTools.trim(segment).split(" ");
      var current:String = "";
      var rows:Array<String> = [];

      for (word in words)
      {
        var trial:String = current == "" ? word : current + " " + word;
        measurer.text = trial;

        if (measurer.width > maxWidth && current != "")
        {
          rows.push(current);
          current = word;
        }
        else
        {
          current = trial;
        }
      }

      rows.push(current);
      rows = tidyLines(rows, maxWidth);

      for (r in rows) lines.push(r);
    }

    return lines;
  }

  function tidyLines(lines:Array<String>, maxWidth:Float):Array<String>
  {
    if (lines.length < 2) return lines;

    var rows:Array<Array<String>> = [];
    for (line in lines) rows.push(line.split(" "));

    pushSingleLetters(rows, maxWidth);

    var tail:Array<String> = rows[rows.length - 1];
    var prev:Array<String> = rows[rows.length - 2];
    if (tail.length == 1 && prev.length > 1)
    {
      var moved:String = prev[prev.length - 1];
      if (fits(moved + " " + tail.join(" "), maxWidth))
      {
        prev.pop();
        tail.unshift(moved);
      }
    }

    pushSingleLetters(rows, maxWidth);

    var out:Array<String> = [];
    for (row in rows) out.push(row.join(" "));

    return out;
  }

  function pushSingleLetters(rows:Array<Array<String>>, maxWidth:Float):Void
  {
    for (i in 0...rows.length - 1)
    {
      var row:Array<String> = rows[i];
      if (row.length < 2) continue;

      var last:String = row[row.length - 1];
      if (last.length != 1) continue;

      if (!fits(last + " " + rows[i + 1].join(" "), maxWidth)) continue;

      row.pop();
      rows[i + 1].unshift(last);
    }
  }

  function fits(line:String, maxWidth:Float):Bool
  {
    measurer.text = line;
    return measurer.width <= maxWidth;
  }

  function applyTag(tag:String):Void
  {
    if (tag == null) return;

    if (HexDialogueParser.isCutTag(tag))
    {
      setMode("cutscene");
      setPanel(tag);
    }
    else if (HexDialogueParser.isBackgroundTag(tag))
    {
      var blackedOut:Bool = screenFade != null && screenFade.visible && screenFade.alpha >= 1;
      var entering:Bool = mode != "sprite" || currentBg == null || blackedOut;
      setMode("sprite");
      setBackground(tag, entering);
    }
    else
    {
      setPose(tag);
    }
  }

  function setMode(next:String):Void
  {
    if (mode == next && (window.visible || cutPanel.visible)) return;

    mode = next;

    var isSprite:Bool = next == "sprite";
    bgFull.visible = isSprite && bgFull.graphic != null;
    swirlBg.visible = isSprite;
    window.visible = isSprite && window.graphic != null;
    middleLine.visible = isSprite;

    topBar.visible = true;
    bottomBar.visible = true;

    for (spr in castSpr) spr.visible = false;
    for (entry in onStage) castSpr[entry.pool].visible = isSprite;
    cutPanel.visible = !isSprite && cutPanel.graphic != null;

    cutOld.visible = false;
    windowOld.visible = false;
  }

  function showBlackScreen():Void
  {
    bgFull.visible = false;
    swirlBg.visible = false;
    window.visible = false;
    middleLine.visible = false;
    for (spr in castSpr) spr.visible = false;
    cutPanel.visible = false;
    cutOld.visible = false;
    windowOld.visible = false;
    nametag.visible = false;
    colon.visible = false;
    text.resetText("");
  }

  function setPanel(tag:String):Void
  {
    var path:String = Paths.image(STORY + "cutsceneMode/" + cutsceneFolder + "/" + tag.toUpperCase());
    if (!Assets.exists(path))
    {
      trace("[HexDialogue] missing panel " + path);
      return;
    }

    cutPanel.loadGraphic(path);

    var band:Float = BOTTOM_BAR_Y - TOP_BAR_H + BAR_BLEED * 2;
    var fill:Float = Math.max(FlxG.width / cutPanel.frameWidth, band / cutPanel.frameHeight);
    cutPanel.scale.set(fill, fill);
    cutPanel.updateHitbox();
    cutPanel.visible = true;

    place(cutAnim, (FlxG.width - cutPanel.width) / 2, (FlxG.height - cutPanel.height) / 2);

    cutOld.visible = false;
  }

  function setBackground(key:String, instant:Bool):Void
  {
    if (key == currentBg) return;

    if (!instant && onStage.length > 0 && pendingBg == null)
    {
      pendingBg = key;
      castExit = CAST_EXIT_TIME;
      pictureHold = CAST_EXIT_TIME + PICTURE_HOLD;
      clearCast();
      return;
    }

    applyBackground(key, instant);
  }

  function applyBackground(key:String, instant:Bool):Void
  {
    var index:Int = trailingNumber(key);
    currentBg = key;

    for (entry in onStage)
    {
      castSpr[entry.pool].visible = false;
      castAnim[entry.pool].alphaNow = 0;
      castAnim[entry.pool].alphaTgt = 0;
    }

    onStage = [];
    litId = null;

    var fullPath:String = Paths.image(STORY + "spriteMode/" + key);
    if (Assets.exists(fullPath))
    {
      bgFull.loadGraphic(fullPath);
      bgFull.setGraphicSize(FlxG.width, FlxG.height);
      bgFull.updateHitbox();
      bgFull.visible = true;
    }

    var windowPath:String = Paths.image(STORY + "spriteMode/windowBG" + index);
    if (Assets.exists(windowPath))
    {
      if (!instant) sendOffLeft(window, windowOld, winOldAnim);

      window.loadGraphic(windowPath);
      window.updateHitbox();
      window.visible = true;

      place(winAnim, (FlxG.width - window.width) / 2, WINDOW_Y);

      if (!instant)
      {
        winAnim.offX = FlxG.width;
        winAnim.rate = PICTURE_RATE;
        window.x = winAnim.baseX + winAnim.offX;

        pictureHold = PICTURE_HOLD;
      }
      else
      {
        windowOld.visible = false;
      }
    }

    if (index >= 1 && index <= swirlColors.length)
    {
      var c:Array<Float> = swirlColors[index - 1];
      for (i in 0...6)
        swirlTarget[i] = c[i] * SWIRL_DARKEN;
    }

    swirlBg.visible = true;
  }

  function setPose(tag:String):Void
  {
    if (pictureHold > 0)
    {
      pendingPose = tag;
      return;
    }

    applyPose(tag);
  }

  function applyPose(tag:String):Void
  {
    var folder:String = HexDialogueParser.folderForTag(tag);
    if (folder == null) return;

    var path:String = Paths.image(STORY + "spriteMode/sprites/" + folder + "/" + tag);
    if (!Assets.exists(path))
    {
      trace("[HexDialogue] missing pose " + path);
      return;
    }

    speakTick += 1;

    var at:Int = castIndex(folder);
    var newcomer:Bool = at == -1;

    if (newcomer)
    {
      if (onStage.length >= 3)
      {
        var oldest:Int = -1;

        for (i in 0...onStage.length)
        {
          if (onStage[i].id == "BF") continue;
          if (oldest == -1 || onStage[i].spoke < onStage[oldest].spoke) oldest = i;
        }

        if (oldest != -1)
        {
          sendAway(castSpr[onStage[oldest].pool], castAnim[onStage[oldest].pool]);
          onStage.splice(oldest, 1);
        }
      }

      var entry:CastEntry = new CastEntry(folder, poolFree(), speakTick);

      // Boyfriend holds the right hand end
      if (folder != "BF" && onStage.length > 0 && onStage[onStage.length - 1].id == "BF") onStage.insert(onStage.length - 1, entry);
      else onStage.push(entry);

      at = castIndex(folder);
    }

    onStage[at].spoke = speakTick;

    var sprite:FlxSprite = castSpr[onStage[at].pool];
    var anim:SlideEntry = castAnim[onStage[at].pool];

    castTag[onStage[at].pool] = tag;
    sprite.loadGraphic(path);
    sprite.setGraphicSize(Std.int(sprite.frameWidth * SPRITE_SCALE));
    sprite.updateHitbox();
    sprite.visible = mode == "sprite";

    anim.alphaTgt = 1;

    layoutCast();

    if (newcomer)
    {
      anim.rate = CAST_RATE;
      anim.offY = SLIDE_UP;
      anim.offX = 0;
      anim.alphaNow = 0;
      sprite.alpha = 0;
    }
    else
    {
      anim.rate = BOP_RATE;
      anim.offX = 0;
      anim.offY -= BOP_UP;
    }

    sprite.x = anim.baseX + anim.offX;
    sprite.y = anim.baseY + anim.offY;

    litId = folder;
    applyLighting();
  }

  function applyLighting():Void
  {
    for (entry in onStage)
      castSpr[entry.pool].color = entry.id == litId ? 0xFFFFFFFF : 0xFF5B5F7A;
  }

  function nametagFor(code:String, tag:String):String
  {
    if (code == null) return null;

    var id:String = code.toUpperCase();
    if (id == "IN" || id == "IF") return "IF";
    // BX is the shared "BF&Hex" plate.
    if (id == "BF&HX") return "BX";
    if (id == "??")
    {
      var folder:String = HexDialogueParser.folderForTag(tag);
      return folder != null && !HexDialogueParser.isCutTag(tag) ? folder.toUpperCase() : "HX";
    }
    return id;
  }

  function voiceFor(code:String, tag:String):String
  {
    var folder:String = HexDialogueParser.folderForTag(tag);
    if (folder != null && !HexDialogueParser.isCutTag(tag)) return folder.toLowerCase();

    if (code == null) return null;

    var id:String = code.toUpperCase();
    if (id == "IF") return "in";
    if (id == "??") return "ir";
    if (id == "BF&HX") return "bf";
    return id.toLowerCase();
  }

  function runDirective(name:String, value:String):Void
  {
    switch (name)
    {
      case "cutscenes":
        cutsceneFolder = value;
      case "musicvolume":
        musicVolume = Std.parseFloat(value);
      case "musicloop":
        musicLoop = value.toLowerCase() != "false" && value.toLowerCase() != "off";
      case "playmusic":
        playMusic(value);
      case "musiceffect":
        musicEffect(value.toLowerCase());
      case "screeneffect":
        startScreenFade(value.toLowerCase() == "fadeout" ? 1.0 : 0.0);
      case "playercontrols":
        autoPlay = value.toLowerCase() == "disabled";
        autoTimer = 0;
      case "playsound":
        var path:String = Paths.sound(STORY + "sounds/" + value);
        if (Assets.exists(path)) FunkinSound.playOnce(path, 0.9);
      case "loopsound":
        stopLoopedSfx();
        var loopPath:String = Paths.sound(STORY + "sounds/" + value);
        if (Assets.exists(loopPath))
        {
          loopedSfx = FunkinSound.load(loopPath, 0.7, true);
          FlxG.sound.list.add(loopedSfx);
          loopedSfx.play();
        }
      case "wait":
        waitTimer = Std.parseFloat(value);
      case "playvideo":
        startVideo(value);
    }
  }

  function startVideo(key:String):Void
  {
    var path:String = Paths.videos(STORY + "videos/" + key);
    if (!Assets.exists(path))
    {
      trace("[HexDialogue] missing video " + path);
      return;
    }

    video = new FunkinVideoSprite(0, 0);
    video.zIndex = 10000;

    var bitmap:Dynamic = video.bitmap;

    bitmap.onFormatSetup.add(function()
    {
      if (video == null) return;
      var vb:Dynamic = video.bitmap;
      if (vb == null || vb.bitmapData == null) return;

      var w:Float = vb.bitmapData.width;
      var h:Float = vb.bitmapData.height;
      var fit:Float = Math.min(FlxG.width / w, FlxG.height / h);
      video.setGraphicSize(Std.int(w * fit), Std.int(h * fit));
      video.updateHitbox();
      video.screenCenter();
    });

    bitmap.onEndReached.add(function()
    {
      endVideo();
    });

    add(video);

    restackOverlay();

    videoPlaying = true;

    video.load(path);
    video.play();
  }

  function restackOverlay():Void
  {
    lift(screenFade);

    if (overlayLowered)
    {
      lift(transition);
      lift(topCircle);
      lift(bottomCircle);
    }
    else
    {
      lift(topCircle);
      lift(bottomCircle);
      lift(transition);
    }

    if (video != null)
    {
      lift(video);
      lift(transition);
    }
  }

  function lift(obj:FlxBasic):Void
  {
    if (obj == null) return;

    remove(obj, true);
    add(obj);
  }

  function lowerOverlay():Void
  {
    if (overlayLowered) return;

    overlayLowered = true;
    restackOverlay();
  }

  function endVideo():Void
  {
    if (!videoPlaying) return;

    videoPlaying = false;

    if (video != null)
    {
      remove(video, true);
      video.destroy();
      video = null;
    }

    if (startDelay <= 0 && scriptDelay <= 0) step();
  }

  function playMusic(key:String):Void
  {
    if (music != null)
    {
      music.fadeOut(0.6, 0);
      music = null;
    }

    if (key == null || key.toLowerCase() == "none") return;

    var path:String = musicPath(key);
    if (path == null)
    {
      trace("[HexDialogue] missing track " + key);
      return;
    }

    music = FunkinSound.load(path, 0, musicLoop);
    FlxG.sound.list.add(music);
    music.play();
    music.fadeIn(1, 0, musicVolume);
  }

  function musicEffect(effect:String):Void
  {
    if (music == null) return;

    switch (effect)
    {
      case "fadeout":
        music.fadeOut(MUSIC_FADE, 0);
        music = null;
      case "fadein":
        music.fadeIn(MUSIC_FADE, music.volume, musicVolume);
      case "stop":
        music.stop();
        music = null;
    }
  }

  function startScreenFade(target:Float):Bool
  {
    if (screenFade == null || screenFade.alpha == target) return false;

    fadeFrom = screenFade.alpha;
    fadeTarget = target;
    fadeTime = 0;
    fadeHolding = true;

    return true;
  }

  function stepScreenFade(elapsed:Float):Void
  {
    if (screenFade == null || fadeTime >= SCREEN_FADE) return;

    fadeTime += elapsed;

    var t:Float = Math.min(fadeTime / SCREEN_FADE, 1);
    screenFade.alpha = fadeFrom + (fadeTarget - fadeFrom) * t;
    screenFade.visible = screenFade.alpha > 0;

    if (fadeTime >= SCREEN_FADE && fadeHolding)
    {
      fadeHolding = false;
      step();
    }
  }

  function musicPath(key:String):String
  {
    var candidates:Array<String> = [STORY + "music/" + key, "ui/hex/music/" + key, "ui/hex/sounds/" + key];

    for (candidate in candidates)
    {
      var path:String = Paths.music(candidate);
      if (Assets.exists(path)) return path;
      path = Paths.sound(candidate);
      if (Assets.exists(path)) return path;
    }

    return null;
  }

  function stopLoopedSfx():Void
  {
    if (loopedSfx == null) return;
    loopedSfx.stop();
    loopedSfx = null;
  }

  function skipToEnd():Void
  {
    while (cmdIndex < commands.length)
    {
      var cmd:DialogueCommand = commands[cmdIndex];
      cmdIndex++;
      if (cmd.type == "startsong")
      {
        finish(true);
        return;
      }
      if (cmd.type == "backtomenu")
      {
        finish(false);
        return;
      }
    }

    finish(true);
  }

  function finish(intoSong:Bool):Void
  {
    if (finished) return;
    finished = true;
    endedOnSong = intoSong;
    modeWipeShut = false;
    modeWiping = false;
    fadeHolding = false;

    trace("[HexDialogue] finish at command " + cmdIndex + " of " + commands.length + " intoSong=" + intoSong);

    stopLoopedSfx();
    if (music != null) music.fadeOut(0.5, 0);

    overlayLowered = false;
    restackOverlay();

    transition.noSound = false;
    transition.transitionIn();
    transition.onComplete = function(out:Bool)
    {
      if (out) return;

      transition.onComplete = null;
      close();
    };
  }

  static function trailingNumber(key:String):Int
  {
    var digits:String = "";
    var i:Int = key.length - 1;
    while (i >= 0)
    {
      var c:String = key.charAt(i);
      if (c < "0" || c > "9") break;
      digits = c + digits;
      i--;
    }

    if (digits == "") return 1;
    return Std.parseInt(digits);
  }
}
