package kade.hex.objects.freeplay;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.graphics.FunkinSprite;
import kade.hex.menus.Anim;

class StarDisplay extends FlxSpriteGroup
{
  var stars:Array<FunkinSprite> = [];

  var time:Float = 0;
  var bounceStart:Array<Float> = [];
  var bouncing:Array<Bool> = [];
  var filled:Array<Bool> = [];

  public function setDifficulty(starsCount:Int):Void
  {
    var above10:Bool = starsCount > 10;

    var loopCount:Int = above10 ? starsCount : stars.length;

    for (i in 0...loopCount)
    {
      var wi:Int = i;
      if (wi >= 10) wi -= 10;
      if (wi >= stars.length) break;

      stars[wi].y = y + 29.5;
      stars[wi].offset.set(10, 10);
      stars[wi].angle = 0;

      if (i < starsCount)
      {
        if (i >= 10)
        {
          bounceStart[wi] = time + (wi * 0.08);
          bouncing[wi] = true;
          filled[wi] = true;
          Anim.play(stars[wi], "evilStar");
        }
        else
        {
          bounceStart[wi] = time + (i * 0.08);
          bouncing[wi] = true;
          filled[wi] = false;
          Anim.play(stars[wi], "starBounce");
        }
        stars[wi].y -= 2;
      }
      else
      {
        Anim.play(stars[wi], "idle");
        bouncing[wi] = false;
        filled[wi] = false;
      }
    }
  }

  public function new()
  {
    super();

    for (i in 0...10)
    {
      var star:FunkinSprite = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_freeplay/stars");
      Anim.addByPrefix(star, "idle", "noStar", 24, false);
      Anim.addByPrefix(star, "star", "normalStar", 24, false);
      Anim.addByPrefix(star, "starBounce", "normalBounce", 24, false);
      Anim.addByPrefix(star, "evilStar", "above10", 24, false);
      Anim.play(star, "idle");
      star.scale.set(0.63, 0.63);
      star.scrollFactor.set();
      star.updateHitbox();
      star.x = i * (36.54 + 10);
      star.y = y + 29.5;
      star.offset.set(10, 10);
      add(star);
      stars.push(star);
      bounceStart.push(0);
      bouncing.push(false);
      filled.push(false);
    }
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
    time += elapsed;

    for (i in 0...stars.length)
    {
      if (!bouncing[i])
      {
        if (filled[i])
        {
          var shakeX:Float = FlxG.random.float(-0.75, 0.75);
          var shakeY:Float = FlxG.random.float(-0.75, 0.75);
          stars[i].offset.set(10 + shakeX, 10 + shakeY + Math.sin(time * 4 + i * 0.6) * 2.5);
        }
        continue;
      }
      if (time <= bounceStart[i]) continue;

      var span:Float = 0.3 + (i * 0.02);
      var elapsedBounce:Float = time - bounceStart[i];
      if (elapsedBounce < span)
      {
        var ease:Float = FlxEase.circOut(Math.min(1, elapsedBounce / span));
        stars[i].offset.set(10, FlxMath.lerp(20, 10, ease));
        if (filled[i]) stars[i].angle = FlxMath.lerp(-360, 0, ease);
      }
      else
      {
        stars[i].offset.set(10, 10);
        stars[i].angle = 0;
        if (!filled[i]) Anim.play(stars[i], "star");
        bouncing[i] = false;
      }
    }
  }
}
