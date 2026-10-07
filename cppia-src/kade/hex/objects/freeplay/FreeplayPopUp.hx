package kade.hex.objects.freeplay;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import funkin.Paths;
import funkin.audio.FunkinSound;
import kade.hex.util.HexTouch;

/**
 * The notice about the new song versions in freeplay.
 */
class FreeplayPopUp extends FlxSpriteGroup
{
  var dim:FlxSprite;
  var window:FlxSprite;

  var openTime:Float = 0;

  public var isOpen:Bool = false;
  public var closing:Bool = false;

  public var onClose:Void->Void = null;

  public function new()
  {
    super();

    dim = new FlxSprite();
    dim.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    dim.scrollFactor.set();

    window = new FlxSprite().loadGraphic(Paths.image("ui/hex/hex_freeplay/textWindow"));
    window.scrollFactor.set();

    window.x = FlxG.width / 2 - window.width / 2;
    window.y = FlxG.height / 2 - window.height / 2;

    add(dim);
    add(window);

    for (sprite in members)
    {
      sprite.alpha = 0;
      sprite.visible = false;
    }
  }

  public function show():Void
  {
    isOpen = true;
    closing = false;
    openTime = 0;

    for (sprite in members)
    {
      sprite.alpha = 0;
      sprite.visible = true;
    }
  }

  public function close():Void
  {
    isOpen = false;
    closing = true;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (isOpen && !closing)
    {
      openTime += elapsed;

      // Small delay so a key held from the previous menu does not close it instantly.
      if (openTime > 0.25 && (FlxG.keys.justPressed.ANY || HexTouch.tapped()))
      {
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        close();
        if (onClose != null) onClose();
      }
    }

    for (sprite in members)
    {
      if (!sprite.visible) continue;

      var target:Float = 1.0;
      if (closing) target = 0.0;
      else if (sprite == dim) target = 0.6;

      if (sprite.alpha < target)
      {
        sprite.alpha += elapsed * 4;
        if (sprite.alpha > target) sprite.alpha = target;
      }
      else if (sprite.alpha > target)
      {
        sprite.alpha -= elapsed * 4;
        if (sprite.alpha <= target)
        {
          sprite.alpha = target;
          if (target <= 0) sprite.visible = false;
        }
      }
    }
  }
}
