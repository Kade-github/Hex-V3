package kade.hex.menus.objects.gallery;

import flixel.FlxSprite;
import funkin.graphics.FunkinSprite;
import funkin.group.FunkinGroup;

/**
 * A meta dot in the gallery.
 */
class GalleryMetaDot extends FunkinGroup<FlxSprite>
{
  var item:FunkinSprite;
  var selectedItem:FunkinSprite;

  public function new()
  {
    super();

    item = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/sectionUnselected");
    selectedItem = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/sectionSelected");

    add(item);
    add(selectedItem);

    setSelected(false);
  }

  public function setSelected(selected:Bool):Void
  {
    item.localVisible = !selected;
    selectedItem.localVisible = selected;
  }
}
