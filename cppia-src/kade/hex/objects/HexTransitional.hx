package kade.hex.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import funkin.Paths;
import funkin.audio.FunkinSound;

/**
 * A simple top and bottom bar transition effect.
 */
class HexTransitional extends FlxSpriteGroup
{
  var _topBar:FlxSprite;
  var _bottomBar:FlxSprite;

  public var noSound:Bool = false;

  public var _inTween:Bool = false;
  public var _outTween:Bool = false;

  public var complete:Bool = true;

  // onComplete(out:Bool)
  public var onComplete:Bool->Void = null;

  public function new()
  {
    super();

    _topBar = new FlxSprite(0, -FlxG.height / 2);
    _bottomBar = new FlxSprite(0, FlxG.height);

    makeBar(_bottomBar);
    makeBar(_topBar);
    _topBar.scrollFactor.set();
    _bottomBar.scrollFactor.set();

    add(_topBar);
    add(_bottomBar);

    FunkinSound.load(Paths.sound("ui/hex/sounds/trans_in"));
    FunkinSound.load(Paths.sound("ui/hex/sounds/trans_out"));

    forceOut();
  }

  function makeBar(bar:FlxSprite):Void
  {
    bar.makeGraphic(1, 1, 0xFFFFFFFF);
    bar.color = 0xFF000000;
    bar.scale.set(FlxG.width, FlxG.height / 2);
    bar.updateHitbox();
  }

  public function transitionIn():Void
  {
    forceOut();

    _inTween = true;
    _outTween = false;

    complete = false;

    if (!noSound) FunkinSound.playOnce(Paths.sound("ui/hex/sounds/trans_in"));
  }

  public function transitionOut():Void
  {
    forceIn();
    _outTween = true;
    _inTween = false;

    complete = false;

    if (!noSound) FunkinSound.playOnce(Paths.sound("ui/hex/sounds/trans_out"));
  }

  public function forceIn():Void
  {
    _inTween = false;
    _outTween = false;

    if (_topBar == null || _bottomBar == null) return;

    _topBar.y = 0;
    _bottomBar.y = FlxG.height / 2;
  }

  public function forceOut():Void
  {
    _inTween = false;
    _outTween = false;

    if (_topBar == null || _bottomBar == null) return;

    _topBar.y = -FlxG.height / 2;
    _bottomBar.y = FlxG.height;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (complete) return;

    var half:Float = FlxG.height / 2;
    var t:Float = 0.12 * FlxG.elapsed * 80;

    if (_inTween)
    {
      _topBar.y = FlxMath.lerp(_topBar.y, 0, t);
      _bottomBar.y = FlxMath.lerp(_bottomBar.y, half, t);

      if (Math.abs(_topBar.y) <= 1 && Math.abs(_bottomBar.y - half) <= 1)
      {
        _topBar.y = 0;
        _bottomBar.y = half;
        complete = true;
        if (onComplete != null) onComplete(false);
      }
    }
    else if (_outTween)
    {
      _topBar.y = FlxMath.lerp(_topBar.y, -half, t);
      _bottomBar.y = FlxMath.lerp(_bottomBar.y, FlxG.height, t);

      if (Math.abs(_topBar.y + half) <= 1 && Math.abs(_bottomBar.y - FlxG.height) <= 1)
      {
        _topBar.y = -half;
        _bottomBar.y = FlxG.height;
        complete = true;
        if (onComplete != null) onComplete(true);
      }
    }
  }
}
