package kade.hex.objects.freeplay;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

class DifficultySelect extends FlxSpriteGroup
{
  var time:Float = 0;
  var startTime:Float = -1;
  var diff:FlxSprite;
  var slash:FlxSprite;
  var diffNumber:BetterAtlasText;

  var onlyNumber:Bool = false;

  public var diffIndex:Int = 0;

  public function setNum(diffNum:Int):Void
  {
    startTime = time;
    onlyNumber = true;
    diffNumber.text = Std.string(diffNum);
  }

  public function setDifficulty(index:Int, diffNum:Int, max:Int = 2):Void
  {
    diffIndex = index;

    if (diffIndex < 0) diffIndex = max;
    if (diffIndex > max) diffIndex = 0;

    fakeDiff(diffIndex);

    diffNumber.text = Std.string(diffNum);
  }

  public function fakeDiff(index:Int):Void
  {
    onlyNumber = false;
    startTime = time;

    switch (index)
    {
      case 0:
        diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayEasy"));
      case 1:
        diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayNorm"));
      case 2:
        diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayHard"));
      case 3:
        diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayTech"));
      case 4:
        diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayErect"));
    }

    diff.scrollFactor.set();
    diff.scale.set(0.75, 0.75);
    diff.updateHitbox();
  }

  public function new()
  {
    super();

    diff = new FlxSprite(0, 0);
    diff.loadGraphic(Paths.image("ui/hex/hex_freeplay/freeplayEasy"));
    diff.scrollFactor.set();
    diff.scale.set(0.75, 0.75);
    diff.updateHitbox();
    add(diff);

    slash = new FlxSprite(diff.width + 10, 0);
    slash.loadGraphic(Paths.image("ui/hex/hex_freeplay/slash"));
    slash.scrollFactor.set();
    slash.scale.set(0.75, 0.75);
    slash.updateHitbox();
    slash.y = (diff.height / 2) - (slash.height / 2);
    add(slash);

    diffNumber = new BetterAtlasText(Paths.image("ui/fonts/hex_artist"), Paths.xml("ui/fonts/hex_artist"), slash.x + slash.width + 10, 0, "1");
    diffNumber.letterSpacing = -2;
    add(diffNumber);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    time += elapsed;

    if (startTime < 0) return;

    var since:Float = time - startTime;
    if (since < 0.25)
    {
      var ease:Float = FlxEase.circOut(Math.min(1, since / 0.25));
      if (!onlyNumber) diff.y = FlxMath.lerp(y - 15, y, ease);
      diffNumber.y = FlxMath.lerp(y - 15, y + 10, ease);
    }
    else
    {
      if (!onlyNumber) diff.y = y;
      diffNumber.y = y + 10;
      startTime = -1;
    }
  }
}
