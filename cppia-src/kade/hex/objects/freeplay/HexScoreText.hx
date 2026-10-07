package kade.hex.objects.freeplay;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.graphics.FunkinSprite;
import kade.hex.menus.Anim;

class HexScoreText extends FlxSpriteGroup
{
  static var DIGITS:Array<String> = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

  var texts:Array<FunkinSprite>;
  var shown:Array<String> = [];

  public var badge:FunkinSprite = null;

  public var score(default, set):Int;

  var lerpScore:Float = 0;
  var startLerp:Float = -1;

  function set_score(value:Int):Int
  {
    score = value;
    startLerp = 1.0;
    return value;
  }

  public function set_badge_rank(value:Int):Void
  {
    badge.visible = true;

    switch (value)
    {
      case 5:
        Anim.play(badge, "Py");
      case 4:
        Anim.play(badge, "P");
      case 3:
        Anim.play(badge, "E");
      case 2:
        Anim.play(badge, "G");
      case 1:
        Anim.play(badge, "Gb");
      case 0:
        Anim.play(badge, "L");
      default:
        badge.visible = false;
    }
  }

  function showScore(value:Int):Void
  {
    var scoreStr:String = StringTools.lpad(Std.string(value), "0", 8);

    for (i in 0...texts.length)
    {
      if (i >= scoreStr.length) continue;

      var digit:Int = scoreStr.charCodeAt(i) - "0".code;
      if (digit < 0 || digit > 9) continue;

      var name:String = DIGITS[digit];
      if (shown[i] == name) continue;

      shown[i] = name;
      Anim.play(texts[i], name, true);
    }
  }

  function createNumberSprite():FunkinSprite
  {
    var sprite:FunkinSprite = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_freeplay/digital numbers results");
    Anim.addByPrefix(sprite, "one", "ONE DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "two", "TWO DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "three", "THREE DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "four", "FOUR DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "five", "FIVE DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "six", "SIX DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "seven", "SEVEN DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "eight", "EIGHT DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "nine", "NINE DIGITAL", 24, false);
    Anim.addByPrefix(sprite, "zero", "ZERO DIGITAL", 24, false);
    sprite.scale.set(0.6, 0.6);
    sprite.scrollFactor.set();
    sprite.updateHitbox();
    return sprite;
  }

  public function new()
  {
    super();
    texts = [];
    for (i in 0...8)
    {
      var numSprite:FunkinSprite = createNumberSprite();
      numSprite.x = i * (numSprite.width / 1.5 + 2);
      add(numSprite);
      texts.push(numSprite);
      shown.push(null);
    }

    badge = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_freeplay/rankbadges");
    Anim.addByPrefix(badge, "P", "PerfectPink", 24, false);
    Anim.addByPrefix(badge, "Py", "PerfectYellow", 24, false);
    Anim.addByPrefix(badge, "E", "Excellent", 24, false);
    Anim.addByPrefix(badge, "G", "GoodSilver", 24, false);
    Anim.addByPrefix(badge, "Gb", "GoodBronze", 24, false);
    Anim.addByPrefix(badge, "L", "Loser", 24, false);
    Anim.play(badge, "P");
    badge.scale.set(0.6, 0.6);
    badge.scrollFactor.set();
    badge.updateHitbox();
    badge.x = texts[7].x + texts[7].width + 20;
    badge.y = (texts[0].height / 2) - (badge.height / 2);
    add(badge);

    badge.visible = false;

    score = 0;
    showScore(0);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (startLerp < 0) return;

    startLerp -= elapsed;

    lerpScore = FlxMath.lerp(lerpScore, score, FlxEase.circOut(Math.min(1, 1 - (startLerp / 1.0))));
    if (startLerp <= 0)
    {
      lerpScore = score;
      startLerp = -1;
    }

    showScore(Std.int(lerpScore));
  }
}
