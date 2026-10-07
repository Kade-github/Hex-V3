package kade.hex.menus.objects.gallery;

import flixel.FlxSprite;
import funkin.graphics.FunkinSprite;
import funkin.group.FunkinGroup;

/**
 * An image in the gallery, can be expanded to a fullscreen view.
 */
class GalleryImage extends FunkinGroup<FlxSprite>
{
  public var thumb:FunkinSprite;
  public var full:FunkinSprite;

  public var expandCallback:(FunkinSprite, Bool) -> Void = null;

  public function new()
  {
    super();
  }

  public function loadPair(prefix:String, index:Int, extra:Int = -1):Void
  {
    if (thumb != null)
    {
      remove(thumb, true);
      thumb.destroy();
    }
    if (full != null)
    {
      remove(full, true);
      full.destroy();
    }

    var e:String = (extra != -1) ? "_" + (extra + 1) : "";

    thumb = FunkinSprite.create(x, y, "ui/hex/hex_gallery/" + prefix + (index + 1) + e + "Thumbnail");
    full = FunkinSprite.create(x, y, "ui/hex/hex_gallery/" + prefix + (index + 1) + e + "FullScreen");

    add(thumb);
  }

  public function expand(back:Bool):Void
  {
    if (expandCallback != null) expandCallback(full, back);
  }
}
