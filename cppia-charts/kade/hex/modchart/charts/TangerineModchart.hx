// exported by mod-ed

package kade.hex.modchart.charts;

import Math;
import flixel.FlxG;
import funkin.play.PlayState;
import kade.hex.chart.Chart;

class TangerineModchart extends Chart
{
	public function new()
	{
		super("tangerine_modchart");
	}

	override function setup():Void
	{
		stage3d(0, 1, 1, 2.55);
		quantSkin("gameplay/hex/me-quant-notes");
		addField(0);
		addField(1);
		var self = this;
		hook("ring", function(b:Float, args:Array<Dynamic>) { self.ringAt(b, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]); });
	}
	override function build():Void
	{
		// == main : layer 1, layer 11, layer 18, layer 19, layer 20 2, layer 25, layer 26, layer 27, layer 34, layer 35, layer 36 ==
		// == skewboys : layer 2, layer 3, layer 4, layer 5, layer 6, layer 7, layer 8, layer 24 ==
		// == drunks : layer 9, layer 10, layer 20, layer 13, layer 39 ==
		// == cams : layer 14, layer 21, layer 22, layer 28, layer 29, layer 30, layer 31, layer 32 ==
		// == up and down : layer 15, layer 16, layer 17, layer 23 ==
		// == splines : layer 33 ==
		// == rings : layer 37, layer 38, layer 40 ==

		layer("layer 1", function()
		{
			jump([0, 275, "drawAhead"]);
			to([19.5, 0.5, "insine", 25, "rowCenterX"]);
			to([20, 0.5, "insine", 50, "rowCenterX"]);
			to([20.5, 0.5, "insine", 75, "rowCenterX"]);
			to([21, 0.5, "insine", 100, "rowCenterX"]);
			to([21.5, 0.5, "insine", 125, "rowCenterX"]);
			to([22, 0.5, "insine", 150, "rowCenterX"]);
			to([22.5, 0.5, "insine", 175, "rowCenterX"]);
			to([23, 0.5, "insine", 200, "rowCenterX"]);
			to([23.5, 0.5, "insine", 175, "rowCenterX"]);
			to([24, 0.5, "insine", 150, "rowCenterX"]);
			to([24.5, 0.5, "insine", 125, "rowCenterX"]);
			to([25, 0.5, "insine", 100, "rowCenterX"]);
			to([25.5, 0.5, "insine", 75, "rowCenterX"]);
			to([26, 0.5, "insine", 50, "rowCenterX"]);
			to([26.5, 0.5, "insine", 25, "rowCenterX"]);
			to([27, 0.5, "insine", 0, "rowCenterX"]);
			to([27.5, 0.5, "insine", 25, "rowCenterX"]);
			to([28, 0.5, "insine", 50, "rowCenterX"]);
			to([28.5, 0.5, "insine", 75, "rowCenterX"]);
			to([29, 0.5, "insine", 100, "rowCenterX"]);
			to([29.5, 0.5, "insine", 125, "rowCenterX"]);
			to([30, 0.5, "insine", 150, "rowCenterX"]);
			to([30.5, 0.5, "insine", 175, "rowCenterX"]);
			to([31, 0.5, "insine", 200, "rowCenterX"]);
			to([35, 1, "insine", 0, "rowCenterX"]);
		});

		layer("layer 11", function()
		{
			jump([0, 60, "rate"]);
		});

		layer("layer 18", function()
		{
			jump([0, 100, "hideHits"], {plr: [2, 3]});
		});

		layer("layer 19", function()
		{
			to([35, 1, "insine", 45, "rate"]);
		});

		layer("layer 2", function()
		{
			to([0.0115, 0.4794, "outsine", 14, "skewY"]);
			to([0.5, 0.25, "outsine", -14, "skewY"], {from: 14});
			to([0.75, 0.25, "outsine", 14, "skewY"]);
			to([1, 1, "outsine", 0, "skewY"], {from: 14});
			to([2, 0.25, "outsine", -24, "skewY"], {from: 14});
			to([2.25, 0.25, "outsine", 24, "skewY"]);
			to([2.5, 0.25, "outsine", -24, "skewY"], {from: 14});
			to([2.75, 0.25, "outsine", 24, "skewY"]);
			to([3, 0.25, "insine", 0, "skewY"], {from: 37});
			to([3.5, 0.25, "insine", 0, "skewY"], {from: -14});
			to([20, 0.5, "insine", 0, "fold"], {from: 16});
			to([20.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([21, 0.5, "insine", 0, "fold"], {from: 16});
			to([21.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([22, 0.5, "insine", 0, "fold"], {from: 16});
			to([22.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([23, 0.5, "insine", 0, "fold"], {from: 16});
			to([23.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([24, 0.5, "insine", 0, "fold"], {from: 16});
			to([24.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([25, 0.5, "insine", 0, "fold"], {from: 16});
			to([25.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([26, 0.5, "insine", 0, "fold"], {from: 16});
			to([26.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([27, 0.5, "insine", 0, "fold"], {from: 16});
			to([27.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([28, 0.5, "insine", 0, "fold"], {from: 16});
			to([28.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([29, 0.5, "insine", 0, "fold"], {from: 16});
			to([29.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([30, 0.5, "insine", 0, "fold"], {from: 16});
			to([30.5, 0.5, "insine", 0, "fold"], {from: -16});
			to([31, 0.5, "insine", 50, "fold"]);
			to([31.5, 0.5, "insine", 100, "fold"]);
			to([32, 1, "outsine", 0, "fold"], {from: -100});
			to([35, 0.5, "instant", 0, "fold"]);
		});

		layer("layer 3", function()
		{
			to([1, 0.25, "outsine", 14, "skewX"]);
			to([1.25, 0.25, "outsine", -14, "skewX"]);
			to([1.5, 0.25, "outsine", 14, "skewX"]);
			to([1.75, 0.25, "outsine", -14, "skewX"]);
			to([3, 0.25, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([3.5, 0.25, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([0.0115, 0.2294, "outsine", 25, "rowCenterX"]);
			to([0.5, 0.25, "outsine", 50, "rowCenterX"]);
			to([0.75, 0.25, "outsine", 75, "rowCenterX"]);
			to([1, 0.5, "outsine", 100, "rowCenterX"]);
			to([3, 0.25, "outsine", 50, "rowCenterX"]);
			to([3.5, 0.25, "outsine", 0, "rowCenterX"]);
		});

		layer("layer 5", function()
		{
			to([1, 0.5, "insine", 100, "fold"]);
			to([1.5, 0.5, "outsine", -100, "fold"]);
			to([2, 0.5, "insine", 0, "shiftY0"], {from: -50});
			to([2.5, 0.5, "insine", 0, "shiftY2"], {from: -50});
			to([3, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			jump([3.75, 5, "bobX"]);
		});

		layer("layer 6", function()
		{
			to([2.25, 0.5, "insine", 0, "shiftY1"], {from: 50});
			to([2.75, 0.5, "insine", 0, "shiftY3"], {from: 50});
			to([3.5, 1, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 7", function()
		{
			to([2, 0.25, "outsine", 0, "faceZ0"], {from: 90});
			to([2.25, 0.25, "outsine", 0, "faceZ1"], {from: -90});
			to([2.5, 0.25, "outsine", 0, "faceZ2"], {from: 90});
			to([2.75, 0.25, "outsine", 0, "faceZ3"], {from: -90});
			to([3, 1, "outsine", 100, "fold"]);
			to([4, 0.5, "outsine", 0, "fold"], {from: 16});
			jump([31, 50, "swell"]);
		});

		layer("layer 8", function()
		{
			to([0.0115, 0.4794, "outsine", 0, "pinch"], {from: -50});
			to([0.5, 0.5, "outsine", 0, "pinch"], {from: -50});
			to([1, 0.25, "outsine", 0, "pinch"], {from: 25});
			to([1.25, 0.25, "outsine", 0, "pinch"], {from: -25});
			to([1.5, 0.25, "outsine", 0, "pinch"], {from: 25});
			to([1.75, 0.25, "outsine", 0, "pinch"], {from: -25});
			to([2, 1, "outsine", 0, "pinch"], {from: -25});
			to([3, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([3.5, 1.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 9", function()
		{
			to([3.75, 0.25, "insine", 100, "drunk"]);
			to([4, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([4.5, 0.25, "insine", -100, "drunk"]);
			to([4.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([5.25, 0.25, "insine", 100, "drunk"]);
			to([5.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([6, 0.25, "insine", -100, "drunk"]);
			to([6.25, 0.25, "insine", 100, "drunk"], {from: -100});
			to([6.5, 0.25, "insine", 0, "drunk"], {from: 100});
			to([6.75, 0.25, "insine", -100, "drunk"]);
			to([7, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([7.5, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([8, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([8.5, 0.25, "insine", 100, "drunk"]);
			to([8.75, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([9.25, 0.25, "insine", -100, "drunk"]);
			to([9.5, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([10, 0.25, "insine", 100, "drunk"]);
			to([10.25, 0.25, "insine", -100, "drunk"], {from: 100});
			to([10.5, 0.25, "insine", 0, "drunk"], {from: -100});
			to([10.75, 0.25, "insine", 100, "drunk"]);
			to([11, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([11.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([12, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([12.5, 0.25, "insine", -100, "drunk"]);
			to([12.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([13.25, 0.25, "insine", 100, "drunk"]);
			to([13.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([14, 0.25, "insine", -100, "drunk"]);
			to([14.25, 0.25, "insine", 100, "drunk"], {from: -100});
			to([14.5, 0.25, "insine", 0, "drunk"], {from: 100});
			to([14.75, 0.25, "insine", -100, "drunk"]);
			to([15, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([15.5, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([16, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([16.5, 0.25, "insine", 100, "drunk"]);
			to([16.75, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([17.25, 0.25, "insine", -100, "drunk"]);
			to([17.5, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([18, 0.25, "insine", 100, "drunk"]);
			to([18.25, 0.25, "insine", -100, "drunk"], {from: 100});
			to([18.5, 0.25, "insine", 0, "drunk"], {from: -100});
			to([18.75, 0.25, "insine", 100, "drunk"]);
			to([19, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([19.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([20, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([20.5, 0.25, "insine", -100, "drunk"]);
			to([20.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([21.25, 0.25, "insine", 100, "drunk"]);
			to([21.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([22, 0.25, "insine", -100, "drunk"]);
			to([22.25, 0.25, "insine", 100, "drunk"], {from: -100});
			to([22.5, 0.25, "insine", 0, "drunk"], {from: 100});
			to([22.75, 0.25, "insine", -100, "drunk"]);
			to([23, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([23.5, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([24, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([24.5, 0.25, "insine", 100, "drunk"]);
			to([24.75, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([25.25, 0.25, "insine", -100, "drunk"]);
			to([25.5, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([26, 0.25, "insine", 100, "drunk"]);
			to([26.25, 0.25, "insine", -100, "drunk"], {from: 100});
			to([26.5, 0.25, "insine", 0, "drunk"], {from: -100});
			to([26.75, 0.25, "insine", 100, "drunk"]);
			to([27, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([27.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([28, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([28.5, 0.25, "insine", -100, "drunk"]);
			to([28.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([29.25, 0.25, "insine", 100, "drunk"]);
			to([29.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([30, 0.25, "insine", -100, "drunk"]);
			to([30.25, 0.25, "insine", 100, "drunk"], {from: -100});
			to([30.5, 0.25, "insine", 0, "drunk"], {from: 100});
			to([30.75, 0.25, "insine", -100, "drunk"]);
			to([31, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([31.5, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([32, 0.5, "outsine", 0, "drunk"]);
		});

		layer("layer 10", function()
		{
			to([4, 4, "outsine", 0, "showPath"], {from: 45});
			to([8, 4, "outsine", 0, "showPath"], {from: 45});
			to([12, 4, "outsine", 0, "showPath"], {from: 45});
			to([16, 4, "outsine", 0, "showPath"], {from: 45});
			to([20, 4, "outsine", 0, "showPath"], {from: 45});
			to([24, 4, "outsine", 0, "showPath"], {from: 45});
			to([28, 4, "outsine", 0, "showPath"], {from: 45});
			to([32, 4, "outsine", 0, "showPath"], {from: 45});
		});

		layer("layer 20", function()
		{
			to([32, 3, "insine", 100, "dim"]);
			to([35, 1, "insine", 0, "dim"], {plr: 0});
		});

		layer("layer 13", function()
		{
			to([35, 1, "insine", 100, "drunk"]);
		});

		layer("layer 14", function()
		{
			to([34, 2, "insine", 8, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([35.75, 0.25, "insine", -15, "cam.y"]);
		});

		layer("layer 15", function()
		{
			to([35.75, 0.25, "insine", 60, "pinchX"]);
		});

		layer("layer 16", function()
		{
			to([35.5, 0.5, "insine", -15, "shiftY"]);
		});

		layer("layer 17", function()
		{
			to([35.75, 0.25, "insine", -60, "pinchY"]);
		});

		layer("layer 37", function()
		{
			jump([0, 100, "blind", 100, "dim"], {plr: [2, 3]});
		});

		// -- intro @ 36 --
		layer("layer 1", function()
		{
			to([38.5, 0.5, "insine", 100, "mirror"]);
			to([40, 0.5, "outsine", 0, "mirror"]);
			to([46.5, 0.5, "insine", 100, "mirror"]);
			to([48, 0.5, "outsine", 0, "mirror"]);
			to([53.75, 0.75, "insine", -100, "laneX2"]);
			to([55.25, 0.25, "outsine", 0, "laneX2"]);
			to([61.75, 0.75, "insine", -100, "laneX2"]);
			to([63.25, 0.25, "outsine", 0, "laneX2"]);
		});

		layer("layer 11", function()
		{
			to([41, 1.75, "insine", 0, "dim"], {plr: 1});
			to([52.5, 0.75, "insine", 100, "laneX0"]);
			to([54.25, 0.25, "outsine", 0, "laneX0"]);
			to([55.5, 0.75, "insine", 100, "laneX1"]);
			to([57.25, 0.25, "outsine", 0, "laneX1"]);
			to([60.5, 0.75, "insine", 100, "laneX0"]);
			to([62.25, 0.25, "outsine", 0, "laneX0"]);
			to([63.5, 0.75, "insine", 100, "laneX1"]);
			to([65.25, 0.25, "outsine", 0, "laneX1"]);
		});

		layer("layer 18", function()
		{
			to([41, 1.75, "insine", 0, "blind"], {plr: 1, from: 100});
		});

		layer("layer 19", function()
		{
			to([67, 1, "insine", 50, "rate"]);
		});

		layer("layer 2", function()
		{
			to([67, 0.5, "insine", 0, "skewY"], {from: 37});
			to([67.5, 1, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([67, 0.5, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([67.5, 1, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 6", function()
		{
			to([67, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			to([67.5, 1, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 8", function()
		{
			to([67, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([67.5, 1.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 9", function()
		{
			to([67, 1, "insine", 0, "swell"]);
		});

		layer("layer 10", function()
		{
			to([67, 1, "insine", 65, "surge"]);
		});

		layer("layer 13", function()
		{
			to([36, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([36.5, 0.25, "insine", -100, "drunk"]);
			to([36.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([37.25, 0.25, "insine", 100, "drunk"]);
			to([37.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([38, 0.25, "insine", -100, "drunk"]);
			to([38.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([38.75, 0.25, "insine", 100, "drunk"]);
			to([39, 0.5, "insine", -100, "drunk"], {from: 100});
			to([39.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([40, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([40.5, 0.25, "insine", -100, "drunk"]);
			to([40.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([41.25, 0.25, "insine", 100, "drunk"]);
			to([41.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([42, 0.25, "insine", -100, "drunk"]);
			to([42.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([42.75, 0.25, "insine", 100, "drunk"]);
			to([43, 0.5, "insine", -100, "drunk"], {from: 100});
			to([43.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([44, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([44.5, 0.25, "insine", -100, "drunk"]);
			to([44.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([45.25, 0.25, "insine", 100, "drunk"]);
			to([45.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([46, 0.25, "insine", -100, "drunk"]);
			to([46.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([46.75, 0.25, "insine", 100, "drunk"]);
			to([47, 0.5, "insine", -100, "drunk"], {from: 100});
			to([47.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([48, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([48.5, 0.25, "insine", -100, "drunk"]);
			to([48.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([49.25, 0.25, "insine", 100, "drunk"]);
			to([49.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([50, 0.25, "insine", -100, "drunk"]);
			to([50.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([50.75, 0.25, "insine", 100, "drunk"]);
			to([51, 0.5, "insine", -100, "drunk"], {from: 100});
			to([51.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([52, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([52.5, 0.25, "insine", -100, "drunk"]);
			to([52.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([53.25, 0.25, "insine", 100, "drunk"]);
			to([53.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([54, 0.25, "insine", -100, "drunk"]);
			to([54.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([54.75, 0.25, "insine", 100, "drunk"]);
			to([55, 0.5, "insine", -100, "drunk"], {from: 100});
			to([55.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([56, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([56.5, 0.25, "insine", -100, "drunk"]);
			to([56.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([57.25, 0.25, "insine", 100, "drunk"]);
			to([57.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([58, 0.25, "insine", -100, "drunk"]);
			to([58.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([58.75, 0.25, "insine", 100, "drunk"]);
			to([59, 0.5, "insine", -100, "drunk"], {from: 100});
			to([59.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([60, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([60.5, 0.25, "insine", -100, "drunk"]);
			to([60.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([61.25, 0.25, "insine", 100, "drunk"]);
			to([61.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([62, 0.25, "insine", -100, "drunk"]);
			to([62.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([62.75, 0.25, "insine", 100, "drunk"]);
			to([63, 0.5, "insine", -100, "drunk"], {from: 100});
			to([63.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([64, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([64.5, 0.25, "insine", -100, "drunk"]);
			to([64.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([65.25, 0.25, "insine", 100, "drunk"]);
			to([65.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([66, 0.25, "insine", -100, "drunk"]);
			to([66.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([66.75, 0.25, "insine", 100, "drunk"]);
			to([67, 0.5, "insine", -100, "drunk"], {from: 100});
			to([67.5, 0.5, "insine", 50, "drunk"], {from: -100});
		});

		layer("layer 14", function()
		{
			to([36, 1, "outsine", 0, "cam.rotZ"]);
			to([67, 0.5, "outsine", -7, "cam.rotZ"], {from: 7});
			to([67.5, 0.5, "outsine", 0, "cam.rotZ"], {from: -7});
		});

		layer("layer 21", function()
		{
			to([36, 0.5, "outsine", 0, "cam.y"]);
			to([36.75, 0.25, "insine", -15, "cam.y"]);
			to([37, 0.5, "outsine", 0, "cam.y"]);
			to([37.75, 0.25, "insine", -15, "cam.y"]);
			to([38, 0.5, "outsine", 0, "cam.y"]);
			to([38.75, 0.25, "insine", -15, "cam.y"]);
			to([39, 0.5, "outsine", 0, "cam.y"]);
			to([39.75, 0.25, "insine", -15, "cam.y"]);
			to([40, 0.5, "outsine", 0, "cam.y"]);
			to([40.75, 0.25, "insine", -15, "cam.y"]);
			to([41, 0.5, "outsine", 0, "cam.y"]);
			to([41.75, 0.25, "insine", -15, "cam.y"]);
			to([42, 0.5, "outsine", 0, "cam.y"]);
			to([42.75, 0.25, "insine", -15, "cam.y"]);
			to([43, 0.5, "outsine", 0, "cam.y"]);
			to([43.75, 0.25, "insine", -15, "cam.y"]);
			to([44, 0.5, "outsine", 0, "cam.y"]);
			to([44.75, 0.25, "insine", -15, "cam.y"]);
			to([45, 0.5, "outsine", 0, "cam.y"]);
			to([45.75, 0.25, "insine", -15, "cam.y"]);
			to([46, 0.5, "outsine", 0, "cam.y"]);
			to([46.75, 0.25, "insine", -15, "cam.y"]);
			to([47, 0.5, "outsine", 0, "cam.y"]);
			to([47.75, 0.25, "insine", -15, "cam.y"]);
			to([48, 0.5, "outsine", 0, "cam.y"]);
			to([48.75, 0.25, "insine", -15, "cam.y"]);
			to([49, 0.5, "outsine", 0, "cam.y"]);
			to([49.75, 0.25, "insine", -15, "cam.y"]);
			to([50, 0.5, "outsine", 0, "cam.y"]);
			to([50.75, 0.25, "insine", -15, "cam.y"]);
			to([51, 0.5, "outsine", 0, "cam.y"]);
			to([51.75, 0.25, "insine", -15, "cam.y"]);
			to([52, 0.5, "outsine", 0, "cam.y"]);
			to([52.75, 0.25, "insine", -15, "cam.y"]);
			to([53, 0.5, "outsine", 0, "cam.y"]);
			to([53.75, 0.25, "insine", -15, "cam.y"]);
			to([54, 0.5, "outsine", 0, "cam.y"]);
			to([54.75, 0.25, "insine", -15, "cam.y"]);
			to([55, 0.5, "outsine", 0, "cam.y"]);
			to([55.75, 0.25, "insine", -15, "cam.y"]);
			to([56, 0.5, "outsine", 0, "cam.y"]);
			to([56.75, 0.25, "insine", -15, "cam.y"]);
			to([57, 0.5, "outsine", 0, "cam.y"]);
			to([57.75, 0.25, "insine", -15, "cam.y"]);
			to([58, 0.5, "outsine", 0, "cam.y"]);
			to([58.75, 0.25, "insine", -15, "cam.y"]);
			to([59, 0.5, "outsine", 0, "cam.y"]);
			to([59.75, 0.25, "insine", -15, "cam.y"]);
			to([60, 0.5, "outsine", 0, "cam.y"]);
			to([60.75, 0.25, "insine", -15, "cam.y"]);
			to([61, 0.5, "outsine", 0, "cam.y"]);
			to([61.75, 0.25, "insine", -15, "cam.y"]);
			to([62, 0.5, "outsine", 0, "cam.y"]);
			to([62.75, 0.25, "insine", -15, "cam.y"]);
			to([63, 0.5, "outsine", 0, "cam.y"]);
			to([63.75, 0.25, "insine", -15, "cam.y"]);
			to([64, 0.5, "outsine", 0, "cam.y"]);
			to([64.75, 0.25, "insine", -15, "cam.y"]);
			to([65, 0.5, "outsine", 0, "cam.y"]);
			to([65.75, 0.25, "insine", -15, "cam.y"]);
			to([66, 0.5, "outsine", 0, "cam.y"]);
			to([66.75, 0.25, "insine", -15, "cam.y"]);
			to([67, 0.5, "outsine", 0, "cam.y"]);
		});

		layer("layer 22", function()
		{
			to([36, 1, "outsine", 0, "cam.x"]);
			to([43, 1, "insine", -8, "cam.rotZ"]);
			to([44, 1, "outsine", 0, "cam.rotZ"]);
			to([51, 1, "insine", 8, "cam.rotZ"]);
			to([52, 1, "outsine", 0, "cam.rotZ"]);
			to([59, 1, "insine", -8, "cam.rotZ"]);
			to([60, 1, "outsine", 0, "cam.rotZ"]);
		});

		layer("layer 15", function()
		{
			to([36, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([36.75, 0.25, "insine", 60, "pinchX"]);
			to([37, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([37.75, 0.25, "insine", 60, "pinchX"]);
			to([38, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([38.75, 0.25, "insine", 60, "pinchX"]);
			to([39, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([39.75, 0.25, "insine", 60, "pinchX"]);
			to([40, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([40.75, 0.25, "insine", 60, "pinchX"]);
			to([41, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([41.75, 0.25, "insine", 60, "pinchX"]);
			to([42, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([42.75, 0.25, "insine", 60, "pinchX"]);
			to([43, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([43.75, 0.25, "insine", 60, "pinchX"]);
			to([44, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([44.75, 0.25, "insine", 60, "pinchX"]);
			to([45, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([45.75, 0.25, "insine", 60, "pinchX"]);
			to([46, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([46.75, 0.25, "insine", 60, "pinchX"]);
			to([47, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([47.75, 0.25, "insine", 60, "pinchX"]);
			to([48, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([48.75, 0.25, "insine", 60, "pinchX"]);
			to([49, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([49.75, 0.25, "insine", 60, "pinchX"]);
			to([50, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([50.75, 0.25, "insine", 60, "pinchX"]);
			to([51, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([51.75, 0.25, "insine", 60, "pinchX"]);
			to([52, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([52.75, 0.25, "insine", 60, "pinchX"]);
			to([53, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([53.75, 0.25, "insine", 60, "pinchX"]);
			to([54, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([54.75, 0.25, "insine", 60, "pinchX"]);
			to([55, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([55.75, 0.25, "insine", 60, "pinchX"]);
			to([56, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([56.75, 0.25, "insine", 60, "pinchX"]);
			to([57, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([57.75, 0.25, "insine", 60, "pinchX"]);
			to([58, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([58.75, 0.25, "insine", 60, "pinchX"]);
			to([59, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([59.75, 0.25, "insine", 60, "pinchX"]);
			to([60, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([60.75, 0.25, "insine", 60, "pinchX"]);
			to([61, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([61.75, 0.25, "insine", 60, "pinchX"]);
			to([62, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([62.75, 0.25, "insine", 60, "pinchX"]);
			to([63, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([63.75, 0.25, "insine", 60, "pinchX"]);
			to([64, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([64.75, 0.25, "insine", 60, "pinchX"]);
			to([65, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([65.75, 0.25, "insine", 60, "pinchX"]);
			to([66, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([66.75, 0.25, "insine", 60, "pinchX"]);
			to([67, 0.25, "outsine", 0, "pinchX"], {from: 60});
		});

		layer("layer 16", function()
		{
			to([36, 0.5, "outsine", 0, "shiftY"]);
			to([36.5, 0.5, "insine", -15, "shiftY"]);
			to([37, 0.5, "outsine", 0, "shiftY"]);
			to([37.5, 0.5, "insine", -15, "shiftY"]);
			to([38, 0.5, "outsine", 0, "shiftY"]);
			to([38.5, 0.5, "insine", -15, "shiftY"]);
			to([39, 0.5, "outsine", 0, "shiftY"]);
			to([39.5, 0.5, "insine", -15, "shiftY"]);
			to([40, 0.5, "outsine", 0, "shiftY"]);
			to([40.5, 0.5, "insine", -15, "shiftY"]);
			to([41, 0.5, "outsine", 0, "shiftY"]);
			to([41.5, 0.5, "insine", -15, "shiftY"]);
			to([42, 0.5, "outsine", 0, "shiftY"]);
			to([42.5, 0.5, "insine", -15, "shiftY"]);
			to([43, 0.5, "outsine", 0, "shiftY"]);
			to([43.5, 0.5, "insine", -15, "shiftY"]);
			to([44, 0.5, "outsine", 0, "shiftY"]);
			to([44.5, 0.5, "insine", -15, "shiftY"]);
			to([45, 0.5, "outsine", 0, "shiftY"]);
			to([45.5, 0.5, "insine", -15, "shiftY"]);
			to([46, 0.5, "outsine", 0, "shiftY"]);
			to([46.5, 0.5, "insine", -15, "shiftY"]);
			to([47, 0.5, "outsine", 0, "shiftY"]);
			to([47.5, 0.5, "insine", -15, "shiftY"]);
			to([48, 0.5, "outsine", 0, "shiftY"]);
			to([48.5, 0.5, "insine", -15, "shiftY"]);
			to([49, 0.5, "outsine", 0, "shiftY"]);
			to([49.5, 0.5, "insine", -15, "shiftY"]);
			to([50, 0.5, "outsine", 0, "shiftY"]);
			to([50.5, 0.5, "insine", -15, "shiftY"]);
			to([51, 0.5, "outsine", 0, "shiftY"]);
			to([51.5, 0.5, "insine", -15, "shiftY"]);
			to([52, 0.5, "outsine", 0, "shiftY"]);
			to([52.5, 0.5, "insine", -15, "shiftY"]);
			to([53, 0.5, "outsine", 0, "shiftY"]);
			to([53.5, 0.5, "insine", -15, "shiftY"]);
			to([54, 0.5, "outsine", 0, "shiftY"]);
			to([54.5, 0.5, "insine", -15, "shiftY"]);
			to([55, 0.5, "outsine", 0, "shiftY"]);
			to([55.5, 0.5, "insine", -15, "shiftY"]);
			to([56, 0.5, "outsine", 0, "shiftY"]);
			to([56.5, 0.5, "insine", -15, "shiftY"]);
			to([57, 0.5, "outsine", 0, "shiftY"]);
			to([57.5, 0.5, "insine", -15, "shiftY"]);
			to([58, 0.5, "outsine", 0, "shiftY"]);
			to([58.5, 0.5, "insine", -15, "shiftY"]);
			to([59, 0.5, "outsine", 0, "shiftY"]);
			to([59.5, 0.5, "insine", -15, "shiftY"]);
			to([60, 0.5, "outsine", 0, "shiftY"]);
			to([60.5, 0.5, "insine", -15, "shiftY"]);
			to([61, 0.5, "outsine", 0, "shiftY"]);
			to([61.5, 0.5, "insine", -15, "shiftY"]);
			to([62, 0.5, "outsine", 0, "shiftY"]);
			to([62.5, 0.5, "insine", -15, "shiftY"]);
			to([63, 0.5, "outsine", 0, "shiftY"]);
			to([63.5, 0.5, "insine", -15, "shiftY"]);
			to([64, 0.5, "outsine", 0, "shiftY"]);
			to([64.5, 0.5, "insine", -15, "shiftY"]);
			to([65, 0.5, "outsine", 0, "shiftY"]);
			to([65.5, 0.5, "insine", -15, "shiftY"]);
			to([66, 0.5, "outsine", 0, "shiftY"]);
			to([66.5, 0.5, "insine", -15, "shiftY"]);
			to([67, 0.5, "outsine", 0, "shiftY"]);
		});

		layer("layer 17", function()
		{
			to([36, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([36.75, 0.25, "insine", -60, "pinchY"]);
			to([37, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([37.75, 0.25, "insine", -60, "pinchY"]);
			to([38, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([38.75, 0.25, "insine", -60, "pinchY"]);
			to([39, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([39.75, 0.25, "insine", -60, "pinchY"]);
			to([40, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([40.75, 0.25, "insine", -60, "pinchY"]);
			to([41, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([41.75, 0.25, "insine", -60, "pinchY"]);
			to([42, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([42.75, 0.25, "insine", -60, "pinchY"]);
			to([43, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([43.75, 0.25, "insine", -60, "pinchY"]);
			to([44, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([44.75, 0.25, "insine", -60, "pinchY"]);
			to([45, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([45.75, 0.25, "insine", -60, "pinchY"]);
			to([46, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([46.75, 0.25, "insine", -60, "pinchY"]);
			to([47, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([47.75, 0.25, "insine", -60, "pinchY"]);
			to([48, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([48.75, 0.25, "insine", -60, "pinchY"]);
			to([49, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([49.75, 0.25, "insine", -60, "pinchY"]);
			to([50, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([50.75, 0.25, "insine", -60, "pinchY"]);
			to([51, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([51.75, 0.25, "insine", -60, "pinchY"]);
			to([52, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([52.75, 0.25, "insine", -60, "pinchY"]);
			to([53, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([53.75, 0.25, "insine", -60, "pinchY"]);
			to([54, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([54.75, 0.25, "insine", -60, "pinchY"]);
			to([55, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([55.75, 0.25, "insine", -60, "pinchY"]);
			to([56, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([56.75, 0.25, "insine", -60, "pinchY"]);
			to([57, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([57.75, 0.25, "insine", -60, "pinchY"]);
			to([58, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([58.75, 0.25, "insine", -60, "pinchY"]);
			to([59, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([59.75, 0.25, "insine", -60, "pinchY"]);
			to([60, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([60.75, 0.25, "insine", -60, "pinchY"]);
			to([61, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([61.75, 0.25, "insine", -60, "pinchY"]);
			to([62, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([62.75, 0.25, "insine", -60, "pinchY"]);
			to([63, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([63.75, 0.25, "insine", -60, "pinchY"]);
			to([64, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([64.75, 0.25, "insine", -60, "pinchY"]);
			to([65, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([65.75, 0.25, "insine", -60, "pinchY"]);
			to([66, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([66.75, 0.25, "insine", -60, "pinchY"]);
			to([67, 0.25, "outsine", 0, "pinchY"], {from: -60});
		});

		// -- verse 1 @ 68 --
		layer("layer 1", function()
		{
			to([82.5, 1.5, "insine", 100, "flipRow"]);
			to([99, 1, "insine", 0, "flipRow"]);
		});

		layer("layer 11", function()
		{
			to([98, 2, "insine", 0, "fadeNear"]);
		});

		layer("layer 18", function()
		{
			to([98, 2, "insine", 35, "dim"], {plr: 0});
		});

		layer("layer 19", function()
		{
			to([98, 2, "insine", 35, "blind"], {plr: 0});
		});

		layer("layer 20 2", function()
		{
			to([92, 6, "insine", 50, "fadeNear"]);
		});

		layer("layer 2", function()
		{
			to([99, 0.5, "insine", 0, "skewY"], {from: 37});
			to([99.5, 1, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([99, 0.5, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([99.5, 1, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([99, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			to([99.5, 1, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 5", function()
		{
			to([99, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([99.5, 1.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 13", function()
		{
			to([68, 1, "outsine", 25, "drunk"], {from: 100});
			to([69, 1, "insine", -50, "drunk"]);
			to([70, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([71, 1, "insine", 50, "drunk"]);
			to([72, 1, "outsine", 0, "drunk"], {from: 50});
			to([73, 1, "insine", -50, "drunk"]);
			to([74, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([75, 1, "insine", 50, "drunk"]);
			to([76, 1, "outsine", 0, "drunk"], {from: 50});
			to([77, 1, "insine", -50, "drunk"]);
			to([78, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([79, 1, "insine", 50, "drunk"]);
			to([80, 1, "outsine", 0, "drunk"], {from: 50});
			to([81, 1, "insine", -50, "drunk"]);
			to([82, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([83, 1, "insine", 50, "drunk"]);
			to([84, 1, "outsine", 0, "drunk"], {from: 50});
			to([85, 1, "insine", -50, "drunk"]);
			to([86, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([87, 1, "insine", 50, "drunk"]);
			to([88, 1, "outsine", 0, "drunk"], {from: 50});
			to([89, 1, "insine", -50, "drunk"]);
			to([90, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([91, 1, "insine", 50, "drunk"]);
			to([92, 1, "outsine", 0, "drunk"], {from: 50});
			to([93, 1, "insine", -50, "drunk"]);
			to([94, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([95, 1, "insine", 50, "drunk"]);
			to([96, 1, "outsine", 0, "drunk"], {from: 50});
			to([97, 1, "insine", -50, "drunk"]);
			to([98, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([99, 1, "insine", 50, "drunk"]);
		});

		layer("layer 14", function()
		{
			to([68, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([68.5, 3.5, "insine", 0, "cam.rotZ"]);
			to([72, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([74, 2, "insine", 0, "cam.rotZ"]);
			to([76, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([78, 2, "insine", 0, "cam.rotZ"]);
			to([80, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([82, 2, "insine", 0, "cam.rotZ"]);
			to([84, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([86, 2, "insine", 0, "cam.rotZ"]);
			to([88, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([90, 2, "insine", 0, "cam.rotZ"]);
			to([92, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([94, 2, "insine", 0, "cam.rotZ"]);
			to([96, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([98, 2, "insine", 0, "cam.rotZ"]);
		});

		layer("layer 16", function()
		{
			to([99.75, 0.5, "insine", -15, "shiftY"]);
		});

		// -- pre-drop @ 100 --
		layer("layer 1", function()
		{
			to([100, 8, "linear", 200, "rowCenterX"]);
			to([108, 8, "linear", 0, "rowCenterX"]);
			to([116, 8, "linear", 200, "rowCenterX"]);
			to([124, 6.5, "linear", 0, "rowCenterX"]);
			to([130.5, 0.5, "insine", 50, "rowCenterX"]);
			to([131, 1, "insine", 100, "rowCenterX"]);
		});

		layer("layer 11", function()
		{
			to([108, 4, "insine", 50, "fadeNear"]);
			to([114, 2, "insine", 0, "fadeNear"]);
			to([124, 4, "insine", 50, "fadeNear"]);
			to([130.5, 1.5, "insine", 50, "rowCenterY"]);
		});

		layer("layer 18", function()
		{
			to([130, 2, "insine", 0, "surge"]);
		});

		layer("layer 19", function()
		{
			to([130, 2, "insine", 45, "rate"]);
		});

		layer("layer 20 2", function()
		{
			to([130, 2, "linear", 190, "drawAhead"]);
		});

		layer("layer 26", function()
		{
			to([128, 4, "insine", 0, "fadeNear"]);
		});

		layer("layer 2", function()
		{
			to([131, 0.5, "insine", 0, "skewY"], {from: 37});
			to([131.5, 0.5, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([131, 0.5, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([131.5, 0.5, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([131, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			to([131.5, 0.5, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 5", function()
		{
			to([131, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([131.5, 0.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 13", function()
		{
			to([131.5, 0.5, "insine", 100, "drunk"]);
		});

		layer("layer 14", function()
		{
			to([100, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([102, 2, "insine", 0, "cam.rotZ"]);
			to([104, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([106, 2, "insine", 0, "cam.rotZ"]);
			to([108, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([110, 2, "insine", 0, "cam.rotZ"]);
			to([112, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([114, 2, "insine", 0, "cam.rotZ"]);
			to([116, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([118, 2, "insine", 0, "cam.rotZ"]);
			to([120, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([122, 2, "insine", 0, "cam.rotZ"]);
			to([124, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([126, 2, "insine", 0, "cam.rotZ"]);
			to([128, 2, "outsine", -4, "cam.rotZ"], {from: 0});
			to([130, 2, "insine", 0, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([131.75, 0.25, "insine", -30, "cam.y"]);
		});

		layer("layer 15", function()
		{
			to([100, 0.25, "insine", 60, "pinchX"]);
			to([100.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([101, 0.25, "insine", 60, "pinchX"]);
			to([101.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([102, 0.25, "insine", 60, "pinchX"]);
			to([102.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([103, 0.25, "insine", 60, "pinchX"]);
			to([103.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([104, 0.25, "insine", 60, "pinchX"]);
			to([104.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([105, 0.25, "insine", 60, "pinchX"]);
			to([105.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([106, 0.25, "insine", 60, "pinchX"]);
			to([106.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([107, 0.25, "insine", 60, "pinchX"]);
			to([107.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([108, 0.25, "insine", 60, "pinchX"]);
			to([108.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([109, 0.25, "insine", 60, "pinchX"]);
			to([109.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([110, 0.25, "insine", 60, "pinchX"]);
			to([110.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([111, 0.25, "insine", 60, "pinchX"]);
			to([111.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([112, 0.25, "insine", 60, "pinchX"]);
			to([112.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([113, 0.25, "insine", 60, "pinchX"]);
			to([113.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([114, 0.25, "insine", 60, "pinchX"]);
			to([114.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([115, 0.25, "insine", 60, "pinchX"]);
			to([115.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([116, 0.25, "insine", 60, "pinchX"]);
			to([116.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([117, 0.25, "insine", 60, "pinchX"]);
			to([117.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([118, 0.25, "insine", 60, "pinchX"]);
			to([118.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([119, 0.25, "insine", 60, "pinchX"]);
			to([119.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([120, 0.25, "insine", 60, "pinchX"]);
			to([120.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([121, 0.25, "insine", 60, "pinchX"]);
			to([121.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([122, 0.25, "insine", 60, "pinchX"]);
			to([122.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([123, 0.25, "insine", 60, "pinchX"]);
			to([123.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([124, 0.25, "insine", 60, "pinchX"]);
			to([124.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([125, 0.25, "insine", 60, "pinchX"]);
			to([125.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([126, 0.25, "insine", 60, "pinchX"]);
			to([126.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([127, 0.25, "insine", 60, "pinchX"]);
			to([127.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([128, 0.25, "insine", 60, "pinchX"]);
			to([128.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([129, 0.25, "insine", 60, "pinchX"]);
			to([129.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([130, 0.25, "insine", 60, "pinchX"]);
			to([130.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([131, 0.25, "insine", 60, "pinchX"]);
			to([131.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
		});

		layer("layer 16", function()
		{
			to([100.25, 0.5, "outsine", 0, "shiftY"]);
			to([100.75, 0.5, "insine", -15, "shiftY"]);
			to([101.25, 0.5, "outsine", 0, "shiftY"]);
			to([101.75, 0.5, "insine", -15, "shiftY"]);
			to([102.25, 0.5, "outsine", 0, "shiftY"]);
			to([102.75, 0.5, "insine", -15, "shiftY"]);
			to([103.25, 0.5, "outsine", 0, "shiftY"]);
			to([103.75, 0.5, "insine", -15, "shiftY"]);
			to([104.25, 0.5, "outsine", 0, "shiftY"]);
			to([104.75, 0.5, "insine", -15, "shiftY"]);
			to([105.25, 0.5, "outsine", 0, "shiftY"]);
			to([105.75, 0.5, "insine", -15, "shiftY"]);
			to([106.25, 0.5, "outsine", 0, "shiftY"]);
			to([106.75, 0.5, "insine", -15, "shiftY"]);
			to([107.25, 0.5, "outsine", 0, "shiftY"]);
			to([107.75, 0.5, "insine", -15, "shiftY"]);
			to([108.25, 0.5, "outsine", 0, "shiftY"]);
			to([108.75, 0.5, "insine", -15, "shiftY"]);
			to([109.25, 0.5, "outsine", 0, "shiftY"]);
			to([109.75, 0.5, "insine", -15, "shiftY"]);
			to([110.25, 0.5, "outsine", 0, "shiftY"]);
			to([110.75, 0.5, "insine", -15, "shiftY"]);
			to([111.25, 0.5, "outsine", 0, "shiftY"]);
			to([111.75, 0.5, "insine", -15, "shiftY"]);
			to([112.25, 0.5, "outsine", 0, "shiftY"]);
			to([112.75, 0.5, "insine", -15, "shiftY"]);
			to([113.25, 0.5, "outsine", 0, "shiftY"]);
			to([113.75, 0.5, "insine", -15, "shiftY"]);
			to([114.25, 0.5, "outsine", 0, "shiftY"]);
			to([114.75, 0.5, "insine", -15, "shiftY"]);
			to([115.25, 0.5, "outsine", 0, "shiftY"]);
			to([115.75, 0.5, "insine", -15, "shiftY"]);
			to([116.25, 0.5, "outsine", 0, "shiftY"]);
			to([116.75, 0.5, "insine", -15, "shiftY"]);
			to([117.25, 0.5, "outsine", 0, "shiftY"]);
			to([117.75, 0.5, "insine", -15, "shiftY"]);
			to([118.25, 0.5, "outsine", 0, "shiftY"]);
			to([118.75, 0.5, "insine", -15, "shiftY"]);
			to([119.25, 0.5, "outsine", 0, "shiftY"]);
			to([119.75, 0.5, "insine", -15, "shiftY"]);
			to([120.25, 0.5, "outsine", 0, "shiftY"]);
			to([120.75, 0.5, "insine", -15, "shiftY"]);
			to([121.25, 0.5, "outsine", 0, "shiftY"]);
			to([121.75, 0.5, "insine", -15, "shiftY"]);
			to([122.25, 0.5, "outsine", 0, "shiftY"]);
			to([122.75, 0.5, "insine", -15, "shiftY"]);
			to([123.25, 0.5, "outsine", 0, "shiftY"]);
			to([123.75, 0.5, "insine", -15, "shiftY"]);
			to([124.25, 0.5, "outsine", 0, "shiftY"]);
			to([124.75, 0.5, "insine", -15, "shiftY"]);
			to([125.25, 0.5, "outsine", 0, "shiftY"]);
			to([125.75, 0.5, "insine", -15, "shiftY"]);
			to([126.25, 0.5, "outsine", 0, "shiftY"]);
			to([126.75, 0.5, "insine", -15, "shiftY"]);
			to([127.25, 0.5, "outsine", 0, "shiftY"]);
			to([127.75, 0.5, "insine", -15, "shiftY"]);
			to([128.25, 0.5, "outsine", 0, "shiftY"]);
			to([128.75, 0.5, "insine", -15, "shiftY"]);
			to([129.25, 0.5, "outsine", 0, "shiftY"]);
			to([129.75, 0.5, "insine", -15, "shiftY"]);
			to([130.25, 0.5, "outsine", 0, "shiftY"]);
			to([130.75, 0.5, "insine", -15, "shiftY"]);
			to([131.25, 0.5, "outsine", 0, "shiftY"]);
		});

		layer("layer 17", function()
		{
			to([100, 0.25, "insine", -60, "pinchY"]);
			to([100.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([101, 0.25, "insine", -60, "pinchY"]);
			to([101.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([102, 0.25, "insine", -60, "pinchY"]);
			to([102.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([103, 0.25, "insine", -60, "pinchY"]);
			to([103.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([104, 0.25, "insine", -60, "pinchY"]);
			to([104.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([105, 0.25, "insine", -60, "pinchY"]);
			to([105.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([106, 0.25, "insine", -60, "pinchY"]);
			to([106.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([107, 0.25, "insine", -60, "pinchY"]);
			to([107.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([108, 0.25, "insine", -60, "pinchY"]);
			to([108.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([109, 0.25, "insine", -60, "pinchY"]);
			to([109.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([110, 0.25, "insine", -60, "pinchY"]);
			to([110.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([111, 0.25, "insine", -60, "pinchY"]);
			to([111.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([112, 0.25, "insine", -60, "pinchY"]);
			to([112.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([113, 0.25, "insine", -60, "pinchY"]);
			to([113.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([114, 0.25, "insine", -60, "pinchY"]);
			to([114.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([115, 0.25, "insine", -60, "pinchY"]);
			to([115.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([116, 0.25, "insine", -60, "pinchY"]);
			to([116.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([117, 0.25, "insine", -60, "pinchY"]);
			to([117.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([118, 0.25, "insine", -60, "pinchY"]);
			to([118.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([119, 0.25, "insine", -60, "pinchY"]);
			to([119.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([120, 0.25, "insine", -60, "pinchY"]);
			to([120.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([121, 0.25, "insine", -60, "pinchY"]);
			to([121.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([122, 0.25, "insine", -60, "pinchY"]);
			to([122.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([123, 0.25, "insine", -60, "pinchY"]);
			to([123.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([124, 0.25, "insine", -60, "pinchY"]);
			to([124.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([125, 0.25, "insine", -60, "pinchY"]);
			to([125.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([126, 0.25, "insine", -60, "pinchY"]);
			to([126.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([127, 0.25, "insine", -60, "pinchY"]);
			to([127.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([128, 0.25, "insine", -60, "pinchY"]);
			to([128.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([129, 0.25, "insine", -60, "pinchY"]);
			to([129.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([130, 0.25, "insine", -60, "pinchY"]);
			to([130.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([131, 0.25, "insine", -60, "pinchY"]);
			to([131.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
		});

		// -- drop @ 132 --
		layer("layer 1", function()
		{
			to([147.5, 0.5, "insine", 15, "bobX"]);
			to([159, 1, "insine", 5, "bobX"], {plr: [0, 1, 2, 3]});
			to([160.25, 1.75, "insine", 60, "rate"], {plr: [0, 1, 2, 3]});
			to([163.5, 0.5, "linear", 75, "zoom"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 11", function()
		{
			to([162, 2, "linear", 450, "drawAhead"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 18", function()
		{
			jump([163.75, 0, "hideHits"], {plr: [2, 3]});
		});

		layer("layer 2", function()
		{
			to([160, 0.4794, "outsine", 14, "skewY"]);
			to([160.4885, 0.25, "outsine", -14, "skewY"], {from: 14});
			to([160.7385, 0.25, "outsine", 14, "skewY"]);
			to([160.9885, 1, "outsine", 0, "skewY"], {from: 14});
			to([161.9885, 0.25, "outsine", -24, "skewY"], {from: 14});
			to([162.2385, 0.25, "outsine", 24, "skewY"]);
			to([162.4885, 0.25, "outsine", -24, "skewY"], {from: 14});
			to([162.7385, 0.25, "outsine", 24, "skewY"]);
			to([162.9885, 0.25, "insine", 0, "skewY"], {from: 37});
			to([163.4885, 0.25, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([160.9885, 0.25, "outsine", 14, "skewX"]);
			to([161.2385, 0.25, "outsine", -14, "skewX"]);
			to([161.4885, 0.25, "outsine", 14, "skewX"]);
			to([161.7385, 0.25, "outsine", -14, "skewX"]);
			to([162.9885, 0.25, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([163.4885, 0.25, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([160, 0.2294, "outsine", 25, "rowCenterX"]);
			to([160.4885, 0.25, "outsine", 50, "rowCenterX"]);
			to([160.7385, 0.25, "outsine", 75, "rowCenterX"]);
			to([160.9885, 0.5, "outsine", 100, "rowCenterX"]);
			to([162.9885, 0.25, "outsine", 50, "rowCenterX"]);
			to([163.4885, 0.25, "outsine", 50.5, "rowCenterX"]);
		});

		layer("layer 5", function()
		{
			to([160.9885, 0.5, "insine", 100, "fold"]);
			to([161.4885, 0.5, "outsine", -100, "fold"]);
			to([161.9885, 0.5, "insine", 0, "shiftY0"], {from: -50});
			to([162.4885, 0.5, "insine", 0, "shiftY2"], {from: -50});
			to([162.9885, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			jump([163.7385, 5, "bobX"]);
		});

		layer("layer 6", function()
		{
			to([132, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([132.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([133.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([134.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([135, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([135.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([136, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([136.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([137.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([138.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([139, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([139.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([140, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([140.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([141.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([142.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([143, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([143.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([144, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([144.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([145.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([146.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([147, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([147.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([148, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([148.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([149.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([150.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([151, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([151.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([152, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([152.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([153.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([154.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([155, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([155.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([156, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([156.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([157.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([158.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([159, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([159.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([162.2385, 0.5, "insine", 0, "shiftY1"], {from: 50});
			to([162.7385, 0.5, "insine", 0, "shiftY3"], {from: 50});
			to([163.4885, 1, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 7", function()
		{
			to([161.9885, 0.25, "outsine", 0, "faceZ0"], {from: 90});
			to([162.2385, 0.25, "outsine", 0, "faceZ1"], {from: -90});
			to([162.4885, 0.25, "outsine", 0, "faceZ2"], {from: 90});
			to([162.7385, 0.25, "outsine", 0, "faceZ3"], {from: -90});
			to([162.9885, 1, "outsine", 100, "fold"]);
			to([163.9885, 0.5, "outsine", 0, "fold"], {from: 16});
		});

		layer("layer 8", function()
		{
			to([160, 0.4794, "outsine", 0, "pinch"], {from: -50});
			to([160.4885, 0.5, "outsine", 0, "pinch"], {from: -50});
			to([160.9885, 0.25, "outsine", 0, "pinch"], {from: 25});
			to([161.2385, 0.25, "outsine", 0, "pinch"], {from: -25});
			to([161.4885, 0.25, "outsine", 0, "pinch"], {from: 25});
			to([161.7385, 0.25, "outsine", 0, "pinch"], {from: -25});
			to([161.9885, 1, "outsine", 0, "pinch"], {from: -25});
			to([162.9885, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([163.4885, 1.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 24", function()
		{
			to([163.5, 0.5, "insine", 0, "rowCenterY"]);
		});

		layer("layer 9", function()
		{
			to([159.5, 0.5, "insine", 0, "showPath"], {plr: 0});
			to([163, 1, "linear", 35, "drunk"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 13", function()
		{
			to([132, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([132.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([133.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([134.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([135, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([135.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([136, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([136.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([137.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([138.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([139, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([139.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([140, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([140.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([141.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([142.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([143, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([143.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([144, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([144.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([145.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([146.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([147, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([147.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([148, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([148.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([149.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([150.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([151, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([151.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([152, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([152.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([153.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([154.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([155, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([155.5, 0.5, "outsine", 100, "drunk"], {from: -100});
			to([156, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([156.75, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([157.5, 0.75, "outsine", -100, "drunk"], {from: 100});
			to([158.25, 0.75, "outsine", 100, "drunk"], {from: -100});
			to([159, 0.5, "outsine", -100, "drunk"], {from: 100});
			to([159.5, 0.5, "outsine", 0, "drunk"], {from: -100});
		});

		layer("layer 14", function()
		{
			to([132, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([132.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([133.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([134.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([135, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([135.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([136, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([136.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([137.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([138.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([139, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([139.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([140, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([140.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([141.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([142.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([143, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([143.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([144, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([144.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([145.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([146.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([147, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([147.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([148, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([148.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([149.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([150.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([151, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([151.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([152, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([152.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([153.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([154.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([155, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([155.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([156, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([156.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([157.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([158.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([159, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([159.5, 0.5, "arc", -4, "cam.rotZ"], {from: 0});
			to([162, 2, "insine", -8, "cam.rotZ"], {from: 0});
		});

		layer("layer 21", function()
		{
			to([132, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([132.5, 0.25, "insine", 30, "cam.y"]);
			to([132.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([133.25, 0.25, "insine", -30, "cam.y"]);
			to([133.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([134, 0.25, "insine", 30, "cam.y"]);
			to([134.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([134.75, 0.25, "insine", -30, "cam.y"]);
			to([135, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([135.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([136, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([136.5, 0.25, "insine", 30, "cam.y"]);
			to([136.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([137.25, 0.25, "insine", -30, "cam.y"]);
			to([137.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([138, 0.25, "insine", 30, "cam.y"]);
			to([138.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([138.75, 0.25, "insine", -30, "cam.y"]);
			to([139, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([139.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([140, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([140.5, 0.25, "insine", 30, "cam.y"]);
			to([140.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([141.25, 0.25, "insine", -30, "cam.y"]);
			to([141.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([142, 0.25, "insine", 30, "cam.y"]);
			to([142.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([142.75, 0.25, "insine", -30, "cam.y"]);
			to([143, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([143.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([144, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([144.5, 0.25, "insine", 30, "cam.y"]);
			to([144.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([145.25, 0.25, "insine", -30, "cam.y"]);
			to([145.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([146, 0.25, "insine", 30, "cam.y"]);
			to([146.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([146.75, 0.25, "insine", -30, "cam.y"]);
			to([147, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([147.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([148, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([148.5, 0.25, "insine", 30, "cam.y"]);
			to([148.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([149.25, 0.25, "insine", -30, "cam.y"]);
			to([149.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([150, 0.25, "insine", 30, "cam.y"]);
			to([150.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([150.75, 0.25, "insine", -30, "cam.y"]);
			to([151, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([151.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([152, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([152.5, 0.25, "insine", 30, "cam.y"]);
			to([152.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([153.25, 0.25, "insine", -30, "cam.y"]);
			to([153.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([154, 0.25, "insine", 30, "cam.y"]);
			to([154.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([154.75, 0.25, "insine", -30, "cam.y"]);
			to([155, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([155.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([156, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([156.5, 0.25, "insine", 30, "cam.y"]);
			to([156.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([157.25, 0.25, "insine", -30, "cam.y"]);
			to([157.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([158, 0.25, "insine", 30, "cam.y"]);
			to([158.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([158.75, 0.25, "insine", -30, "cam.y"]);
			to([159, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([159.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
		});

		layer("layer 22", function()
		{
			to([145.5, 1, "insine", 180, "tiltZ"]);
			to([160, 1, "insine", 0, "tiltZ"]);
		});

		layer("layer 28", function()
		{
			to([145.5, 1, "insine", 26.5, "fieldX"]);
			to([160, 1, "insine", 0, "fieldX"]);
		});

		layer("layer 29", function()
		{
			to([145.5, 1, "insine", 141.5, "fieldY"]);
			to([160, 1, "insine", 0, "fieldY"]);
		});

		layer("layer 30", function()
		{
			to([145.5, 1, "insine", 180, "faceZ"]);
			to([159.5, 0.5, "insine", 0, "mirror"]);
			to([160, 1, "insine", 0, "faceZ"]);
		});

		layer("layer 31", function()
		{
			to([145.5, 1, "insine", 100, "mirror"]);
			to([159, 1, "insine", 0, "dim"], {plr: 0});
		});

		layer("layer 32", function()
		{
			to([145, 1.5, "insine", 100, "blind"], {plr: 0});
			to([159, 1, "insine", 0, "blind"], {plr: 0});
		});

		layer("layer 15", function()
		{
			to([163.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 16", function()
		{
			to([163.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 17", function()
		{
			to([163.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 23", function()
		{
			to([163.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
		});

		// -- chorus @ 164 --
		layer("layer 1", function()
		{
			to([195, 1, "insine", 0, "rowCenterX"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 18", function()
		{
			to([164, 8, "insine", 100, "zoom"], {plr: [0, 1, 2, 3]});
			to([172, 8, "outsine", 75, "zoom"], {plr: [0, 1, 2, 3]});
			to([180, 8, "insine", 100, "zoom"], {plr: [0, 1, 2, 3]});
			to([188, 7, "outsine", 75, "zoom"], {plr: [0, 1, 2, 3]});
			to([195, 1, "insine", 100, "zoom"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 19", function()
		{
			jump([195.75, 100, "hideHits"], {plr: [2, 3]});
		});

		layer("layer 20 2", function()
		{
			to([164, 1, "insine", 45, "dim"], {plr: [0, 2]});
			to([191, 3, "insine", 100, "dim"], {plr: [2, 3]});
			to([195, 1, "insine", 0, "dim"], {plr: 0});
		});

		layer("layer 25", function()
		{
			to([164, 1, "insine", 45, "blind"], {plr: [0, 2]});
			to([191, 3, "insine", 100, "blind"], {plr: [2, 3]});
			to([195, 1, "insine", 0, "blind"], {plr: 0});
		});

		layer("layer 26", function()
		{
			to([195, 1, "insine", 45, "rate"]);
		});

		layer("layer 2", function()
		{
			to([195, 0.5, "insine", 0, "skewY"], {from: 37});
			to([195.5, 1, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([195, 0.5, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([195.5, 1, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([195, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			to([195.5, 1, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 5", function()
		{
			to([195, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([195.5, 1.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 9", function()
		{
			to([194, 1, "insine", 0, "drunk"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 14", function()
		{
			to([164, 2, "outsine", -4, "cam.rotZ"]);
			to([166, 2, "insine", 0, "cam.rotZ"]);
			to([168, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([170, 2, "insine", 0, "cam.rotZ"]);
			to([172, 2, "outsine", -4, "cam.rotZ"]);
			to([174, 2, "insine", 0, "cam.rotZ"]);
			to([176, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([178, 2, "insine", 0, "cam.rotZ"]);
			to([180, 2, "outsine", -4, "cam.rotZ"]);
			to([182, 2, "insine", 0, "cam.rotZ"]);
			to([184, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([186, 2, "insine", 0, "cam.rotZ"]);
			to([188, 2, "outsine", -4, "cam.rotZ"]);
			to([190, 2, "insine", 0, "cam.rotZ"]);
			to([192, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([194, 2, "insine", 8, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([195.75, 0.25, "insine", -15, "cam.y"]);
		});

		layer("layer 15", function()
		{
			to([164, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([164.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([165, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([165.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([166, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([166.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([167, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([167.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([168, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([168.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([169, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([169.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([170, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([170.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([171, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([171.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([172, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([172.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([173, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([173.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([174, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([174.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([175, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([175.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([176, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([176.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([177, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([177.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([178, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([178.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([179, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([179.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([180, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([180.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([181, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([181.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([182, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([182.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([183, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([183.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([184, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([184.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([185, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([185.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([186, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([186.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([187, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([187.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([188, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([188.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([189, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([189.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([190, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([190.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([191, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([191.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([192, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([192.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([193, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([193.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([194, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
		});

		layer("layer 16", function()
		{
			to([164, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([164.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([165, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([165.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([166, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([166.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([167, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([167.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([168, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([168.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([169, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([169.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([170, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([170.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([171, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([171.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([172, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([172.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([173, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([173.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([174, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([174.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([175, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([175.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([176, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([176.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([177, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([177.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([178, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([178.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([179, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([179.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([180, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([180.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([181, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([181.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([182, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([182.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([183, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([183.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([184, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([184.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([185, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([185.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([186, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([186.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([187, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([187.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([188, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([188.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([189, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([189.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([190, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([190.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([191, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([191.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([192, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([192.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([193, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([193.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([194, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([195.75, 0.5, "insine", -15, "shiftY"]);
		});

		layer("layer 17", function()
		{
			to([164, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([164.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([165, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([165.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([166, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([166.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([167, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([167.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([168, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([168.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([169, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([169.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([170, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([170.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([171, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([171.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([172, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([172.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([173, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([173.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([174, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([174.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([175, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([175.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([176, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([176.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([177, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([177.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([178, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([178.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([179, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([179.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([180, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([180.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([181, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([181.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([182, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([182.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([183, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([183.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([184, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([184.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([185, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([185.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([186, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([186.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([187, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([187.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([188, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([188.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([189, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([189.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([190, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([190.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([191, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([191.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([192, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([192.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([193, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([193.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([194, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
		});

		layer("layer 23", function()
		{
			to([164, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([164.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([165, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([165.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([166, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([166.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([167, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([167.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([168, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([168.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([169, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([169.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([170, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([170.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([171, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([171.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([172, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([172.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([173, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([173.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([174, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([174.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([175, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([175.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([176, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([176.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([177, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([177.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([178, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([178.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([179, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([179.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([180, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([180.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([181, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([181.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([182, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([182.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([183, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([183.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([184, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([184.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([185, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([185.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([186, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([186.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([187, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([187.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([188, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([188.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([189, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([189.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([190, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([190.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([191, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([191.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([192, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([192.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([193, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([193.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([194, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 38", function()
		{
			every([164, 32, "ring", [164, 8, 32, 561, 1095, 100, 50, 100.5, 100]]);
		});

		// -- verse 2 @ 196 --
		layer("layer 1", function()
		{
			to([198.5, 0.5, "insine", 100, "mirror"]);
			to([200, 0.5, "outsine", 0, "mirror"]);
			to([206.5, 0.5, "insine", 100, "mirror"]);
			to([208, 0.5, "outsine", 0, "mirror"]);
			to([213.75, 0.75, "insine", -100, "laneX2"]);
			to([215.25, 0.25, "outsine", 0, "laneX2"]);
			to([221.75, 0.75, "insine", -100, "laneX2"]);
			to([223.25, 0.25, "outsine", 0, "laneX2"]);
			to([227, 1, "insine", 50, "blind"], {plr: 0});
		});

		layer("layer 11", function()
		{
			to([201, 1.75, "insine", 0, "dim"], {plr: 1});
			to([212.5, 0.75, "insine", 100, "laneX0"]);
			to([214.25, 0.25, "outsine", 0, "laneX0"]);
			to([215.5, 0.75, "insine", 100, "laneX1"]);
			to([217.25, 0.25, "outsine", 0, "laneX1"]);
			to([220.5, 0.75, "insine", 100, "laneX0"]);
			to([222.25, 0.25, "outsine", 0, "laneX0"]);
			to([223.5, 0.75, "insine", 100, "laneX1"]);
			to([225.25, 0.25, "outsine", 0, "laneX1"]);
			to([227, 1, "insine", 100, "rowCenterX"]);
		});

		layer("layer 18", function()
		{
			to([201, 1.75, "insine", 0, "blind"], {plr: 1, from: 100});
			to([227, 1, "linear", 28.5, "fieldZ"], {plr: 0});
		});

		layer("layer 19", function()
		{
			to([227, 1, "insine", 40, "rate"]);
		});

		layer("layer 20 2", function()
		{
			to([227, 1, "insine", 100, "dim"], {plr: 0});
		});

		layer("layer 25", function()
		{
			jump([227, 100, "hideHits"], {plr: 0});
		});

		layer("layer 9", function()
		{
			to([227, 1, "insine", 25, "tornado"]);
		});

		layer("layer 13", function()
		{
			to([196, 1, "insine", 100, "drunk"]);
			to([197, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([197.5, 0.25, "insine", -100, "drunk"]);
			to([197.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([198.25, 0.25, "insine", 100, "drunk"]);
			to([198.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([199, 0.25, "insine", -100, "drunk"]);
			to([199.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([199.75, 0.25, "insine", 100, "drunk"]);
			to([200, 0.5, "insine", -100, "drunk"], {from: 100});
			to([200.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([201, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([201.5, 0.25, "insine", -100, "drunk"]);
			to([201.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([202.25, 0.25, "insine", 100, "drunk"]);
			to([202.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([203, 0.25, "insine", -100, "drunk"]);
			to([203.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([203.75, 0.25, "insine", 100, "drunk"]);
			to([204, 0.5, "insine", -100, "drunk"], {from: 100});
			to([204.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([205, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([205.5, 0.25, "insine", -100, "drunk"]);
			to([205.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([206.25, 0.25, "insine", 100, "drunk"]);
			to([206.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([207, 0.25, "insine", -100, "drunk"]);
			to([207.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([207.75, 0.25, "insine", 100, "drunk"]);
			to([208, 0.5, "insine", -100, "drunk"], {from: 100});
			to([208.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([209, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([209.5, 0.25, "insine", -100, "drunk"]);
			to([209.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([210.25, 0.25, "insine", 100, "drunk"]);
			to([210.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([211, 0.25, "insine", -100, "drunk"]);
			to([211.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([211.75, 0.25, "insine", 100, "drunk"]);
			to([212, 0.5, "insine", -100, "drunk"], {from: 100});
			to([212.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([213, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([213.5, 0.25, "insine", -100, "drunk"]);
			to([213.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([214.25, 0.25, "insine", 100, "drunk"]);
			to([214.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([215, 0.25, "insine", -100, "drunk"]);
			to([215.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([215.75, 0.25, "insine", 100, "drunk"]);
			to([216, 0.5, "insine", -100, "drunk"], {from: 100});
			to([216.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([217, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([217.5, 0.25, "insine", -100, "drunk"]);
			to([217.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([218.25, 0.25, "insine", 100, "drunk"]);
			to([218.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([219, 0.25, "insine", -100, "drunk"]);
			to([219.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([219.75, 0.25, "insine", 100, "drunk"]);
			to([220, 0.5, "insine", -100, "drunk"], {from: 100});
			to([220.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([221, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([221.5, 0.25, "insine", -100, "drunk"]);
			to([221.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([222.25, 0.25, "insine", 100, "drunk"]);
			to([222.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([223, 0.25, "insine", -100, "drunk"]);
			to([223.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([223.75, 0.25, "insine", 100, "drunk"]);
			to([224, 0.5, "insine", -100, "drunk"], {from: 100});
			to([224.5, 0.5, "insine", 100, "drunk"], {from: -100});
			to([225, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([225.5, 0.25, "insine", -100, "drunk"]);
			to([225.75, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([226.25, 0.25, "insine", 100, "drunk"]);
			to([226.5, 0.5, "outsine", 0, "drunk"], {from: 100});
			to([227, 0.25, "insine", -100, "drunk"]);
			to([227.25, 0.5, "outsine", 0, "drunk"], {from: -100});
			to([227.75, 0.25, "insine", 100, "drunk"]);
		});

		layer("layer 14", function()
		{
			to([196, 1, "outsine", 0, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([196, 0.5, "outsine", 0, "cam.y"]);
			to([196.75, 0.25, "insine", -15, "cam.y"]);
			to([197, 0.5, "outsine", 0, "cam.y"]);
			to([197.75, 0.25, "insine", -15, "cam.y"]);
			to([198, 0.5, "outsine", 0, "cam.y"]);
			to([198.75, 0.25, "insine", -15, "cam.y"]);
			to([199, 0.5, "outsine", 0, "cam.y"]);
			to([199.75, 0.25, "insine", -15, "cam.y"]);
			to([200, 0.5, "outsine", 0, "cam.y"]);
			to([200.75, 0.25, "insine", -15, "cam.y"]);
			to([201, 0.5, "outsine", 0, "cam.y"]);
			to([201.75, 0.25, "insine", -15, "cam.y"]);
			to([202, 0.5, "outsine", 0, "cam.y"]);
			to([202.75, 0.25, "insine", -15, "cam.y"]);
			to([203, 0.5, "outsine", 0, "cam.y"]);
			to([203.75, 0.25, "insine", -15, "cam.y"]);
			to([204, 0.5, "outsine", 0, "cam.y"]);
			to([204.75, 0.25, "insine", -15, "cam.y"]);
			to([205, 0.5, "outsine", 0, "cam.y"]);
			to([205.75, 0.25, "insine", -15, "cam.y"]);
			to([206, 0.5, "outsine", 0, "cam.y"]);
			to([206.75, 0.25, "insine", -15, "cam.y"]);
			to([207, 0.5, "outsine", 0, "cam.y"]);
			to([207.75, 0.25, "insine", -15, "cam.y"]);
			to([208, 0.5, "outsine", 0, "cam.y"]);
			to([208.75, 0.25, "insine", -15, "cam.y"]);
			to([209, 0.5, "outsine", 0, "cam.y"]);
			to([209.75, 0.25, "insine", -15, "cam.y"]);
			to([210, 0.5, "outsine", 0, "cam.y"]);
			to([210.75, 0.25, "insine", -15, "cam.y"]);
			to([211, 0.5, "outsine", 0, "cam.y"]);
			to([211.75, 0.25, "insine", -15, "cam.y"]);
			to([212, 0.5, "outsine", 0, "cam.y"]);
			to([212.75, 0.25, "insine", -15, "cam.y"]);
			to([213, 0.5, "outsine", 0, "cam.y"]);
			to([213.75, 0.25, "insine", -15, "cam.y"]);
			to([214, 0.5, "outsine", 0, "cam.y"]);
			to([214.75, 0.25, "insine", -15, "cam.y"]);
			to([215, 0.5, "outsine", 0, "cam.y"]);
			to([215.75, 0.25, "insine", -15, "cam.y"]);
			to([216, 0.5, "outsine", 0, "cam.y"]);
			to([216.75, 0.25, "insine", -15, "cam.y"]);
			to([217, 0.5, "outsine", 0, "cam.y"]);
			to([217.75, 0.25, "insine", -15, "cam.y"]);
			to([218, 0.5, "outsine", 0, "cam.y"]);
			to([218.75, 0.25, "insine", -15, "cam.y"]);
			to([219, 0.5, "outsine", 0, "cam.y"]);
			to([219.75, 0.25, "insine", -15, "cam.y"]);
			to([220, 0.5, "outsine", 0, "cam.y"]);
			to([220.75, 0.25, "insine", -15, "cam.y"]);
			to([221, 0.5, "outsine", 0, "cam.y"]);
			to([221.75, 0.25, "insine", -15, "cam.y"]);
			to([222, 0.5, "outsine", 0, "cam.y"]);
			to([222.75, 0.25, "insine", -15, "cam.y"]);
			to([223, 0.5, "outsine", 0, "cam.y"]);
			to([223.75, 0.25, "insine", -15, "cam.y"]);
			to([224, 0.5, "outsine", 0, "cam.y"]);
			to([224.75, 0.25, "insine", -15, "cam.y"]);
			to([225, 0.5, "outsine", 0, "cam.y"]);
			to([225.75, 0.25, "insine", -15, "cam.y"]);
			to([226, 0.5, "outsine", 0, "cam.y"]);
			to([226.75, 0.25, "insine", -15, "cam.y"]);
			to([227, 0.5, "outsine", 0, "cam.y"]);
			to([227.75, 0.25, "insine", -15, "cam.y"]);
		});

		layer("layer 22", function()
		{
			to([196, 1, "outsine", 0, "cam.x"]);
			to([203, 1, "insine", -8, "cam.rotZ"]);
			to([204, 1, "outsine", 0, "cam.rotZ"]);
			to([211, 1, "insine", 8, "cam.rotZ"]);
			to([212, 1, "outsine", 0, "cam.rotZ"]);
			to([219, 1, "insine", -8, "cam.rotZ"]);
			to([220, 1, "outsine", 0, "cam.rotZ"]);
		});

		layer("layer 15", function()
		{
			to([196, 0.25, "insine", 60, "pinchX"]);
			to([196.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([197, 0.25, "insine", 60, "pinchX"]);
			to([197.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([198, 0.25, "insine", 60, "pinchX"]);
			to([198.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([199, 0.25, "insine", 60, "pinchX"]);
			to([199.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([200, 0.25, "insine", 60, "pinchX"]);
			to([200.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([201, 0.25, "insine", 60, "pinchX"]);
			to([201.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([202, 0.25, "insine", 60, "pinchX"]);
			to([202.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([203, 0.25, "insine", 60, "pinchX"]);
			to([203.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([204, 0.25, "insine", 60, "pinchX"]);
			to([204.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([205, 0.25, "insine", 60, "pinchX"]);
			to([205.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([206, 0.25, "insine", 60, "pinchX"]);
			to([206.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([207, 0.25, "insine", 60, "pinchX"]);
			to([207.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([208, 0.25, "insine", 60, "pinchX"]);
			to([208.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([209, 0.25, "insine", 60, "pinchX"]);
			to([209.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([210, 0.25, "insine", 60, "pinchX"]);
			to([210.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([211, 0.25, "insine", 60, "pinchX"]);
			to([211.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([212, 0.25, "insine", 60, "pinchX"]);
			to([212.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([213, 0.25, "insine", 60, "pinchX"]);
			to([213.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([214, 0.25, "insine", 60, "pinchX"]);
			to([214.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([215, 0.25, "insine", 60, "pinchX"]);
			to([215.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([216, 0.25, "insine", 60, "pinchX"]);
			to([216.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([217, 0.25, "insine", 60, "pinchX"]);
			to([217.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([218, 0.25, "insine", 60, "pinchX"]);
			to([218.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([219, 0.25, "insine", 60, "pinchX"]);
			to([219.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([220, 0.25, "insine", 60, "pinchX"]);
			to([220.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([221, 0.25, "insine", 60, "pinchX"]);
			to([221.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([222, 0.25, "insine", 60, "pinchX"]);
			to([222.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([223, 0.25, "insine", 60, "pinchX"]);
			to([223.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([224, 0.25, "insine", 60, "pinchX"]);
			to([224.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([225, 0.25, "insine", 60, "pinchX"]);
			to([225.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([226, 0.25, "insine", 60, "pinchX"]);
			to([226.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
			to([227, 0.25, "insine", 60, "pinchX"]);
			to([227.25, 0.25, "outsine", 0, "pinchX"], {from: 60});
		});

		layer("layer 16", function()
		{
			to([196.25, 0.5, "outsine", 0, "shiftY"]);
			to([196.75, 0.5, "insine", -15, "shiftY"]);
			to([197.25, 0.5, "outsine", 0, "shiftY"]);
			to([197.75, 0.5, "insine", -15, "shiftY"]);
			to([198.25, 0.5, "outsine", 0, "shiftY"]);
			to([198.75, 0.5, "insine", -15, "shiftY"]);
			to([199.25, 0.5, "outsine", 0, "shiftY"]);
			to([199.75, 0.5, "insine", -15, "shiftY"]);
			to([200.25, 0.5, "outsine", 0, "shiftY"]);
			to([200.75, 0.5, "insine", -15, "shiftY"]);
			to([201.25, 0.5, "outsine", 0, "shiftY"]);
			to([201.75, 0.5, "insine", -15, "shiftY"]);
			to([202.25, 0.5, "outsine", 0, "shiftY"]);
			to([202.75, 0.5, "insine", -15, "shiftY"]);
			to([203.25, 0.5, "outsine", 0, "shiftY"]);
			to([203.75, 0.5, "insine", -15, "shiftY"]);
			to([204.25, 0.5, "outsine", 0, "shiftY"]);
			to([204.75, 0.5, "insine", -15, "shiftY"]);
			to([205.25, 0.5, "outsine", 0, "shiftY"]);
			to([205.75, 0.5, "insine", -15, "shiftY"]);
			to([206.25, 0.5, "outsine", 0, "shiftY"]);
			to([206.75, 0.5, "insine", -15, "shiftY"]);
			to([207.25, 0.5, "outsine", 0, "shiftY"]);
			to([207.75, 0.5, "insine", -15, "shiftY"]);
			to([208.25, 0.5, "outsine", 0, "shiftY"]);
			to([208.75, 0.5, "insine", -15, "shiftY"]);
			to([209.25, 0.5, "outsine", 0, "shiftY"]);
			to([209.75, 0.5, "insine", -15, "shiftY"]);
			to([210.25, 0.5, "outsine", 0, "shiftY"]);
			to([210.75, 0.5, "insine", -15, "shiftY"]);
			to([211.25, 0.5, "outsine", 0, "shiftY"]);
			to([211.75, 0.5, "insine", -15, "shiftY"]);
			to([212.25, 0.5, "outsine", 0, "shiftY"]);
			to([212.75, 0.5, "insine", -15, "shiftY"]);
			to([213.25, 0.5, "outsine", 0, "shiftY"]);
			to([213.75, 0.5, "insine", -15, "shiftY"]);
			to([214.25, 0.5, "outsine", 0, "shiftY"]);
			to([214.75, 0.5, "insine", -15, "shiftY"]);
			to([215.25, 0.5, "outsine", 0, "shiftY"]);
			to([215.75, 0.5, "insine", -15, "shiftY"]);
			to([216.25, 0.5, "outsine", 0, "shiftY"]);
			to([216.75, 0.5, "insine", -15, "shiftY"]);
			to([217.25, 0.5, "outsine", 0, "shiftY"]);
			to([217.75, 0.5, "insine", -15, "shiftY"]);
			to([218.25, 0.5, "outsine", 0, "shiftY"]);
			to([218.75, 0.5, "insine", -15, "shiftY"]);
			to([219.25, 0.5, "outsine", 0, "shiftY"]);
			to([219.75, 0.5, "insine", -15, "shiftY"]);
			to([220.25, 0.5, "outsine", 0, "shiftY"]);
			to([220.75, 0.5, "insine", -15, "shiftY"]);
			to([221.25, 0.5, "outsine", 0, "shiftY"]);
			to([221.75, 0.5, "insine", -15, "shiftY"]);
			to([222.25, 0.5, "outsine", 0, "shiftY"]);
			to([222.75, 0.5, "insine", -15, "shiftY"]);
			to([223.25, 0.5, "outsine", 0, "shiftY"]);
			to([223.75, 0.5, "insine", -15, "shiftY"]);
			to([224.25, 0.5, "outsine", 0, "shiftY"]);
			to([224.75, 0.5, "insine", -15, "shiftY"]);
			to([225.25, 0.5, "outsine", 0, "shiftY"]);
			to([225.75, 0.5, "insine", -15, "shiftY"]);
			to([226.25, 0.5, "outsine", 0, "shiftY"]);
			to([226.75, 0.5, "insine", -15, "shiftY"]);
			to([227.25, 0.5, "outsine", 0, "shiftY"]);
		});

		layer("layer 17", function()
		{
			to([196, 0.25, "insine", -60, "pinchY"]);
			to([196.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([197, 0.25, "insine", -60, "pinchY"]);
			to([197.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([198, 0.25, "insine", -60, "pinchY"]);
			to([198.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([199, 0.25, "insine", -60, "pinchY"]);
			to([199.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([200, 0.25, "insine", -60, "pinchY"]);
			to([200.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([201, 0.25, "insine", -60, "pinchY"]);
			to([201.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([202, 0.25, "insine", -60, "pinchY"]);
			to([202.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([203, 0.25, "insine", -60, "pinchY"]);
			to([203.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([204, 0.25, "insine", -60, "pinchY"]);
			to([204.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([205, 0.25, "insine", -60, "pinchY"]);
			to([205.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([206, 0.25, "insine", -60, "pinchY"]);
			to([206.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([207, 0.25, "insine", -60, "pinchY"]);
			to([207.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([208, 0.25, "insine", -60, "pinchY"]);
			to([208.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([209, 0.25, "insine", -60, "pinchY"]);
			to([209.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([210, 0.25, "insine", -60, "pinchY"]);
			to([210.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([211, 0.25, "insine", -60, "pinchY"]);
			to([211.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([212, 0.25, "insine", -60, "pinchY"]);
			to([212.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([213, 0.25, "insine", -60, "pinchY"]);
			to([213.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([214, 0.25, "insine", -60, "pinchY"]);
			to([214.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([215, 0.25, "insine", -60, "pinchY"]);
			to([215.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([216, 0.25, "insine", -60, "pinchY"]);
			to([216.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([217, 0.25, "insine", -60, "pinchY"]);
			to([217.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([218, 0.25, "insine", -60, "pinchY"]);
			to([218.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([219, 0.25, "insine", -60, "pinchY"]);
			to([219.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([220, 0.25, "insine", -60, "pinchY"]);
			to([220.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([221, 0.25, "insine", -60, "pinchY"]);
			to([221.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([222, 0.25, "insine", -60, "pinchY"]);
			to([222.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([223, 0.25, "insine", -60, "pinchY"]);
			to([223.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([224, 0.25, "insine", -60, "pinchY"]);
			to([224.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([225, 0.25, "insine", -60, "pinchY"]);
			to([225.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([226, 0.25, "insine", -60, "pinchY"]);
			to([226.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
			to([227, 0.25, "insine", -60, "pinchY"]);
			to([227.25, 0.25, "outsine", 0, "pinchY"], {from: -60});
		});

		// -- pre-drop 2 @ 228 --
		layer("layer 1", function()
		{
			to([228, 16, "arc", 180, "spinY"]);
			to([244, 16, "arc", -180, "spinY"]);
		});

		layer("layer 11", function()
		{
			to([256, 4, "insine", 10, "rowCenterX"]);
		});

		layer("layer 19", function()
		{
			to([256, 4, "outsine", 0, "blind"], {plr: 0});
		});

		layer("layer 20 2", function()
		{
			to([246, 2.75, "insine", 35, "fadeNear"]);
			to([256, 4, "outsine", 0, "dim"], {plr: 0});
		});

		layer("layer 25", function()
		{
			to([257, 2, "outsine", 0, "fadeNear"]);
		});

		layer("layer 26", function()
		{
			jump([257.75, 0, "hideHits"], {plr: 0});
		});

		layer("layer 9", function()
		{
			to([228, 16, "arc", -25, "incomeAngle"]);
			to([244, 16, "arc", 25, "incomeAngle"]);
		});

		layer("layer 10", function()
		{
			to([258, 2, "insine", 0, "tornado"]);
		});

		layer("layer 20", function()
		{
			to([258, 2, "linear", 100, "surge"]);
		});

		layer("layer 13", function()
		{
			to([228, 1, "outsine", 25, "drunk"], {from: 100});
			to([229, 1, "insine", -50, "drunk"]);
			to([230, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([231, 1, "insine", 50, "drunk"]);
			to([232, 1, "outsine", 0, "drunk"], {from: 50});
			to([233, 1, "insine", -50, "drunk"]);
			to([234, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([235, 1, "insine", 50, "drunk"]);
			to([236, 1, "outsine", 25, "drunk"], {from: 100});
			to([237, 1, "insine", -50, "drunk"]);
			to([238, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([239, 1, "insine", 50, "drunk"]);
			to([240, 1, "outsine", 0, "drunk"], {from: 50});
			to([241, 1, "insine", -50, "drunk"]);
			to([242, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([243, 1, "insine", 50, "drunk"]);
			to([244, 1, "outsine", 25, "drunk"], {from: 100});
			to([245, 1, "insine", -50, "drunk"]);
			to([246, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([247, 1, "insine", 50, "drunk"]);
			to([248, 1, "outsine", 0, "drunk"], {from: 50});
			to([249, 1, "insine", -50, "drunk"]);
			to([250, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([251, 1, "insine", 50, "drunk"]);
			to([252, 1, "outsine", 25, "drunk"], {from: 100});
			to([253, 1, "insine", -50, "drunk"]);
			to([254, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([255, 1, "insine", 50, "drunk"]);
			to([256, 1, "outsine", 0, "drunk"], {from: 50});
			to([257, 1, "insine", -50, "drunk"]);
			to([258, 1, "outsine", 0, "drunk"], {from: -49.5});
			to([259, 1, "insine", 50, "drunk"]);
		});

		layer("layer 39", function()
		{
			to([258, 2, "linear", 267.5, "drawAhead"]);
		});

		layer("layer 21", function()
		{
			to([228, 0.5, "outsine", 0, "cam.y"]);
			to([228.75, 0.25, "insine", -15, "cam.y"]);
			to([229, 0.5, "outsine", 0, "cam.y"]);
			to([229.75, 0.25, "insine", -15, "cam.y"]);
			to([230, 0.5, "outsine", 0, "cam.y"]);
			to([230.75, 0.25, "insine", -15, "cam.y"]);
			to([231, 0.5, "outsine", 0, "cam.y"]);
			to([231.75, 0.25, "insine", -15, "cam.y"]);
			to([232, 0.5, "outsine", 0, "cam.y"]);
			to([232.75, 0.25, "insine", -15, "cam.y"]);
			to([233, 0.5, "outsine", 0, "cam.y"]);
			to([233.75, 0.25, "insine", -15, "cam.y"]);
			to([234, 0.5, "outsine", 0, "cam.y"]);
			to([234.75, 0.25, "insine", -15, "cam.y"]);
			to([235, 0.5, "outsine", 0, "cam.y"]);
			to([235.75, 0.25, "insine", -15, "cam.y"]);
			to([236, 0.5, "outsine", 0, "cam.y"]);
			to([236.75, 0.25, "insine", -15, "cam.y"]);
			to([237, 0.5, "outsine", 0, "cam.y"]);
			to([237.75, 0.25, "insine", -15, "cam.y"]);
			to([238, 0.5, "outsine", 0, "cam.y"]);
			to([238.75, 0.25, "insine", -15, "cam.y"]);
			to([239, 0.5, "outsine", 0, "cam.y"]);
			to([239.75, 0.25, "insine", -15, "cam.y"]);
			to([240, 0.5, "outsine", 0, "cam.y"]);
			to([240.75, 0.25, "insine", -15, "cam.y"]);
			to([241, 0.5, "outsine", 0, "cam.y"]);
			to([241.75, 0.25, "insine", -15, "cam.y"]);
			to([242, 0.5, "outsine", 0, "cam.y"]);
			to([242.75, 0.25, "insine", -15, "cam.y"]);
			to([243, 0.5, "outsine", 0, "cam.y"]);
			to([243.75, 0.25, "insine", -15, "cam.y"]);
			to([244, 0.5, "outsine", 0, "cam.y"]);
			to([244.75, 0.25, "insine", -15, "cam.y"]);
			to([245, 0.5, "outsine", 0, "cam.y"]);
			to([245.75, 0.25, "insine", -15, "cam.y"]);
			to([246, 0.5, "outsine", 0, "cam.y"]);
			to([246.75, 0.25, "insine", -15, "cam.y"]);
			to([247, 0.5, "outsine", 0, "cam.y"]);
			to([247.75, 0.25, "insine", -15, "cam.y"]);
			to([248, 0.5, "outsine", 0, "cam.y"]);
			to([248.75, 0.25, "insine", -15, "cam.y"]);
			to([249, 0.5, "outsine", 0, "cam.y"]);
			to([249.75, 0.25, "insine", -15, "cam.y"]);
			to([250, 0.5, "outsine", 0, "cam.y"]);
			to([250.75, 0.25, "insine", -15, "cam.y"]);
			to([251, 0.5, "outsine", 0, "cam.y"]);
			to([251.75, 0.25, "insine", -15, "cam.y"]);
			to([252, 0.5, "outsine", 0, "cam.y"]);
			to([252.75, 0.25, "insine", -15, "cam.y"]);
			to([253, 0.5, "outsine", 0, "cam.y"]);
			to([253.75, 0.25, "insine", -15, "cam.y"]);
			to([254, 0.5, "outsine", 0, "cam.y"]);
			to([254.75, 0.25, "insine", -15, "cam.y"]);
			to([255, 0.5, "outsine", 0, "cam.y"]);
			to([255.75, 0.25, "insine", -15, "cam.y"]);
			to([256, 0.5, "outsine", 0, "cam.y"]);
			to([256.75, 0.25, "insine", -15, "cam.y"]);
			to([257, 0.5, "outsine", 0, "cam.y"]);
			to([257.75, 0.25, "insine", -15, "cam.y"]);
			to([258, 0.5, "outsine", 0, "cam.y"]);
			to([258.75, 0.25, "insine", -15, "cam.y"]);
			to([259, 0.5, "outsine", 0, "cam.y"]);
			to([259.75, 0.25, "insine", -15, "cam.y"]);
		});

		// -- buildup @ 260 --
		layer("layer 18", function()
		{
			jump([291.75, 0, "hideHits"], {plr: [2, 3]});
		});

		layer("layer 9", function()
		{
			to([275, 1, "insine", 200, "rowCenterX"]);
			to([276, 2, "insine", 175, "rowCenterX"]);
			to([278, 1, "outsine", 200, "rowCenterX"]);
			to([279, 1, "insine", 0, "rowCenterX"]);
			to([280, 2, "insine", 25, "rowCenterX"]);
			to([282, 1, "outsine", 0, "rowCenterX"]);
			to([283, 1, "insine", 200, "rowCenterX"]);
			to([287, 1, "insine", 0, "rowCenterX"]);
			to([291, 1, "linear", 35, "drunk"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 10", function()
		{
			to([290, 2, "insine", 0, "surge"]);
		});

		layer("layer 20", function()
		{
			to([291.5, 1, "insine", 100, "flipRow"], {plr: [1, 3]});
		});

		layer("layer 13", function()
		{
			to([291, 0.75, "linear", 300, "drawAhead"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 14", function()
		{
			to([275, 1, "insine", -5, "cam.rotZ"]);
			to([276, 1, "outsine", 0, "cam.rotZ"]);
			to([277.5, 0.5, "insine", 2.5, "cam.rotZ"]);
			to([278, 1, "outsine", 0, "cam.rotZ"]);
			to([279, 1, "insine", -5, "cam.rotZ"]);
			to([280, 1, "outsine", 0, "cam.rotZ"]);
			to([281.5, 0.5, "insine", 2.5, "cam.rotZ"]);
			to([282, 1, "outsine", 0, "cam.rotZ"]);
			to([283, 1, "insine", -5, "cam.rotZ"]);
			to([284, 1, "outsine", 0, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([260, 0.5, "outsine", 0, "cam.y"]);
			to([260.75, 0.25, "insine", -15, "cam.y"]);
			to([261, 0.5, "outsine", 0, "cam.y"]);
			to([261.75, 0.25, "insine", -15, "cam.y"]);
			to([262, 0.5, "outsine", 0, "cam.y"]);
			to([262.75, 0.25, "insine", -15, "cam.y"]);
			to([263, 0.5, "outsine", 0, "cam.y"]);
			to([263.75, 0.25, "insine", -15, "cam.y"]);
			to([264, 0.5, "outsine", 0, "cam.y"]);
			to([264.75, 0.25, "insine", -15, "cam.y"]);
			to([265, 0.5, "outsine", 0, "cam.y"]);
			to([265.75, 0.25, "insine", -15, "cam.y"]);
			to([266, 0.5, "outsine", 0, "cam.y"]);
			to([266.75, 0.25, "insine", -15, "cam.y"]);
			to([267, 0.5, "outsine", 0, "cam.y"]);
			to([267.75, 0.25, "insine", -15, "cam.y"]);
			to([268, 0.5, "outsine", 0, "cam.y"]);
			to([268.75, 0.25, "insine", -15, "cam.y"]);
			to([269, 0.5, "outsine", 0, "cam.y"]);
			to([269.75, 0.25, "insine", -15, "cam.y"]);
			to([270, 0.5, "outsine", 0, "cam.y"]);
			to([270.75, 0.25, "insine", -15, "cam.y"]);
			to([271, 0.5, "outsine", 0, "cam.y"]);
			to([271.75, 0.25, "insine", -15, "cam.y"]);
			to([272, 0.5, "outsine", 0, "cam.y"]);
			to([272.75, 0.25, "insine", -15, "cam.y"]);
			to([273, 0.5, "outsine", 0, "cam.y"]);
			to([273.75, 0.25, "insine", -15, "cam.y"]);
			to([274, 0.5, "outsine", 0, "cam.y"]);
			to([274.75, 0.25, "insine", -15, "cam.y"]);
			to([275, 0.5, "outsine", 0, "cam.y"]);
			to([275.75, 0.25, "insine", -15, "cam.y"]);
			to([276, 0.5, "outsine", 0, "cam.y"]);
			to([276.75, 0.25, "insine", -15, "cam.y"]);
			to([277, 0.5, "outsine", 0, "cam.y"]);
			to([277.75, 0.25, "insine", -15, "cam.y"]);
			to([278, 0.5, "outsine", 0, "cam.y"]);
			to([278.75, 0.25, "insine", -15, "cam.y"]);
			to([279, 0.5, "outsine", 0, "cam.y"]);
			to([279.75, 0.25, "insine", -15, "cam.y"]);
			to([280, 0.5, "outsine", 0, "cam.y"]);
			to([280.75, 0.25, "insine", -15, "cam.y"]);
			to([281, 0.5, "outsine", 0, "cam.y"]);
			to([281.75, 0.25, "insine", -15, "cam.y"]);
			to([282, 0.5, "outsine", 0, "cam.y"]);
			to([282.75, 0.25, "insine", -15, "cam.y"]);
			to([283, 0.5, "outsine", 0, "cam.y"]);
			to([283.75, 0.25, "insine", -15, "cam.y"]);
			to([284, 0.5, "outsine", 0, "cam.y"]);
			to([284.75, 0.25, "insine", -15, "cam.y"]);
			to([285, 0.5, "outsine", 0, "cam.y"]);
			to([285.75, 0.25, "insine", -15, "cam.y"]);
			to([286, 0.5, "outsine", 0, "cam.y"]);
			to([286.75, 0.25, "insine", -15, "cam.y"]);
			to([287, 0.5, "outsine", 0, "cam.y"]);
			to([287.75, 0.25, "insine", -15, "cam.y"]);
			to([288, 0.5, "outsine", 0, "cam.y"]);
			to([288.75, 0.25, "insine", -15, "cam.y"]);
			to([289, 0.5, "outsine", 0, "cam.y"]);
			to([289.75, 0.25, "insine", -15, "cam.y"]);
			to([290, 0.5, "outsine", 0, "cam.y"]);
			to([290.75, 0.25, "insine", -15, "cam.y"]);
			to([291, 0.5, "outsine", 0, "cam.y"]);
		});

		layer("layer 15", function()
		{
			to([275.5, 0.5, "insine", -100, "pinch"]);
			to([276, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([279.5, 0.5, "insine", -100, "pinch"]);
			to([280, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([283.5, 0.5, "insine", -100, "pinch"]);
			to([284, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([287.5, 0.5, "insine", -100, "pinch"]);
			to([288, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([291.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 16", function()
		{
			to([284, 4, "arc", 45, "orient"]);
			to([291.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 17", function()
		{
			to([291.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 23", function()
		{
			to([291.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
		});

		// -- chorus 2 @ 292 --
		layer("layer 1", function()
		{
			to([351, 1, "insine", 0, "flipRow"], {plr: 0});
			to([354.5, 0.5, "insine", 50, "rowCenterX"]);
			to([355, 1, "insine", 100, "rowCenterX"]);
		});

		layer("layer 11", function()
		{
			to([354.5, 1.5, "insine", 50, "rowCenterY"]);
		});

		layer("layer 18", function()
		{
			jump([338.75, 100, "hideHits"], {plr: [2, 3]});
			to([354, 2, "insine", 0, "surge"]);
		});

		layer("layer 19", function()
		{
			to([354, 2, "insine", 45, "rate"]);
		});

		layer("layer 20 2", function()
		{
			to([292, 1, "insine", 45, "dim"], {plr: [0, 2]});
			to([338, 1, "insine", 100, "dim"], {plr: 2});
			to([350, 1, "insine", 0, "dim"], {plr: 0});
			to([354, 2, "linear", 190, "drawAhead"]);
		});

		layer("layer 25", function()
		{
			to([292, 1, "insine", 45, "blind"], {plr: [0, 2]});
			to([338, 1, "insine", 100, "blind"], {plr: 2});
			to([350, 1, "insine", 0, "blind"], {plr: 0});
		});

		layer("layer 26", function()
		{
			to([352, 4, "insine", 0, "fadeNear"]);
		});

		layer("layer 27", function()
		{
			to([354, 2, "insine", 100, "dim"], {plr: 0});
		});

		layer("layer 34", function()
		{
			to([354, 1, "insine", 45, "blind"], {plr: 0});
		});

		layer("layer 2", function()
		{
			to([355, 0.5, "insine", 0, "skewY"], {from: 37});
			to([355.5, 0.5, "insine", 0, "skewY"], {from: -14});
		});

		layer("layer 3", function()
		{
			to([355, 0.5, "insine", 0, "skewX"], {plr: 0, from: 24});
			to([355.5, 0.5, "insine", 0, "skewX"], {plr: 0, from: -24});
		});

		layer("layer 4", function()
		{
			to([355, 0.5, "insine", 0, "skewX"], {plr: 1, from: -24.5});
			to([355.5, 0.5, "insine", 0, "skewX"], {plr: 1, from: 24});
		});

		layer("layer 5", function()
		{
			to([355, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([355.5, 0.5, "outsine", 0, "pinch"], {from: -50});
		});

		layer("layer 9", function()
		{
			to([339, 1, "insine", 0, "rowCenterX"]);
			to([340, 2, "insine", 25, "rowCenterX"]);
			to([342, 1, "outsine", 0, "rowCenterX"]);
			to([343, 1, "insine", 200, "rowCenterX"]);
			to([344, 2, "insine", 175, "rowCenterX"]);
			to([346, 1, "outsine", 200, "rowCenterX"]);
			to([347, 1, "insine", 0, "rowCenterX"]);
		});

		layer("layer 14", function()
		{
			to([292, 2, "outsine", -4, "cam.rotZ"]);
			to([294, 2, "insine", 0, "cam.rotZ"]);
			to([296, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([298, 2, "insine", 0, "cam.rotZ"]);
			to([300, 2, "outsine", -4, "cam.rotZ"]);
			to([302, 2, "insine", 0, "cam.rotZ"]);
			to([304, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([306, 2, "insine", 0, "cam.rotZ"]);
			to([308, 2, "outsine", -4, "cam.rotZ"]);
			to([310, 2, "insine", 0, "cam.rotZ"]);
			to([312, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([314, 2, "insine", 0, "cam.rotZ"]);
			to([316, 2, "outsine", -4, "cam.rotZ"]);
			to([318, 2, "insine", 0, "cam.rotZ"]);
			to([320, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([322, 2, "insine", 8, "cam.rotZ"]);
			to([324, 2, "outsine", -4, "cam.rotZ"]);
			to([326, 2, "insine", 0, "cam.rotZ"]);
			to([328, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([330, 2, "insine", 0, "cam.rotZ"]);
			to([332, 2, "outsine", -4, "cam.rotZ"]);
			to([334, 2, "insine", 0, "cam.rotZ"]);
			to([336, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([338, 2, "insine", 0, "cam.rotZ"]);
			to([340, 2, "outsine", -4, "cam.rotZ"]);
			to([342, 2, "insine", 0, "cam.rotZ"]);
			to([344, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([346, 2, "insine", 0, "cam.rotZ"]);
			to([348, 2, "outsine", -4, "cam.rotZ"]);
			to([350, 2, "insine", 0, "cam.rotZ"]);
			to([352, 2, "outsine", 4, "cam.rotZ"], {from: 0});
			to([354, 1.75, "insine", 0, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([355.75, 0.25, "insine", -30, "cam.y"]);
		});

		layer("layer 15", function()
		{
			to([292, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([292.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([293, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([293.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([294, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([294.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([295, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([295.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([296, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([296.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([297, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([297.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([298, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([298.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([299, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([299.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([300, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([300.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([301, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([301.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([302, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([302.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([303, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([303.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([304, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([304.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([305, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([305.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([306, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([306.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([307, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([307.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([308, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([308.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([309, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([309.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([310, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([310.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([311, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([311.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([312, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([312.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([313, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([313.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([314, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([314.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([315, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([315.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([316, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([316.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([317, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([317.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([318, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([318.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([319, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([319.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([320, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([320.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([321, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([321.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([322, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([322.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([323, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([323.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([324, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([324.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([325, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([325.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([326, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([326.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([327, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([327.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([328, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([328.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([329, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([329.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([330, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([330.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([331, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([331.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([332, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([332.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([333, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([333.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([334, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([334.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([335, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([335.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([336, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([336.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([337, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([337.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([338, 0.75, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([338.75, 0.25, "insine", 60, "pinchX"], {plr: [0, 1, 2, 3]});
			to([339, 0.5, "insine", 0, "pinchX"], {plr: [0, 1, 2, 3], from: 60});
			to([339.5, 0.5, "insine", -100, "pinch"]);
			to([340, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([343.5, 0.5, "insine", -100, "pinch"]);
			to([344, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([347.5, 0.5, "insine", -100, "pinch"]);
			to([348, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([351.5, 0.5, "insine", -100, "pinch"]);
			to([352, 0.75, "outsine", 0, "pinch"], {from: -100});
		});

		layer("layer 16", function()
		{
			to([292, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([292.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([293, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([293.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([294, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([294.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([295, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([295.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([296, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([296.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([297, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([297.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([298, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([298.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([299, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([299.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([300, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([300.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([301, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([301.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([302, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([302.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([303, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([303.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([304, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([304.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([305, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([305.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([306, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([306.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([307, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([307.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([308, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([308.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([309, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([309.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([310, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([310.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([311, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([311.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([312, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([312.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([313, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([313.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([314, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([314.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([315, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([315.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([316, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([316.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([317, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([317.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([318, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([318.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([319, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([319.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([320, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([320.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([321, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([321.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([322, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([322.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([323, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([323.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([324, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([324.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([325, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([325.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([326, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([326.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([327, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([327.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([328, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([328.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([329, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([329.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([330, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([330.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([331, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([331.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([332, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([332.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([333, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([333.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([334, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([334.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([335, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([335.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([336, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([336.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([337, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([337.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([338, 0.75, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([338.75, 0.25, "insine", -15, "shiftY"], {plr: [0, 1, 2, 3]});
			to([339, 0.5, "insine", 0, "shiftY"], {plr: [0, 1, 2, 3]});
			to([348, 4, "arc", 45, "faceZ"]);
		});

		layer("layer 17", function()
		{
			to([292, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([292.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([293, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([293.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([294, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([294.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([295, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([295.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([296, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([296.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([297, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([297.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([298, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([298.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([299, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([299.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([300, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([300.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([301, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([301.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([302, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([302.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([303, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([303.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([304, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([304.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([305, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([305.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([306, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([306.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([307, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([307.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([308, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([308.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([309, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([309.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([310, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([310.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([311, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([311.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([312, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([312.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([313, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([313.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([314, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([314.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([315, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([315.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([316, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([316.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([317, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([317.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([318, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([318.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([319, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([319.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([320, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([320.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([321, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([321.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([322, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([322.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([323, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([323.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([324, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([324.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([325, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([325.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([326, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([326.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([327, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([327.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([328, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([328.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([329, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([329.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([330, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([330.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([331, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([331.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([332, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([332.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([333, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([333.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([334, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([334.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([335, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([335.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([336, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([336.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([337, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([337.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([338, 0.75, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
			to([338.75, 0.25, "insine", -60, "pinchY"], {plr: [0, 1, 2, 3]});
			to([339, 0.5, "insine", 0, "pinchY"], {plr: [0, 1, 2, 3], from: -60});
		});

		layer("layer 23", function()
		{
			to([292, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([292.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([293, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([293.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([294, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([294.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([295, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([295.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([296, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([296.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([297, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([297.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([298, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([298.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([299, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([299.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([300, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([300.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([301, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([301.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([302, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([302.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([303, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([303.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([304, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([304.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([305, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([305.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([306, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([306.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([307, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([307.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([308, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([308.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([309, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([309.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([310, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([310.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([311, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([311.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([312, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([312.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([313, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([313.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([314, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([314.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([315, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([315.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([316, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([316.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([317, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([317.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([318, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([318.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([319, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([319.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([320, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([320.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([321, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([321.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([322, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([322.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([323, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([323.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([324, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([324.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([325, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([325.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([326, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([326.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([327, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([327.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([328, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([328.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([329, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([329.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([330, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([330.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([331, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([331.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([332, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([332.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([333, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([333.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([334, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([334.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([335, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([335.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([336, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([336.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([337, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([337.75, 0.25, "insine", -25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([338, 0.75, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
			to([338.75, 0.25, "insine", 25, "faceZ"], {plr: [0, 1, 2, 3]});
			to([339, 0.5, "insine", 0, "faceZ"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 37", function()
		{
			to([323, 1, "insine", -10, "flipRow"], {plr: [1, 3]});
			to([324, 1.5, "outsine", 100, "flipRow"], {plr: [0, 2]});
		});

		layer("layer 38", function()
		{
			every([292, 32, "ring", [292, 8, 32, 742.5, 1095, 100, 50, 1, 100, 0, -1]]);
			every([324, 16, "ring", [324, 4, 16, 561, 1095, 100, -50, 27.5, 100, -1, 0]]);
		});

		layer("layer 40", function()
		{
			to([324, 1.5, "outsine", 0, "flipRow"], {plr: [1, 3]});
		});

		// -- drop 2 @ 356 --
		layer("layer 1", function()
		{
			to([383, 1.5, "insine", 0, "rowCenterY"]);
		});

		layer("layer 11", function()
		{
			to([382, 2, "insine", 0, "bobX"]);
		});

		layer("layer 19", function()
		{
			to([382, 2, "insine", 60, "rate"]);
		});

		layer("layer 2", function()
		{
			to([371, 1, "insine", -90, "tiltZ"]);
			to([382, 2, "inoutsine", 0, "tiltZ"]);
			to([388, 3, "insine", -100, "mirror"]);
		});

		layer("layer 3", function()
		{
			to([371, 1, "insine", -166, "fieldX"]);
			to([382, 2, "inoutsine", 0, "fieldX"]);
			to([388, 3, "linear", 100, "blind"]);
		});

		layer("layer 4", function()
		{
			to([371, 1, "insine", 54.5, "fieldY"]);
			to([382, 2, "inoutsine", 0, "fieldY"]);
			to([388, 3, "linear", 100, "dim"]);
		});

		layer("layer 5", function()
		{
			to([383, 1, "linear", 0, "drunk"], {plr: [0, 1, 2, 3]});
		});

		layer("layer 6", function()
		{
			to([356, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([356.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([357.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([358.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([359, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([359.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([360, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([360.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([361.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([362.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([363, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([363.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([364, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([364.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([365.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([366.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([367, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([367.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([368, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([368.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([369.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([370.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([371, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([371.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([372, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([372.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([373.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([374.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([375, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([375.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([376, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([376.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([377.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([378.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([379, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([379.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([380, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([380.75, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([381.5, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([382.25, 0.75, "outsine", 0, "pinch"], {from: -100});
			to([383, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([383.5, 0.5, "outsine", 0, "pinch"], {from: -100});
			to([387.5, 0.5, "insine", -100, "pinch"]);
			to([388, 3, "outsine", 0, "pinch"], {from: -100});
		});

		layer("layer 14", function()
		{
			to([356, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([356.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([357.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([358.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([359, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([359.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([360, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([360.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([361.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([362.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([363, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([363.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([364, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([364.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([365.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([366.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([367, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([367.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([368, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([368.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([369.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([370.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([371, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([371.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([372, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([372.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([373.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([374.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([375, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([375.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([376, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([376.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([377.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([378.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([379, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([379.5, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([380, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([380.75, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([381.5, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([382.25, 0.5, "outsine", -4, "cam.rotZ"], {from: 0});
			to([383, 0.5, "outsine", 4, "cam.rotZ"], {from: 0});
			to([383.5, 0.5, "insine", -4, "cam.rotZ"], {from: 0});
			to([384, 0.5, "outsine", 0, "cam.rotZ"]);
			to([387.5, 0.5, "insine", 4, "cam.rotZ"], {from: 0});
			to([388, 1, "outsine", 0, "cam.rotZ"]);
		});

		layer("layer 21", function()
		{
			to([356, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([356.5, 0.25, "insine", 30, "cam.y"]);
			to([356.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([357.25, 0.25, "insine", -30, "cam.y"]);
			to([357.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([358, 0.25, "insine", 30, "cam.y"]);
			to([358.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([358.75, 0.25, "insine", -30, "cam.y"]);
			to([359, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([359.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([360, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([360.5, 0.25, "insine", 30, "cam.y"]);
			to([360.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([361.25, 0.25, "insine", -30, "cam.y"]);
			to([361.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([362, 0.25, "insine", 30, "cam.y"]);
			to([362.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([362.75, 0.25, "insine", -30, "cam.y"]);
			to([363, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([363.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([364, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([364.5, 0.25, "insine", 30, "cam.y"]);
			to([364.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([365.25, 0.25, "insine", -30, "cam.y"]);
			to([365.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([366, 0.25, "insine", 30, "cam.y"]);
			to([366.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([366.75, 0.25, "insine", -30, "cam.y"]);
			to([367, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([367.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([368, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([368.5, 0.25, "insine", 30, "cam.y"]);
			to([368.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([369.25, 0.25, "insine", -30, "cam.y"]);
			to([369.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([370, 0.25, "insine", 30, "cam.y"]);
			to([370.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([370.75, 0.25, "insine", -30, "cam.y"]);
			to([371, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([371.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([372, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([372.5, 0.25, "insine", 30, "cam.y"]);
			to([372.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([373.25, 0.25, "insine", -30, "cam.y"]);
			to([373.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([374, 0.25, "insine", 30, "cam.y"]);
			to([374.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([374.75, 0.25, "insine", -30, "cam.y"]);
			to([375, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([375.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([376, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([376.5, 0.25, "insine", 30, "cam.y"]);
			to([376.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([377.25, 0.25, "insine", -30, "cam.y"]);
			to([377.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([378, 0.25, "insine", 30, "cam.y"]);
			to([378.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([378.75, 0.25, "insine", -30, "cam.y"]);
			to([379, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([379.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([380, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([380.5, 0.25, "insine", 30, "cam.y"]);
			to([380.75, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([381.25, 0.25, "insine", -30, "cam.y"]);
			to([381.5, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([382, 0.25, "insine", 30, "cam.y"]);
			to([382.25, 0.5, "outsine", 0, "cam.y"], {from: 30});
			to([382.75, 0.25, "insine", -30, "cam.y"]);
			to([383, 0.5, "outsine", 30, "cam.y"], {from: -30});
			to([383.5, 0.5, "outsine", -30, "cam.y"], {from: 30});
			to([384, 0.5, "outsine", 0, "cam.y"], {from: -30});
			to([388, 0.5, "outsine", 0, "cam.y"], {from: -63});
			to([388.5, 3.5, "insine", 0, "cam.y"]);
		});
	}
	var RING_LANE:Float = 100;

	var RING_SEAT:Array<Int> = [1, 2, 3, 0];

	var RING_HIDE:Array<Float> = [0, 0, 45, 0];

	var RING_SCREEN:Float = 1000;

	static inline var RING_EDGE:Float = 2;

	var RING_HALF:Float = 0;
	var RING_READ:Bool = false;

	function ringRead():Void
	{
		RING_READ = true;
		RING_HALF = 0;

		var state = PlayState.instance;
		if (state == null) return;

		var one = state.opponentStrumline;
		var two = state.playerStrumline;
		if (one == null || two == null) return;

		var a0 = one.getByIndex(0);
		var a3 = one.getByIndex(3);
		var b0 = two.getByIndex(0);
		if (a0 == null || a3 == null || b0 == null) return;

		var lane:Float = (a3.x - a0.x) / 3;
		if (lane <= 0) return;

		RING_HALF = (b0.x - a0.x) * 0.5 * RING_LANE / lane;
		RING_SCREEN = FlxG.width * RING_LANE / lane;
	}

	function ringEase(t:Float):Float
	{
		if (t <= 0) return 0;
		if (t >= 1) return 1;

		return t * t * (3 - 2 * t);
	}

	function ringAt(b:Float, anchor:Float, ?turnBeats:Null<Float>, ?runBeats:Null<Float>, ?depth:Null<Float>, ?across:Null<Float>, ?pack:Null<Float>, ?form:Null<Float>, ?tall:Null<Float>, ?keep:Null<Float>, ?way:Null<Float>, ?leave:Null<Float>, ?fromLap:Null<Float>):Void
	{
		if (!RING_READ) ringRead();

		var turn:Float = turnBeats == null || turnBeats <= 0 ? 8 : turnBeats;
		var wide:Float = across == null || across <= 0 ? RING_HALF : across;
		var seat:Float = (pack == null || pack <= 0 ? 100 : pack) * 0.01;

		var opens:Bool = form == null || form >= 0;

		var made:Float = RING_EDGE;
		var high:Float = tall == null || tall <= 0 ? wide * 0.35 : tall;

		var side2:Float = (way != null && way < 0) ? -1 : 1;

		var held:Float = (keep == null ? 0 : keep) * 0.01;
		if (held < 0) held = 0;
		if (held > 1) held = 1;

		var gone:Float = b - anchor;
		if (gone < 0) gone = 0;

		var into:Float = opens ? gone / made : 1;
		if (into > 1) into = 1;
		if (into < 0) into = 0;

		var span:Float = runBeats == null || runBeats <= 0 ? blockSpan() : runBeats;
		var ends:Float = anchor + span;

		var shuts:Bool = leave == null || leave >= 0;

		var left:Float = shuts ? (ends - b) / RING_EDGE : 1;
		if (left > 1) left = 1;
		if (left < 0) left = 0;

		into = ringEase(into);
		left = ringEase(left);

		var start:Float = fromLap == null ? 0 : fromLap;

		var spin:Float = gone / turn;

		if (side2 < 0) {
			if (!opens && made > 0) {
				if (gone < made) {
					var x:Float = gone / made;
					spin = (gone - 2 * made * (x * x * x - x * x * x * x * 0.5)) / turn;
				}
				else spin = -(gone - made) / turn;
			}
			else spin = -spin;
		}

		var laps:Float = start + spin;

		if (shuts && left < 1)
		{
			var park:Float = Math.round(laps);
			laps = park + (laps - park) * left;
		}

		for (pn in 0...4)
		{

			if (pn >= 2)
			{
				var held2:Float = RING_HIDE[pn];
				var gone2:Float = held2 + (100 - held2) * (1 - into * left);

				live("blind", gone2, pn);
				live("dim", gone2, pn);
			}

			var grow:Float = pn < 2 ? into : 1;

			var stood:Float = read("shiftZ", pn);

			var small:Float = read("zoom", pn) * 0.01;
			if (small <= 0) small = 1;

			var walk:Float = 1 - read("rowCenterX", pn) * 0.01;
			var home:Float = ((pn == 0 || pn == 2) ? -1 : 1) * RING_HALF * walk;

			var slot:Int = RING_SEAT[pn];

			for (col in 0...4)
			{
				var k:Int = slot * 4 + col;
				var spot:Float = (k - 7.5) * seat / 16;
				var ang:Float = 2 * Math.PI * (laps + spot);

				var round:Float = wide * Math.sin(ang);

				var step:Float = 2 * wide / 16;
				var span:Float = step * 16;
				var walked:Float = step * (k - 7.5) + span * laps * into;
				var stay:Float = walked - span * Math.floor(walked / span + 0.5);

				var off:Float = k < 7.5 ? (7.5 - k) / 7.5 : (k - 7.5) / 7.5;
				var runs:Float = made * (1 - 0.4 * off);

				var mine:Float = (runs <= 0 || !opens) ? 1 : ringEase(gone / runs);
				if (grow >= 1) mine = 1;

				var rest:Float = home + (col - 1.5) * RING_LANE * small;
				var side:Float = small * (round * (1 - held) + stay * held) - rest;

				var lift:Float = high * small * Math.cos(ang);
				var deep:Float = depth * small * 0.5 * (1 - Math.cos(ang));

				liveCol("shiftX", col, side * mine * left, pn);
				liveCol("shiftY", col, lift * mine * left, pn);
				liveCol("shiftZ", col, (stood + (deep - stood) * mine) * left, pn);
			}
		}
	}
}
