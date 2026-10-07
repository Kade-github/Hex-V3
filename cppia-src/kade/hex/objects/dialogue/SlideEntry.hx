package kade.hex.objects.dialogue;

import flixel.FlxSprite;

/**
 * Slide state for one sprite the dialogue moves around.
 */
class SlideEntry
{
  public var spr:FlxSprite;
  public var baseX:Float = 0;
  public var baseY:Float = 0;
  public var offX:Float = 0;
  public var offY:Float = 0;
  public var tgtX:Float = 0;
  public var tgtY:Float = 0;
  public var rate:Float = 0;
  public var alphaNow:Float = 1;
  public var alphaTgt:Float = 1;

  public function new(spr:FlxSprite, rate:Float)
  {
    this.spr = spr;
    this.rate = rate;
  }
}
