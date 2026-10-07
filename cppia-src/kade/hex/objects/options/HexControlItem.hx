package kade.hex.objects.options;

import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

class HexControlItem extends HexOptionItem
{
  var callback:(String, String) -> String;

  public function new(x:Float, y:Float, labelStr:String, valueStr:String, valueStr2:String, callback:(String, String) -> String)
  {
    super(x, y);

    isControl = true;
    useOwnSpacing = true;
    spacing = 15;

    this.callback = callback;

    label = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, labelStr);
    label.alignment = "LEFT";
    label.letterSpacing = -3;
    label.textScale = 0.5;
    label.localX = 25;
    label.localY = 5;
    label.setCharOffset("g", 0, 8);
    label.setCharOffset("y", 0, 8);
    add(label);

    valueLabel = new BetterAtlasText(Paths.image("ui/fonts/hex_default"), Paths.xml("ui/fonts/hex_default"), 0, 0, valueStr);
    valueLabel.alignment = "RIGHT";
    valueLabel.textScale = 0.7;
    valueLabel.letterSpacing = 0;
    valueLabel.localX = 470;
    valueLabel.localY = 8;
    add(valueLabel);

    valueLabel2 = new BetterAtlasText(Paths.image("ui/fonts/hex_default"), Paths.xml("ui/fonts/hex_default"), 0, 0, valueStr2);
    valueLabel2.alignment = "RIGHT";
    valueLabel2.textScale = 0.7;
    valueLabel2.letterSpacing = 0;
    valueLabel2.localX = valueLabel.localX + 260;
    valueLabel2.localY = 8;
    add(valueLabel2);
  }

  override public function selectBinding():Void
  {
    if (focusedBinding == 0) valueLabel.text = "...";
    else valueLabel2.text = "...";
  }

  override public function select():Void
  {
    if (callback == null) return;
    setValue(callback(valueLabel.text, valueLabel2.text));
  }
}
