package kade.hex.objects.options;

import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

class HexDataBox extends HexOptionItem
{
  var callback:(String, Int) -> String;

  public function new(x:Float, y:Float, labelStr:String, valueStr:String, callback:(String, Int) -> String)
  {
    super(x, y);

    spacing = 45;

    this.callback = callback;

    label = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, labelStr);
    label.alignment = "LEFT";
    label.letterSpacing = -3;
    label.textScale = 0.6;
    label.localX = 120;
    label.localY = 5;
    label.setCharOffset("g", 0, 8);
    label.setCharOffset("y", 0, 8);
    add(label);

    valueLabel = new BetterAtlasText(Paths.image("ui/fonts/hex_default"), Paths.xml("ui/fonts/hex_default"), 0, 0, valueStr);
    valueLabel.alignment = "LEFT";
    valueLabel.textScale = 0.8;
    valueLabel.letterSpacing = 0;
    valueLabel.localX = 10;
    valueLabel.localY = 8;
    add(valueLabel);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    label.localX = valueLabel.localX + valueLabel.width + 25;
  }

  override public function adjust(dir:Int):Void
  {
    if (callback == null) return;
    setValue(callback(valueLabel.text, dir));
  }

  override public function select():Void
  {
    adjust(1);
  }
}
