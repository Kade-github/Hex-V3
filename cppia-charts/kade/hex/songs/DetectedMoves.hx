package kade.hex.songs;

import funkin.modding.module.ModuleHandler;

class DetectedMoves
{
  static inline final COLS:Int = 4;

  static final SLIDE:Array<String> = ["slide0", "slide1", "slide2", "slide3"];
  static final LIFT:Array<String> = ["lift0", "lift1", "lift2", "lift3"];
  static final WAVE:Array<String> = ["rowWave0", "rowWave1", "rowWave2", "rowWave3"];
  static final STAMP:Array<String> = ["stamp0", "stamp1", "stamp2", "stamp3"];

  static final first:Array<Float> = [0, 0, 0, 0];
  static final second:Array<Float> = [0, 0, 0, 0];

  static var chart:Dynamic = null;

  static var px:Float = 100 / 112;
  static var lane:Float = 112;
  static var gap:Float = 640;
  static var wrapStep:Float = 177.5;
  static var wrapPeriod:Float = 1420;

  public static function lanes(id:String, px:Float, lane:Float, gap:Float, wrapStep:Float, wrapPeriod:Float):Void
  {
    chart = ModuleHandler.getModule(id);

    DetectedMoves.px = px;
    DetectedMoves.lane = lane;
    DetectedMoves.gap = gap;
    DetectedMoves.wrapStep = wrapStep;
    DetectedMoves.wrapPeriod = wrapPeriod;
  }

  static inline function fmod(a:Float, b:Float):Float
  {
    return a - Math.floor(a / b) * b;
  }

  public static function sway(b:Float, swapAt:Float, both:Bool, flat:Bool):Void
  {
    if (chart == null) return;

    for (pn in 0...2)
    {
      if (!both && pn != ((b > swapAt) ? 1 : 0)) continue;

      for (col in 0...COLS)
      {
        first[col] = 32 * px * Math.sin((b + col * 0.25) * Math.PI);
        second[col] = 32 * px * ((col % 2 == 0) ? 1 : -1) * Math.tan(b * 0.25 * Math.PI);
      }

      chart.liveEach(SLIDE, first, pn);
      if (!flat) chart.liveEach(LIFT, second, pn);
    }
  }

  public static function wrap(b:Float, fromBeat:Float):Void
  {
    if (chart == null) return;

    var walked:Float = b - fromBeat;

    for (pn in 0...2)
    {
      var colspacing:Float = chart.read("colspacing", pn);
      var spacing:Float = chart.read("spacing", pn);
      var addx:Float = chart.read("addx", pn);
      var waveamp:Float = chart.read("waveamp", pn);

      for (col in 0...COLS)
      {
        var rest:Float = -col * lane - pn * gap;
        var landed:Float = fmod(col * colspacing + pn * spacing + walked * wrapStep, wrapPeriod) + addx;

        first[col] = (rest + landed) * px;

        var ang:Float = 2 * Math.PI * ((pn * COLS + col) / 8);
        second[col] = waveamp * 0.1 * Math.sin(b * Math.PI + ang);
      }

      chart.liveEach(SLIDE, first, pn);
      chart.liveEach(WAVE, second, pn);
    }
  }

  public static function step(b:Float, baseBeat:Float, solo:Bool, firstHalf:Bool):Void
  {
    if (chart == null) return;

    var pn:Int = (fmod(b - baseBeat, 32) > 16) ? 1 : 0;
    if (solo && pn != 0) return;

    var pingpong:Float = b - Math.floor(b);
    if (fmod(b, 2) > 1) pingpong = 1 - pingpong;

    var wdir:Float = (pn == 0) ? 1 : -1;
    if (fmod(b - baseBeat, 8) > 4) wdir = -wdir;

    if (b < baseBeat + 32)
    {
      for (col in 0...COLS)
      {
        var v:Float = -lane * wdir * Math.sin(b * Math.PI + col * Math.PI);
        if (v > 0) v = 0;

        first[col] = v * px;
      }

      chart.liveEach(STAMP, first, pn);
      chart.live("fold", pingpong * 120, pn);
      return;
    }

    if (firstHalf) return;

    for (col in 0...COLS)
      first[col] = -lane * 0.6 * wdir * Math.sin(b * Math.PI + col * Math.PI) * px;

    chart.liveEach(STAMP, first, pn);
    chart.live("fold", 60 - 60 * Math.cos(b * Math.PI), pn);
  }

  public static function easyDrunk(b:Float):Void
  {
    if (chart == null) return;

    var time:Float = chart.songTime();
    var sec:Float = time * 0.001;

    for (pn in 0...2)
    {
      var held:Float = chart.read("easydrunk", pn);
      var amt:Float = held * 0.01;

      for (col in 0...COLS)
        first[col] = (amt == 0) ? 0 : amt * Math.cos(sec + col * 0.2 + 0.2) * lane * 0.5 * px;

      chart.liveEach(SLIDE, first, pn);
    }
  }

  public static function halo(b:Float, fromBeat:Float):Void
  {
    if (chart == null) return;

    for (pn in 0...2)
    {
      var held:Float = chart.read("halo", pn);
      var much:Float = held * 0.01;

      var row:Float = chart.read("rowY", pn);
      var fallen:Float = row / px;

      for (col in 0...COLS)
      {
        var ang:Float = 2 * Math.PI * ((pn * COLS + col) / 8) + (b - fromBeat) * 0.5 * Math.PI;

        first[col] = 280 * much * Math.sin(ang) * px;
        second[col] = 70 * (1 - fallen / 300) * much * Math.cos(ang) * px;
      }

      chart.liveEach(SLIDE, first, pn);
      chart.liveEach(LIFT, second, pn);
    }
  }

  public static function camRock(b:Float, fromBeat:Float):Void
  {
    if (chart == null) return;

    for (pn in 0...2)
    {
      var much:Float = chart.read("camwagBy", pn);
      chart.live("camwag", much * Math.sin(b * Math.PI), pn);
    }
  }
}
