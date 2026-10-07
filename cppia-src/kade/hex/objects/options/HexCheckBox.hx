package kade.hex.objects.options;

import funkin.Paths;
import funkin.graphics.FunkinSprite;
import kade.hex.objects.BetterAtlasText;

class HexCheckBox extends HexOptionItem
{
  var checkbox:FunkinSprite;
  var checkmark:FunkinSprite;
  var isChecked:Bool;
  var callback:Bool->Void;

  public function new(x:Float, y:Float, labelStr:String, checked:Bool, callback:Bool->Void)
  {
    super(x, y);

    this.isChecked = checked;
    this.callback = callback;

    label = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, labelStr);
    label.letterSpacing = -3;
    label.textScale = 0.6;
    label.alignment = "LEFT";
    label.localX = 120;
    label.localY = 10;
    label.setCharOffset("g", 0, 8);
    label.setCharOffset("y", 0, 8);
    add(label);

    checkbox = FunkinSprite.create(0, 0, "ui/hex/hex_options/checkbox");
    checkbox.localScale.set(0.6, 0.6);
    add(checkbox);
    checkbox.updateHitbox();
    checkbox.localX = -25;
    checkbox.localY = -(checkbox.height / 2) + 35;

    checkmark = FunkinSprite.create(0, 0, "ui/hex/hex_options/on");
    checkmark.localScale.set(0.6, 0.6);
    add(checkmark);
    checkmark.updateHitbox();
    checkmark.localX = -18;
    checkmark.localY = -(checkmark.height / 2) + 15;

    checkmark.localVisible = isChecked;
    spacing = isChecked ? 0 : 25;
  }

  override public function select():Void
  {
    isChecked = !isChecked;
    checkmark.localVisible = isChecked;
    spacing = isChecked ? 0 : 25;
    if (callback != null) callback(isChecked);
  }
}
