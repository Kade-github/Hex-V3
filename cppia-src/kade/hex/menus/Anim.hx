package kade.hex.menus;

class Anim
{
  public static function play(spr:Dynamic, name:String, force:Bool = false, reversed:Bool = false, frame:Int = 0):Void
  {
    var a:Dynamic = spr.animation;
    a.play(name, force, reversed, frame);
  }

  public static function addByPrefix(spr:Dynamic, name:String, prefix:String, fps:Float = 24, looped:Bool = true):Void
  {
    var a:Dynamic = spr.animation;
    a.addByPrefix(name, prefix, fps, looped);
  }

  public static function addByNames(spr:Dynamic, name:String, names:Array<String>, fps:Float = 24, looped:Bool = true):Void
  {
    var a:Dynamic = spr.animation;
    a.addByNames(name, names, fps, looped);
  }

  public static function name(spr:Dynamic):String
  {
    var a:Dynamic = spr.animation;
    return a.name;
  }

  public static function finished(spr:Dynamic):Bool
  {
    var a:Dynamic = spr.animation;
    return a.finished;
  }

  public static function frameIndex(spr:Dynamic):Int
  {
    var a:Dynamic = spr.animation;
    return a.frameIndex;
  }

  public static function finish(spr:Dynamic):Void
  {
    var a:Dynamic = spr.animation;
    a.finish();
  }

  public static function has(spr:Dynamic, name:String):Bool
  {
    var a:Dynamic = spr.animation;
    return a.getByName(name) != null;
  }

  public static function onFinish(spr:Dynamic, fn:String->Void):Void
  {
    var a:Dynamic = spr.animation;
    a.onFinish.add(fn);
  }
}
