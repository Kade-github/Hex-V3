package kade.hex.objects.options;

import flixel.FlxSprite;
import funkin.group.FunkinGroup;
import kade.hex.objects.BetterAtlasText;

/**
 * What every row in the options list has in common, so the menu can drive them without
 * caring which kind each one is.
 */
class HexOptionItem extends FunkinGroup<FlxSprite>
{
  public var label:BetterAtlasText = null;
  public var valueLabel:BetterAtlasText = null;
  public var valueLabel2:BetterAtlasText = null;

  public var isControl:Bool = false;
  public var isButton:Bool = false;
  public var isHeader:Bool = false;
  public var useOwnSpacing:Bool = false;
  public var spacing:Float = 0;

  public var controlName:String = null;
  public var focusedBinding:Int = 0;

  public function new(x:Float, y:Float)
  {
    super(x, y);
  }

  public function select():Void {}

  public function adjust(dir:Int):Void {}

  public function setFocus(binding:Int):Void
  {
    focusedBinding = binding;
  }

  public function selectBinding():Void {}

  public function setValue(newValue:String):Void
  {
    if (valueLabel != null) valueLabel.text = newValue;
  }

  public function setValue2(newValue:String):Void
  {
    if (valueLabel2 != null) valueLabel2.text = newValue;
  }
}
