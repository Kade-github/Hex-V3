package kade.hex.objects;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import funkin.Assets;
import funkin.Paths;
import openfl.filters.ShaderFilter;

class PersonaSelection extends FlxObject
{
  var _uPos1:Array<Float> = [0.0, 0.0];
  var _uPos2:Array<Float> = [0.0, 0.0];
  var _uPos3:Array<Float> = [0.0, 0.0];
  var _uPos4:Array<Float> = [0.0, 0.0];

  var personaShader:FlxRuntimeShader;
  public var _internalShaderFilter:ShaderFilter;

  var startLerp:Float = 0;

  var spx1:Float = 0;
  var spy1:Float = 0;
  var spx2:Float = 0;
  var spy2:Float = 0;
  var spx3:Float = 0;
  var spy3:Float = 0;
  var spx4:Float = 0;
  var spy4:Float = 0;

  var px1:Float = 0;
  var py1:Float = 0;
  var px2:Float = 0;
  var py2:Float = 0;
  var px3:Float = 0;
  var py3:Float = 0;
  var px4:Float = 0;
  var py4:Float = 0;

  var lpx1:Float = 0;
  var lpy1:Float = 0;
  var lpx2:Float = 0;
  var lpy2:Float = 0;
  var lpx3:Float = 0;
  var lpy3:Float = 0;
  var lpx4:Float = 0;
  var lpy4:Float = 0;

  var time:Float = 0;
  var realTime:Float = 0;

  public var color1(default, set):Array<Float> = [11, 0, 249];
  public var color2(default, set):Array<Float> = [185, 255, 251];
  public var color3(default, set):Array<Float> = [255, 79, 0];

  function set_color1(value:Array<Float>):Array<Float>
  {
    color1 = value;
    if (personaShader != null) personaShader.setFloatArray("uColor1", [value[0] / 255, value[1] / 255, value[2] / 255]);
    return value;
  }

  function set_color2(value:Array<Float>):Array<Float>
  {
    color2 = value;
    if (personaShader != null) personaShader.setFloatArray("uColor2", [value[0] / 255, value[1] / 255, value[2] / 255]);
    return value;
  }

  function set_color3(value:Array<Float>):Array<Float>
  {
    color3 = value;
    if (personaShader != null) personaShader.setFloatArray("uColor3", [value[0] / 255, value[1] / 255, value[2] / 255]);
    return value;
  }

  public var mix:Float = 0;
  public var timeScale:Float = 1;

  public var enabled(default, set):Bool = false;

  public var pos(get, set):Array<Array<Float>>;
  public var lerpPos(get, set):Array<Array<Float>>;

  function set_lerpPos(value:Array<Array<Float>>):Array<Array<Float>>
  {
    if (value.length != 4)
    {
      trace("[ERROR] PersonaSelection lerpPos must have exactly 4 points.");
      return get_lerpPos();
    }

    lpx1 = value[0][0];
    lpy1 = value[0][1];
    lpx2 = value[1][0];
    lpy2 = value[1][1];
    lpx3 = value[2][0];
    lpy3 = value[2][1];
    lpx4 = value[3][0];
    lpy4 = value[3][1];

    return value;
  }

  function get_lerpPos():Array<Array<Float>>
  {
    return [[lpx1, lpy1], [lpx2, lpy2], [lpx3, lpy3], [lpx4, lpy4]];
  }

  function get_pos():Array<Array<Float>>
  {
    return [[px1, py1], [px2, py2], [px3, py3], [px4, py4]];
  }

  function set_pos(value:Array<Array<Float>>):Array<Array<Float>>
  {
    if (value.length != 4)
    {
      trace("[ERROR] PersonaSelection pos must have exactly 4 points.");
      return get_pos();
    }

    startLerp = realTime;

    spx1 = lpx1;
    spy1 = lpy1;
    spx2 = lpx2;
    spy2 = lpy2;
    spx3 = lpx3;
    spy3 = lpy3;
    spx4 = lpx4;
    spy4 = lpy4;

    px1 = value[0][0];
    py1 = value[0][1];
    px2 = value[1][0];
    py2 = value[1][1];
    px3 = value[2][0];
    py3 = value[2][1];
    px4 = value[3][0];
    py4 = value[3][1];

    return value;
  }

  function set_enabled(value:Bool):Bool
  {
    enabled = value;
    if (personaShader != null) personaShader.setBool("uEnabled", value);
    return value;
  }

  public function new()
  {
    super();
  }

  public function initShader(?camera:FlxCamera):Void
  {
    personaShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/personaQuad")));
    personaShader.setFloat("uMix", 0);
    personaShader.setFloat("uTime", 0);
    personaShader.setBool("uEnabled", false);
    personaShader.setFloat("jitterAmount", 0.009);

    color1 = [11, 0, 249];
    color2 = [185, 255, 251];
    color3 = [255, 79, 0];

    _internalShaderFilter = new ShaderFilter(personaShader);
    if (camera != null) camera.filters = [_internalShaderFilter];
    else FlxG.camera.filters = [_internalShaderFilter];
  }

  public function updateShader(elapsed:Float):Void
  {
    realTime += elapsed;
    time += elapsed * timeScale;

    if (personaShader == null) return;

    var clampMix:Float = Math.max(0, Math.min(mix, 1));
    personaShader.setFloat("uTime", time);
    personaShader.setFloat("uMix", clampMix);

    var lT:Float = (realTime - startLerp) / 0.09;
    if (lT > 1) lT = 1;
    lpx1 = FlxMath.lerp(spx1, px1, lT);
    lpy1 = FlxMath.lerp(spy1, py1, lT);
    lpx2 = FlxMath.lerp(spx2, px2, lT);
    lpy2 = FlxMath.lerp(spy2, py2, lT);
    lpx3 = FlxMath.lerp(spx3, px3, lT);
    lpy3 = FlxMath.lerp(spy3, py3, lT);
    lpx4 = FlxMath.lerp(spx4, px4, lT);
    lpy4 = FlxMath.lerp(spy4, py4, lT);

    _uPos1[0] = lpx1;
    _uPos1[1] = lpy1;
    _uPos2[0] = lpx2;
    _uPos2[1] = lpy2;
    _uPos3[0] = lpx3;
    _uPos3[1] = lpy3;
    _uPos4[0] = lpx4;
    _uPos4[1] = lpy4;

    personaShader.setFloatArray("uPos1", _uPos1);
    personaShader.setFloatArray("uPos2", _uPos2);
    personaShader.setFloatArray("uPos3", _uPos3);
    personaShader.setFloatArray("uPos4", _uPos4);
  }
}
