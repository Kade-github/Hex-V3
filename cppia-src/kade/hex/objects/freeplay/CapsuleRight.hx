package kade.hex.objects.freeplay;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;

class CapsuleRight extends FlxSpriteGroup
{
  var time:Float = 0;
  var startTime:Float = -1;
  var slideDone:Bool = false;

  public var allSort:HexSort;

  public var onComplete:Void->Void = null;

  public function tween():Void
  {
    startTime = time;
    slideDone = false;
  }

  public function resetMembers():Void
  {
    for (sprite in members)
    {
      sprite.x = FlxG.width + 700;
    }
  }

  public function new()
  {
    super();

    add(new Border(false));

    allSort = new HexSort();
    allSort.x = FlxG.width + 700;
    allSort.y = 82;
    allSort.scrollFactor.set();
    add(allSort);
  }

  function restX(i:Int):Float
  {
    if (i == 0) return 0;
    return FlxG.width - (allSort.optionWidth() * 3);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
    time += elapsed;

    if (startTime < 0) return;

    var diff:Float = time - startTime;

    if (!slideDone)
    {
      for (i in 0...members.length)
      {
        var sprite:FlxSprite = members[i];
        var speed:Float = i == 0 ? 1.5 : 0.85 + (i * 0.15);
        var d:Float = diff;

        if (i != 0)
        {
          if (d < 0.25) continue;
          d -= 0.25;
        }

        var from:Float = i == 0 ? FlxG.width : FlxG.width + 700;
        sprite.x = FlxMath.lerp(from, restX(i), FlxEase.circOut(Math.min(1, d * speed)));
      }

      if (diff > 2.6)
      {
        for (i in 0...members.length)
        {
          members[i].x = restX(i);
        }
        slideDone = true;
      }
    }

    if (diff > 2.5 && onComplete != null)
    {
      onComplete();
      onComplete = null;
    }
  }
}
