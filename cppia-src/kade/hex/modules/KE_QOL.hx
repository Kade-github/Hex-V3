package kade.hex.modules;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import funkin.Paths;
import funkin.graphics.FunkinSprite;
import funkin.modding.CppiaScripts;
import funkin.modding.events.ScriptEvent;
import funkin.modding.events.ScriptEvent.GhostMissNoteScriptEvent;
import funkin.modding.events.ScriptEvent.HitNoteScriptEvent;
import funkin.modding.events.ScriptEvent.NoteScriptEvent;
import funkin.modding.events.ScriptEvent.SongLoadScriptEvent;
import funkin.modding.events.ScriptEvent.SongRetryEvent;
import funkin.modding.events.ScriptEvent.UpdateScriptEvent;
import funkin.modding.module.Module;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.notes.Strumline;
import funkin.save.Save;
import funkin.util.Constants;

class KE_QOL extends Module
{
  static inline final ID:String = "KE-QOL";
  static inline final HOST:String = "kade.hex.notefield.Host";
  static inline final LANES:String = "kade.hex.notefield.TouchLanes";

  public static var instance:KE_QOL = null;

  public static function ensure():Void
  {
    var found = ModuleHandler.getModule(ID);
    if (found != null && Std.isOfType(found, KE_QOL))
    {
      instance = cast found;
      return;
    }

    instance = new KE_QOL();

    @:privateAccess
    {
      ModuleHandler.addToModuleCache(instance);
      ModuleHandler.reorderModuleCache();
    }
  }

  public function new(?id:String)
  {
    super(ID);
    instance = this;
  }

  public var useKEStuff:Bool = false;

  public var started:Bool = false;
  public var hitANote:Bool = false;

  public var sicks:Int = 0;
  public var goods:Int = 0;
  public var misses:Int = 0;
  public var totalNotes:Int = 0;

  public var scoreText:FlxText = null;

  public var healthBar:FlxBar;
  public var healthBarBG:FunkinSprite;

  var healthLerp:Float = Constants.HEALTH_STARTING;

  var scoreDirty:Bool = false;
  var scoreCooldown:Float = 0;
  var holdCooldown:Float = 0;
  var shownScore:Float = 0;
  var shownText:String = null;

  public function toggleScoreText():Void
  {
    if (scoreText != null) scoreText.visible = !scoreText.visible;
  }

  public function updateScore():Void
  {
    scoreDirty = true;
  }

  function currentScore():Float
  {
    if (PlayState.instance == null) return 0;
    return Math.max(PlayState.instance.songScore, 0);
  }

  function applyScoreText():Void
  {
    scoreDirty = false;
    shownScore = Math.floor(currentScore());

    if (scoreText == null) return;

    var acc:Float = totalNotes == 0 ? 1 : (sicks + goods - misses) / totalNotes;

    if (acc < -1) acc = -1;
    if (acc > 1) acc = 1;
    if (!started || !hitANote) acc = 1;

    var text:String = 'Score: ' + FlxStringUtil.formatMoney(shownScore, false, true);
    if (acc < 0) text += ' • Accuracy: 0% (' + Std.int(acc * 100) + '%)';
    else text += ' • Accuracy: ' + Std.int(acc * 100) + '%';

    if (text == shownText) return;

    shownText = text;
    scoreText.text = text;
    scoreText.x = (FlxG.width / 2) - (scoreText.width / 2);
  }

  public override function onNoteGhostMiss(event:GhostMissNoteScriptEvent)
  {
    if (useKEStuff) event.cancelEvent();
  }

  public override function onNoteHit(event:HitNoteScriptEvent)
  {
    if (!useKEStuff) return;
    if (event.score == 0) return;

    super.onNoteHit(event);

    if (event.judgement == "sick") sicks++;
    else if (event.judgement == "good") goods++;

    hitANote = true;
    totalNotes++;
    updateScore();
  }

  public override function onNoteMiss(event:NoteScriptEvent)
  {
    if (!useKEStuff) return;

    misses++;
    hitANote = true;
    totalNotes++;

    updateScore();
  }

  public override function onNoteIncoming(event:NoteScriptEvent)
  {
    if (!useKEStuff) return;

    var note = event.note;
    if (note == null || note.holdNoteSprite == null) return;

    note.holdNoteSprite.alpha = 0.75;
  }

  public override function onSongStart(event:ScriptEvent)
  {
    if (!useKEStuff) return;

    started = true;
  }

  public override function onStateCreate(event:ScriptEvent)
  {
    super.onStateCreate(event);

    started = false;
    hitANote = false;
    totalNotes = 0;

    sicks = 0;
    goods = 0;
    misses = 0;

    if (scoreText != null)
    {
      scoreText.destroy();
      scoreText = null;
    }
  }

  public override function onSongRetry(event:SongRetryEvent)
  {
    if (!useKEStuff) return;

    started = false;
    hitANote = false;
    totalNotes = 0;

    sicks = 0;
    goods = 0;
    misses = 0;

    updateScore();
  }

  public override function onUpdate(event:UpdateScriptEvent)
  {
    if (!useKEStuff) return;

    super.onUpdate(event);
    updateHealthBar();

    scoreCooldown -= event.elapsed;
    holdCooldown -= event.elapsed;

    if (holdCooldown <= 0)
    {
      holdCooldown = 0.25;
      if (Math.floor(currentScore()) != shownScore) scoreDirty = true;
    }

    if (scoreDirty && scoreCooldown <= 0)
    {
      scoreCooldown = 0.05;
      applyScoreText();
    }
  }

  function updateHealthBar():Void
  {
    if (PlayState.instance == null || healthBar == null) return;

    healthLerp = FlxMath.lerp(healthLerp, PlayState.instance.health, 0.15);
    healthBar.value = healthLerp;
  }

  function centerStrums():Void
  {
    if (!useKEStuff || PlayState.instance == null) return;

    var strumWidth:Float = Strumline.NOTE_SPACING;

    var opStrum:Strumline = PlayState.instance.opponentStrumline;
    var bfStrum:Strumline = PlayState.instance.playerStrumline;

    if (opStrum.strumlineScale.x < 1) return;

    opStrum.x = ((FlxG.width / 2) - opStrum.width / 2);
    bfStrum.x = ((FlxG.width / 2) - bfStrum.width / 2);

    opStrum.x -= opStrum.width - strumWidth;
    bfStrum.x += bfStrum.width - strumWidth;
  }

  function barLow():Bool
  {
    return !PlayState.instance.playerStrumline.isDownscroll;
  }

  function placeBar():Void
  {
    if (!useKEStuff || PlayState.instance == null || healthBarBG == null) return;

    var low:Bool = barLow();

    healthBarBG.y = low ? FlxG.height * 0.9 : FlxG.height * 0.1;
    healthBar.y = healthBarBG.y + 4;

    if (scoreText != null) scoreText.y = healthBarBG.y + (low ? 40 : -40);

    PlayState.instance.healthBar.x = healthBar.x;
    PlayState.instance.healthBar.y = healthBarBG.y + (low ? 4 : 24);
  }

  function relayout():Void
  {
    centerStrums();
    placeBar();
  }

  function offer(what:Dynamic):Void
  {
    CppiaScripts.call(HOST, "offer", [what]);
  }

  function withdraw(what:Dynamic):Void
  {
    CppiaScripts.call(HOST, "withdraw", [what]);
  }

  public override function onSongLoaded(event:SongLoadScriptEvent)
  {
    var state = PlayState.instance;

    @:privateAccess
    if (state.noteStyle.id == "hex") useKEStuff = true;
    if (!useKEStuff) return;

    centerStrums();

    if (healthBar != null)
    {
      withdraw(healthBar);
      state.remove(healthBar);
      healthBar.destroy();
      healthBar = null;
    }

    if (healthBarBG != null)
    {
      withdraw(healthBarBG);
      state.remove(healthBarBG);
      healthBarBG.destroy();
      healthBarBG = null;
    }

    var low:Bool = barLow();

    healthBarBG = FunkinSprite.create(0, 0, 'ui/hex/hex_healthBar');
    healthBarBG.scale.set(1.14, 1.02);
    healthBarBG.updateHitbox();
    healthBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), null, "", 0, 2);
    healthBarBG.y = low ? FlxG.height * 0.9 : FlxG.height * 0.1;
    healthBarBG.x = FlxG.width / 2 - healthBarBG.width / 2;
    healthBarBG.scrollFactor.set(0, 0);
    state.add(healthBarBG);

    healthBar.x = healthBarBG.x + 4;
    healthBar.y = healthBarBG.y + 4;
    healthBar.scrollFactor.set();
    healthBar.zIndex = 801;
    state.add(healthBar);

    healthLerp = state.health;
    updateHealthBar();

    healthBarBG.zIndex = 803;

    var stock:FlxBar = state.healthBar;
    var anchor:FlxBar = new FlxBar(healthBar.x, healthBar.y, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8),
      null, "", 0, 2);
    anchor.parent = state;
    anchor.parentVariable = 'healthLerp';
    anchor.scrollFactor.set();
    anchor.createFilledBar(0x00000000, 0x00000000);
    anchor.zIndex = 801;
    anchor.cameras = [state.camHUD];
    state.healthBar = anchor;
    state.add(anchor);

    if (stock != null)
    {
      state.remove(stock);
      stock.destroy();
    }

    if (state.healthBarBG != null) state.healthBarBG.visible = false;

    @:privateAccess
    if (state.scoreText != null) state.scoreText.visible = false;

    var leftChar = state.currentStage.getDad();
    var rightChar = state.currentStage.getBoyfriend();
    var leftName:String = leftChar == null ? "" : leftChar.characterName;
    var rightName:String = rightChar == null ? "" : rightChar.characterName;

    var colorLeft:FlxColor = FlxColor.fromRGB(66, 250, 244);
    var colorRight:FlxColor = FlxColor.fromRGB(48, 177, 209);

    if (StringTools.startsWith(rightName, "Hex")) colorRight = colorLeft;
    if (StringTools.startsWith(leftName, "Iris") || StringTools.contains(leftName, "Glitcher") || StringTools.contains(leftName, "Detected"))
      colorLeft = FlxColor.fromRGB(239, 58, 45);
    if (StringTools.startsWith(leftName, "Slasher")) colorLeft = FlxColor.fromRGB(227, 37, 101);
    if (StringTools.startsWith(leftName, "Whitty")) colorLeft = FlxColor.fromRGB(48, 50, 86);
    if (StringTools.startsWith(leftName, "Coda")) colorLeft = FlxColor.fromRGB(247, 101, 69);
    if (StringTools.startsWith(leftName, "Richard")) colorLeft = FlxColor.fromRGB(58, 84, 197);

    healthBar.createFilledBar(colorLeft, colorRight);

    healthBar.cameras = [state.camHUD];
    healthBarBG.cameras = [state.camHUD];

    if (scoreText != null)
    {
      withdraw(scoreText);
      scoreText.destroy();
      scoreText = null;
    }

    scoreText = new FlxText(healthBarBG.x + healthBarBG.width - 190, healthBarBG.y + (low ? 40 : -40), 0, '', 20);
    scoreText.setFormat(Paths.font('ui/fonts/AristaLight'), 26, 0xFFFFFFFF, "right", FlxTextBorderStyle.OUTLINE, 0xFF000000);
    scoreText.scrollFactor.set();
    scoreText.zIndex = 802;
    state.add(scoreText);
    scoreText.cameras = [state.camHUD];

    offer(healthBar);
    offer(scoreText);
    offer(healthBarBG);

    hitANote = false;
    totalNotes = 0;

    sicks = 0;
    goods = 0;
    misses = 0;
    shownText = null;
    updateScore();

    CppiaScripts.call(LANES, "afterLayout", [relayout]);

    var bag:Dynamic = Save.instance.getModOptions("hex");
    if (bag != null && bag.fourLanes == true) CppiaScripts.call(LANES, "toggle", [true, true]);

    relayout();

    state.refresh();
  }
}
