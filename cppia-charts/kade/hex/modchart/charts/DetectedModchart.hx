// exported by mod-ed

package kade.hex.modchart.charts;

import Math;
import flixel.FlxG;
import funkin.play.PlayState;
import funkin.play.notes.Strumline;
import kade.hex.chart.Chart;
import kade.hex.songs.DetectedMoves;

class DetectedModchart extends Chart
{
    var PX:Float = 100 / 112;

    var chartSpeed:Float = 1;

    var LANE:Float = 112;
    var GAP:Float = 640;
    var BASEX:Float = 0;
    var MIDX:Float = 640;

    var WRAP_EDGE:Float = 140;
    var WRAP_PERIOD:Float = 1420;
    var WRAP_SPREAD:Float = 710;
    var WRAP_STEP:Float = 177.5;

    static inline var HOME:Float = 1;

    static inline var LIFT_ROW:Float = 100;

    static inline var SHOVE_ROW:Float = 100;

    static inline var HIDDEN_UNIT:Float = 239.7;

    static inline var COLS:Int = 4;
    static var SLIDE_CH = ["slide0", "slide1", "slide2", "slide3"];
    static var LIFT_CH = ["lift0", "lift1", "lift2", "lift3"];
    static var WAVE_CH = ["rowWave0", "rowWave1", "rowWave2", "rowWave3"];
    static var STAMP_CH = ["stamp0", "stamp1", "stamp2", "stamp3"];

    public function new()
    {
        super("detected_modchart", 100);
    }

    override function setup():Void
    {
		nf.field.hudFollowsRow = false;

		quantSkin("gameplay/hex/me-quant-notes");

		virtual("alpha");
		virtual("colspacing");
		virtual("spacing");
		virtual("addx");
		virtual("waveamp");
		virtual("halo");
		virtual("camwagBy");
		virtual("camwag");
		virtual("addDrunk");
		virtual("addTipsy");
		virtual("slide0");
		virtual("lift0");
		virtual("rowWave0");
		virtual("stamp0");
		virtual("slide1");
		virtual("lift1");
		virtual("rowWave1");
		virtual("stamp1");
		virtual("slide2");
		virtual("lift2");
		virtual("rowWave2");
		virtual("stamp2");
		virtual("slide3");
		virtual("lift3");
		virtual("rowWave3");
		virtual("stamp3");

		base([100, "rate"]);
		base([0, "fold.arc"]);
		base([350, "drawAhead"]);
		base([100, "drawAhead.fade"]);
		base([100, "alpha"]);
		base([672, "spacing"]);
		base([112, "colspacing"]);
        chartSpeed = scrollSpeed();
        readLanes();

        declareAlpha();
        declareColumns();
        declareFraming();
        declareNumbers();
        declareSecondWaves();
        declareBlocks();
    }

    function declareAlpha():Void
    {

        make(["alpha", function(v:Float, pn:Int):Array<Float>
        {
            var gone:Float = 100 - v;
            return [gone, gone];
        }, "blind", "dim"]);
    }

    function declareColumns():Void
    {
        for (c in 0...COLS)
        {

            make(["slide" + c, 100, "shiftX" + c]);
            make(["lift" + c, 100, "shiftY" + c]);

            make(["rowWave" + c, 100, "flipRow" + c]);

            make(["stamp" + c, 100, 100, "rowY" + c, "laneY" + c]);
        }
    }

    function declareFraming():Void
    {
        make(["flipRow", -LIFT_ROW, "fieldY"]);

        make(["tiltZ", function(v:Float, pn:Int):Float
        {
            return SHOVE_ROW * Math.sin(v * Math.PI / 180);
        }, "fieldX"]);
    }

    function declareNumbers():Void
    {

        make(["camwag", 100, "tiltZ"]);
    }

    function declareSecondWaves():Void
    {

        make(["addDrunk", 100, "drunk"]);
        make(["addTipsy", 100, "tipsy"]);
    }

    function declareBlocks():Void
    {
        var self = this;

        hook("sway", function(b:Float, args:Array<Dynamic>) { DetectedMoves.sway(b, args[0], args[1], false); });
        hook("wrap", function(b:Float, args:Array<Dynamic>) { DetectedMoves.wrap(b, args[0]); });
        hook("step", function(b:Float, args:Array<Dynamic>) { DetectedMoves.step(b, args[0], false, false); });
        hook("halo", function(b:Float, args:Array<Dynamic>) { DetectedMoves.halo(b, args[0]); });
        hook("camRock", function(b:Float, args:Array<Dynamic>) { DetectedMoves.camRock(b, args[0]); });
    }

    function readLanes():Void
    {
        var state = PlayState.instance;
        if (state == null) return;

        var lines = [state.opponentStrumline, state.playerStrumline];

        var x0:Float = 0;
        var other:Float = 0;
        var got:Bool = false;

        if (lines[0] != null && lines[0].getByIndex(0) != null && lines[0].getByIndex(1) != null)
        {
            x0 = lines[0].getByIndex(0).x;
            LANE = lines[0].getByIndex(1).x - x0;
            BASEX = x0;
            got = true;
        }

        if (lines[1] != null && lines[1].getByIndex(0) != null)
        {
            other = lines[1].getByIndex(0).x;
            if (got) GAP = other - x0;
        }

        PX = 100 / Strumline.STRUMLINE_SIZE;

        MIDX = FlxG.width / 2;

        WRAP_EDGE = LANE * 1.25;
        WRAP_PERIOD = FlxG.width + WRAP_EDGE;
        WRAP_SPREAD = WRAP_PERIOD / 2;
        WRAP_STEP = WRAP_PERIOD / 8;

        DetectedMoves.lanes(moduleId, PX, LANE, GAP, WRAP_STEP, WRAP_PERIOD);
    }

    function xmod(v:Float):Float
    {
        return v / chartSpeed * 100;
    }

    function hiddenAt(px:Float):Float
    {
        return 100 * (px / HIDDEN_UNIT - 1);
    }

    function plain(v:String):String
    {
        return (v == null) ? "" : v.toLowerCase();
    }

    function fmod(a:Float, b:Float):Float
    {
        return a - Math.floor(a / b) * b;
    }

    function only(pn:Int):Dynamic
    {
        return {plr: pn};
    }

    function walkHome(at:Float, names:Array<String>):Void
    {
        for (n in names)
            for (c in 0...COLS)
                to([at, HOME, outCubic, 0, n + c]);
    }

    function hideRow(bt:Float, pn:Int):Void
    {
        for (i in 0...COLS)
        {
            var at:Float = bt + i * 0.125;

            to([at - 1, 0.5, outExpo, -70 * PX, "shiftY" + i], only(pn));
            to([at - 0.5, 1.25, inExpo, 650 * PX, "shiftY" + i], only(pn));

            jump([at + 1.75, 100, "blind", 100, "dim"], only(pn));
        }
    }

    function showRow(bt:Float, pn:Int):Void
    {
        for (i in 0...COLS)
        {
            var at:Float = bt + i * 0.125;

            jump([at - 2, 0, "blind", 0, "dim"], only(pn));

            to([at - 2, 1, outExpo, -70 * PX, "shiftY" + i], only(pn));
            to([at - 1, 1, inExpo, 50 * PX, "shiftY" + i], only(pn));
            to([at, 1.25, outElastic, 0, "shiftY" + i], only(pn));
        }
    }

    function wig(b:Float, num:Int, div:Float, curve:Dynamic, am:Float, mod:String, pn:Int):Void
    {
        var f:Float = 1;
        for (i in 0...(num + 1))
        {
            var smul:Float = (i == 0) ? 1 : 0;
            var emul:Float = (i == num) ? 0 : 1;

            var o:Dynamic = (pn < 0) ? {from: am * smul * f} : {plr: [pn], from: am * smul * f};
            to([b + i * (1 / div), 1 / div, curve, am * emul * -f, mod], o);

            f = -f;
        }
    }

    function sm2(b:Float, len:Float, curve:Dynamic, amt:Float, mod:String, pn:Int, intime:Float):Void
    {
        if (intime <= 0) intime = 0.001;

        var o:Dynamic = (pn < 0) ? null : only(pn);
        to([b - intime, intime, linear, amt, mod], o);
        to([b, len - intime, curve, 0, mod], o);
    }

    function kicks(list:Array<Float>, amount:Float):Void
    {
        for (pn in 0...2)
        {
            var lean:Float = (pn == 0) ? -1 : 1;
            var f1:Float = 1;
            var f2:Float = 1;

            var i:Int = 0;
            while (i + 1 < list.length)
            {
                var at:Float = list[i];
                var which:Float = list[i + 1];
                i += 2;

                if (which == 0)
                {
                    to([at, 0.75, outCubic, 0, "addDrunk"], {plr: [pn], from: amount * f1 * lean});
                    f1 = -f1;
                }
                else
                {
                    to([at, 0.75, outCubic, 0, "addTipsy"], {plr: [pn], from: amount * f2 * lean});
                    f2 = -f2;
                }
            }
        }
    }

    function spins(fromBeat:Float, toBeat:Float, swapAt:Float, both:Bool):Void
    {
        var f:Float = 1;
        var i:Float = fromBeat;

        while (i <= toBeat)
        {
            var pn:Int = both ? -1 : ((i >= swapAt) ? 1 : 0);
            var o:Dynamic = (pn < 0) ? {from: 360 * f} : {plr: [pn], from: 360 * f};

            to([i, 2, outCubic, 0, "faceZ"], o);

            f = -f;
            i += 4;
        }
    }

    function crossRows(atBeat:Float):Void
    {
        var out:Float = COLS * LANE * 1.2 * PX;

        for (n in 0...2)
        {
            to([atBeat + 8 * n, 4, linear, out, "shiftX"], only(0));
            to([atBeat + 4 + 8 * n, 4, linear, 0, "shiftX"], only(0));
            to([atBeat + 16 + 8 * n, 4, linear, -out, "shiftX"], only(1));
            to([atBeat + 16 + 4 + 8 * n, 4, linear, 0, "shiftX"], only(1));
        }
    }
	override function build():Void
	{
		// == song : rate, beat, drawAhead, drawAhead.fade, fadeNear, fadeNear.offset ==
		// == opacity : alpha, alpha 2, blind, dim ==
		// == row : rowCenterX, rowY, laneY, flipRow, fieldY, shiftX, shiftY, mirror, fold, drag, swell ==
		// == columns : colspacing, spacing, addx, waveamp, slide0, slide1, slide2, slide3, lift0, lift0 2, lift1, lift1 2, lift2, lift2 2, lift3, lift3 2, rowWave0, rowWave1, rowWave2, rowWave3, stamp0, stamp1, stamp2, stamp3 ==
		// == wiggle : drunk, drunk 2, tipsy, addDrunk, addDrunk 2, addDrunk 3, addDrunk 4, addTipsy, addTipsy 2, addTipsy 3, addTipsy 4, faceZ, tiltZ, camwagBy, halo, halo 2 ==
		// == blocks : sway, wrap, step, camRock ==

		// -- intro @ 0 --
		layer("rate", function()
		{
			jump([0, 100, "rate"]);
		});

		layer("drawAhead", function()
		{
			jump([0, 600, "drawAhead"]);
		});

		layer("drawAhead.fade", function()
		{
			jump([0, 25, "drawAhead.fade"]);
		});

		layer("tipsy", function()
		{
			to([0, 4, "outcubic", 200, "tipsy"], {plr: 0});
			to([12, 4, "incubic", 100, "tipsy"], {plr: 0});
			to([16, 4, "outcubic", 100, "tipsy"], {plr: 1});
			to([28, 4, "incubic", 0, "tipsy"]);
		});

		// -- sway @ 32 --
		layer("alpha", function()
		{
			to([62, 4, "inoutcubic", 40, "alpha"], {plr: 0});
		});

		layer("faceZ", function()
		{
			to([32, 2, "outcubic", 0, "faceZ"], {plr: 0, from: 360});
			to([36, 2, "outcubic", 0, "faceZ"], {plr: 0, from: -360});
			to([40, 2, "outcubic", 0, "faceZ"], {plr: 0, from: 360});
			to([44, 2, "outcubic", 0, "faceZ"], {plr: 0, from: -360});
			to([48, 2, "outcubic", 0, "faceZ"], {plr: 1, from: 360});
			to([52, 2, "outcubic", 0, "faceZ"], {plr: 1, from: -360});
			to([56, 2, "outcubic", 0, "faceZ"], {plr: 1, from: 360});
			to([60, 2, "outcubic", 0, "faceZ"], {plr: 1, from: -360});
		});

		layer("sway", function()
		{
			every([32, 32, "sway", [48, false]]);
		});

		// -- wrapping @ 64 --
		layer("rate", function()
		{
			to([93, 3, "linear", 100, "rate"]);
		});

		layer("beat", function()
		{
			jump([91.5, 300, "beat"]);
			jump([95.5, 0, "beat"]);
		});

		layer("alpha", function()
		{
			to([94, 4, "inoutcubic", 100, "alpha"], {plr: 0});
		});

		layer("shiftY", function()
		{
			to([92, 3, "linear", 48.0769, "shiftY"]);
		});

		layer("colspacing", function()
		{
			to([64, 8, "inoutcubic", 185.875, "colspacing"]);
			to([92, 4, "incubic", 112, "colspacing"]);
		});

		layer("spacing", function()
		{
			to([64, 8, "inoutcubic", 743.5, "spacing"]);
			to([92, 4, "incubic", 672, "spacing"]);
		});

		layer("addx", function()
		{
			to([64, 8, "inoutcubic", -224.9, "addx"]);
			to([92, 4, "incubic", 0, "addx"]);
		});

		layer("waveamp", function()
		{
			to([64, 8, "inoutcubic", 100, "waveamp"]);
			to([92, 4, "incubic", 0, "waveamp"]);
		});

		layer("slide0", function()
		{
			to([95, 1, "outcubic", 0, "slide0"]);
		});

		layer("slide1", function()
		{
			to([95, 1, "outcubic", 0, "slide1"]);
		});

		layer("slide2", function()
		{
			to([95, 1, "outcubic", 0, "slide2"]);
		});

		layer("slide3", function()
		{
			to([95, 1, "outcubic", 0, "slide3"]);
		});

		layer("lift0", function()
		{
			to([64, 1, "outcubic", 0, "lift0"]);
			to([94, 0.5, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([94.5, 1.25, "inexpo", 625, "lift0"], {plr: 1});
		});

		layer("lift1", function()
		{
			to([64, 1, "outcubic", 0, "lift1"]);
			to([94.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([94.625, 1.25, "inexpo", 625, "lift1"], {plr: 1});
		});

		layer("lift2", function()
		{
			to([64, 1, "outcubic", 0, "lift2"]);
			to([94.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([94.75, 1.25, "inexpo", 625, "lift2"], {plr: 1});
		});

		layer("lift3", function()
		{
			to([64, 1, "outcubic", 0, "lift3"]);
			to([94.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([94.875, 1.25, "inexpo", 625, "lift3"], {plr: 1});
		});

		layer("rowWave0", function()
		{
			to([95, 1, "outcubic", 0, "rowWave0"]);
		});

		layer("rowWave1", function()
		{
			to([95, 1, "outcubic", 0, "rowWave1"]);
		});

		layer("rowWave2", function()
		{
			to([95, 1, "outcubic", 0, "rowWave2"]);
		});

		layer("rowWave3", function()
		{
			to([95, 1, "outcubic", 0, "rowWave3"]);
		});

		layer("wrap", function()
		{
			every([64, 31, "wrap", [64]]);
		});

		// -- stepping @ 96 --
		layer("rate", function()
		{
			to([157, 3, "inoutcubic", 60, "rate"]);
		});

		layer("beat", function()
		{
			jump([159.7, 200, "beat"]);
		});

		layer("drawAhead", function()
		{
			to([157, 1, "linear", 700, "drawAhead"]);
		});

		layer("alpha", function()
		{
			to([158, 4, "inoutcubic", 20, "alpha"], {plr: 0});
		});

		layer("blind", function()
		{
			jump([96.75, 100, "blind"], {plr: 1});
			jump([96.875, 100, "blind"], {plr: 1});
			jump([97, 100, "blind"], {plr: 1});
			jump([97.125, 100, "blind"], {plr: 1});
			jump([110, 0, "blind"], {plr: 1});
			jump([110.125, 0, "blind"], {plr: 1});
			jump([110.25, 0, "blind"], {plr: 1});
			jump([110.375, 0, "blind"], {plr: 1});
			jump([113.75, 100, "blind"], {plr: 0});
			jump([113.875, 100, "blind"], {plr: 0});
			jump([114, 100, "blind"], {plr: 0});
			jump([114.125, 100, "blind"], {plr: 0});
			jump([126, 0, "blind"], {plr: 0});
			jump([126.125, 0, "blind"], {plr: 0});
			jump([126.25, 0, "blind"], {plr: 0});
			jump([126.375, 0, "blind"], {plr: 0});
			jump([129.75, 100, "blind"], {plr: 1});
			jump([129.875, 100, "blind"], {plr: 1});
			jump([130, 100, "blind"], {plr: 1});
			jump([130.125, 100, "blind"], {plr: 1});
			jump([142, 0, "blind"], {plr: 1});
			jump([142.125, 0, "blind"], {plr: 1});
			jump([142.25, 0, "blind"], {plr: 1});
			jump([142.375, 0, "blind"], {plr: 1});
			jump([145.75, 100, "blind"], {plr: 0});
			jump([145.875, 100, "blind"], {plr: 0});
			jump([146, 100, "blind"], {plr: 0});
			jump([146.125, 100, "blind"], {plr: 0});
			jump([158, 0, "blind"], {plr: 0});
			jump([158.125, 0, "blind"], {plr: 0});
			jump([158.25, 0, "blind"], {plr: 0});
			jump([158.375, 0, "blind"], {plr: 0});
		});

		layer("dim", function()
		{
			jump([96.75, 100, "dim"], {plr: 1});
			jump([96.875, 100, "dim"], {plr: 1});
			jump([97, 100, "dim"], {plr: 1});
			jump([97.125, 100, "dim"], {plr: 1});
			jump([110, 0, "dim"], {plr: 1});
			jump([110.125, 0, "dim"], {plr: 1});
			jump([110.25, 0, "dim"], {plr: 1});
			jump([110.375, 0, "dim"], {plr: 1});
			jump([113.75, 100, "dim"], {plr: 0});
			jump([113.875, 100, "dim"], {plr: 0});
			jump([114, 100, "dim"], {plr: 0});
			jump([114.125, 100, "dim"], {plr: 0});
			jump([126, 0, "dim"], {plr: 0});
			jump([126.125, 0, "dim"], {plr: 0});
			jump([126.25, 0, "dim"], {plr: 0});
			jump([126.375, 0, "dim"], {plr: 0});
			jump([129.75, 100, "dim"], {plr: 1});
			jump([129.875, 100, "dim"], {plr: 1});
			jump([130, 100, "dim"], {plr: 1});
			jump([130.125, 100, "dim"], {plr: 1});
			jump([142, 0, "dim"], {plr: 1});
			jump([142.125, 0, "dim"], {plr: 1});
			jump([142.25, 0, "dim"], {plr: 1});
			jump([142.375, 0, "dim"], {plr: 1});
			jump([145.75, 100, "dim"], {plr: 0});
			jump([145.875, 100, "dim"], {plr: 0});
			jump([146, 100, "dim"], {plr: 0});
			jump([146.125, 100, "dim"], {plr: 0});
			jump([158, 0, "dim"], {plr: 0});
			jump([158.125, 0, "dim"], {plr: 0});
			jump([158.25, 0, "dim"], {plr: 0});
			jump([158.375, 0, "dim"], {plr: 0});
		});

		layer("rowCenterX", function()
		{
			to([158, 4, "inoutcubic", 100, "rowCenterX"]);
		});

		layer("shiftX", function()
		{
			to([96, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([100, 4, "linear", 0, "shiftX"], {plr: 0});
			to([104, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([108, 4, "linear", 0, "shiftX"], {plr: 0});
			to([112, 4, "linear", -516.9231, "shiftX"], {plr: 1});
			to([116, 4, "linear", 0, "shiftX"], {plr: 1});
			to([120, 4, "linear", -516.9231, "shiftX"], {plr: 1});
			to([124, 4, "linear", 0, "shiftX"], {plr: 1});
		});

		layer("mirror", function()
		{
			to([96, 3, "linear", -10, "mirror"]);
			to([124, 4, "incubic", 0, "mirror"]);
		});

		layer("lift0", function()
		{
			to([110, 1, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([111, 1, "inexpo", 48.0769, "lift0"], {plr: 1});
			to([112, 1.25, "outelastic", 0, "lift0"], {plr: 1});
			to([126, 1, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([127, 1, "inexpo", 48.0769, "lift0"], {plr: 0});
			to([128, 1.25, "outelastic", 0, "lift0"], {plr: 0});
			to([142, 1, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([143, 1, "inexpo", 48.0769, "lift0"], {plr: 1});
			to([144, 1.25, "outelastic", 0, "lift0"], {plr: 1});
			to([158, 1, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([159, 1, "inexpo", 48.0769, "lift0"], {plr: 0});
		});

		layer("lift0 2", function()
		{
			to([111, 0.5, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([111.5, 1.25, "inexpo", 625, "lift0"], {plr: 0});
			to([127, 0.5, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([127.5, 1.25, "inexpo", 625, "lift0"], {plr: 1});
			to([143, 0.5, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([143.5, 1.25, "inexpo", 625, "lift0"], {plr: 0});
		});

		layer("lift1", function()
		{
			to([110.125, 1, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([111.125, 1, "inexpo", 48.0769, "lift1"], {plr: 1});
			to([112.125, 1.25, "outelastic", 0, "lift1"], {plr: 1});
			to([126.125, 1, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([127.125, 1, "inexpo", 48.0769, "lift1"], {plr: 0});
			to([128.125, 1.25, "outelastic", 0, "lift1"], {plr: 0});
			to([142.125, 1, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([143.125, 1, "inexpo", 48.0769, "lift1"], {plr: 1});
			to([144.125, 1.25, "outelastic", 0, "lift1"], {plr: 1});
			to([158.125, 1, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([159.125, 1, "inexpo", 48.0769, "lift1"], {plr: 0});
		});

		layer("lift1 2", function()
		{
			to([111.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([111.625, 1.25, "inexpo", 625, "lift1"], {plr: 0});
			to([127.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([127.625, 1.25, "inexpo", 625, "lift1"], {plr: 1});
			to([143.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([143.625, 1.25, "inexpo", 625, "lift1"], {plr: 0});
		});

		layer("lift2", function()
		{
			to([110.25, 1, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([111.25, 1, "inexpo", 48.0769, "lift2"], {plr: 1});
			to([112.25, 1.25, "outelastic", 0, "lift2"], {plr: 1});
			to([126.25, 1, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([127.25, 1, "inexpo", 48.0769, "lift2"], {plr: 0});
			to([128.25, 1.25, "outelastic", 0, "lift2"], {plr: 0});
			to([142.25, 1, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([143.25, 1, "inexpo", 48.0769, "lift2"], {plr: 1});
			to([144.25, 1.25, "outelastic", 0, "lift2"], {plr: 1});
			to([158.25, 1, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([159.25, 1, "inexpo", 48.0769, "lift2"], {plr: 0});
		});

		layer("lift2 2", function()
		{
			to([111.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([111.75, 1.25, "inexpo", 625, "lift2"], {plr: 0});
			to([127.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([127.75, 1.25, "inexpo", 625, "lift2"], {plr: 1});
			to([143.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([143.75, 1.25, "inexpo", 625, "lift2"], {plr: 0});
		});

		layer("lift3", function()
		{
			to([110.375, 1, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([111.375, 1, "inexpo", 48.0769, "lift3"], {plr: 1});
			to([112.375, 1.25, "outelastic", 0, "lift3"], {plr: 1});
			to([126.375, 1, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([127.375, 1, "inexpo", 48.0769, "lift3"], {plr: 0});
			to([128.375, 1.25, "outelastic", 0, "lift3"], {plr: 0});
			to([142.375, 1, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([143.375, 1, "inexpo", 48.0769, "lift3"], {plr: 1});
			to([144.375, 1.25, "outelastic", 0, "lift3"], {plr: 1});
			to([158.375, 1, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([159.375, 1, "inexpo", 48.0769, "lift3"], {plr: 0});
		});

		layer("lift3 2", function()
		{
			to([111.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([111.875, 1.25, "inexpo", 625, "lift3"], {plr: 0});
			to([127.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([127.875, 1.25, "inexpo", 625, "lift3"], {plr: 1});
			to([143.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([143.875, 1.25, "inexpo", 625, "lift3"], {plr: 0});
		});

		layer("step", function()
		{
			every([96, 64, "step", [96]]);
		});

		// -- drop @ 160 --
		layer("rate", function()
		{
			to([207, 1, "linear", 85, "rate"]);
			to([221, 3, "linear", 50, "rate"]);
		});

		layer("beat", function()
		{
			jump([207.3, 0, "beat"]);
		});

		layer("drawAhead", function()
		{
			to([207, 1, "linear", 400, "drawAhead"]);
		});

		layer("alpha", function()
		{
			to([206, 4, "inoutcubic", 50, "alpha"], {plr: 0});
			to([216, 4, "linear", 0, "alpha"], {plr: 1});
			to([223, 2, "inoutcubic", 50, "alpha"], {plr: 0});
		});

		layer("alpha 2", function()
		{
			to([219, 2, "inoutcubic", 100, "alpha"], {plr: 0});
		});

		layer("rowCenterX", function()
		{
			to([206, 2, "incubic", 0, "rowCenterX"]);
			to([208, 12, "linear", 100, "rowCenterX"]);
		});

		layer("rowY", function()
		{
			to([160, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([161, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([162, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([163, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([164, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([165, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([166, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([167, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([168, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([169, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([170, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([171, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([172, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([173, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([174, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([175, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([176, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([177, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([178, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([179, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([180, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([181, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([182, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([183, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([184, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([185, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([186, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([187, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([188, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([189, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([190, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([191, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([192, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([193, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([194, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([195, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([196, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([197, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([198, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([199, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([200, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([201, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([202, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([203, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([204, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([205, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([206, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([207, 1, "linear", 183.0769, "rowY"], {from: 0});
			jump([208, 0, "rowY"]);
		});

		layer("laneY", function()
		{
			to([160, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([161, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([162, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([163, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([164, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([165, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([166, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([167, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([168, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([169, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([170, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([171, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([172, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([173, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([174, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([175, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([176, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([177, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([178, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([179, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([180, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([181, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([182, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([183, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([184, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([185, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([186, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([187, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([188, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([189, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([190, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([191, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([192, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([193, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([194, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([195, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([196, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([197, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([198, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([199, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([200, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([201, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([202, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([203, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([204, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([205, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([206, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([207, 1, "linear", 183.0769, "laneY"], {from: 0});
			jump([208, 0, "laneY"]);
		});

		layer("fieldY", function()
		{
			to([174, 4, "inoutcubic", 538.4615, "fieldY"]);
			to([190, 4, "inoutcubic", 269.2308, "fieldY"]);
			to([206, 4, "inoutcubic", 0, "fieldY"]);
		});

		layer("mirror", function()
		{
			to([174, 4, "inoutcubic", 100, "mirror"]);
			to([190, 4, "inoutcubic", 0, "mirror"]);
		});

		layer("lift0", function()
		{
			to([160, 1.25, "outelastic", 0, "lift0"], {plr: 0});
		});

		layer("lift1", function()
		{
			to([160.125, 1.25, "outelastic", 0, "lift1"], {plr: 0});
		});

		layer("lift2", function()
		{
			to([160.25, 1.25, "outelastic", 0, "lift2"], {plr: 0});
		});

		layer("lift3", function()
		{
			to([160.375, 1.25, "outelastic", 0, "lift3"], {plr: 0});
		});

		layer("stamp0", function()
		{
			to([160, 1, "outcubic", 0, "stamp0"]);
		});

		layer("stamp1", function()
		{
			to([160, 1, "outcubic", 0, "stamp1"]);
		});

		layer("stamp2", function()
		{
			to([160, 1, "outcubic", 0, "stamp2"]);
		});

		layer("stamp3", function()
		{
			to([160, 1, "outcubic", 0, "stamp3"]);
		});

		layer("drunk", function()
		{
			to([220, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 100});
			to([220.25, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([220.5, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([220.75, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([221, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([221.25, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([221.5, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([221.75, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([222, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([222.25, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([222.5, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([222.75, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([223, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([223.25, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
			to([223.5, 0.25, "outcubic", -100, "drunk"], {plr: 0, from: 0});
			to([223.75, 0.25, "outcubic", 100, "drunk"], {plr: 0, from: 0});
		});

		layer("addDrunk", function()
		{
			to([208, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([208.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([209.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([210.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([212, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([212.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([213.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([214.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([216, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([216.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([217.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([218.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
		});

		layer("addDrunk 2", function()
		{
			to([208, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([208.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([209.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([210.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([212, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([212.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([213.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([214.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([216, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([216.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([217.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([218.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
		});

		layer("addTipsy", function()
		{
			to([211, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
			to([215, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
			to([219, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
		});

		layer("addTipsy 2", function()
		{
			to([211, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
			to([215, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
			to([219, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
		});

		layer("addTipsy 3", function()
		{
			to([211.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
			to([215.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
			to([219.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
		});

		layer("addTipsy 4", function()
		{
			to([211.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
			to([215.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
			to([219.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
		});

		layer("faceZ", function()
		{
			to([174, 4, "inoutcubic", -180, "faceZ"]);
			to([190, 4, "inoutcubic", -90, "faceZ"]);
			to([206, 4, "inoutcubic", 0, "faceZ"]);
		});

		layer("tiltZ", function()
		{
			to([174, 4, "inoutcubic", 180, "tiltZ"]);
			to([190, 4, "inoutcubic", 90, "tiltZ"]);
			to([206, 4, "inoutcubic", 0, "tiltZ"]);
		});

		// -- hidden @ 224 --
		layer("rate", function()
		{
			to([253, 3, "linear", 60, "rate"]);
		});

		layer("drawAhead", function()
		{
			jump([224, 650, "drawAhead"]);
		});

		layer("drawAhead.fade", function()
		{
			jump([224, 0, "drawAhead.fade"]);
		});

		layer("fadeNear", function()
		{
			to([224, 8, "linear", 27, "fadeNear"]);
			to([272, 8, "inoutcubic", 0, "fadeNear"]);
		});

		layer("fadeNear.offset", function()
		{
			jump([224, -79.1406, "fadeNear.offset"]);
			to([238, 10, "linear", 14, "fadeNear.offset"]);
			to([252, 8, "inoutcubic", -16.5624, "fadeNear.offset"]);
		});

		layer("alpha", function()
		{
			jump([224, 100, "alpha"], {plr: 1});
			jump([224, 30, "alpha"], {plr: 0});
		});

		layer("blind", function()
		{
			jump([224, 0, "blind"], {plr: 1});
		});

		layer("dim", function()
		{
			jump([224, 100, "dim"], {plr: 1});
			to([234, 3, "linear", 0, "dim"], {plr: 1});
		});

		layer("rowCenterX", function()
		{
			jump([224, 100, "rowCenterX"]);
			to([284, 4, "incubic", 0, "rowCenterX"]);
		});

		layer("swell", function()
		{
			to([224, 28, "linear", 100, "swell"]);
			to([252, 8, "inoutcubic", 200, "swell"]);
			to([280, 8, "inoutcubic", 0, "swell"]);
		});

		layer("slide0", function()
		{
			to([284, 1, "outcubic", 0, "slide0"]);
		});

		layer("slide1", function()
		{
			to([284, 1, "outcubic", 0, "slide1"]);
		});

		layer("slide2", function()
		{
			to([284, 1, "outcubic", 0, "slide2"]);
		});

		layer("slide3", function()
		{
			to([284, 1, "outcubic", 0, "slide3"]);
		});

		layer("lift0", function()
		{
			to([284, 1, "outcubic", 0, "lift0"]);
		});

		layer("lift1", function()
		{
			to([284, 1, "outcubic", 0, "lift1"]);
		});

		layer("lift2", function()
		{
			to([284, 1, "outcubic", 0, "lift2"]);
		});

		layer("lift3", function()
		{
			to([284, 1, "outcubic", 0, "lift3"]);
		});

		layer("drunk", function()
		{
			to([224, 0.25, "outcubic", 0, "drunk"], {plr: 0, from: 0});
			to([252, 8, "inoutcubic", 25, "drunk"]);
			to([280, 8, "inoutcubic", 0, "drunk"]);
		});

		layer("faceZ", function()
		{
			to([256, 2, "outcubic", 0, "faceZ"], {from: 360});
			to([260, 2, "outcubic", 0, "faceZ"], {from: -360});
			to([264, 2, "outcubic", 0, "faceZ"], {from: 360});
			to([268, 2, "outcubic", 0, "faceZ"], {from: -360});
			to([272, 2, "outcubic", 0, "faceZ"], {from: 360});
			to([276, 2, "outcubic", 0, "faceZ"], {from: -360});
			to([280, 2, "outcubic", 0, "faceZ"], {from: 360});
		});

		layer("sway", function()
		{
			every([256, 28, "sway", [0, true]]);
		});

		// -- wrapping @ 288 --
		layer("rate", function()
		{
			to([317, 3, "linear", 94.4444, "rate"]);
		});

		layer("beat", function()
		{
			jump([315.5, 300, "beat"]);
			jump([319.5, 0, "beat"]);
		});

		layer("fadeNear.offset", function()
		{
			jump([288, 0, "fadeNear.offset"]);
		});

		layer("alpha", function()
		{
			to([318, 2, "linear", 100, "alpha"], {plr: 0});
		});

		layer("shiftY", function()
		{
			to([316, 3, "linear", 48.0769, "shiftY"]);
		});

		layer("colspacing", function()
		{
			to([288, 8, "inoutcubic", 185.875, "colspacing"]);
			to([316, 4, "incubic", 112, "colspacing"]);
		});

		layer("spacing", function()
		{
			to([288, 8, "inoutcubic", 743.5, "spacing"]);
			to([316, 4, "incubic", 672, "spacing"]);
		});

		layer("addx", function()
		{
			to([288, 8, "inoutcubic", -224.9, "addx"]);
			to([316, 4, "incubic", 0, "addx"]);
		});

		layer("waveamp", function()
		{
			to([288, 8, "inoutcubic", 100, "waveamp"]);
			to([316, 4, "incubic", 0, "waveamp"]);
		});

		layer("lift0", function()
		{
			to([318, 0.5, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([318.5, 1.25, "inexpo", 625, "lift0"], {plr: 1});
		});

		layer("lift1", function()
		{
			to([318.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([318.625, 1.25, "inexpo", 625, "lift1"], {plr: 1});
		});

		layer("lift2", function()
		{
			to([318.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([318.75, 1.25, "inexpo", 625, "lift2"], {plr: 1});
		});

		layer("lift3", function()
		{
			to([318.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([318.875, 1.25, "inexpo", 625, "lift3"], {plr: 1});
		});

		layer("wrap", function()
		{
			every([288, 32, "wrap", [288]]);
		});

		// -- stepping @ 320 --
		layer("alpha", function()
		{
			to([351, 2, "linear", 50, "alpha"], {plr: 0});
		});

		layer("blind", function()
		{
			jump([320.75, 100, "blind"], {plr: 1});
			jump([320.875, 100, "blind"], {plr: 1});
			jump([321, 100, "blind"], {plr: 1});
			jump([321.125, 100, "blind"], {plr: 1});
			jump([334, 0, "blind"], {plr: 1});
			jump([334.125, 0, "blind"], {plr: 1});
			jump([334.25, 0, "blind"], {plr: 1});
			jump([334.375, 0, "blind"], {plr: 1});
			jump([337.75, 100, "blind"], {plr: 0});
			jump([337.875, 100, "blind"], {plr: 0});
			jump([338, 100, "blind"], {plr: 0});
			jump([338.125, 100, "blind"], {plr: 0});
			jump([350, 0, "blind"], {plr: 0});
			jump([350.125, 0, "blind"], {plr: 0});
			jump([350.25, 0, "blind"], {plr: 0});
			jump([350.375, 0, "blind"], {plr: 0});
		});

		layer("dim", function()
		{
			jump([320.75, 100, "dim"], {plr: 1});
			jump([320.875, 100, "dim"], {plr: 1});
			jump([321, 100, "dim"], {plr: 1});
			jump([321.125, 100, "dim"], {plr: 1});
			jump([334, 0, "dim"], {plr: 1});
			jump([334.125, 0, "dim"], {plr: 1});
			jump([334.25, 0, "dim"], {plr: 1});
			jump([334.375, 0, "dim"], {plr: 1});
			jump([337.75, 100, "dim"], {plr: 0});
			jump([337.875, 100, "dim"], {plr: 0});
			jump([338, 100, "dim"], {plr: 0});
			jump([338.125, 100, "dim"], {plr: 0});
			jump([350, 0, "dim"], {plr: 0});
			jump([350.125, 0, "dim"], {plr: 0});
			jump([350.25, 0, "dim"], {plr: 0});
			jump([350.375, 0, "dim"], {plr: 0});
		});

		layer("flipRow", function()
		{
			to([323, 2, "inoutexpo", 100, "flipRow"], {plr: 0});
			to([327, 2, "inoutexpo", 0, "flipRow"], {plr: 0});
			to([331, 2, "inoutexpo", 100, "flipRow"], {plr: 0});
			to([335, 2, "inoutexpo", 0, "flipRow"], {plr: 0});
			to([339, 2, "inoutexpo", 100, "flipRow"], {plr: 1});
			to([343, 2, "inoutexpo", 0, "flipRow"], {plr: 1});
			to([347, 2, "inoutexpo", 100, "flipRow"], {plr: 1});
			to([351, 2, "inoutexpo", 0, "flipRow"], {plr: 1});
		});

		layer("shiftX", function()
		{
			to([320, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([324, 4, "linear", 0, "shiftX"], {plr: 0});
			to([328, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([332, 4, "linear", 0, "shiftX"], {plr: 0});
			to([336, 4, "linear", -516.9231, "shiftX"], {plr: 1});
			to([340, 4, "linear", 0, "shiftX"], {plr: 1});
			to([344, 4, "linear", -516.9231, "shiftX"], {plr: 1});
			to([348, 4, "linear", 0, "shiftX"], {plr: 1});
		});

		layer("mirror", function()
		{
			to([320, 3, "linear", -10, "mirror"]);
			to([348, 4, "incubic", 0, "mirror"]);
		});

		layer("drag", function()
		{
			to([351.9, 0.1, "linear", 100, "drag"]);
		});

		layer("slide0", function()
		{
			to([320, 1, "outcubic", 0, "slide0"]);
		});

		layer("slide1", function()
		{
			to([320, 1, "outcubic", 0, "slide1"]);
		});

		layer("slide2", function()
		{
			to([320, 1, "outcubic", 0, "slide2"]);
		});

		layer("slide3", function()
		{
			to([320, 1, "outcubic", 0, "slide3"]);
		});

		layer("lift0", function()
		{
			to([334, 1, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([335, 1, "inexpo", 48.0769, "lift0"], {plr: 1});
			to([336, 1.25, "outelastic", 0, "lift0"], {plr: 1});
			to([350, 1, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([351, 1, "inexpo", 48.0769, "lift0"], {plr: 0});
		});

		layer("lift0 2", function()
		{
			to([335, 0.5, "outexpo", -67.3077, "lift0"], {plr: 0});
			to([335.5, 1.25, "inexpo", 625, "lift0"], {plr: 0});
		});

		layer("lift1", function()
		{
			to([334.125, 1, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([335.125, 1, "inexpo", 48.0769, "lift1"], {plr: 1});
			to([336.125, 1.25, "outelastic", 0, "lift1"], {plr: 1});
			to([350.125, 1, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([351.125, 1, "inexpo", 48.0769, "lift1"], {plr: 0});
		});

		layer("lift1 2", function()
		{
			to([335.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 0});
			to([335.625, 1.25, "inexpo", 625, "lift1"], {plr: 0});
		});

		layer("lift2", function()
		{
			to([334.25, 1, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([335.25, 1, "inexpo", 48.0769, "lift2"], {plr: 1});
			to([336.25, 1.25, "outelastic", 0, "lift2"], {plr: 1});
			to([350.25, 1, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([351.25, 1, "inexpo", 48.0769, "lift2"], {plr: 0});
		});

		layer("lift2 2", function()
		{
			to([335.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 0});
			to([335.75, 1.25, "inexpo", 625, "lift2"], {plr: 0});
		});

		layer("lift3", function()
		{
			to([334.375, 1, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([335.375, 1, "inexpo", 48.0769, "lift3"], {plr: 1});
			to([336.375, 1.25, "outelastic", 0, "lift3"], {plr: 1});
			to([350.375, 1, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([351.375, 1, "inexpo", 48.0769, "lift3"], {plr: 0});
		});

		layer("lift3 2", function()
		{
			to([335.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 0});
			to([335.875, 1.25, "inexpo", 625, "lift3"], {plr: 0});
		});

		layer("rowWave0", function()
		{
			to([320, 1, "outcubic", 0, "rowWave0"]);
		});

		layer("rowWave1", function()
		{
			to([320, 1, "outcubic", 0, "rowWave1"]);
		});

		layer("rowWave2", function()
		{
			to([320, 1, "outcubic", 0, "rowWave2"]);
		});

		layer("rowWave3", function()
		{
			to([320, 1, "outcubic", 0, "rowWave3"]);
		});

		layer("drunk", function()
		{
			to([351.9, 0.1, "linear", 200, "drunk"]);
		});

		layer("step", function()
		{
			every([320, 64, "step", [320]]);
		});

		// -- brake stabs @ 352 --
		layer("rate", function()
		{
			to([381, 3, "inoutcubic", 77.7778, "rate"]);
		});

		layer("beat", function()
		{
			jump([383.7, 200, "beat"]);
		});

		layer("alpha", function()
		{
			to([382, 4, "inoutcubic", 25, "alpha"], {plr: 0});
		});

		layer("rowCenterX", function()
		{
			to([353, 1, "inoutexpo", 100, "rowCenterX"]);
			to([354.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([357, 1, "inoutexpo", 100, "rowCenterX"]);
			to([358.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([361, 1, "inoutexpo", 100, "rowCenterX"]);
			to([362.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([365, 1, "inoutexpo", 100, "rowCenterX"]);
			to([366.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([369, 1, "inoutexpo", 100, "rowCenterX"]);
			to([370.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([373, 1, "inoutexpo", 100, "rowCenterX"]);
			to([374.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([377, 1, "inoutexpo", 100, "rowCenterX"]);
			to([378.5, 1, "inoutexpo", 0, "rowCenterX"]);
			to([381, 1, "inoutexpo", 100, "rowCenterX"]);
		});

		layer("fold", function()
		{
			to([353, 1, "inoutcubic", 100, "fold"]);
			to([354.5, 1, "inoutcubic", 0, "fold"]);
			to([357, 1, "inoutcubic", 100, "fold"]);
			to([358.5, 1, "inoutcubic", 0, "fold"]);
			to([361, 1, "inoutcubic", 100, "fold"]);
			to([362.5, 1, "inoutcubic", 0, "fold"]);
			to([365, 1, "inoutcubic", 100, "fold"]);
			to([366.5, 1, "inoutcubic", 0, "fold"]);
			to([369, 1, "inoutcubic", 100, "fold"]);
			to([370.5, 1, "inoutcubic", 0, "fold"]);
			to([373, 1, "inoutcubic", 100, "fold"]);
			to([374.5, 1, "inoutcubic", 0, "fold"]);
			to([377, 1, "inoutcubic", 100, "fold"]);
			to([378.5, 1, "inoutcubic", 0, "fold"]);
		});

		layer("drag", function()
		{
			to([352, 1.9, "outcubic", 0, "drag"]);
			to([355.9, 0.1, "linear", 100, "drag"]);
			to([356, 1.9, "outcubic", 0, "drag"]);
			to([359.9, 0.1, "linear", 100, "drag"]);
			to([360, 1.9, "outcubic", 0, "drag"]);
			to([363.9, 0.1, "linear", 100, "drag"]);
			to([364, 1.9, "outcubic", 0, "drag"]);
			to([367.9, 0.1, "linear", 100, "drag"]);
			to([368, 1.9, "outcubic", 0, "drag"]);
			to([371.9, 0.1, "linear", 100, "drag"]);
			to([372, 1.9, "outcubic", 0, "drag"]);
			to([375.9, 0.1, "linear", 100, "drag"]);
			to([376, 1.9, "outcubic", 0, "drag"]);
			to([379.9, 0.1, "linear", 100, "drag"]);
			to([380, 1.9, "outcubic", 0, "drag"]);
		});

		layer("lift0", function()
		{
			to([352, 1.25, "outelastic", 0, "lift0"], {plr: 0});
		});

		layer("lift1", function()
		{
			to([352.125, 1.25, "outelastic", 0, "lift1"], {plr: 0});
		});

		layer("lift2", function()
		{
			to([352.25, 1.25, "outelastic", 0, "lift2"], {plr: 0});
		});

		layer("lift3", function()
		{
			to([352.375, 1.25, "outelastic", 0, "lift3"], {plr: 0});
		});

		layer("rowWave0", function()
		{
			to([353, 0.5, "outcubic", 10, "rowWave0"]);
			to([353.5, 0.5, "incubic", 0, "rowWave0"]);
			to([354.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([355, 0.5, "incubic", 0, "rowWave0"]);
			to([357, 0.5, "outcubic", 10, "rowWave0"]);
			to([357.5, 0.5, "incubic", 0, "rowWave0"]);
			to([358.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([359, 0.5, "incubic", 0, "rowWave0"]);
			to([361, 0.5, "outcubic", 10, "rowWave0"]);
			to([361.5, 0.5, "incubic", 0, "rowWave0"]);
			to([362.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([363, 0.5, "incubic", 0, "rowWave0"]);
			to([365, 0.5, "outcubic", 10, "rowWave0"]);
			to([365.5, 0.5, "incubic", 0, "rowWave0"]);
			to([366.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([367, 0.5, "incubic", 0, "rowWave0"]);
			to([369, 0.5, "outcubic", 10, "rowWave0"]);
			to([369.5, 0.5, "incubic", 0, "rowWave0"]);
			to([370.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([371, 0.5, "incubic", 0, "rowWave0"]);
			to([373, 0.5, "outcubic", 10, "rowWave0"]);
			to([373.5, 0.5, "incubic", 0, "rowWave0"]);
			to([374.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([375, 0.5, "incubic", 0, "rowWave0"]);
			to([377, 0.5, "outcubic", 10, "rowWave0"]);
			to([377.5, 0.5, "incubic", 0, "rowWave0"]);
			to([378.5, 0.5, "outcubic", -10, "rowWave0"]);
			to([379, 0.5, "incubic", 0, "rowWave0"]);
		});

		layer("rowWave1", function()
		{
			to([353, 0.5, "outcubic", -10, "rowWave1"]);
			to([353.5, 0.5, "incubic", 0, "rowWave1"]);
			to([354.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([355, 0.5, "incubic", 0, "rowWave1"]);
			to([357, 0.5, "outcubic", -10, "rowWave1"]);
			to([357.5, 0.5, "incubic", 0, "rowWave1"]);
			to([358.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([359, 0.5, "incubic", 0, "rowWave1"]);
			to([361, 0.5, "outcubic", -10, "rowWave1"]);
			to([361.5, 0.5, "incubic", 0, "rowWave1"]);
			to([362.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([363, 0.5, "incubic", 0, "rowWave1"]);
			to([365, 0.5, "outcubic", -10, "rowWave1"]);
			to([365.5, 0.5, "incubic", 0, "rowWave1"]);
			to([366.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([367, 0.5, "incubic", 0, "rowWave1"]);
			to([369, 0.5, "outcubic", -10, "rowWave1"]);
			to([369.5, 0.5, "incubic", 0, "rowWave1"]);
			to([370.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([371, 0.5, "incubic", 0, "rowWave1"]);
			to([373, 0.5, "outcubic", -10, "rowWave1"]);
			to([373.5, 0.5, "incubic", 0, "rowWave1"]);
			to([374.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([375, 0.5, "incubic", 0, "rowWave1"]);
			to([377, 0.5, "outcubic", -10, "rowWave1"]);
			to([377.5, 0.5, "incubic", 0, "rowWave1"]);
			to([378.5, 0.5, "outcubic", 10, "rowWave1"]);
			to([379, 0.5, "incubic", 0, "rowWave1"]);
		});

		layer("rowWave2", function()
		{
			to([353, 0.5, "outcubic", 10, "rowWave2"]);
			to([353.5, 0.5, "incubic", 0, "rowWave2"]);
			to([354.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([355, 0.5, "incubic", 0, "rowWave2"]);
			to([357, 0.5, "outcubic", 10, "rowWave2"]);
			to([357.5, 0.5, "incubic", 0, "rowWave2"]);
			to([358.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([359, 0.5, "incubic", 0, "rowWave2"]);
			to([361, 0.5, "outcubic", 10, "rowWave2"]);
			to([361.5, 0.5, "incubic", 0, "rowWave2"]);
			to([362.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([363, 0.5, "incubic", 0, "rowWave2"]);
			to([365, 0.5, "outcubic", 10, "rowWave2"]);
			to([365.5, 0.5, "incubic", 0, "rowWave2"]);
			to([366.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([367, 0.5, "incubic", 0, "rowWave2"]);
			to([369, 0.5, "outcubic", 10, "rowWave2"]);
			to([369.5, 0.5, "incubic", 0, "rowWave2"]);
			to([370.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([371, 0.5, "incubic", 0, "rowWave2"]);
			to([373, 0.5, "outcubic", 10, "rowWave2"]);
			to([373.5, 0.5, "incubic", 0, "rowWave2"]);
			to([374.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([375, 0.5, "incubic", 0, "rowWave2"]);
			to([377, 0.5, "outcubic", 10, "rowWave2"]);
			to([377.5, 0.5, "incubic", 0, "rowWave2"]);
			to([378.5, 0.5, "outcubic", -10, "rowWave2"]);
			to([379, 0.5, "incubic", 0, "rowWave2"]);
		});

		layer("rowWave3", function()
		{
			to([353, 0.5, "outcubic", -10, "rowWave3"]);
			to([353.5, 0.5, "incubic", 0, "rowWave3"]);
			to([354.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([355, 0.5, "incubic", 0, "rowWave3"]);
			to([357, 0.5, "outcubic", -10, "rowWave3"]);
			to([357.5, 0.5, "incubic", 0, "rowWave3"]);
			to([358.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([359, 0.5, "incubic", 0, "rowWave3"]);
			to([361, 0.5, "outcubic", -10, "rowWave3"]);
			to([361.5, 0.5, "incubic", 0, "rowWave3"]);
			to([362.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([363, 0.5, "incubic", 0, "rowWave3"]);
			to([365, 0.5, "outcubic", -10, "rowWave3"]);
			to([365.5, 0.5, "incubic", 0, "rowWave3"]);
			to([366.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([367, 0.5, "incubic", 0, "rowWave3"]);
			to([369, 0.5, "outcubic", -10, "rowWave3"]);
			to([369.5, 0.5, "incubic", 0, "rowWave3"]);
			to([370.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([371, 0.5, "incubic", 0, "rowWave3"]);
			to([373, 0.5, "outcubic", -10, "rowWave3"]);
			to([373.5, 0.5, "incubic", 0, "rowWave3"]);
			to([374.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([375, 0.5, "incubic", 0, "rowWave3"]);
			to([377, 0.5, "outcubic", -10, "rowWave3"]);
			to([377.5, 0.5, "incubic", 0, "rowWave3"]);
			to([378.5, 0.5, "outcubic", 10, "rowWave3"]);
			to([379, 0.5, "incubic", 0, "rowWave3"]);
		});

		layer("drunk", function()
		{
			to([352, 1.9, "outcubic", 0, "drunk"]);
			to([355.9, 0.1, "linear", 200, "drunk"]);
			to([356, 1.9, "outcubic", 0, "drunk"]);
			to([359.9, 0.1, "linear", 200, "drunk"]);
			to([360, 1.9, "outcubic", 0, "drunk"]);
			to([363.9, 0.1, "linear", 200, "drunk"]);
			to([364, 1.9, "outcubic", 0, "drunk"]);
			to([367.9, 0.1, "linear", 200, "drunk"]);
			to([368, 1.9, "outcubic", 0, "drunk"]);
			to([371.9, 0.1, "linear", 200, "drunk"]);
			to([372, 1.9, "outcubic", 0, "drunk"]);
			to([375.9, 0.1, "linear", 200, "drunk"]);
			to([376, 1.9, "outcubic", 0, "drunk"]);
			to([379.9, 0.1, "linear", 200, "drunk"]);
			to([380, 1.9, "outcubic", 0, "drunk"]);
		});

		// -- drop @ 384 --
		layer("rate", function()
		{
			to([415, 2, "inoutcubic", 94.4444, "rate"]);
		});

		layer("beat", function()
		{
			jump([415.3, 0, "beat"]);
		});

		layer("drawAhead", function()
		{
			to([415.75, 0.75, "linear", 350, "drawAhead"]);
		});

		layer("drawAhead.fade", function()
		{
			jump([415.75, 15, "drawAhead.fade"]);
		});

		layer("alpha", function()
		{
			to([414, 4, "inoutcubic", 45, "alpha"], {plr: 0});
			to([436, 8, "linear", 0, "alpha"], {plr: 0});
		});

		layer("rowCenterX", function()
		{
			jump([384, 100, "rowCenterX"]);
			to([414, 2, "incubic", 0, "rowCenterX"]);
			to([428, 12, "linear", 100, "rowCenterX"]);
		});

		layer("rowY", function()
		{
			to([384, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([385, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([386, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([387, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([388, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([389, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([390, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([391, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([392, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([393, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([394, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([395, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([396, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([397, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([398, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([399, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([400, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([401, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([402, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([403, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([404, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([405, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([406, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([407, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([408, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([409, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([410, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([411, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([412, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([413, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([414, 1, "linear", 183.0769, "rowY"], {from: 0});
			to([415, 1, "linear", 183.0769, "rowY"], {from: 0});
			jump([416, 0, "rowY"]);
		});

		layer("laneY", function()
		{
			to([384, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([385, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([386, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([387, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([388, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([389, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([390, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([391, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([392, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([393, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([394, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([395, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([396, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([397, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([398, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([399, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([400, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([401, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([402, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([403, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([404, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([405, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([406, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([407, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([408, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([409, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([410, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([411, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([412, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([413, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([414, 1, "linear", 183.0769, "laneY"], {from: 0});
			to([415, 1, "linear", 183.0769, "laneY"], {from: 0});
			jump([416, 0, "laneY"]);
		});

		layer("flipRow", function()
		{
			to([416, 4, "linear", 100, "flipRow"]);
			to([420, 4, "linear", 0, "flipRow"]);
			to([424, 4, "linear", 100, "flipRow"]);
			to([428, 4, "linear", 0, "flipRow"]);
			to([432, 2, "linear", 100, "flipRow"]);
			to([434, 2, "linear", 0, "flipRow"]);
			to([436, 2, "linear", 100, "flipRow"]);
			to([438, 2, "linear", 0, "flipRow"]);
		});

		layer("fieldY", function()
		{
			to([391, 2, "inoutcubic", 538.4615, "fieldY"]);
			to([399, 2, "inoutcubic", 0, "fieldY"]);
			to([407, 2, "inoutcubic", 269.2308, "fieldY"]);
			to([415, 2, "inoutcubic", 0, "fieldY"]);
		});

		layer("mirror", function()
		{
			to([391, 2, "inoutcubic", 100, "mirror"]);
			to([399, 2, "inoutcubic", 0, "mirror"]);
		});

		layer("stamp0", function()
		{
			to([384, 1, "outcubic", 0, "stamp0"]);
		});

		layer("stamp1", function()
		{
			to([384, 1, "outcubic", 0, "stamp1"]);
		});

		layer("stamp2", function()
		{
			to([384, 1, "outcubic", 0, "stamp2"]);
		});

		layer("stamp3", function()
		{
			to([384, 1, "outcubic", 0, "stamp3"]);
		});

		layer("drunk", function()
		{
			to([440, 0.25, "outcubic", -100, "drunk"], {from: 100});
			to([440.25, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([440.5, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([440.75, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([441, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([441.25, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([441.5, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([441.75, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([442, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([442.25, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([442.5, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([442.75, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([443, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([443.25, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([443.5, 0.25, "outcubic", -100, "drunk"], {from: 0});
			to([443.75, 0.25, "outcubic", 100, "drunk"], {from: 0});
			to([444, 0.25, "outcubic", 0, "drunk"], {from: 0});
			to([444.25, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([444.5, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([444.75, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([445, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([445.25, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([445.5, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([445.75, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([446, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([446.25, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([446.5, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([446.75, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([447, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([447.25, 0.25, "outcubic", 200, "drunk"], {from: 0});
			to([447.5, 0.25, "outcubic", -200, "drunk"], {from: 0});
			to([447.75, 0.25, "outcubic", 200, "drunk"], {from: 0});
		});

		layer("drunk 2", function()
		{
			to([444, 0.25, "outcubic", -200, "drunk"], {from: 200});
		});

		layer("addDrunk", function()
		{
			to([416, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([416.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([417.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([418.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([420, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([420.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([421.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([422.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([424, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([424.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([425.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([426.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([428, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([428.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([429.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([430.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([432, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([433, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([434, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([435, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([436, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([437, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([438, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
			to([439, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -200});
		});

		layer("addDrunk 2", function()
		{
			to([416, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([416.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([417.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([418.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([420, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([420.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([421.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([422.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([424, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([424.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([425.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([426.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([428, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([428.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([429.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([430.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([432, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([433, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([434, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([435, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([436, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([437, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([438, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
			to([439, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 200});
		});

		layer("addDrunk 3", function()
		{
			to([432.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([433.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([434.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([435.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([436.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([437.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([438.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
			to([439.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 200});
		});

		layer("addDrunk 4", function()
		{
			to([432.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([433.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([434.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([435.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([436.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([437.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([438.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
			to([439.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -200});
		});

		layer("addTipsy", function()
		{
			to([419, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
			to([423, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
			to([427, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
			to([431, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -200});
		});

		layer("addTipsy 2", function()
		{
			to([419, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
			to([423, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
			to([427, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
			to([431, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 200});
		});

		layer("addTipsy 3", function()
		{
			to([419.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
			to([423.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
			to([427.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
			to([431.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 200});
		});

		layer("addTipsy 4", function()
		{
			to([419.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
			to([423.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
			to([427.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
			to([431.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -200});
		});

		layer("faceZ", function()
		{
			to([391, 2, "inoutcubic", -180, "faceZ"]);
			to([399, 2, "inoutcubic", 0, "faceZ"]);
			to([407, 2, "inoutcubic", 90, "faceZ"]);
			to([415, 2, "inoutcubic", 0, "faceZ"]);
		});

		layer("tiltZ", function()
		{
			to([391, 2, "inoutcubic", 180, "tiltZ"]);
			to([399, 2, "inoutcubic", 0, "tiltZ"]);
			to([407, 2, "inoutcubic", -90, "tiltZ"]);
			to([415, 2, "inoutcubic", 0, "tiltZ"]);
		});

		layer("camwagBy", function()
		{
			jump([384, 8, "camwagBy"]);
			to([414, 2, "linear", 0, "camwagBy"]);
		});

		layer("camRock", function()
		{
			every([384, 32, "camRock", [384]]);
		});

		// -- wrapping @ 448 --
		layer("alpha", function()
		{
			jump([448, 40, "alpha"], {plr: 0});
			to([448, 2, "linear", 30, "alpha"], {plr: 0});
			to([475, 2, "linear", 100, "alpha"], {plr: 0});
		});

		layer("rowCenterX", function()
		{
			jump([448, 0, "rowCenterX"]);
		});

		layer("flipRow", function()
		{
			to([451, 2, "inoutcubic", 100, "flipRow"]);
			to([455, 2, "inoutcubic", 0, "flipRow"]);
			to([459, 2, "inoutcubic", 100, "flipRow"]);
			to([463, 2, "inoutcubic", 0, "flipRow"]);
			to([465.5, 1, "inoutcubic", 100, "flipRow"]);
			to([467.5, 1, "inoutcubic", 0, "flipRow"]);
			to([469.5, 1, "inoutcubic", 100, "flipRow"]);
			to([471.5, 1, "inoutcubic", 0, "flipRow"]);
		});

		layer("shiftX", function()
		{
			jump([476, 323.0769, "shiftX"], {plr: 0});
			jump([476, -323.0769, "shiftX"], {plr: 1});
		});

		layer("mirror", function()
		{
			to([472, 4, "inexpo", 50, "mirror"]);
		});

		layer("colspacing", function()
		{
			to([448, 4, "outcubic", 185.875, "colspacing"], {from: 112});
			to([472, 4, "incubic", 112, "colspacing"]);
		});

		layer("spacing", function()
		{
			to([448, 4, "outcubic", 743.5, "spacing"], {from: 0});
			to([472, 4, "incubic", 0, "spacing"]);
		});

		layer("addx", function()
		{
			to([448, 4, "outcubic", -224.9, "addx"], {from: 336});
			to([472, 4, "incubic", -336, "addx"]);
		});

		layer("waveamp", function()
		{
			to([448, 8, "inoutcubic", 100, "waveamp"]);
			to([472, 4, "incubic", 0, "waveamp"]);
		});

		layer("drunk", function()
		{
			to([448, 0.25, "outcubic", 0, "drunk"], {from: 0});
		});

		layer("halo", function()
		{
			every([476, 12, "halo", [476]]);
		});

		layer("halo 2", function()
		{
			to([476, 8, "outexpo", 100, "halo"]);
		});

		layer("wrap", function()
		{
			every([448, 28, "wrap", [448]]);
		});

		// -- halo @ 476 --
		layer("rowY", function()
		{
			to([484, 4, "incubic", 721.1538, "rowY"]);
		});

		layer("laneY", function()
		{
			to([484, 4, "incubic", 721.1538, "laneY"]);
		});

		layer("slide3", function()
		{
			to([488, 1, "outcubic", 0, "slide3"]);
		});

		layer("lift1", function()
		{
			to([488, 1, "outcubic", 0, "lift1"]);
		});

		layer("lift2", function()
		{
			to([488, 1, "outcubic", 0, "lift2"]);
		});

		layer("lift3", function()
		{
			to([488, 1, "outcubic", 0, "lift3"]);
		});
	}
    function speed():Void
    {
        var self = this;

        layer("rate", function()
        {
            self.to([93, 3, self.linear, self.xmod(1.6), "rate"]);
            self.to([157, 3, self.inOutCubic, self.xmod(1.4), "rate"]);
            self.to([317, 3, self.linear, self.xmod(1.7), "rate"]);
            self.to([381, 3, self.inOutCubic, self.xmod(1.4), "rate"]);
            self.to([415, 2, self.inOutCubic, self.xmod(1.7), "rate"]);
        });
    }

    function beating():Void
    {
        var self = this;

        layer("beat", function()
        {
            self.jump([91.5, 300, "beat"]);
            self.jump([95.5, 0, "beat"]);

            self.jump([159.7, 200, "beat"]);
            self.jump([207.3, 0, "beat"]);

            self.jump([315.5, 300, "beat"]);
            self.jump([319.5, 0, "beat"]);

            self.jump([383.7, 200, "beat"]);
            self.jump([415.3, 0, "beat"]);
        });
    }

    function opacity():Void
    {
        var self = this;

        layer("alpha", function()
        {
            self.to([62, 4, self.inOutCubic, 40, "alpha"], self.only(0));
            self.to([94, 4, self.inOutCubic, 100, "alpha"], self.only(0));

            self.to([158, 4, self.inOutCubic, 20, "alpha"], self.only(0));
            self.to([206, 4, self.inOutCubic, 50, "alpha"], self.only(0));
            self.to([219, 2, self.inOutCubic, 100, "alpha"], self.only(0));
            self.to([223, 2, self.inOutCubic, 50, "alpha"], self.only(0));

            self.to([216, 4, self.linear, 0, "alpha"], self.only(1));
            self.jump([224, 100, "alpha"], self.only(1));

            self.jump([224, 30, "alpha"], self.only(0));

            self.to([318, 2, self.linear, 100, "alpha"], self.only(0));
            self.to([351, 2, self.linear, 50, "alpha"], self.only(0));

            self.to([382, 4, self.inOutCubic, 25, "alpha"], self.only(0));
            self.to([414, 4, self.inOutCubic, 45, "alpha"], self.only(0));
            self.to([436, 8, self.linear, 0, "alpha"], self.only(0));

            self.to([448, 2, self.linear, 30, "alpha"], self.only(0));
            self.jump([448, 40, "alpha"], self.only(0));

            self.to([475, 2, self.linear, 100, "alpha"], self.only(0));
        });
    }

    function centering():Void
    {
        var self = this;

        layer("center", function()
        {
            self.to([158, 4, self.inOutCubic, 100, "rowCenterX"]);
            self.to([206, 2, self.inCubic, 0, "rowCenterX"]);
            self.to([208, 12, self.linear, 100, "rowCenterX"]);

            self.jump([224, 100, "rowCenterX"]);
            self.to([284, 4, self.inCubic, 0, "rowCenterX"]);

            var i:Float = 352;
            while (i <= 383)
            {
                self.to([i + 1, 1, self.inOutExpo, 100, "rowCenterX"]);
                if (i != 380) self.to([i + 2.5, 1, self.inOutExpo, 0, "rowCenterX"]);
                i += 4;
            }

            self.jump([384, 100, "rowCenterX"]);
            self.to([414, 2, self.inCubic, 0, "rowCenterX"]);
            self.to([428, 12, self.linear, 100, "rowCenterX"]);

            self.jump([448, 0, "rowCenterX"]);
            self.jump([476, 100, "rowCenterX"]);
        });
    }

    function intro():Void
    {
        var self = this;

        layer("intro 0", function()
        {
            self.to([0, 4, self.outCubic, 200, "tipsy"], self.only(0));
            self.to([12, 4, self.inCubic, 100, "tipsy"], self.only(0));
            self.to([16, 4, self.outCubic, 100, "tipsy"], self.only(1));
            self.to([28, 4, self.inCubic, 0, "tipsy"]);
        });
    }

    function swayOne():Void
    {
        var self = this;

        layer("sway 32", function()
        {
            self.every([32, 32, "sway", [48, false]]);
            self.walkHome(64, ["shiftX", "shiftY"]);

            self.spins(32, 63, 48, false);
        });
    }

    function wrapOne():Void
    {
        var self = this;

        layer("wrap 64", function()
        {
            self.openWrap(64);
            self.closeWrap(92);

            self.every([64, 31, "wrap", [64]]);
            self.walkHome(95, ["shiftX", "flipRow"]);
        });
    }

    function stepOne():Void
    {
        var self = this;

        layer("step 96", function()
        {
            self.layer("hides 96", function()
            {
                self.hideRow(95, 1);
                self.showRow(112, 1);
                self.hideRow(112, 0);
                self.showRow(128, 0);
                self.hideRow(128, 1);
                self.showRow(144, 1);
                self.hideRow(144, 0);
                self.showRow(160, 0);
            });

            self.to([92, 3, self.linear, 50 * self.PX, "shiftY"]);

            self.to([96, 3, self.linear, -10, "mirror"]);
            self.to([124, 4, self.inCubic, 0, "mirror"]);

            self.crossRows(96);

            self.every([96, 64, "step", [96]]);
            self.walkHome(160, ["rowY", "laneY"]);
        });
    }

    function dropOne():Void
    {
        var self = this;

        layer("drop 160", function()
        {
            self.layer("kicks 208", function()
            {
                self.kicks([
                    208, 0, 208.75, 0, 209.5, 0, 210.25, 0, 211, 3, 211.5, 3,
                    212, 0, 212.75, 0, 213.5, 0, 214.25, 0, 215, 3, 215.5, 3,
                    216, 0, 216.75, 0, 217.5, 0, 218.25, 0, 219, 3, 219.5, 3
                ], 200);
            });

            var drop:Float = 1.7 * self.LANE * self.PX;
            var i:Float = 160;
            while (i < 208)
            {
                self.to([i, 1, self.linear, drop, "rowY", drop, "laneY"], {from: 0});
                i += 1;
            }
            self.jump([208, 0, "rowY", 0, "laneY"]);

            self.layer("turns 174", function()
            {
                self.turnOver(174, 4, 180, -560);
                self.turnOver(190, 4, 90, -280);
                self.turnOver(206, 4, 0, 0);

                self.to([174, 4, self.inOutCubic, -180, "faceZ"]);
                self.to([190, 4, self.inOutCubic, -90, "faceZ"]);
                self.to([206, 4, self.inOutCubic, 0, "faceZ"]);

                self.to([174, 4, self.inOutCubic, 100, "mirror"]);
                self.to([190, 4, self.inOutCubic, 0, "mirror"]);
            });

            self.wig(220, 16, 4, self.outCubic, 100, "drunk", 0);

            self.jump([224, 0, "blind"], self.only(1));
            self.jump([224, 100, "dim"], self.only(1));
            self.to([234, 3, self.linear, 0, "dim"], self.only(1));
        });
    }

    function turnOver(at:Float, len:Float, degrees:Float, camY:Float):Void
    {
        to([at, len, inOutCubic, degrees, "tiltZ"]);
        to([at, len, inOutCubic, -camY * PX, "fieldY"]);
    }

    function veiled():Void
    {
        var self = this;

        layer("veil 224", function()
        {

            self.to([224, 28, self.linear, 300, "swell"]);
            self.to([224, 8, self.linear, 100, "fadeNear"]);

            self.jump([224, self.hiddenAt(50), "fadeNear.offset"]);
            self.to([240, 12, self.linear, self.hiddenAt(400), "fadeNear.offset"]);

            self.to([252, 8, self.inOutCubic, 200, "swell"]);
            self.to([252, 8, self.inOutCubic, 50, "drunk"]);
            self.to([252, 8, self.inOutCubic, self.hiddenAt(200), "fadeNear.offset"]);

            self.every([256, 28, "sway", [0, true]]);
            self.walkHome(284, ["shiftX", "shiftY"]);

            self.to([280, 8, self.inOutCubic, 0, "swell"]);
            self.to([280, 8, self.inOutCubic, 0, "drunk"]);
            self.to([276, 8, self.inOutCubic, 0, "fadeNear"]);
            self.jump([288, 0, "fadeNear.offset"]);

            self.spins(256, 283, 0, true);
        });
    }

    function wrapTwo():Void
    {
        var self = this;

        layer("wrap 288", function()
        {
            self.openWrap(288);
            self.closeWrap(316);

            self.every([288, 32, "wrap", [288]]);
            self.walkHome(320, ["shiftX", "flipRow"]);
        });
    }

    function stepTwo():Void
    {
        var self = this;

        layer("step 320", function()
        {
            self.layer("hides 320", function()
            {
                self.hideRow(319, 1);
                self.showRow(336, 1);
                self.hideRow(336, 0);
                self.showRow(352, 0);
            });

            self.to([316, 3, self.linear, 50 * self.PX, "shiftY"]);

            self.to([320, 3, self.linear, -10, "mirror"]);
            self.to([348, 4, self.inCubic, 0, "mirror"]);

            self.crossRows(320);

            self.every([320, 64, "step", [320]]);
            self.walkHome(384, ["rowY", "laneY"]);

            var i:Float = 320;
            while (i <= 351)
            {
                var pn:Int = (self.fmod(i - 320, 32) < 16) ? 0 : 1;
                self.to([i + 3, 2, self.inOutExpo, 100, "flipRow"], self.only(pn));
                self.to([i + 7, 2, self.inOutExpo, 0, "flipRow"], self.only(pn));
                i += 8;
            }
        });
    }

    function stabs():Void
    {
        var self = this;

        layer("stabs 352", function()
        {
            var i:Float = 352;
            while (i <= 383)
            {

                self.sm2(i, 2, self.outCubic, 200, "drunk", -1, 0.1);
                self.sm2(i, 2, self.outCubic, 100, "drag", -1, 0.1);

                if (i != 380)
                {

                    self.to([i + 1, 1, self.inOutCubic, 100, "fold"]);
                    self.to([i + 2.5, 1, self.inOutCubic, 0, "fold"]);

                    for (c in 0...COLS)
                    {
                        var mu:Float = (c % 2 == 0) ? 1 : -1;
                        self.to([i + 1, 0.5, self.outCubic, 10 * mu, "flipRow" + c]);
                        self.to([i + 1.5, 0.5, self.inCubic, 0, "flipRow" + c]);
                        self.to([i + 2.5, 0.5, self.outCubic, -10 * mu, "flipRow" + c]);
                        self.to([i + 3, 0.5, self.inCubic, 0, "flipRow" + c]);
                    }
                }

                i += 4;
            }
        });
    }

    function dropTwo():Void
    {
        var self = this;

        layer("drop 384", function()
        {
            var drop:Float = 1.7 * self.LANE * self.PX;
            var i:Float = 384;
            while (i < 416)
            {
                self.to([i, 1, self.linear, drop, "rowY", drop, "laneY"], {from: 0});
                i += 1;
            }
            self.jump([416, 0, "rowY", 0, "laneY"]);

            self.jump([384, 8, "camwagBy"]);
            self.to([414, 2, self.linear, 0, "camwagBy"]);
            self.every([384, 32, "camRock", [384]]);

            self.layer("turns 391", function()
            {
                self.turnOver(391, 2, 180, -560);
                self.turnOver(399, 2, 0, 0);
                self.turnOver(407, 2, -90, -280);
                self.turnOver(415, 2, 0, 0);

                self.to([391, 2, self.inOutCubic, -180, "faceZ"]);
                self.to([399, 2, self.inOutCubic, 0, "faceZ"]);
                self.to([407, 2, self.inOutCubic, 90, "faceZ"]);
                self.to([415, 2, self.inOutCubic, 0, "faceZ"]);

                self.to([391, 2, self.inOutCubic, 100, "mirror"]);
                self.to([399, 2, self.inOutCubic, 0, "mirror"]);
            });

            self.wig(440, 16, 4, self.outCubic, 100, "drunk", -1);
            self.wig(444, 16, 4, self.outCubic, 200, "drunk", -1);

            for (n in 0...2)
            {
                self.to([416 + 8 * n, 4, self.linear, 100, "flipRow"]);
                self.to([420 + 8 * n, 4, self.linear, 0, "flipRow"]);
                self.to([432 + 4 * n, 2, self.linear, 100, "flipRow"]);
                self.to([434 + 4 * n, 2, self.linear, 0, "flipRow"]);
            }

            self.layer("kicks 416", function()
            {
                self.kicks([
                416, 0, 416.75, 0, 417.5, 0, 418.25, 0, 419, 3, 419.5, 3,
                420, 0, 420.75, 0, 421.5, 0, 422.25, 0, 423, 3, 423.5, 3,
                424, 0, 424.75, 0, 425.5, 0, 426.25, 0, 427, 3, 427.5, 3,
                428, 0, 428.75, 0, 429.5, 0, 430.25, 0, 431, 3, 431.5, 3,
                432, 0, 432.5, 0, 433, 0, 433.5, 0, 434, 0, 434.5, 0,
                435, 0, 435.5, 0, 436, 0, 436.5, 0, 437, 0, 437.5, 0,
                438, 0, 438.5, 0, 439, 0, 439.5, 0
                ], 200);
            });
        });
    }

    function wrapThree():Void
    {
        var self = this;

        layer("wrap 448", function()
        {
            self.to([472, 4, self.inExpo, 50, "mirror"]);

            self.to([448, 4, self.outCubic, self.WRAP_STEP, "colspacing"], {from: self.LANE});
            self.to([448, 4, self.outCubic, self.WRAP_SPREAD, "spacing"], {from: 0});
            self.to([448, 4, self.outCubic, -(self.BASEX + self.WRAP_EDGE), "addx"], {from: self.GAP / 2});
            self.to([448, 8, self.inOutCubic, 100, "waveamp"]);

            self.to([472, 4, self.inCubic, self.LANE, "colspacing"]);
            self.to([472, 4, self.inCubic, 0, "spacing"]);
            self.to([472, 4, self.inCubic, -self.GAP / 2, "addx"]);
            self.to([472, 4, self.inCubic, 0, "waveamp"]);

            self.every([448, 28, "wrap", [448]]);
            self.walkHome(476, ["shiftX", "flipRow"]);

            var i:Float = 448;
            while (i <= 463)
            {
                self.to([i + 3, 2, self.inOutCubic, 100, "flipRow"]);
                self.to([i + 7, 2, self.inOutCubic, 0, "flipRow"]);
                i += 8;
            }

            i = 464;
            while (i <= 471)
            {
                self.to([i + 1.5, 1, self.inOutCubic, 100, "flipRow"]);
                self.to([i + 3.5, 1, self.inOutCubic, 0, "flipRow"]);
                i += 4;
            }
        });
    }

    function halo():Void
    {
        var self = this;

        layer("halo 476", function()
        {
            self.to([476, 8, self.outExpo, 100, "halo"]);

            self.every([476, 12, "halo", [476]]);
            self.walkHome(488, ["shiftX", "shiftY"]);

            var fall:Float = 750 * self.PX;
            self.to([484, 4, self.inCubic, fall, "rowY", fall, "laneY"]);
        });
    }

    function openWrap(atBeat:Float):Void
    {
        to([atBeat, 8, inOutCubic, WRAP_STEP, "colspacing"]);
        to([atBeat, 8, inOutCubic, WRAP_SPREAD, "spacing"]);
        to([atBeat, 8, inOutCubic, -(BASEX + WRAP_EDGE), "addx"]);
        to([atBeat, 8, inOutCubic, 100, "waveamp"]);
    }

    function closeWrap(atBeat:Float):Void
    {
        to([atBeat, 4, inCubic, LANE, "colspacing"]);
        to([atBeat, 4, inCubic, GAP, "spacing"]);
        to([atBeat, 4, inCubic, 0, "addx"]);
        to([atBeat, 4, inCubic, 0, "waveamp"]);
    }
}
