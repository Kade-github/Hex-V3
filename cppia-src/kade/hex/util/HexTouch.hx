package kade.hex.util;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.touch.FlxTouch;
import flixel.util.FlxColor;
import funkin.Assets;
import funkin.Paths;
import funkin.graphics.FunkinCamera;
import funkin.mobile.input.ControlsHandler;
import funkin.mobile.ui.FunkinBackButton;
import funkin.ui.MusicBeatState;
import funkin.util.ReflectUtil;

class HexTouch
{
  static inline final TAP_TICKS:Float = 300;
  static inline final TAP_DISTANCE:Float = 20;
  static inline final SWIPE_DISTANCE:Float = 60;

  public static var active:Bool = false;
  public static var mobile(get, never):Bool;

  static var mobileKnown:Bool = false;
  static var mobileBuild:Bool = false;

  static function get_mobile():Bool
  {
    if (!mobileKnown)
    {
      mobileKnown = true;

      try
      {
        mobileBuild = ReflectUtil.getInstanceFields(MusicBeatState).indexOf("addHitbox") >= 0;
      }
      catch (e:Dynamic) {}
    }

    return mobileBuild;
  }
  public static var backButton:FunkinBackButton;

  public static var touch(get, never):FlxTouch;
  public static var pressed(get, never):Bool;
  public static var dragX(get, never):Float;
  public static var dragY(get, never):Float;
  public static var justSwipedLeft(get, never):Bool;
  public static var justSwipedRight(get, never):Bool;
  public static var justSwipedUp(get, never):Bool;
  public static var justSwipedDown(get, never):Bool;

  static var camControls:FunkinCamera;
  static var startX:Float = 0;
  static var startY:Float = 0;
  static var lastPinch:Float = -1;
  static var seeded:Bool = false;

  public static function update(?state:FlxState, ?onBack:Void->Void):Void
  {
    if (!seeded)
    {
      seeded = true;
      if (mobile && !ControlsHandler.hasExternalInputDevice) active = true;
    }

    if (FlxG.touches.list.length > 0) active = true;
    else if (FlxG.keys.justPressed.ANY) active = false;

    var t:FlxTouch = touch;
    if (t != null && t.justPressed)
    {
      startX = t.gameX;
      startY = t.gameY;
    }

    if (state != null && active && backButton == null)
    {
      camControls = new FunkinCamera('camControls');
      FlxG.cameras.add(camControls, false);
      camControls.bgColor = 0x0;

      backButton = new FunkinBackButton(FlxG.width - 230, FlxG.height - 200, FlxColor.WHITE, onBack, 0.7);
      backButton.cameras = [camControls];
      state.add(backButton);
    }

    if (backButton != null) backButton.visible = active;
  }

  public static function clear():Void
  {
    if (camControls != null && FlxG.cameras.list.contains(camControls)) FlxG.cameras.remove(camControls);
    camControls = null;
    backButton = null;
  }

  static inline final CONTROLS_DESKTOP:Int = 7001;
  static inline final CONTROLS_MOBILE:Int = 7002;
  static inline final CONTROLS_NONE:Int = 7003;

  static final CONTROLS_BAND:Map<String, Float> = [
    "hex_freeplay/controlsText" => 40.5,
    "main-menu/controls-text" => 34,
    "story-menu/controlsText" => 34
  ];

  public static function controls(sprite:FlxSprite, key:String):Void
  {
    if (sprite == null || sprite.ID == CONTROLS_NONE) return;

    var mobile:Bool = sprite.ID == CONTROLS_MOBILE;
    if (mobile == active) return;

    if (!active && sprite.ID != CONTROLS_MOBILE)
    {
      sprite.ID = CONTROLS_DESKTOP;
      return;
    }

    var path:String = Paths.image("ui/hex/" + key + (active ? "-mobile" : ""));
    if (!Assets.exists(path))
    {
      sprite.ID = CONTROLS_NONE;
      return;
    }

    var band:Null<Float> = CONTROLS_BAND.get(key);
    var from:Float = (mobile && band != null) ? band : sprite.frameHeight * 0.5;

    var left:Float = sprite.x - sprite.offset.x + sprite.origin.x * (1 - sprite.scale.x);
    var middle:Float = sprite.y - sprite.offset.y + sprite.origin.y * (1 - sprite.scale.y) + from * sprite.scale.y;

    sprite.loadGraphic(path);

    var to:Float = (active && band != null) ? band : sprite.frameHeight * 0.5;

    var toX:Float = left + sprite.offset.x - sprite.origin.x * (1 - sprite.scale.x);
    var toY:Float = middle - to * sprite.scale.y + sprite.offset.y - sprite.origin.y * (1 - sprite.scale.y);

    sprite.offset.x += sprite.x - toX;
    sprite.offset.y += sprite.y - toY;
    sprite.ID = active ? CONTROLS_MOBILE : CONTROLS_DESKTOP;
  }

  public static function tapped():Bool
  {
    var t:FlxTouch = touch;
    if (!active || t == null || !t.justReleased) return false;
    if (t.ticksDeltaSincePress > TAP_TICKS) return false;
    if (Math.abs(dragX) > TAP_DISTANCE || Math.abs(dragY) > TAP_DISTANCE) return false;
    return !overBackButton();
  }

  public static function overlaps(object:FlxBasic, ?camera:FlxCamera):Bool
  {
    var t:FlxTouch = touch;
    if (!active || t == null || object == null) return false;
    return t.overlaps(object, camera != null ? camera : object.camera);
  }

  public static function tappedObject(object:FlxBasic, ?camera:FlxCamera):Bool
  {
    return tapped() && overlaps(object, camera);
  }

  public static function overQuad(quad:Array<Float>):Bool
  {
    var t:FlxTouch = touch;
    if (!active || t == null || quad == null) return false;

    var inside:Bool = false;
    var j:Int = 3;
    for (i in 0...4)
    {
      var xi:Float = quad[i * 2];
      var yi:Float = quad[i * 2 + 1];
      var xj:Float = quad[j * 2];
      var yj:Float = quad[j * 2 + 1];
      if ((yi > t.gameY) != (yj > t.gameY) && t.gameX < (xj - xi) * (t.gameY - yi) / (yj - yi) + xi) inside = !inside;
      j = i;
    }
    return inside;
  }

  public static function tappedQuad(quads:Array<Array<Float>>):Int
  {
    if (!tapped()) return -1;
    for (i in 0...quads.length)
    {
      if (overQuad(quads[i])) return i;
    }
    return -1;
  }

  public static function pinch():Float
  {
    var list:Array<FlxTouch> = FlxG.touches.list;
    if (list.length < 2 || !list[0].pressed || !list[1].pressed)
    {
      lastPinch = -1;
      return 0;
    }

    var dx:Float = list[0].gameX - list[1].gameX;
    var dy:Float = list[0].gameY - list[1].gameY;
    var dist:Float = Math.sqrt(dx * dx + dy * dy);
    var delta:Float = lastPinch < 0 ? 0 : dist - lastPinch;
    lastPinch = dist;
    return delta;
  }

  static function overBackButton():Bool
  {
    return backButton != null && backButton.visible && touch.overlaps(backButton, camControls);
  }

  static function swiped(horizontal:Bool, sign:Int):Bool
  {
    var t:FlxTouch = touch;
    if (!active || t == null || !t.justReleased) return false;

    var main:Float = horizontal ? dragX : dragY;
    var other:Float = horizontal ? dragY : dragX;
    return main * sign > SWIPE_DISTANCE && Math.abs(main) > Math.abs(other);
  }

  static function get_touch():FlxTouch
  {
    return FlxG.touches.getFirst();
  }

  static function get_pressed():Bool
  {
    var t:FlxTouch = touch;
    return active && t != null && t.pressed;
  }

  static function get_dragX():Float
  {
    var t:FlxTouch = touch;
    return t == null ? 0 : t.gameX - startX;
  }

  static function get_dragY():Float
  {
    var t:FlxTouch = touch;
    return t == null ? 0 : t.gameY - startY;
  }

  static function get_justSwipedLeft():Bool
  {
    return swiped(true, -1);
  }

  static function get_justSwipedRight():Bool
  {
    return swiped(true, 1);
  }

  static function get_justSwipedUp():Bool
  {
    return swiped(false, -1);
  }

  static function get_justSwipedDown():Bool
  {
    return swiped(false, 1);
  }
}
