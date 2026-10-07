package kade.hex.objects.options;

import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

class HexHeaderItem extends HexOptionItem
{
  public function new(x:Float, y:Float, labelStr:String)
  {
    super(x, y);

    isHeader = true;
    spacing = 25;

    label = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, labelStr);
    label.alignment = "LEFT";
    label.letterSpacing = -3;
    label.textScale = 0.7;
    label.localY = 5;
    label.setCharOffset("g", 0, 8);
    label.setCharOffset("y", 0, 8);
    label.alpha = 0.5;
    add(label);
  }
}
