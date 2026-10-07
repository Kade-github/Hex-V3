package kade.hex.objects.mainmenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import kade.hex.util.HexTouch;

/**
 * The title screen that sits over the main menu until the player presses enter.
 */
class HexTitle extends FlxSpriteGroup
{
  public var complete:Bool = false;

  var title_bg:FlxSprite;

  var realTime:Float = 0;
  var time:Float = 10;

  var swirlTransition:FlxRuntimeShader;
  var invertText:FlxRuntimeShader;

  var canContinue:Bool = false;

  var startTime:Float = 0.0;
  var invertStartTime:Float = 0.0;

  var invertAnimation:Bool = false;
  var delay:Float = 0.0;

  var logoText:FlxSprite;
  var logo:FlxSprite;

  var playedSound:Bool = false;
  var tapText:Bool = false;

  public var onComplete:Void->Void = null;

  public function new()
  {
    super();

    swirlTransition = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirlTrans")));

    swirlTransition.setFloat("uTime", 2);

    title_bg = new FlxSprite(0, 0);
    title_bg.loadGraphic(Paths.image("ui/hex/main-menu/title-bg"));
    title_bg.setGraphicSize(FlxG.width, FlxG.height);
    title_bg.scrollFactor.set();
    title_bg.updateHitbox();
    add(title_bg);

    title_bg.shader = swirlTransition;

    logo = new FlxSprite(-25, FlxG.height);
    logo.loadGraphic(Paths.image("ui/hex/main-menu/title/logo"));
    logo.scrollFactor.set();
    add(logo);

    invertText = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/better_invertColor")));
    invertText.setFloat("uIntensity", 0);

    logoText = new FlxSprite(-10, FlxG.height);
    logoText.loadGraphic(Paths.image("ui/hex/main-menu/title/logo_text"));
    logoText.scrollFactor.set();
    add(logoText);

    logoText.shader = invertText;

    logo.scale.set(0.75, 0.75);
    logoText.scale.set(0.75, 0.75);
  }

  static function clamp(min:Float, value:Float, max:Float):Float
  {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  public function showLogo():Void
  {
    canContinue = true;
    startTime = realTime;
  }

  public function doTrans():Void
  {
    time = 2;
    invertAnimation = true;
    invertStartTime = realTime;
    delay = 2.2;
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));

    if (FlxG.sound.music != null) FlxG.sound.music.fadeOut(5);
  }

  var reachedEnd:Bool = false;
  var hurryTfUp:Float = 0;

  var lastLogoY:Float = 0;
  var lastLogoTextY:Float = 0;

  function swapLogoText():Void
  {
    tapText = HexTouch.active;

    var path:String = Paths.image("ui/hex/main-menu/title/logo_text" + (tapText ? "_mobile" : ""));
    if (!Assets.exists(path)) return;

    var centre:Float = logoText.x + logoText.frameWidth * 0.5;
    logoText.loadGraphic(path);
    logoText.x = centre - logoText.frameWidth * 0.5;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    realTime += elapsed;

    if (HexTouch.active != tapText && !invertAnimation) swapLogoText();

    if (canContinue)
    {
      var elapsedSince:Float = realTime - startTime;

      var logoYTarget:Float = (FlxG.height - (logo.height + 50));
      var logoTextYTarget:Float = (FlxG.height - (logoText.height + 25));

      var sin:Float = Math.sin(realTime * 1.2);
      var sin2:Float = Math.sin(realTime * 1.9);

      logoYTarget += sin2 * 5;
      logoTextYTarget += sin * 7;

      if (hurryTfUp > 0 && !reachedEnd)
      {
        var elapsedSinceHurry:Float = realTime - hurryTfUp;
        logo.y = FlxMath.lerp(lastLogoY, logoYTarget, FlxEase.backOut(clamp(0, elapsedSinceHurry / 1, 1)));
        if (elapsedSince > 0.5) logoText.y = FlxMath.lerp(lastLogoTextY, logoTextYTarget, FlxEase.backOut(clamp(0, (elapsedSinceHurry - 0.5) / 1, 1)));

        if (elapsedSinceHurry >= 1.25)
        {
          delay = 0.1;
          reachedEnd = true;
          lastLogoTextY = logoText.y;
          lastLogoY = logo.y;
        }
      }

      if (invertAnimation && delay <= 0)
      {
        logoText.y = FlxMath.lerp(lastLogoTextY, FlxG.height + (sin * 7), FlxEase.circIn(clamp(0, elapsedSince / 1.25, 1)));
        if (elapsedSince > 0.75) logo.y = FlxMath.lerp(lastLogoY, FlxG.height + (sin2 * 5), FlxEase.circIn(clamp(0, (elapsedSince - 0.75) / 0.75, 1)));
      }
      else if (hurryTfUp <= 0 && !invertAnimation)
      {
        logo.y = FlxMath.lerp(FlxG.height, logoYTarget, FlxEase.backOut(clamp(0, elapsedSince / 4, 1)));
        if (elapsedSince > 1.25) logoText.y = FlxMath.lerp(FlxG.height, logoTextYTarget, FlxEase.backOut(clamp(0, (elapsedSince - 1.25) / 2.5, 1)));

        if (elapsedSince >= 3.5)
        {
          lastLogoTextY = logoText.y;
          lastLogoY = logo.y;
          reachedEnd = true;
        }
      }
      else if (reachedEnd && delay > 0)
      {
        // Keep the floating effect.
        logo.y = logoYTarget;
        logoText.y = logoTextYTarget;

        delay -= elapsed;

        if (delay <= 0 && invertAnimation)
        {
          lastLogoTextY = logoText.y;
          lastLogoY = logo.y;
          startTime = realTime;
        }
      }
    }

    if ((FlxG.keys.justPressed.ENTER || HexTouch.tapped()) && !invertAnimation)
    {
      if (canContinue)
      {
        if (!reachedEnd)
        {
          lastLogoY = logo.y;
          lastLogoTextY = logoText.y;
          hurryTfUp = realTime;
        }
        doTrans();
      }
      else
      {
        FlxG.camera.stopFlash();
        showLogo();
      }
    }

    if (time > 0)
    {
      if (time > 2)
      {
        title_bg.alpha = 1;
      }
      else
      {
        var elapsedSinceOther:Float = realTime - startTime;
        if (elapsedSinceOther >= 1 && delay <= 0)
        {
          if (!playedSound && time <= 1.8)
          {
            playedSound = true;
            FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_scratch"));
          }
          time -= elapsed * 0.6;
          swirlTransition.setFloat("uTime", time);
        }
        var elapsedSince:Float = realTime - invertStartTime;

        var y:Float = elapsedSince / 0.5;

        invertText.setFloat("uIntensity", clamp(0, 1 - y, 1));
      }
    }
    else
    {
      if (!complete)
      {
        complete = true;
        if (onComplete != null) onComplete();
      }

      if (title_bg.alpha > 0) title_bg.alpha -= elapsed;
      else title_bg.alpha = 0;
    }
  }
}
