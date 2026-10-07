package kade.hex.objects.story;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Paths;

/**
 * A menu item in the story menu.
 */
class StoryMenuItem extends FlxSpriteGroup
{
  var selected:FlxSprite;
  var unselected:FlxSprite;

  var shouldBounce:Bool = false;
  var bounceTime:Float = 0;

  public function new(unselectedGraphic:String, selectedGraphic:String)
  {
    super();

    unselected = new FlxSprite().loadGraphic(Paths.image(unselectedGraphic));
    selected = new FlxSprite().loadGraphic(Paths.image(selectedGraphic));

    add(unselected);
    add(selected);

    selected.visible = false;
  }

  public function select():Void
  {
    selected.visible = true;
    unselected.visible = false;
  }

  public function deselect():Void
  {
    selected.visible = false;
    unselected.visible = true;
  }

  public function bounce():Void
  {
    shouldBounce = true;
    bounceTime = 0;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (!shouldBounce) return;

    bounceTime += elapsed;

    var t:Float = bounceTime / 0.3;
    var tweener:Float = FlxEase.circInOut(t);
    var yOffset:Float = 0;

    if (tweener < 0.5) yOffset = FlxMath.lerp(0, 10, tweener * 2);
    else yOffset = FlxMath.lerp(10, 0, (tweener - 0.5) * 2);

    selected.offset.set(0, yOffset);
    unselected.offset.set(0, yOffset);

    if (t >= 1)
    {
      shouldBounce = false;
      bounceTime = 0;
      selected.offset.set(0, 0);
      unselected.offset.set(0, 0);
    }
  }
}
