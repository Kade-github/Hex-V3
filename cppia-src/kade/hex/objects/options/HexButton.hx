package kade.hex.objects.options;

import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

class HexButton extends HexOptionItem
{
  var callback:Void->Void;

  public function new(x:Float, y:Float, labelStr:String, callback:Void->Void)
  {
    super(x, y);

    isButton = true;
    spacing = 40;

    this.callback = callback;

    label = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, labelStr);
    label.alignment = "LEFT";
    label.letterSpacing = -3;
    label.textScale = 0.6;
    label.setCharOffset("g", 0, 8);
    label.setCharOffset("y", 0, 8);
    add(label);
  }

  override public function select():Void
  {
    if (callback != null) callback();
  }
}
