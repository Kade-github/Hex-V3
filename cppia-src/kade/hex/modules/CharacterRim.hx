package kade.hex.modules;

import flixel.FlxG;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import funkin.Assets;
import funkin.Paths;
import funkin.modding.events.ScriptEvent.StateChangeScriptEvent;
import funkin.modding.module.Module;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.character.BaseCharacter;
import haxe.ds.StringMap;
import kade.hex.util.HexTouch;
import openfl.display.BitmapData;

class CharacterRim extends Module
{
  static inline final ID:String = "CharacterRim";

  public static var instance:CharacterRim = null;

  public static function ensure():Void
  {
    var found = ModuleHandler.getModule(ID);
    if (found != null && Std.isOfType(found, CharacterRim))
    {
      instance = cast found;
      return;
    }

    instance = new CharacterRim();

    @:privateAccess
    {
      ModuleHandler.addToModuleCache(instance);
      ModuleHandler.reorderModuleCache();
    }
  }

  static inline final RIM_AMOUNT:Float = 0.95;
  static inline final RIM_SPREAD:Float = 3;
  static inline final RIM_CURVE:Float = 1.5;
  static inline final RIM_GLOW_CURVE:Float = 0.6;
  static inline final RIM_GLOW_AMOUNT:Float = 0.45;
  static inline final RIM_GAIN_SCALE:Float = 0.5;

  static inline final WEEKEND_AMOUNT:Float = 1;
  static inline final WEEKEND_SPREAD:Float = 2.2;
  static inline final WEEKEND_CURVE:Float = 2;
  static inline final WEEKEND_GLOW_CURVE:Float = 0.6;
  static inline final WEEKEND_GLOW_AMOUNT:Float = 0.5;
  static inline final WEEKEND_GAIN_SCALE:Float = 1;

  static final CHARACTER_GAIN:Map<String, Float> = [
    "hex-sunset" => 6,
    "hex-night" => 6,
    "bf-old-sunset" => 6,
    "bf-old-night" => 10,
    "bf-old-glitcher" => 6,
    "gf-old-sunset" => 10,
    "gf-old-night" => 10,
    "gf-old-glitcher" => 4,
    "bf-old-weekend" => 4,
    "bf-old-weekend-dark" => 4,
    "bf-old-weekend-lcdred" => 4,
    "bf-old-weekend-lcdreddark" => 4,
    "gf-old-weekend" => 4,
    "gf-old-weekend-dark" => 4,
    "gf-old-weekend-lcdred" => 4,
    "gf-old-weekend-lcdreddark" => 4,
    "hex-weekend" => 4,
    "hex-weekend-dark" => 6,
    "hex-weekend-lcdred" => 4,
    "hex-weekend-lcdreddark" => 4
  ];

  var base:String = null;
  var look:String = null;
  var owner:PlayState = null;
  var hooked:Bool = false;
  var hook:Void->Void = null;

  var chars:Array<BaseCharacter> = [];
  var shaders:Array<FlxRuntimeShader> = [];

  var fromLooks:Array<String> = [];
  var toLooks:Array<String> = [];
  var fadeStarts:Array<Float> = [];
  var fadeLengths:Array<Float> = [];
  var time:Float = 0;

  var without:Array<BaseCharacter> = [];
  var luts:StringMap<BitmapData> = new StringMap<BitmapData>();

  public function new(?id:String)
  {
    super(ID);
    instance = this;
    hook = refresh;
  }

  function weekend():Bool
  {
    return base != null && StringTools.startsWith(base, "weekend");
  }

  public function enable(name:String):Void
  {
    disable();

    if (PlayState.instance == null) return;

    owner = PlayState.instance;
    base = name;
    look = name;

    FlxG.signals.preDraw.add(hook);
    hooked = true;
    refresh();
  }

  public function shift(name:String, fade:Float):Void
  {
    if (base == null) return;

    look = name == "" ? base : base + "-" + name;

    for (i in 0...chars.length)
    {
      var who = chars[i];
      if (!hasLook(who, look)) continue;

      if (!bind(shaders[i], "lutInnerTo", "lutRimTo", "uRimGainTo", who, look)) continue;

      bind(shaders[i], "lutInner", "lutRim", "uRimGain", who, toLooks[i]);
      fromLooks[i] = toLooks[i];
      toLooks[i] = look;
      fadeStarts[i] = time;
      fadeLengths[i] = fade;
      shaders[i].setFloat("uBlend", 0);
    }
  }

  public function holds(who:Dynamic):Bool
  {
    return who != null && chars.indexOf(who) != -1;
  }

  public function disable():Void
  {
    if (hooked)
    {
      FlxG.signals.preDraw.remove(hook);
      hooked = false;
    }

    for (i in 0...chars.length)
    {
      if (chars[i] != null && chars[i].shader == shaders[i]) chars[i].shader = null;
    }

    chars = [];
    shaders = [];
    fromLooks = [];
    toLooks = [];
    fadeStarts = [];
    fadeLengths = [];
    without = [];
    luts = new StringMap<BitmapData>();

    base = null;
    look = null;
    owner = null;
  }

  function lookPath(who:BaseCharacter, name:String, part:String):String
  {
    return Paths.image("gameplay/looks/" + who.characterId + "-" + name + "-" + part);
  }

  function hasLook(who:BaseCharacter, name:String):Bool
  {
    return Assets.exists(lookPath(who, name, "inner")) && Assets.exists(lookPath(who, name, "rim"));
  }

  function readGain(who:BaseCharacter, name:String):Float
  {
    var key:String = who.characterId + "-" + name;
    return CHARACTER_GAIN.exists(key) ? CHARACTER_GAIN.get(key) : 1;
  }

  function lut(path:String):BitmapData
  {
    var found = luts.get(path);
    if (found != null) return found;

    var made:BitmapData = null;

    try
    {
      made = Assets.getBitmapData(path, false, false, false);
    }
    catch (e:Dynamic)
    {
      trace("[CharacterRim] " + path + " failed to load uncompressed: " + e);
    }

    if (made == null)
    {
      try
      {
        made = Assets.getBitmapData(path, false);
      }
      catch (e:Dynamic)
      {
        trace("[CharacterRim] " + path + " failed to load: " + e);
      }
    }

    if (made != null) luts.set(path, made);

    return made;
  }

  function bind(shader:FlxRuntimeShader, inner:String, rim:String, gain:String, who:BaseCharacter, name:String):Bool
  {
    var innerLut = lut(lookPath(who, name, "inner"));
    var rimLut = lut(lookPath(who, name, "rim"));
    if (innerLut == null || rimLut == null) return false;

    shader.setBitmapData(inner, innerLut);
    shader.setBitmapData(rim, rimLut);
    shader.setFloat(gain, readGain(who, name) * (weekend() ? WEEKEND_GAIN_SCALE : RIM_GAIN_SCALE));
    return true;
  }

  function setFrame(shader:FlxRuntimeShader, left:Float, top:Float, right:Float, bottom:Float):Void
  {
    shader.setFloat("uFrameLeft", left);
    shader.setFloat("uFrameTop", top);
    shader.setFloat("uFrameRight", right);
    shader.setFloat("uFrameBottom", bottom);
  }

  function attach(who:BaseCharacter):Void
  {
    if (who == null || chars.indexOf(who) != -1 || without.indexOf(who) != -1) return;

    if (!hasLook(who, look))
    {
      without.push(who);
      return;
    }

    var shader:FlxRuntimeShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/characterRim")));
    if (!bind(shader, "lutInner", "lutRim", "uRimGain", who, look) || !bind(shader, "lutInnerTo", "lutRimTo", "uRimGainTo", who, look))
    {
      without.push(who);
      return;
    }

    var wk:Bool = weekend();

    shader.setFloat("uBlend", 0);
    shader.setFloat("uStrength", 1);
    shader.setFloat("uRimAmount", wk ? WEEKEND_AMOUNT : RIM_AMOUNT);
    shader.setFloat("uRimSpread", wk ? WEEKEND_SPREAD : RIM_SPREAD);
    shader.setFloat("uRimCurve", wk ? WEEKEND_CURVE : RIM_CURVE);
    shader.setFloat("uGlowCurve", wk ? WEEKEND_GLOW_CURVE : RIM_GLOW_CURVE);
    shader.setFloat("uGlowAmount", wk ? WEEKEND_GLOW_AMOUNT : RIM_GLOW_AMOUNT);
    shader.setFloat("uTaps", HexTouch.mobile ? 12 : 32);
    setFrame(shader, 0, 0, 1, 1);
    shader.setFloat("uSheetWidth", 1);
    shader.setFloat("uSheetHeight", 1);

    chars.push(who);
    shaders.push(shader);
    fromLooks.push(look);
    toLooks.push(look);
    fadeStarts.push(time);
    fadeLengths.push(0);
    who.shader = shader;
  }

  function stepFade(i:Int):Void
  {
    if (fromLooks[i] == toLooks[i]) return;

    var length:Float = fadeLengths[i];
    var t:Float = length <= 0 ? 1 : FlxMath.bound((time - fadeStarts[i]) / length, 0, 1);
    shaders[i].setFloat("uBlend", FlxEase.sineInOut(t));

    if (t >= 1)
    {
      bind(shaders[i], "lutInner", "lutRim", "uRimGain", chars[i], toLooks[i]);
      fromLooks[i] = toLooks[i];
      shaders[i].setFloat("uBlend", 0);
    }
  }

  function refresh():Void
  {
    var play:PlayState = PlayState.instance;
    if (play == null || play != owner || play.currentStage == null)
    {
      disable();
      return;
    }

    time += FlxG.elapsed;

    var stage = play.currentStage;
    attach(stage.getGirlfriend());
    attach(stage.getDad());
    attach(stage.getBoyfriend());

    for (i in 0...chars.length)
    {
      var who = chars[i];
      if (who == null || who.frame == null || who.frame.uv == null) continue;

      stepFade(i);

      var uv:FlxRect = cast who.frame.uv;
      setFrame(shaders[i], uv.x, uv.y, uv.width, uv.height);

      var sheet = who.frame.parent;
      if (sheet != null)
      {
        shaders[i].setFloat("uSheetWidth", sheet.width);
        shaders[i].setFloat("uSheetHeight", sheet.height);
      }
    }
  }

  public override function onStateChangeBegin(event:StateChangeScriptEvent)
  {
    super.onStateChangeBegin(event);
    disable();
  }
}
