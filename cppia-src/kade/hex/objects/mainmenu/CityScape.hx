package kade.hex.objects.mainmenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Paths;

/**
 * A group of sprites that tween in a parallax style.
 */
class CityScape extends FlxSpriteGroup
{
  var time:Float = 0;
  var startTime:Float = -1;
  var settled:Bool = false;

  public var onComplete:Void->Void = null;

  function addCityScape(file:String):Void
  {
    var sprite:FlxSprite = new FlxSprite(0, FlxG.height);
    sprite.loadGraphic(Paths.image("ui/hex/main-menu/cityscape/" + file));
    sprite.setGraphicSize(FlxG.width, FlxG.height);
    sprite.scrollFactor.set();
    sprite.updateHitbox();
    add(sprite);
  }

  public function tween():Void
  {
    startTime = time;
    settled = false;
  }

  public function new()
  {
    super();

    addCityScape("buildingsBack");
    addCityScape("buildingsMiddle");
    addCityScape("buildingsFront");
    addCityScape("bushesBack");
    addCityScape("bushesFront");
    addCityScape("net");
    addCityScape("light");
  }

  public function forceComplete():Void
  {
    for (sprite in members)
    {
      sprite.y = 0;
    }
    settled = true;

    if (onComplete != null) onComplete();
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    time += elapsed;

    if (startTime < 0) return;

    var diff:Float = time - startTime;

    if (!settled)
    {
      for (i in 0...members.length)
      {
        var speed:Float = 0.5 + (i * 0.15);
        members[i].y = FlxMath.lerp(FlxG.height, 0, FlxEase.circOut(Math.min(1, diff * speed)));
      }

      if (diff > 2.6)
      {
        for (sprite in members) sprite.y = 0;
        settled = true;
      }
    }

    if (diff > 2.5 && onComplete != null)
    {
      onComplete();
      onComplete = null;
    }
  }
}
