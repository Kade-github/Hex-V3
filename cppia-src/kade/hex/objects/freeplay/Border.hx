package kade.hex.objects.freeplay;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.group.FlxSpriteGroup;
import funkin.Assets;
import funkin.Paths;

class Border extends FlxSpriteGroup
{
  var time:Float = 0;
  var swirly:FlxRuntimeShader;

  public function new(left:Bool)
  {
    super();

    var inside:String = left ? "ui/hex/hex_freeplay/borderLeftInside" : "ui/hex/hex_freeplay/borderRightInside";
    var edge:String = left ? "ui/hex/hex_freeplay/borderLeft" : "ui/hex/hex_freeplay/borderRight";

    var borderInside:FlxSprite = new FlxSprite(0, 0);
    borderInside.loadGraphic(Paths.image(inside));
    add(borderInside);
    borderInside.setGraphicSize(FlxG.width, FlxG.height);
    borderInside.scrollFactor.set();
    borderInside.updateHitbox();

    var borderInside2:FlxSprite = new FlxSprite(0, 0);
    borderInside2.loadGraphic(Paths.image(inside));
    add(borderInside2);
    borderInside2.setGraphicSize(FlxG.width, FlxG.height);
    borderInside2.scrollFactor.set();
    borderInside2.updateHitbox();
    borderInside2.alpha = 0.2;
    borderInside2.color = 0x000000;

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.75);
    swirly.setFloatArray("uColor1", [0.012, 0, 0.275]);
    swirly.setFloatArray("uColor2", [0.002, 0.261, 0.535]);
    swirly.setFloat("uIntensity", 10.0);

    borderInside.shader = swirly;

    var border:FlxSprite = new FlxSprite(0, 0);
    border.loadGraphic(Paths.image(edge));
    add(border);
    border.setGraphicSize(FlxG.width, FlxG.height);
    border.scrollFactor.set();
    border.updateHitbox();
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
    time += elapsed;

    swirly.setFloat("uTime", time);
  }
}
