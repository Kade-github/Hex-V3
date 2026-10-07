package kade.hex.objects.options;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import funkin.Paths;
import funkin.group.FunkinGroup;

class OptionsBacking extends FunkinGroup<HexOptionItem>
{
  public var spacing:Float = 5;
  public var scrollOffset:Float = 0;
  public var scrollTarget:Float = 0;

  public var scrollBar:FlxSprite;
  public var scrollBarBall:FlxSprite;

  public var _bg:FlxSprite;

  public var centerItems:Bool = false;

  public function new()
  {
    super();

    _bg = new FlxSprite(0, 0);
    _bg.loadGraphic(Paths.image("ui/hex/hex_options/bigPopUp"));

    scrollBar = new FlxSprite(0, 0);
    scrollBar.loadGraphic(Paths.image("ui/hex/hex_options/scrollLine"));
    scrollBar.scale.set(0.65, 0.65);
    scrollBar.updateHitbox();

    scrollBarBall = new FlxSprite(0, 0);
    scrollBarBall.loadGraphic(Paths.image("ui/hex/hex_options/scrollCircle"));
    scrollBarBall.scale.set(0.65, 0.65);
    scrollBarBall.updateHitbox();
  }

  public function getTotalContentHeight():Float
  {
    var total:Float = 50 + spacing;
    for (child in children)
    {
      total += child.height + (child.useOwnSpacing ? 0 : spacing) + child.spacing;
    }
    return total;
  }

  public function getViewableHeight():Float
  {
    return _bg.height - 25;
  }

  public function clampScroll():Void
  {
    var maxScroll:Float = Math.max(0, getTotalContentHeight() - getViewableHeight());
    if (scrollTarget < 0) scrollTarget = 0;
    if (scrollTarget > maxScroll) scrollTarget = maxScroll;
  }

  public function getItemCenterY(index:Int):Float
  {
    var currentY:Float = 50 + spacing;
    for (i in 0...children.length)
    {
      var child:HexOptionItem = children[i];
      if (i == index) return currentY + child.height / 2;
      currentY += child.height + spacing + child.spacing;
    }
    return 0;
  }

  public function center():Void
  {
    x = FlxG.width / 2 - _bg.width / 2;
    y = FlxG.height / 2 - _bg.height / 2;

    clipRect = FlxRect.get(x + 8, y + 7, _bg.width, _bg.height - 25);
  }

  function positionItems():Void
  {
    var currentY:Float = 50 + (spacing - scrollOffset);
    if (centerItems) currentY += (_bg.height - 25 - getTotalContentHeight()) / 2;
    for (child in children)
    {
      if (centerItems || child.isHeader) child.localX = (_bg.width - child.width) / 2;
      else child.localX = 20;
      child.localY = currentY;
      currentY += child.height + (child.useOwnSpacing ? 0 : spacing) + child.spacing;
    }
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
    _bg.x = x;
    _bg.y = y;
    _bg.visible = visible;

    scrollBar.x = x + _bg.width - scrollBar.width - 35;
    scrollBar.y = y + 25;
    scrollBar.visible = visible;
    scrollBarBall.x = scrollBar.x - (scrollBarBall.width / 2) + 15;
    scrollBarBall.y = y + 45 + (scrollOffset / Math.max(1, getTotalContentHeight() - getViewableHeight())) * ((scrollBar.height - 45) - scrollBarBall.height);
    scrollBarBall.visible = visible;

    if (children.length < 6)
    {
      scrollBar.visible = false;
      scrollBarBall.visible = false;
    }

    scrollOffset += (scrollTarget - scrollOffset) * Math.min(elapsed * 12, 1);
    positionItems();
  }

  public function clean():Void
  {
    for (child in children.copy())
    {
      remove(child, true);
      child.destroy();
    }
  }
}
