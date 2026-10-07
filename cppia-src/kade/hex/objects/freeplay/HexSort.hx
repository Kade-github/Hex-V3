package kade.hex.objects.freeplay;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import funkin.Paths;
import funkin.graphics.FunkinSprite;
import kade.hex.menus.Anim;

class HexSort extends FlxSpriteGroup
{
  var selectedIndex:Int = 0;

  public var leftArrow:FlxSprite;
  public var rightArrow:FlxSprite;

  public var leftSort:FunkinSprite;
  var middleSort:FunkinSprite;
  public var rightSort:FunkinSprite;

  function createSortOption():FunkinSprite
  {
    var sprite:FunkinSprite = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_freeplay/sorting");
    Anim.addByPrefix(sprite, "0", "all", 24, false);
    Anim.addByPrefix(sprite, "1", "weekX", 24, false);
    Anim.addByPrefix(sprite, "2", "weekendX", 24, false);
    Anim.addByPrefix(sprite, "3", "eventX", 24, false);
    Anim.addByPrefix(sprite, "4", "freeplayExclusive", 24, false);
    Anim.play(sprite, "0");
    sprite.scale.set(0.7, 0.7);
    sprite.scrollFactor.set();
    sprite.updateHitbox();
    return sprite;
  }

  public function setSelected(index:Int):Void
  {
    selectedIndex = index;

    var left:Int = (index + 4) % 5;
    var right:Int = (index + 1) % 5;
    Anim.play(leftSort, Std.string(left));
    Anim.play(middleSort, Std.string(index));
    Anim.play(rightSort, Std.string(right));
  }

  /**
   * Width of the first sort option, which CapsuleRight lines the group up against.
   */
  public function optionWidth():Float
  {
    return leftSort.width;
  }

  public function new()
  {
    super();

    leftArrow = new FlxSprite(-225, 10);
    leftArrow.loadGraphic(Paths.image("ui/hex/hex_freeplay/sort_arrow"));
    leftArrow.scale.set(0.7, 0.7);
    leftArrow.scrollFactor.set();
    leftArrow.updateHitbox();
    add(leftArrow);

    leftSort = createSortOption();
    leftSort.x = -170;
    Anim.play(leftSort, "4");
    add(leftSort);

    var leftDot:FlxSprite = new FlxSprite(-75, 6);
    leftDot.scale.set(0.85, 0.85);
    leftDot.loadGraphic(Paths.image("ui/hex/hex_freeplay/sort_seperator"));
    add(leftDot);

    middleSort = createSortOption();
    middleSort.x = -35;
    add(middleSort);

    var rightDot:FlxSprite = new FlxSprite(50, 6);
    rightDot.scale.set(0.85, 0.85);
    rightDot.loadGraphic(Paths.image("ui/hex/hex_freeplay/sort_seperator"));
    add(rightDot);

    rightSort = createSortOption();
    rightSort.x = 90;
    Anim.play(rightSort, "1");
    add(rightSort);

    rightArrow = new FlxSprite(185, 6);
    rightArrow.loadGraphic(Paths.image("ui/hex/hex_freeplay/sort_arrow"));
    rightArrow.scale.set(0.7, 0.7);
    rightArrow.scrollFactor.set();
    rightArrow.updateHitbox();
    rightArrow.flipX = true;
    add(rightArrow);
  }
}
