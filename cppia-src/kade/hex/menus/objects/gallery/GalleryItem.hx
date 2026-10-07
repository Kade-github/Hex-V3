package kade.hex.menus.objects.gallery;

import flixel.FlxSprite;
import funkin.graphics.FunkinSprite;
import funkin.group.FunkinGroup;

/**
 * An item in the gallery list.
 */
class GalleryItem extends FunkinGroup<FlxSprite>
{
  var item:FunkinSprite;
  public var selectedItem:FunkinSprite;

  public function new(index:Int, type:String)
  {
    super();

    item = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/" + type + (index + 1) + "Unselected");
    selectedItem = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/" + type + (index + 1) + "Selected");

    add(item);
    add(selectedItem);

    selectedItem.localX = -4;
    selectedItem.localY = -4;

    setSelected(false);
  }

  public function setSelected(selected:Bool):Void
  {
    item.localVisible = !selected;
    selectedItem.localVisible = selected;
  }
}
