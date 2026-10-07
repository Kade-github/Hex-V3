// exported by mod-ed

package kade.hex.modchart.charts;

import Math;
import flixel.FlxG;
import funkin.play.PlayState;
import funkin.play.notes.Strumline;
import kade.hex.chart.Chart;
import kade.hex.songs.DetectedMoves;

class DetectedModchartNormal extends Chart
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
        super("detected_modchart_normal", 100);
    }

    override function setup():Void
    {
		virtual("alpha");
		virtual("colspacing");
		virtual("spacing");
		virtual("addx");
		virtual("waveamp");
		virtual("halo");
		virtual("easydrunk");
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
		base([0, "easydrunk"]);
		base([672, "spacing"]);
		base([112, "colspacing"]);
		virtual("alpha");
		virtual("colspacing");
		virtual("spacing");
		virtual("addx");
		virtual("waveamp");
		virtual("halo");
		virtual("easydrunk");
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
		base([0, "easydrunk"]);
		base([672, "spacing"]);
		base([112, "colspacing"]);
        quantSkin("gameplay/hex/me-quant-notes");

        chartSpeed = scrollSpeed();
        readLanes();

        nf.field.hudFollowsRow = false;

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

        hook("sway", function(b:Float, args:Array<Dynamic>) { DetectedMoves.sway(b, args[0], args[1] == true, args.length > 2 && args[2] == true); });
        hook("wrap", function(b:Float, args:Array<Dynamic>) { DetectedMoves.wrap(b, args[0]); });
        hook("step", function(b:Float, args:Array<Dynamic>) { DetectedMoves.step(b, args[0], args.length > 1 && args[1] == true, args.length > 2 && args[2] == true); });
        hook("easyDrunk", function(b:Float, args:Array<Dynamic>) { DetectedMoves.easyDrunk(b); });
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

            to([at - 1, 0.5, outExpo, -70 * PX, "lift" + i], only(pn));
            to([at - 0.5, 1.25, inExpo, 650 * PX, "lift" + i], only(pn));

            jump([at + 1.75, 100, "blind", 100, "dim"], only(pn));
        }
    }

    function showRow(bt:Float, pn:Int):Void
    {
        for (i in 0...COLS)
        {
            var at:Float = bt + i * 0.125;

            jump([at - 2, 0, "blind", 0, "dim"], only(pn));

            to([at - 2, 1, outExpo, -70 * PX, "lift" + i], only(pn));
            to([at - 1, 1, inExpo, 50 * PX, "lift" + i], only(pn));
            to([at, 1.25, outElastic, 0, "lift" + i], only(pn));
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

    function kicks(list:Array<Float>, amount:Float, withBrake:Bool):Void
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
                    if (withBrake) to([at, 0.75, outCubic, 0, "drag"], {plr: [pn], from: 50});
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
            for (pn in 0...2)
            {
                if (!both && pn != ((i >= swapAt) ? 1 : 0)) continue;

                to([i, 1.5, outCubic, 0, "faceZ"], {plr: [pn], from: 360 * f});
                jump([i + 1.5, 400 * f, "beat"], only(pn));
                jump([i + 2.5, 0, "beat"], only(pn));
            }

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
        }
    }

    function easyDrunkRun(base:Float, second:Float):Void
    {
        to([base, 2, outCubic, 200, "easydrunk"], only(0));
        to([base + 7, 2, inOutCubic, 0, "easydrunk"], only(0));
        to([base + 8, 2, outCubic, second, "easydrunk"], only(1));
        to([base + 15, 2, inOutCubic, 0, "easydrunk"], only(1));

        to([base + 16, 1, outCubic, 200, "easydrunk"], only(0));
        to([base + 17, 2, inOutCubic, 0, "easydrunk"], only(0));
        to([base + 18, 1, outCubic, second, "easydrunk"], only(1));
        to([base + 19, 2, inOutCubic, 0, "easydrunk"], only(1));
        to([base + 20, 1, outCubic, 200, "easydrunk"], only(0));
        to([base + 21, 2, inOutCubic, 0, "easydrunk"], only(0));
        to([base + 22, 1, outCubic, second, "easydrunk"], only(1));
        to([base + 23, 2, inOutCubic, (second == 100) ? 150 : 200, "easydrunk"], only(1));
        to([base + 24, 2, outCubic, 200, "easydrunk"], only(0));

        to([base + 26, 2, inCubic, 0, "easydrunk"]);

        every([base, 28, "easyDrunk", []]);
        walkHome(base + 28, ["slide"]);
    }

    function dropBeats(fromBeat:Float, toBeat:Float, period:Float, resetBoth:Bool):Void
    {
        var drop:Float = 1.7 * LANE * PX;
        var i:Float = fromBeat;

        while (i < toBeat)
        {
            var pp:Int = (fmod(i - fromBeat, period) >= period / 2) ? 1 : 0;

            to([i, 1, linear, drop, "rowY", drop, "laneY"], {plr: [pp], from: 0});
            jump([i + 0.99, 0, "rowY", 0, "laneY"], resetBoth ? null : only(pp));

            i += 1;
        }
    }

    function drunkPulse(at:Float, back:Float, pn:Int):Void
    {
        to([at, 1, outCubic, 100, "drunk"], only(pn));
        to([at + back, 1, inOutCubic, 0, "drunk"], only(pn));
    }
	override function build():Void
	{
		layer("sway 32", function()
		{
			jump([0, 125, "rate"]);
			every([32, 32, "sway", [48, false, true]]);
			to([32, 1.5, "outcubic", 0, "faceZ"], {plr: 0, from: 360});
			jump([33.5, 400, "beat"], {plr: 0});
			jump([34.5, 0, "beat"], {plr: 0});
			to([36, 1.5, "outcubic", 0, "faceZ"], {plr: 0, from: -360});
			jump([37.5, -400, "beat"], {plr: 0});
			jump([38.5, 0, "beat"], {plr: 0});
			to([40, 1.5, "outcubic", 0, "faceZ"], {plr: 0, from: 360});
			jump([41.5, 400, "beat"], {plr: 0});
			jump([42.5, 0, "beat"], {plr: 0});
			to([44, 1.5, "outcubic", 0, "faceZ"], {plr: 0, from: -360});
			jump([45.5, -400, "beat"], {plr: 0});
			jump([46.5, 0, "beat"], {plr: 0});
			to([48, 1.5, "outcubic", 0, "faceZ"], {plr: 1, from: 360});
			jump([49.5, 400, "beat"], {plr: 1});
			jump([50.5, 0, "beat"], {plr: 1});
			to([52, 1.5, "outcubic", 0, "faceZ"], {plr: 1, from: -360});
			jump([53.5, -400, "beat"], {plr: 1});
			jump([54.5, 0, "beat"], {plr: 1});
			to([56, 1.5, "outcubic", 0, "faceZ"], {plr: 1, from: 360});
			jump([57.5, 400, "beat"], {plr: 1});
			jump([58.5, 0, "beat"], {plr: 1});
			to([60, 1.5, "outcubic", 0, "faceZ"], {plr: 1, from: -360});
			jump([61.5, -400, "beat"], {plr: 1});
			jump([62.5, 0, "beat"], {plr: 1});
			to([208, 1, "linear", 50, "alpha"], {plr: 0});
			to([219, 1, "linear", 100, "alpha"], {plr: 0});
		});

		layer("lanes 64", function()
		{
			every([64, 28, "easyDrunk", []]);
			to([64, 2, "outcubic", 200, "easydrunk"], {plr: 0});
			to([71, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([72, 2, "outcubic", 100, "easydrunk"], {plr: 1});
			to([79, 2, "inoutcubic", 0, "easydrunk"], {plr: 1});
			to([80, 1, "outcubic", 200, "easydrunk"], {plr: 0});
			to([81, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([82, 1, "outcubic", 100, "easydrunk"], {plr: 1});
			to([83, 2, "inoutcubic", 0, "easydrunk"], {plr: 1});
			to([84, 1, "outcubic", 200, "easydrunk"], {plr: 0});
			to([85, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([86, 1, "outcubic", 100, "easydrunk"], {plr: 1});
			to([87, 2, "inoutcubic", 150, "easydrunk"], {plr: 1});
			to([88, 2, "outcubic", 200, "easydrunk"], {plr: 0});
			to([90, 2, "incubic", 0, "easydrunk"]);
			to([92, 1, "outcubic", 0, "slide0", 0, "slide1", 0, "slide2", 0, "slide3"]);
			to([219, 1, "linear", 0, "alpha"], {plr: 1});
			every([256, 28, "sway", [0, true, true]]);
		});

		layer("step 96", function()
		{
			to([92, 3, "linear", 48.0769, "shiftY"]);
			every([96, 64, "step", [96, true, false]]);
			to([96, 3, "linear", -10, "mirror"], {plr: 0});
			to([96, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([100, 4, "linear", 0, "shiftX"], {plr: 0});
			to([104, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([108, 4, "linear", 0, "shiftX"], {plr: 0});
			to([124, 4, "incubic", 0, "shiftY"]);
			to([124, 4, "incubic", 0, "mirror"], {plr: 0});
			to([160, 1, "outcubic", 0, "stamp0", 0, "stamp1", 0, "stamp2", 0, "stamp3"]);
			to([256, 1.5, "outcubic", 0, "faceZ"], {from: 360});
		});

		layer("veil 224", function()
		{
			jump([224, -79.1406, "fadeNear.offset"]);
			to([224, 8, "linear", 20, "fadeNear"]);
			to([240, 12, "linear", 1, "fadeNear.offset"]);
			to([252, 8, "inoutcubic", 50, "drunk", -58.2812, "fadeNear.offset"]);
			jump([257.5, 400, "beat"]);
			jump([258.5, 0, "beat"]);
			to([260, 1.5, "outcubic", 0, "faceZ"], {from: -360});
			jump([261.5, -400, "beat"]);
			jump([262.5, 0, "beat"]);
			to([264, 1.5, "outcubic", 0, "faceZ"], {from: 360});
			jump([265.5, 400, "beat"]);
			jump([266.5, 0, "beat"]);
			to([268, 1.5, "outcubic", 0, "faceZ"], {from: -360});
			jump([269.5, -400, "beat"]);
			jump([270.5, 0, "beat"]);
			to([272, 1.5, "outcubic", 0, "faceZ"], {from: 360});
			jump([273.5, 400, "beat"]);
			jump([274.5, 0, "beat"]);
			to([276, 1.5, "outcubic", 0, "faceZ"], {from: -360});
			jump([277.5, -400, "beat"]);
			jump([278.5, 0, "beat"]);
			to([280, 8, "inoutcubic", 0, "drunk"]);
			to([280, 1.5, "outcubic", 0, "faceZ"], {from: 360});
			jump([281.5, 400, "beat"]);
			jump([282.5, 0, "beat"]);
			to([284, 1, "outcubic", 0, "slide0", 0, "slide1", 0, "slide2", 0, "slide3"]);
			jump([288, 0, "fadeNear.offset"]);
		});

		layer("lanes 288", function()
		{
			to([276, 8, "inoutcubic", 0, "fadeNear"]);
			every([288, 28, "easyDrunk", []]);
			to([288, 2, "outcubic", 200, "easydrunk"], {plr: 0});
			to([295, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([296, 2, "outcubic", 150, "easydrunk"], {plr: 1});
			to([303, 2, "inoutcubic", 0, "easydrunk"], {plr: 1});
			to([304, 1, "outcubic", 200, "easydrunk"], {plr: 0});
			to([305, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([306, 1, "outcubic", 150, "easydrunk"], {plr: 1});
			to([307, 2, "inoutcubic", 0, "easydrunk"], {plr: 1});
			to([308, 1, "outcubic", 200, "easydrunk"], {plr: 0});
			to([309, 2, "inoutcubic", 0, "easydrunk"], {plr: 0});
			to([310, 1, "outcubic", 150, "easydrunk"], {plr: 1});
			to([311, 2, "inoutcubic", 200, "easydrunk"], {plr: 1});
			to([312, 2, "outcubic", 200, "easydrunk"], {plr: 0});
			to([314, 2, "incubic", 0, "easydrunk"]);
			to([316, 1, "outcubic", 0, "slide0", 0, "slide1", 0, "slide2", 0, "slide3"]);
		});

		layer("step 320", function()
		{
			to([316, 3, "linear", 48.0769, "shiftY"]);
			every([320, 32, "step", [320, true, true]]);
			to([320, 3, "linear", -10, "mirror"], {plr: 0});
			to([320, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([324, 4, "linear", 0, "shiftX"], {plr: 0});
			to([328, 4, "linear", 516.9231, "shiftX"], {plr: 0});
			to([332, 4, "linear", 0, "shiftX"], {plr: 0});
			to([348, 4, "incubic", 0, "shiftY"]);
			to([348, 4, "incubic", 0, "mirror"], {plr: 0});
			to([352, 1, "outcubic", 0, "stamp0", 0, "stamp1", 0, "stamp2", 0, "stamp3"]);
		});

		layer("drop 384", function()
		{
			jump([384, 4, "camwagBy"]);
			every([384, 32, "camRock", [384]]);
			to([384, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([384.99, 0, "rowY", 0, "laneY"]);
			to([385, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([385.99, 0, "rowY", 0, "laneY"]);
			to([386, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([386.99, 0, "rowY", 0, "laneY"]);
			to([387, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([387.99, 0, "rowY", 0, "laneY"]);
			to([388, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([388.99, 0, "rowY", 0, "laneY"]);
			to([389, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([389.99, 0, "rowY", 0, "laneY"]);
			to([390, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([390.99, 0, "rowY", 0, "laneY"]);
			to([391, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([391.99, 0, "rowY", 0, "laneY"]);
			to([392, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([392.99, 0, "rowY", 0, "laneY"]);
			to([393, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([393.99, 0, "rowY", 0, "laneY"]);
			to([394, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([394.99, 0, "rowY", 0, "laneY"]);
			to([395, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([395.99, 0, "rowY", 0, "laneY"]);
			to([396, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([396.99, 0, "rowY", 0, "laneY"]);
			to([397, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([397.99, 0, "rowY", 0, "laneY"]);
			to([398, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([398.99, 0, "rowY", 0, "laneY"]);
			to([399, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([399.99, 0, "rowY", 0, "laneY"]);
			to([400, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([400.99, 0, "rowY", 0, "laneY"]);
			to([401, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([401.99, 0, "rowY", 0, "laneY"]);
			to([402, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([402.99, 0, "rowY", 0, "laneY"]);
			to([403, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([403.99, 0, "rowY", 0, "laneY"]);
			to([404, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([404.99, 0, "rowY", 0, "laneY"]);
			to([405, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([405.99, 0, "rowY", 0, "laneY"]);
			to([406, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([406.99, 0, "rowY", 0, "laneY"]);
			to([407, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([407.99, 0, "rowY", 0, "laneY"]);
			to([408, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([408.99, 0, "rowY", 0, "laneY"]);
			to([409, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([409.99, 0, "rowY", 0, "laneY"]);
			to([410, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([410.99, 0, "rowY", 0, "laneY"]);
			to([411, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([411.99, 0, "rowY", 0, "laneY"]);
			to([412, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([412.99, 0, "rowY", 0, "laneY"]);
			to([413, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([413.99, 0, "rowY", 0, "laneY"]);
			to([414, 2, "linear", 0, "camwagBy"]);
			to([414, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([414.99, 0, "rowY", 0, "laneY"]);
			to([415, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([415.99, 0, "rowY", 0, "laneY"]);
			to([444, 0.25, "outcubic", -200, "drunk"], {from: 200});
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
			to([448, 0.25, "outcubic", 0, "drunk"], {from: 0});
			to([472, 4, "incubic", 50, "mirror"]);
		});

		layer("halo 476", function()
		{
			every([476, 12, "halo", [476]]);
			to([476, 8, "outexpo", 100, "halo"]);
			to([484, 4, "incubic", 721.1538, "rowY", 721.1538, "laneY"]);
			to([488, 1, "outcubic", 0, "slide0", 0, "slide1", 0, "slide2", 0, "slide3", 0, "lift0", 0, "lift1", 0, "lift2", 0, "lift3"]);
		});

		layer("rate", function()
		{
			jump([0, 100, "rate"]);
			to([93, 3, "linear", 88.8889, "rate"]);
			to([157, 3, "inoutcubic", 77.7778, "rate"]);
			to([317, 3, "linear", 94.4444, "rate"]);
			to([381, 3, "inoutcubic", 77.7778, "rate"]);
		});

		layer("drawAhead", function()
		{
			jump([0, 600, "drawAhead", 25, "drawAhead.fade"]);
			to([157, 1, "linear", 700, "drawAhead"]);
			to([207, 1, "linear", 400, "drawAhead"]);
			jump([224, 650, "drawAhead", 0, "drawAhead.fade"]);
			jump([416, 50, "drawAhead.fade"]);
			to([416, 0.75, "linear", 400, "drawAhead"]);
		});

		layer("intro 0", function()
		{
			to([0, 4, "outcubic", 100, "tipsy"], {plr: 0});
			to([12, 4, "incubic", 50, "tipsy"], {plr: 0});
			to([16, 4, "outcubic", 50, "tipsy"], {plr: 1});
			to([28, 4, "incubic", 0, "tipsy"]);
		});

		layer("beat", function()
		{
			jump([91.5, 200, "beat"]);
			jump([95.5, 0, "beat"]);
			jump([95.7, 100, "beat"], {plr: 1});
			jump([155.5, 0, "beat"], {plr: 1});
			jump([159.7, 150, "beat"]);
			jump([207.3, 0, "beat"]);
			jump([315.5, 300, "beat"]);
			jump([319.5, 0, "beat"]);
			jump([319.7, 100, "beat"], {plr: 1});
			jump([351.5, 0, "beat"], {plr: 1});
			jump([383.7, 200, "beat"]);
			jump([415.3, 0, "beat"]);
		});

		layer("hides 96", function()
		{
			to([94, 0.5, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([94.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([94.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([94.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([94.5, 1.25, "inexpo", 625, "lift0"], {plr: 1});
			to([94.625, 1.25, "inexpo", 625, "lift1"], {plr: 1});
			to([94.75, 1.25, "inexpo", 625, "lift2"], {plr: 1});
			to([94.875, 1.25, "inexpo", 625, "lift3"], {plr: 1});
			jump([96.75, 100, "blind", 100, "dim"], {plr: 1});
			jump([96.875, 100, "blind", 100, "dim"], {plr: 1});
			jump([97, 100, "blind", 100, "dim"], {plr: 1});
			jump([97.125, 100, "blind", 100, "dim"], {plr: 1});
			jump([110, 0, "blind", 0, "dim"], {plr: 1});
			to([110, 1, "outexpo", -67.3077, "lift0"], {plr: 1});
			jump([110.125, 0, "blind", 0, "dim"], {plr: 1});
			to([110.125, 1, "outexpo", -67.3077, "lift1"], {plr: 1});
			jump([110.25, 0, "blind", 0, "dim"], {plr: 1});
			to([110.25, 1, "outexpo", -67.3077, "lift2"], {plr: 1});
			jump([110.375, 0, "blind", 0, "dim"], {plr: 1});
			to([110.375, 1, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([111, 1, "inexpo", 48.0769, "lift0"], {plr: 1});
			to([111.125, 1, "inexpo", 48.0769, "lift1"], {plr: 1});
			to([111.25, 1, "inexpo", 48.0769, "lift2"], {plr: 1});
			to([111.375, 1, "inexpo", 48.0769, "lift3"], {plr: 1});
			to([112, 1.25, "outelastic", 0, "lift0"], {plr: 1});
			to([112.125, 1.25, "outelastic", 0, "lift1"], {plr: 1});
			to([112.25, 1.25, "outelastic", 0, "lift2"], {plr: 1});
			to([112.375, 1.25, "outelastic", 0, "lift3"], {plr: 1});
		});

		layer("drop 160", function()
		{
			to([160, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([160.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([161, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([161.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([162, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([162.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([163, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([163.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([164, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([164.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([165, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([165.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([166, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([166.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([167, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([167.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([168, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([168.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([169, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([169.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([170, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([170.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([171, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([171.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([172, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([172.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([173, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([173.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([174, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([174.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([175, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([175.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([176, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([176.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([177, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([177.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([178, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([178.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([179, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([179.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([180, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([180.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([181, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([181.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([182, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([182.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([183, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([183.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([184, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([184.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([185, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([185.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([186, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([186.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([187, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([187.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([188, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([188.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([189, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([189.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([190, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([190.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([191, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([191.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([192, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([192.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([193, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([193.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([194, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([194.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([195, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([195.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([196, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([196.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([197, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([197.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([198, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([198.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([199, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 0, from: 0});
			jump([199.99, 0, "rowY", 0, "laneY"], {plr: 0});
			to([200, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([200.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([201, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([201.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([202, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([202.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([203, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([203.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([204, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([204.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([205, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([205.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([206, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([206.99, 0, "rowY", 0, "laneY"], {plr: 1});
			to([207, 1, "linear", 183.0769, "rowY", 183.0769, "laneY"], {plr: 1, from: 0});
			jump([207.99, 0, "rowY", 0, "laneY"], {plr: 1});
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
			jump([224, 0, "blind", 100, "dim"], {plr: 1});
			to([224, 0.25, "outcubic", 0, "drunk"], {plr: 0, from: 0});
			to([234, 3, "linear", 0, "dim"], {plr: 1});
		});

		layer("center", function()
		{
			to([208, 12, "linear", 100, "rowCenterX"]);
			jump([224, 100, "rowCenterX"]);
			to([284, 4, "incubic", 0, "rowCenterX"]);
			to([432, 12, "linear", 100, "rowCenterX"]);
			to([444, 4, "outcubic", 0, "rowCenterX"]);
			to([472, 4, "incubic", 100, "rowCenterX"]);
		});

		layer("kicks 208", function()
		{
			to([208, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([208, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([208.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([208.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([209.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([209.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([210.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([210.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([211, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([211, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([211.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([211.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([212, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([212, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([212.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([212.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([213.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([213.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([214.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([214.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([215, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([215, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([215.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([215.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([216, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([216, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([216.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([216.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([217.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([217.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([218.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([218.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([219, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([219, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([219.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([219.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
		});

		layer("alpha", function()
		{
			to([223, 2, "linear", 40, "alpha"], {plr: 0});
			jump([224, 100, "alpha"], {plr: 1});
			to([287, 2, "linear", 100, "alpha"], {plr: 0});
			to([318, 2, "linear", 100, "alpha"], {plr: 0});
			to([432, 8, "linear", 40, "alpha"], {plr: 0});
			to([444, 4, "linear", 100, "alpha"], {plr: 0});
		});

		layer("hides 320", function()
		{
			to([318, 0.5, "outexpo", -67.3077, "lift0"], {plr: 1});
			to([318.125, 0.5, "outexpo", -67.3077, "lift1"], {plr: 1});
			to([318.25, 0.5, "outexpo", -67.3077, "lift2"], {plr: 1});
			to([318.375, 0.5, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([318.5, 1.25, "inexpo", 625, "lift0"], {plr: 1});
			to([318.625, 1.25, "inexpo", 625, "lift1"], {plr: 1});
			to([318.75, 1.25, "inexpo", 625, "lift2"], {plr: 1});
			to([318.875, 1.25, "inexpo", 625, "lift3"], {plr: 1});
			jump([320.75, 100, "blind", 100, "dim"], {plr: 1});
			jump([320.875, 100, "blind", 100, "dim"], {plr: 1});
			jump([321, 100, "blind", 100, "dim"], {plr: 1});
			jump([321.125, 100, "blind", 100, "dim"], {plr: 1});
			jump([334, 0, "blind", 0, "dim"], {plr: 1});
			to([334, 1, "outexpo", -67.3077, "lift0"], {plr: 1});
			jump([334.125, 0, "blind", 0, "dim"], {plr: 1});
			to([334.125, 1, "outexpo", -67.3077, "lift1"], {plr: 1});
			jump([334.25, 0, "blind", 0, "dim"], {plr: 1});
			to([334.25, 1, "outexpo", -67.3077, "lift2"], {plr: 1});
			jump([334.375, 0, "blind", 0, "dim"], {plr: 1});
			to([334.375, 1, "outexpo", -67.3077, "lift3"], {plr: 1});
			to([335, 1, "inexpo", 48.0769, "lift0"], {plr: 1});
			to([335.125, 1, "inexpo", 48.0769, "lift1"], {plr: 1});
			to([335.25, 1, "inexpo", 48.0769, "lift2"], {plr: 1});
			to([335.375, 1, "inexpo", 48.0769, "lift3"], {plr: 1});
			to([336, 1.25, "outelastic", 0, "lift0"], {plr: 1});
			to([336.125, 1.25, "outelastic", 0, "lift1"], {plr: 1});
			to([336.25, 1.25, "outelastic", 0, "lift2"], {plr: 1});
			to([336.375, 1.25, "outelastic", 0, "lift3"], {plr: 1});
		});

		layer("stabs 352", function()
		{
			to([351.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([352, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([353.4, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([353.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([354.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([355, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([355.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([356, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([357.4, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([357.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([358.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([359, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([359.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([360, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([361.4, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([361.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([362.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([363, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([363.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([364, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([365.4, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 0});
			to([365.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([366.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 0});
			to([367, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 0});
			to([367.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 1});
			to([368, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([369.4, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 1});
			to([369.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([370.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 1});
			to([371, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([371.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 1});
			to([372, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([373.4, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 1});
			to([373.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([374.9, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 1});
			to([375, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([375.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 1});
			to([376, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([377.4, 0.1, "linear", -200, "drunk", 100, "drag"], {plr: 1});
			to([377.5, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
			to([378.9, 0.1, "linear", 200, "drunk", 100, "drag"], {plr: 1});
			to([379, 0.9, "outcubic", 0, "drunk", 0, "drag"], {plr: 1});
		});

		layer("kicks 416", function()
		{
			to([416, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([416, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([416, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([416.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([416.75, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([416.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([417.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([417.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([417.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([418.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([418.25, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([418.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([419, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([419, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([419.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([419.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([420, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([420, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([420, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([420.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([420.75, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([420.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([421.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([421.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([421.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([422.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([422.25, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([422.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([423, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([423, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([423.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([423.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([424, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([424, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([424, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([424.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([424.75, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([424.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([425.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([425.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([425.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([426.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([426.25, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([426.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([427, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([427, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([427.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([427.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([428, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([428, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([428, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([428.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([428.75, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([428.75, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([429.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([429.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([429.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([430.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([430.25, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([430.25, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([431, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: -150});
			to([431, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: 150});
			to([431.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 0, from: 150});
			to([431.5, 0.75, "outcubic", 0, "addTipsy"], {plr: 1, from: -150});
			to([432, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([432, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([432, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([432.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([432.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([432.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([433, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([433, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([433, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([433.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([433.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([433.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([434, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([434, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([434, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([434.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([434.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([434.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([435, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([435, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([435, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([435.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([435.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([435.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([436, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([436, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([436, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([436.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([436.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([436.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([437, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([437, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([437, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([437.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([437.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([437.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([438, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([438, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([438, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([438.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([438.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([438.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
			to([439, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: -150});
			to([439, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([439, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: 150});
			to([439.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 0, from: 150});
			to([439.5, 0.75, "outcubic", 0, "drag"], {from: 50});
			to([439.5, 0.75, "outcubic", 0, "addDrunk"], {plr: 1, from: -150});
		});

		layer("pulses 448", function()
		{
			to([448, 1, "outcubic", 100, "drunk"], {plr: 0});
			to([451, 1, "inoutcubic", 0, "drunk"], {plr: 0});
			to([451, 1, "outcubic", 100, "drunk"], {plr: 1});
			to([455, 1, "inoutcubic", 0, "drunk"], {plr: 1});
			to([456, 1, "outcubic", 100, "drunk"], {plr: 0});
			to([459, 1, "inoutcubic", 0, "drunk"], {plr: 0});
			to([460, 1, "outcubic", 100, "drunk"], {plr: 1});
			to([463, 1, "inoutcubic", 0, "drunk"], {plr: 1});
			to([464, 1, "outcubic", 100, "drunk"], {plr: 0});
			to([465, 1, "inoutcubic", 0, "drunk"], {plr: 0});
			to([466, 1, "outcubic", 100, "drunk"], {plr: 1});
			to([467, 1, "inoutcubic", 0, "drunk"], {plr: 1});
			to([468, 1, "outcubic", 100, "drunk"], {plr: 0});
			to([469, 1, "inoutcubic", 0, "drunk"], {plr: 0});
			to([470, 1, "outcubic", 100, "drunk"], {plr: 1});
			to([471, 1, "inoutcubic", 100, "drunk"], {plr: 0});
			to([474, 1, "incubic", 0, "drunk"]);
		});
	}
    function speed():Void
    {
        var self = this;

        layer("rate", function()
        {
            self.jump([0, self.xmod(1.8), "rate"]);
            self.to([93, 3, self.linear, self.xmod(1.6), "rate"]);
            self.to([157, 3, self.inOutCubic, self.xmod(1.4), "rate"]);
            self.to([317, 3, self.linear, self.xmod(1.7), "rate"]);
            self.to([381, 3, self.inOutCubic, self.xmod(1.4), "rate"]);
        });
    }

    function drawing():Void
    {
        var self = this;

        layer("drawAhead", function()
        {
            self.jump([0, 600, "drawAhead"]);
            self.jump([0, 25, "drawAhead.fade"]);

            self.to([157, 1, self.linear, 700, "drawAhead"]);
            self.to([207, 1, self.linear, 400, "drawAhead"]);

            self.jump([224, 650, "drawAhead"]);
            self.jump([224, 0, "drawAhead.fade"]);

            self.to([416, 0.75, self.linear, 400, "drawAhead"]);
            self.jump([416, 50, "drawAhead.fade"]);
        });
    }

    function beating():Void
    {
        var self = this;

        layer("beat", function()
        {
            self.jump([91.5, 200, "beat"]);
            self.jump([95.5, 0, "beat"]);

            self.jump([95.7, 100, "beat"], self.only(1));
            self.jump([155.5, 0, "beat"], self.only(1));

            self.jump([159.7, 150, "beat"]);
            self.jump([207.3, 0, "beat"]);

            self.jump([315.5, 300, "beat"]);
            self.jump([319.5, 0, "beat"]);

            self.jump([319.7, 100, "beat"], self.only(1));
            self.jump([351.5, 0, "beat"], self.only(1));

            self.jump([383.7, 200, "beat"]);
            self.jump([415.3, 0, "beat"]);
        });
    }

    function opacity():Void
    {
        var self = this;

        layer("alpha", function()
        {
            self.to([223, 2, self.linear, 40, "alpha"], self.only(0));
            self.jump([224, 100, "alpha"], self.only(1));

            self.to([287, 2, self.linear, 100, "alpha"], self.only(0));
            self.to([318, 2, self.linear, 100, "alpha"], self.only(0));

            self.to([432, 8, self.linear, 40, "alpha"], self.only(0));
            self.to([444, 4, self.linear, 100, "alpha"], self.only(0));
        });
    }

    function centering():Void
    {
        var self = this;

        layer("center", function()
        {
            self.to([208, 12, self.linear, 100, "rowCenterX"]);

            self.jump([224, 100, "rowCenterX"]);
            self.to([284, 4, self.inCubic, 0, "rowCenterX"]);

            self.to([432, 12, self.linear, 100, "rowCenterX"]);
            self.to([444, 4, self.outCubic, 0, "rowCenterX"]);

            self.to([472, 4, self.inCubic, 100, "rowCenterX"]);
        });
    }

    function intro():Void
    {
        var self = this;

        layer("intro 0", function()
        {
            self.to([0, 4, self.outCubic, 100, "tipsy"], self.only(0));
            self.to([12, 4, self.inCubic, 50, "tipsy"], self.only(0));
            self.to([16, 4, self.outCubic, 50, "tipsy"], self.only(1));
            self.to([28, 4, self.inCubic, 0, "tipsy"]);
        });
    }

    function swayOne():Void
    {
        var self = this;

        layer("sway 32", function()
        {
            self.every([32, 32, "sway", [48, false, true]]);
            self.walkHome(64, ["slide"]);

            self.spins(32, 63, 48, false);
        });
    }

    function laneSwayOne():Void
    {
        var self = this;

        layer("lanes 64", function()
        {
            self.easyDrunkRun(64, 100);
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
            });

            self.to([92, 3, self.linear, 50 * self.PX, "shiftY"]);
            self.to([96, 3, self.linear, -10, "mirror"], self.only(0));

            self.to([124, 4, self.inCubic, 0, "shiftY"]);
            self.to([124, 4, self.inCubic, 0, "mirror"], self.only(0));

            self.crossRows(96);

            self.every([96, 64, "step", [96, true, false]]);
            self.walkHome(160, ["stamp"]);
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
                ], 150, false);
            });

            self.dropBeats(160, 208, 16, false);

            self.wig(220, 16, 4, self.outCubic, 100, "drunk", 0);

            self.jump([224, 0, "blind"], self.only(1));
            self.jump([224, 100, "dim"], self.only(1));
            self.to([234, 3, self.linear, 0, "dim"], self.only(1));
        });
    }

    function veiled():Void
    {
        var self = this;

        layer("veil 224", function()
        {
            self.to([224, 8, self.linear, 90, "fadeNear"]);

            self.jump([224, self.hiddenAt(50), "fadeNear.offset"]);
            self.to([240, 12, self.linear, self.hiddenAt(200), "fadeNear.offset"]);

            self.to([252, 8, self.inOutCubic, 50, "drunk"]);
            self.to([252, 8, self.inOutCubic, self.hiddenAt(100), "fadeNear.offset"]);

            self.every([256, 28, "sway", [0, true, true]]);
            self.walkHome(284, ["slide"]);

            self.to([280, 8, self.inOutCubic, 0, "drunk"]);
            self.to([276, 8, self.inOutCubic, 0, "fadeNear"]);
            self.jump([288, 0, "fadeNear.offset"]);

            self.spins(256, 283, 0, true);
        });
    }

    function laneSwayTwo():Void
    {
        var self = this;

        layer("lanes 288", function()
        {
            self.easyDrunkRun(288, 150);
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
            });

            self.to([316, 3, self.linear, 50 * self.PX, "shiftY"]);
            self.to([320, 3, self.linear, -10, "mirror"], self.only(0));

            self.to([348, 4, self.inCubic, 0, "shiftY"]);
            self.to([348, 4, self.inCubic, 0, "mirror"], self.only(0));

            self.crossRows(320);

            self.every([320, 32, "step", [320, true, true]]);
            self.walkHome(352, ["stamp"]);
        });
    }

    function stabs():Void
    {
        var self = this;

        layer("stabs 352", function()
        {
            var fb:Float = 1;
            var i:Float = 352;

            while (i <= 379)
            {
                var spn:Int = (i >= 368) ? 1 : 0;

                self.sm2(i, 1, self.outCubic, 200 * fb, "drunk", spn, 0.1);
                self.sm2(i, 1, self.outCubic, 100, "drag", spn, 0.1);
                self.sm2(i + 1.5, 1, self.outCubic, -200 * fb, "drunk", spn, 0.1);
                self.sm2(i + 1.5, 1, self.outCubic, 100, "drag", spn, 0.1);
                self.sm2(i + 3, 1, self.outCubic, 200 * fb, "drunk", spn, 0.1);
                self.sm2(i + 3, 1, self.outCubic, 100, "drag", spn, 0.1);

                fb = -fb;
                i += 4;
            }
        });
    }

    function dropTwo():Void
    {
        var self = this;

        layer("drop 384", function()
        {
            self.jump([384, 4, "camwagBy"]);
            self.to([414, 2, self.linear, 0, "camwagBy"]);
            self.every([384, 32, "camRock", [384]]);

            self.dropBeats(384, 416, 8, true);

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
                ], 150, true);
            });

            self.wig(444, 16, 4, self.outCubic, 200, "drunk", -1);

            self.layer("pulses 448", function()
            {
                self.drunkPulse(448, 3, 0);
                self.drunkPulse(451, 4, 1);
                self.drunkPulse(456, 3, 0);
                self.drunkPulse(460, 3, 1);
                self.drunkPulse(464, 1, 0);
                self.drunkPulse(466, 1, 1);
                self.drunkPulse(468, 1, 0);
                self.to([470, 1, self.outCubic, 100, "drunk"], self.only(1));
                self.to([471, 1, self.inOutCubic, 100, "drunk"], self.only(0));
                self.to([474, 1, self.inCubic, 0, "drunk"]);
            });

            self.to([472, 4, self.inCubic, 50, "mirror"]);
        });
    }

    function halo():Void
    {
        var self = this;

        layer("halo 476", function()
        {
            self.to([476, 8, self.outExpo, 100, "halo"]);

            self.every([476, 12, "halo", [476]]);
            self.walkHome(488, ["slide", "lift"]);

            var fall:Float = 750 * self.PX;
            self.to([484, 4, self.inCubic, fall, "rowY", fall, "laneY"]);
        });
    }
}
