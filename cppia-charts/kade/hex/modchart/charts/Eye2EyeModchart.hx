// exported by mod-ed

package kade.hex.modchart.charts;

import kade.hex.chart.Chart;

class Eye2EyeModchart extends Chart
{
	public function new()
	{
		super("eye2eye_modchart");
	}

	override function setup():Void
	{
		scene("eye2eye_scene");
		stage3d(0, 1, 1, 2.55);
		quantSkin("gameplay/hex/me-quant-notes");

		addField(1);
		addField(1);
	}
	override function build():Void
	{
		// == main : shiftX, shiftY, skewY, screen.glitch, cam.shake, screen.glitch 2, cam.rotZ, faceZ, cam.rotZ 2, shiftY2, shiftX3, fieldX, spare, spare 2 ==
		// == sprite anim : faceX, faceZ0, faceZ1, spare 3, faceZ2, layer 67, layer 68, layer 69, layer 70, layer 71, layer 72, layer 73, layer 74 ==
		// == bops : bobX ==
		// == bends : bendX, joltX ==
		// == positions : dim, blind, freeze, pinch, pinchZ, mirror, skewX, fold, fieldY, fieldY 2, fieldY 3, spare 4, layer 56, layer 57, layer 58, layer 59, layer 60, layer 61, layer 62, layer 63, layer 64, layer 65, layer 66 ==
		// == eyes : eyes.angle, eyes.reach, eye1.angle, eye3.angle, eye6.angle, eye7.angle ==
		// == hide notes : hideNotes, spare 5, spare 6, layer 123, layer 124, layer 125, layer 131, layer 132 ==
		// == arrow hits : shiftX 2, shiftY 2, tiltZ, hideNotes 2, pinch 2, pinch 3, dim 2, pinch 4, faceZ 2, layer 75, layer 76, layer 77, layer 78, layer 79, layer 80, layer 81, layer 82, layer 83, layer 84, layer 85, layer 86, layer 87, layer 88, layer 89 ==
		// == cool stuff : pinch 5, mirror 2, cam.z, layer 90, layer 91, layer 99, layer 129, layer 130 ==
		// == teleporting : layer 92, layer 93, layer 94, layer 95, layer 96, layer 97, layer 98, layer 100, layer 101, layer 102, layer 103, layer 104, layer 105, layer 106, layer 107, layer 108, layer 109, layer 110, layer 111, layer 112, layer 113, layer 114, layer 115, layer 116, layer 117, layer 118, layer 119, layer 120, layer 121, layer 122, layer 126, layer 127, layer 128 ==

		layer("shiftX", function()
		{
			jump([0, 100, "blind"]);
			jump([0, 1199.5, "fieldX"], {plr: 2});
			jump([0, 1467, "fieldX"], {plr: 3});
			jump([0, -60.5, "fieldX"], {plr: 1});
			jump([0.25, 500, "drawAhead"], {plr: [0, 1, 2, 3]});
			jump([0.5, 100, "drawBehind"], {plr: [0, 1, 2, 3]});
		});

		layer("shiftY", function()
		{
			jump([0, 100, "dim"]);
			jump([28, 0.5, "screen.glitch"]);
		});

		layer("skewY", function()
		{
			jump([0, -2429.5, "fieldY"], {plr: 0});
		});

		layer("dim", function()
		{
			jump([0, 100000, "drawBehind"], {plr: [0, 1, 2, 3]});
		});

		// -- unhidden @ 32 --
		layer("shiftX", function()
		{
			to([32, 6, "inoutsine", 0, "screen.glitch"], {from: 0.6});
			jump([57.5, -475, "shiftX0"], {plr: 1});
			jump([57.75, -425, "shiftX1"], {plr: 1});
			jump([58, -100, "shiftX2"], {plr: 1});
			jump([58.25, -50, "shiftX3"], {plr: 1});
			to([58.5, 1.5, "linear", 0, "blind"], {plr: 1});
		});

		layer("shiftY", function()
		{
			jump([57.5, 0, "shiftY0"], {plr: 1});
			jump([57.75, 0, "shiftY1"], {plr: 1});
			jump([58, 0, "shiftY2"], {plr: 1});
			jump([58.25, 0, "shiftY3"], {plr: 1});
			to([58.5, 1.5, "linear", 0, "dim"], {plr: 1});
		});

		layer("skewY", function()
		{
			jump([58.25, 200, "rate"], {plr: [1, 2]});
			to([59.5, 0.1141, "inoutsine", 50, "skewY"], {plr: 1, from: 29});
			to([59.624, 0.1141, "inoutsine", -162, "skewY"], {plr: 1, from: 29});
			to([59.75, 0.1141, "inoutsine", -162, "skewY"], {plr: 1, from: 29});
			to([60, 1.2494, "inoutcubic", 0, "skewY"], {plr: 1});
		});

		layer("screen.glitch", function()
		{
			to([58.5, 1, "insine", 0.3, "screen.glitch"]);
			to([59.5, 3, "outsine", 0, "screen.glitch"], {from: 0.3});
		});

		layer("cam.shake", function()
		{
			to([59.5, 3, "linear", 0, "pinchX"], {from: 119});
		});

		layer("faceX", function()
		{
			to([58.5, 5.5, "inoutsine", 0, "faceX"], {from: 133});
		});

		layer("faceZ0", function()
		{
			to([58.75, 5.25, "inoutsine", 0, "faceZ0"], {from: 50});
		});

		layer("faceZ1", function()
		{
			to([59.25, 4.75, "inoutsine", 0, "faceZ1"], {from: -50});
		});

		layer("faceZ2", function()
		{
			to([60, 4, "inoutsine", 0, "faceZ2"], {from: -42.5});
		});

		layer("bobX", function()
		{
			jump([59.25, 50, "bobX.speed"]);
			jump([59.5, 2, "bobX"]);
			jump([59.75, 5, "joltY"]);
		});

		// -- verse 1 @ 64 --
		layer("shiftX", function()
		{
			jump([87.75, 10, "drawAhead.fade"], {plr: [0, 1, 2, 3]});
			jump([88, 700, "drawAhead"], {plr: [1, 2]});
			to([89, 2.25, "linear", 1040, "stage.radius"]);
		});

		layer("shiftY", function()
		{
			to([88, 8, "inoutsine", 1357.5, "cam.z"]);
		});

		layer("skewY", function()
		{
			to([88, 8, "inoutsine", -945, "fieldZ"], {plr: [1, 2, 3]});
		});

		layer("screen.glitch", function()
		{
			to([88, 8, "inoutsine", 0, "shiftX0"], {plr: 1});
		});

		layer("cam.shake", function()
		{
			to([88, 8, "inoutsine", 0, "shiftY0"], {plr: 1});
		});

		layer("screen.glitch 2", function()
		{
			to([88, 8, "inoutsine", 100, "rowCenterX"], {plr: 1});
		});

		layer("cam.rotZ", function()
		{
			to([88, 8, "inoutsine", 0, "shiftX1"], {plr: 1});
		});

		layer("faceZ", function()
		{
			to([88, 8, "inoutsine", 0, "shiftY1"], {plr: 1});
		});

		layer("cam.rotZ 2", function()
		{
			to([88, 8, "inoutsine", 0, "shiftX2"], {plr: 1});
		});

		layer("shiftY2", function()
		{
			to([88, 8, "inoutsine", 0, "shiftY2"], {plr: 1});
		});

		layer("shiftX3", function()
		{
			to([88, 8, "inoutsine", 0, "shiftX3", 0, "shiftY3"], {plr: 1});
		});

		layer("fieldX", function()
		{
			to([88, 8, "linear", 0, "fieldX"], {plr: 1});
		});

		layer("dim", function()
		{
			to([94, 1.5, "insine", 100, "dim"], {plr: 1});
		});

		layer("blind", function()
		{
			to([94, 1.5, "insine", 100, "blind"], {plr: 1});
		});

		layer("mirror", function()
		{
			to([93, 3, "linear", 60, "rate"], {plr: [1, 2]});
		});

		layer("eyes.angle", function()
		{
			jump([88, 172, "eye5.angle"]);
			to([94.25, 1.75, "outsine", 100, "eyes.reach"]);
		});

		layer("eyes.reach", function()
		{
			to([88, 0.4167, "instant", 90, "eye2.angle"]);
		});

		layer("eye1.angle", function()
		{
			to([88, 0.4167, "instant", 25.5, "eye1.angle"]);
		});

		layer("eye3.angle", function()
		{
			jump([88, 149.5, "eye3.angle"]);
			jump([88.25, 192, "eye8.angle"]);
		});

		layer("eye6.angle", function()
		{
			jump([88, -10, "eye6.angle"]);
		});

		layer("eye7.angle", function()
		{
			jump([88, -73, "eye7.angle"]);
		});

		// -- chorus 1 @ 96 --
		layer("shiftX", function()
		{
			to([127, 1, "insine", -15, "fadeFar"], {plr: 1});
			to([134, 1.5, "inoutsine", 100, "mirror"], {plr: 1});
			jump([136, 100, "freeze"], {plr: 1});
			to([138, 0.9609, "instant", 0, "freeze"], {plr: 1});
			to([139, 1, "linear", 1, "fadeFar"], {plr: 1});
			to([142, 1, "outsine", 0, "mirror"], {plr: 1});
			to([147, 3, "linear", 0, "flipRow"], {plr: 1});
			to([151.5, 4.5, "instant", 100, "hideHits"], {plr: 1});
			to([157, 0.5, "instant", 0, "hideHits"], {plr: 1});
		});

		layer("shiftY", function()
		{
			to([127, 1, "linear", 100, "rate"], {plr: [1, 2]});
			to([136, 1.9962, "linear", 442.5, "rowY"], {plr: 1});
			to([150, 3, "insine", 100, "dim"], {plr: 1});
			jump([154, 0, "blind"], {plr: 1});
			to([155.5, 1, "insine", 0, "dim"], {plr: 1});
		});

		layer("skewY", function()
		{
			to([121.5, 1.5, "linear", 99.5, "rate"], {plr: [1, 2]});
			to([127, 1, "outsine", 0, "dim"], {plr: 3, from: 100});
			jump([135.75, 1155, "drawAhead"], {plr: 1});
			jump([138, 100, "flipRow"], {plr: 1});
			to([139, 1, "insine", 100, "rate"], {plr: 1});
			to([144, 3, "insine", -453, "faceZ"], {plr: 1});
			to([147, 3, "outsine", -720, "faceZ"], {plr: 1});
			to([150, 3, "insine", 100, "blind"], {plr: 1});
			to([156, 5.5, "inoutsine", 37, "cam.z"]);
		});

		layer("screen.glitch", function()
		{
			to([96, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([97.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([99, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([100.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([102, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([103, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([104, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([105.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([107, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([108.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([110, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([111, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([112, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([113.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([115, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([116.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([118, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([119, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([120, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([121.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([123, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([124.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([126, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([127, 1, "outcubic", 0, "screen.glitch"], {from: 0.5});
			to([128, 3, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([131, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([134, 2, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([136, 3, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([139, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([142, 2, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([144, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([147, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([150, 2, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([152, 0.9345, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([153, 0.9345, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([154, 0.9345, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([155, 0.9345, "outcubic", 0, "screen.glitch"], {from: 0.2});
		});

		layer("cam.shake", function()
		{
			to([127, 1, "outsine", 0, "blind"], {plr: 3, from: 100});
			to([131, 3, "linear", 207, "rate"], {plr: 1});
			to([136, 0.5145, "linear", 150, "rate"], {plr: 1});
			to([138, 0.2411, "instant", 0, "rowY"], {plr: 1});
			to([139, 3, "linear", 160, "rate"], {plr: 1});
		});

		layer("screen.glitch 2", function()
		{
			to([131, 2.5, "linear", 0, "drag"], {plr: 1});
			to([134, 2, "insine", 100, "rate"], {plr: 1});
			jump([138, 68.5, "fadeFar"], {plr: 1});
			to([138.25, 0.75, "insine", 500, "drawAhead"], {plr: 1});
			to([139, 3, "linear", 0, "drag"], {plr: 1});
			to([144, 3, "insine", 84, "stage.rotZ"]);
			to([147, 3, "outsine", 180, "stage.rotZ"]);
		});

		layer("cam.rotZ", function()
		{
			to([127, 1, "linear", 6, "cam.rotZ"]);
			to([128, 3, "arc", -33.5, "cam.rotZ"], {from: 0});
			to([136, 3, "arc", 150, "cam.rotZ"]);
			to([142, 2, "linear", 340, "cam.rotZ"]);
			to([144, 3, "insine", 453, "cam.rotZ"]);
			to([147, 3, "outsine", 720, "cam.rotZ"]);
		});

		layer("faceZ", function()
		{
			to([128, 3, "arc", 33.5, "faceZ"], {plr: 1});
			to([131, 3, "outsine", -180, "faceZ"], {plr: 1});
			to([139, 3, "outsine", -360, "faceZ"], {plr: 1});
		});

		layer("cam.rotZ 2", function()
		{
			to([131, 3, "outsine", 180, "cam.rotZ"]);
			jump([137.75, 100, "fadeFar.fade"], {plr: 1});
			to([139, 3.0615, "outsine", 360, "cam.rotZ"]);
		});

		layer("bobX", function()
		{
			to([141.5, 0.5, "insine", -100, "drunk"], {plr: 1});
			to([142.5, 0.5, "insine", 100, "drunk"], {plr: 1});
			to([143.5, 0.5, "insine", 0, "drunk"], {plr: 1});
		});

		layer("bendX", function()
		{
			jump([96, 67.5, "bendX"], {plr: [0, 1, 2]});
			to([98, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([100.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([103, 1, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			jump([104, -67.5, "bendX"], {plr: [0, 1, 2]});
			to([106, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([108.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([111, 1, "linear", 67.5, "bendX"], {plr: [0, 1, 2]});
			jump([112, 67.5, "bendX"], {plr: [0, 1, 2]});
			to([114, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([116.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([119, 1, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			jump([120, -67.5, "bendX"], {plr: [0, 1, 2]});
			to([122, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([124.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([127, 1, "linear", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([128, 1, "inoutsine", 16.5, "bendX"], {plr: [0, 1, 2]});
			to([130.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([133, 1, "insine", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([135.5, 0.5, "insine", 16, "bendX"], {plr: [0, 1, 2]});
			to([138.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([141, 1, "insine", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([142.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([143.5, 0.5, "insine", 16, "bendX"], {plr: [0, 1, 2]});
			jump([154, 175, "rate"], {plr: 1});
			to([156.5, 0.5, "insine", -25, "bendX"], {plr: 1});
			to([157, 0.5, "outsine", 0, "bendX"], {plr: 1});
			to([157.5, 0.5, "insine", 45, "bendX"], {plr: 1});
			to([158, 0.5, "outsine", 0, "bendX"], {plr: 1});
		});

		layer("joltX", function()
		{
			jump([135.5, 50, "joltX.period"], {plr: 1});
			jump([135.75, 70, "joltX"], {plr: 1});
			jump([138, 0, "joltX"], {plr: 1});
		});

		layer("dim", function()
		{
			to([96, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([97.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([99, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([100.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([102, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([103, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([104, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([105.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([107, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([108.5, 1.5, "inoutsine", 45, "blind"], {plr: [1, 2], from: 0});
			to([110, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([111, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([112, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([113.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([115, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([116.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([118, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([119, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([120, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([121.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([123, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([124.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([126, 1, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([127, 1, "inoutsine", 0, "dim"], {plr: [1, 2], from: 0});
		});

		layer("blind", function()
		{
			to([96, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([97.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([99, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([100.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([102, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([103, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([104, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([105.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([107, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([108.5, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([110, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([111, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([112, 1.5, "inoutsine", 85, "dim"], {plr: [1, 2], from: 0});
			to([113.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([115, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([116.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([118, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([119, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([120, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([121.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([123, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([124.5, 1.5, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([126, 1, "inoutsine", 85, "blind"], {plr: [1, 2], from: 0});
			to([127, 1, "inoutsine", 0, "blind"], {plr: [1, 2], from: 0});
		});

		layer("freeze", function()
		{
			to([96, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([97, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([97.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([98.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([99, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([100, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([100.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([101.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([102, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([102.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([103, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([103.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([104, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([105, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([105.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([106.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([107, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([108, 0.472, "linear", 0, "freeze"], {plr: [1, 2]});
			to([108.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([109.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([110, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([110.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([111, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([111.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([112, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([113, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([113.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([114.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([115, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([116, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([116.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([117.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([118, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([118.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([119, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([119.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([120, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([121, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([121.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([122.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([123, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([124, 0.472, "linear", 0, "freeze"], {plr: [1, 2]});
			to([124.5, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([125.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([126, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([126.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
			to([127, 0.25, "instant", 100, "freeze"], {plr: [1, 2]});
			to([127.5, 0.5, "linear", 0, "freeze"], {plr: [1, 2]});
		});

		layer("pinch", function()
		{
			to([96, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([97.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([99, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([100.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([102, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([103, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([104, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([105.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([107, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([108.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([110, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([111, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([112, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([113.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([115, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([116.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([118, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([119.5, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([120.5, 1, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([121.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([123, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([124.5, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([126, 1.5, "outcubic", 0, "pinch"], {plr: [1, 2], from: -150});
			to([131, 2, "incubic", 0, "pinch0"], {plr: [1, 2], from: -255.5});
			to([139, 2, "incubic", 0, "pinch3"], {plr: [1, 2], from: -255.5});
			to([147, 2, "incubic", 0, "pinch3"], {plr: [1, 2], from: -255.5});
		});

		layer("pinchZ", function()
		{
			to([96, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([97.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([99, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([100.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([102, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([103, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([104, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([105.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([107, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([108.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([110, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([111, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([112, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([113.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([115, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([116.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([118, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([119.5, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([120.5, 1, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([121.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([123, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([124.5, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
			to([126, 1.5, "incubic", 0, "pinchZ"], {plr: [1, 2], from: -977.5});
		});

		layer("mirror", function()
		{
			to([103.5, 0.5, "insine", 100, "mirror"], {plr: [0, 1, 2]});
			to([105, 0.5, "insine", 0, "mirror"], {plr: [0, 1, 2], from: 100});
			to([106.5, 0.5, "insine", 100, "flipRow"], {plr: [0, 1, 2]});
			to([108, 0.5, "insine", 50, "flipRow"], {plr: [0, 1, 2]});
			to([109.5, 0.5, "insine", 0, "flipRow"], {plr: [0, 1, 2]});
			to([113, 0.5, "insine", 100, "mirror"], {plr: [0, 1, 2]});
			to([114.5, 0.5, "insine", 0, "mirror"], {plr: [0, 1, 2], from: 100});
			jump([116.5, 704, "drawAhead"], {plr: 1});
			jump([118, 600, "drawAhead"], {plr: 1});
			to([119.5, 0.5, "insine", 100, "mirror"], {plr: [0, 1, 2]});
			to([121, 0.5, "outsine", 0, "mirror"], {plr: [0, 1, 2]});
			to([122.5, 0.5, "insine", -50, "mirror"], {plr: [0, 1, 2]});
			to([124, 0.5, "insine", 0, "mirror"], {plr: [0, 1, 2]});
			to([125.5, 0.5, "insine", -27.5, "shrink"], {plr: 1});
			to([126.5, 0.5, "insine", 27, "shrink"], {plr: 1});
			to([127.5, 0.5, "insine", 0, "shrink"], {plr: 1});
		});

		layer("skewX", function()
		{
			to([96, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([97.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([99, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([100.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([102, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([103, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([104, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([105.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([107, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([108.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([110, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([111, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([112, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([113.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([115, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([116.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([118, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([119, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([120, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([121.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([123, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([124.5, 1.5, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
			to([126, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: 50});
			to([127, 1, "incubic", 0, "skewX"], {plr: [0, 1, 2], from: -50});
		});

		layer("fold", function()
		{
			jump([108.5, 165, "drawAhead"], {plr: 1});
			jump([110, 600, "drawAhead"], {plr: 1});
			to([111.5, 0.5, "insine", -375, "fieldX"], {plr: 1});
			to([113, 0.5, "insine", 300, "fieldX"], {plr: 1});
			to([114.5, 0.5, "insine", 100, "flipRow"], {plr: [0, 1, 2]});
			to([116, 0.5, "insine", 0, "flipRow"], {plr: [0, 1, 2]});
			to([117.5, 0.5, "insine", 9.5, "fieldY"], {plr: 1});
			to([118, 0.5, "outsine", 50, "fold"], {plr: 1});
			to([118.5, 0.5, "insine", 0, "fold"], {plr: 1});
			to([119, 0.5, "outsine", -50, "fold"], {plr: 1});
			to([120, 0.5, "insine", 0, "fold"], {plr: 1});
			to([121, 0.5, "insine", -25, "fieldX"], {plr: 1});
			to([125.5, 0.5, "insine", -25, "fieldX"], {plr: 1});
		});

		layer("fieldY", function()
		{
			to([111.5, 0.5, "insine", 0, "fieldY"], {plr: 1});
			to([113, 0.5, "insine", 0, "fieldY"], {plr: 1});
			to([114.5, 0.5, "insine", -50, "fieldX"], {plr: 1});
			to([116, 0.5, "insine", -371, "fieldX"], {plr: 1});
			to([117.5, 0.5, "insine", -19.5, "fieldX"], {plr: 1});
			to([119.5, 0.5, "outsine", -315.5, "fieldX"], {plr: 1});
			to([121, 0.5, "insine", 0, "fieldY"], {plr: 1});
			jump([122.25, 437.5, "drawAhead"], {plr: 1});
			jump([124.5, 600, "drawAhead"], {plr: 1});
			to([125.5, 0.5, "insine", 25, "fieldY"], {plr: 1});
		});

		layer("fieldY 2", function()
		{
			to([114.5, 0.5, "insine", -25, "fieldY"], {plr: 1});
			to([116, 0.5, "insine", 255.5, "fieldY"], {plr: 1});
			to([119.5, 0.5, "outsine", 300, "fieldY"], {plr: 1});
			jump([122.25, 0, "drawAhead.fade"], {plr: 1});
			to([124, 0.5, "outsine", 275, "fieldX"], {plr: 1});
		});

		layer("fieldY 3", function()
		{
			to([124, 0.5, "outsine", 225, "fieldY"], {plr: 1});
		});

		layer("eyes.angle", function()
		{
			to([96, 8, "insine", 360, "eyes.angle"]);
			to([104, 8, "insine", 360, "eyes.angle"]);
			to([112, 8, "insine", 360, "eyes.angle"]);
			to([120, 8, "insine", 360, "eyes.angle"]);
			to([128, 8, "insine", 360, "eyes.angle"]);
			to([136, 8, "insine", 360, "eyes.angle"]);
			to([144, 8, "insine", 360, "eyes.angle"]);
		});

		layer("eyes.reach", function()
		{
			to([100, 8, "linear", -100, "eyes.reach"]);
			to([108, 8, "linear", 100, "eyes.reach"]);
			to([116, 8, "linear", -100, "eyes.reach"]);
			to([124, 8, "linear", 100, "eyes.reach"]);
			to([132, 8, "linear", -100, "eyes.reach"]);
			to([140, 8, "linear", 100, "eyes.reach"]);
			to([148, 3, "linear", -100, "eyes.reach"]);
			to([151, 1, "insine", 100, "eyes.reach"]);
		});

		layer("hideNotes", function()
		{
			to([152.5, 4.5, "linear", 100, "hideNotes"], {plr: 1});
		});

		layer("shiftX 2", function()
		{
			jump([147, 443.5, "shiftX3"], {plr: 3});
			jump([147.25, -400, "shiftY0"], {plr: 3});
			jump([147.5, -500, "shiftY2"], {plr: 3});
			jump([147.75, -50, "shiftX1"], {plr: 3});
			jump([148.25, -550, "fieldX"], {plr: 3});
			jump([148.75, 443.5, "shiftX3"], {plr: 2});
			jump([149, -400, "shiftY0"], {plr: 2});
			jump([149.25, -500, "shiftY2"], {plr: 2});
			jump([149.5, -50, "shiftX1"], {plr: 2});
			jump([150, -550, "fieldX"], {plr: 2});
			to([152, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([153.5, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([155, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([156.5, 1, "outsine", 0, "cam.shake"], {from: 35});
		});

		layer("shiftY 2", function()
		{
			jump([147, 225, "shiftY3"], {plr: 3});
			jump([147.25, -775, "shiftX0"], {plr: 3});
			jump([147.5, -50, "shiftX2"], {plr: 3});
			jump([147.75, 225, "shiftY1"], {plr: 3});
			jump([148.25, 25, "fieldY"], {plr: 3});
			jump([148.75, 225, "shiftY3"], {plr: 2});
			jump([149, -775, "shiftX0"], {plr: 2});
			jump([149.25, -50, "shiftX2"], {plr: 2});
			jump([149.5, 225, "shiftY1"], {plr: 2});
			jump([150, 25, "fieldY"], {plr: 2});
			jump([158, -1070.5, "fieldY"], {plr: 2});
		});

		layer("tiltZ", function()
		{
			jump([146.75, -944.5, "fieldZ"], {plr: 3});
			to([150, 2, "insine", 0, "dim"], {plr: 2, from: 100});
			to([152, 0.5, "linear", 100, "dim"], {plr: 2});
			to([153.5, 0.5, "linear", 100, "dim"], {plr: 2});
			to([155, 0.5, "linear", 100, "dim"], {plr: 2});
			to([156.5, 0.5, "linear", 100, "dim"], {plr: 2});
		});

		layer("hideNotes 2", function()
		{
			to([147, 13, "linear", 100, "hideNotes"], {plr: [2, 3]});
		});

		layer("pinch 2", function()
		{
			jump([146, 83.6364, "shade"], {plr: 3});
			to([147.75, 0.25, "instant", 100, "dim"], {plr: [2, 3]});
			to([150, 2, "linear", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([152.25, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([153.75, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([155.25, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
		});

		layer("pinch 3", function()
		{
			to([149, 2, "instant", -315.5, "pinch"], {plr: 3, from: 576.5});
			to([152.25, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
			to([153.75, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
			to([155.25, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
		});

		layer("dim 2", function()
		{
			to([149, 3, "insine", 35, "dim"], {plr: 3, from: 100});
			to([156.5, 2, "insine", 100, "dim"], {plr: 3});
		});

		layer("pinch 4", function()
		{
			to([146.25, 5.75, "instant", 100, "hideHits"], {plr: 3});
			to([152, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([153.5, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([155, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([156.5, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
		});

		layer("faceZ 2", function()
		{
			to([149, 3, "linear", 0, "faceZ"], {plr: [2, 3], from: 25});
			to([152, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: -25});
			to([153.5, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: 25});
			to([155, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: -25});
			to([156.5, 2, "insine", 0, "faceZ"], {plr: [2, 3], from: 25});
		});

		// -- verse 2 @ 160 --
		layer("shiftX", function()
		{
			jump([190.25, -258.5, "pinch"], {plr: 0});
			to([190.5, 1, "insine", -292, "shiftY0"], {plr: 1});
			to([192, 16, "linear", 33.5, "stage.rotZ"]);
			to([208, 16, "linear", -8, "stage.rotZ"]);
		});

		layer("shiftY", function()
		{
			to([162, 1.5, "insine", 100, "dim"], {plr: 1});
			to([190.75, 1, "insine", -292, "shiftY1"], {plr: 1});
			to([192, 16, "arc", 16.5, "stage.rotY"]);
			to([208, 16, "arc", -8, "stage.rotY"]);
		});

		layer("skewY", function()
		{
			to([191, 1, "insine", -292, "shiftY2"], {plr: 1});
			jump([201.5, 0, "drunk"], {plr: 1});
			jump([202, 355, "fieldY"], {plr: 1});
			to([204, 20, "outsine", -753, "fieldZ"], {plr: 1});
		});

		layer("screen.glitch", function()
		{
			to([164, 4, "inoutsine", 134.5, "fieldZ"], {plr: [1, 2, 3]});
			to([172, 8, "outcubic", 0, "screen.glitch"], {from: 0.05});
			to([191.25, 1, "insine", -292, "shiftY3"], {plr: 1});
			jump([201.5, 0, "swell"], {plr: 1});
			jump([202, 401, "fieldZ"], {plr: 1});
			to([204, 20, "outsine", 2.5, "fieldX"], {plr: 1});
		});

		layer("cam.shake", function()
		{
			to([192, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([193, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([194, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([195, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([196, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([197, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([198, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([199, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([200, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([201, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([202, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([203, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([204, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([205, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([206, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([207, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([208, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([209, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([210, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([211, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([212, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([213, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([214, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([215, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([216, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([217, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([218, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([219, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([220, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([221, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([222, 1, "outcubic", 0, "cam.shake"], {from: 25});
			to([223, 1, "outcubic", 0, "cam.shake"], {from: 25});
		});

		layer("screen.glitch 2", function()
		{
			to([192, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([193, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([194, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([195, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([196, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([197, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([198, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([199, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([200, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([201, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([202, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([203, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([204, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([205, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([206, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([207, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([208, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([209, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([210, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([211, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([212, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([213, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([214, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([215, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([216, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([217, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([218, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([219, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([220, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([221, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([222, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([223, 1, "outcubic", 0, "screen.glitch"], {from: 0.2});
		});

		layer("cam.rotZ", function()
		{
			to([193, 0.04, "instant", 100, "blind"], {plr: 1});
			jump([201.5, 65, "surge"], {plr: 1});
			to([202, 3, "outsine", 0, "blind"], {plr: 1, from: 100});
		});

		layer("faceZ", function()
		{
			to([193, 0.04, "instant", 100, "dim"], {plr: 1});
			to([202, 3, "outsine", 0, "dim"], {plr: 1, from: 100});
		});

		layer("cam.rotZ 2", function()
		{
			to([192, 1, "linear", 100, "eyes.become"]);
			jump([201.5, 120, "rate"], {plr: 1});
			to([223, 1, "linear", 0, "eyes.become"]);
		});

		layer("fieldX", function()
		{
			jump([202, -400, "fieldX"], {plr: 1});
		});

		layer("bendX", function()
		{
			to([204, 2.5, "insine", -20, "bendX"], {plr: 1});
			to([219, 1, "insine", -45, "bendX"], {plr: 1});
			to([221, 1, "insine", 45, "bendX"], {plr: 1});
			to([223, 2.05, "insine", 0, "bendX"], {plr: 1});
		});

		layer("joltX", function()
		{
			to([202, 2, "insine", 10.5, "tiltZ"], {plr: 1});
			to([204, 2, "outsine", 15, "tiltZ"], {plr: 1});
			to([206, 2, "insine", 3, "tiltZ"], {plr: 1});
			to([208, 2, "outsine", -10, "tiltZ"], {plr: 1});
			to([210, 2, "insine", 0, "tiltZ"], {plr: 1});
			to([212, 2, "insine", 10.5, "tiltZ"], {plr: 1});
			to([214, 2, "outsine", 15, "tiltZ"], {plr: 1});
			to([216, 2, "insine", 3, "tiltZ"], {plr: 1});
			to([218, 2, "outsine", -10, "tiltZ"], {plr: 1});
			to([220, 2, "insine", 0, "tiltZ"], {plr: 1});
		});

		layer("dim", function()
		{
			jump([201.5, 73, "joltX"], {plr: 1});
			jump([201.75, 100, "joltX.period"], {plr: 1});
		});

		layer("blind", function()
		{
			jump([201.75, 0, "surge"], {plr: 1});
		});

		layer("pinch", function()
		{
			to([223, 1, "insine", -15, "mirror"], {plr: 1});
		});

		layer("pinchZ", function()
		{
			jump([201.75, 150, "rate"], {plr: 1});
		});

		layer("mirror", function()
		{
			to([203, 1, "outcubic", 0, "faceZ"], {plr: 1, from: 100});
			to([204.5, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([206, 1, "outcubic", 0, "faceZ"], {plr: 1, from: 100});
			to([207, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([208, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([209.5, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([211, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([212.5, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([214, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([215, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([216, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([217.5, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([219, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([220.5, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([222, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			to([223, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
		});

		layer("eyes.angle", function()
		{
			to([192, 8, "insine", 360, "eyes.angle"]);
			to([200, 8, "insine", 360, "eyes.angle"]);
			to([208, 8, "insine", 360, "eyes.angle"]);
			to([216, 8, "insine", 360, "eyes.angle"]);
		});

		layer("eyes.reach", function()
		{
			to([196, 8, "linear", -100, "eyes.reach"]);
			to([204, 8, "linear", 100, "eyes.reach"]);
			to([212, 8, "linear", -100, "eyes.reach"]);
			to([220, 4, "linear", 100, "eyes.reach"]);
		});

		layer("shiftX 2", function()
		{
			jump([160, 100, "blind"], {plr: [2, 3]});
			to([172, 3, "insine", 0, "dim"], {plr: 1});
			to([180, 6, "insine", 49.5, "fadeNear"], {plr: 1});
			to([192, 0.3333, "instant", 0, "fadeNear"], {plr: 1});
		});

		layer("shiftY 2", function()
		{
			jump([171, -563, "fieldX"], {plr: 1});
			to([172, 4, "insine", 48.5, "fieldX"], {plr: 1});
			to([176, 1, "outsine", 76, "fieldX"], {plr: 1});
			to([177, 3, "insine", 538.5, "fieldX"], {plr: 1});
			to([180, 4, "outsine", -236, "fieldX"], {plr: 1});
			to([188.5, 3.5, "outsine", 15.5, "fieldX"], {plr: 1});
		});

		layer("tiltZ", function()
		{
			jump([160, 100, "dim"], {plr: [2, 3]});
			to([172, 4, "insine", 13.5, "tiltZ"], {plr: 1});
			to([176, 1, "outsine", 0, "tiltZ"], {plr: 1});
			to([177, 3, "insine", 13.5, "tiltZ"], {plr: 1});
			to([180, 4, "outsine", -13, "tiltZ"], {plr: 1});
			to([184, 1.5, "outsine", 10, "tiltZ"], {plr: 1});
			to([185.5, 1.5, "outsine", -18.5, "tiltZ"], {plr: 1});
			to([187, 1.5, "outsine", 10, "tiltZ"], {plr: 1});
			to([188.5, 1.5, "outsine", -18.5, "tiltZ"], {plr: 1});
			to([190, 1, "outsine", 18, "tiltZ"], {plr: 1});
			to([191, 1, "outsine", 0, "tiltZ"], {plr: 1});
		});

		layer("hideNotes 2", function()
		{
			jump([171, 100, "rate"], {plr: 1});
			jump([171.5, 100, "swell"], {plr: 1});
			jump([172, 61.5, "drunk"], {plr: 1});
			to([180, 2, "outsine", 100, "flipRow"], {plr: 1});
			to([187, 2, "outsine", 0, "flipRow"], {plr: 1});
		});

		layer("pinch 5", function()
		{
			to([171, 5, "insine", 0, "pinchX"], {plr: 1, from: 91.5});
			to([176, 2, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([180, 2, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([184, 1.5, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([185.5, 1.5, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([187, 1.5, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([188.5, 1.5, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([190, 1, "outsine", 0, "pinch"], {plr: 1, from: -45});
			to([191, 1, "outsine", 0, "pinch"], {plr: 1, from: -45});
		});

		layer("mirror 2", function()
		{
			to([175, 1, "insine", 100, "mirror"], {plr: 1});
			to([176, 1, "outsine", 100, "mirror"], {plr: 1, from: 125});
			to([177, 1, "insine", 0, "mirror"], {plr: 1});
			to([178, 1, "outsine", 0, "mirror"], {plr: 1, from: -25});
			to([181, 1, "insine", 0, "mirror"], {plr: 1});
			to([182, 1, "outsine", 0, "mirror"], {plr: 1, from: -25});
			to([191, 1.75, "insine", 2862, "stage.radius"]);
		});

		layer("cam.z", function()
		{
			to([191, 5, "insine", 718.5, "cam.z"]);
		});

		// -- bridge 1 @ 224 --
		layer("shiftX", function()
		{
			to([224, 4, "insine", 0, "stage.rotZ"]);
			jump([250.75, -325, "fieldX"], {plr: 2});
			to([252, 1, "linear", 0, "blind"], {plr: [1, 2]});
		});

		layer("shiftY", function()
		{
			jump([250.25, 6.5, "bobX"], {plr: [1, 2]});
			jump([250.75, 303.5, "fieldX"], {plr: 1});
			to([252, 1, "linear", 0, "dim"], {plr: [1, 2]});
		});

		layer("skewY", function()
		{
			jump([250.75, 25, "drunk"], {plr: [1, 2]});
			to([252, 0.1141, "inoutsine", 50, "skewY"], {plr: [1, 2], from: 29});
			to([252.25, 0.1141, "inoutsine", -162, "skewY"], {plr: [1, 2], from: 29});
			to([252.5, 1.2494, "inoutcubic", 0, "skewY"], {plr: [1, 2]});
		});

		layer("screen.glitch", function()
		{
			to([251, 1, "insine", 0.3, "screen.glitch"]);
			to([252, 3, "outsine", 0, "screen.glitch"], {from: 0.3});
		});

		layer("cam.shake", function()
		{
			to([252, 3, "linear", 0, "pinchX"], {plr: [0, 1, 2], from: 119});
		});

		layer("screen.glitch 2", function()
		{
			to([224, 4, "inoutcubic", 0, "screen.glitch"], {from: 0.5});
		});

		layer("cam.rotZ", function()
		{
			to([228, 16, "insine", 8, "cam.rotX"]);
			to([244, 12, "outsine", -8, "cam.rotX"]);
		});

		layer("faceX", function()
		{
			to([250.5, 5.5, "inoutsine", 0, "faceX"], {plr: [1, 2], from: 133});
		});

		layer("faceZ0", function()
		{
			to([250.75, 5.25, "inoutsine", 0, "faceZ0"], {plr: [1, 2], from: 50});
		});

		layer("faceZ1", function()
		{
			to([251.25, 4.75, "inoutsine", 0, "faceZ1"], {plr: [1, 2], from: -50});
		});

		layer("spare 3", function()
		{
			jump([251.25, 13, "joltX"], {plr: [1, 2]});
		});

		layer("faceZ2", function()
		{
			to([252, 4, "inoutsine", 0, "faceZ2"], {plr: [1, 2], from: -42.5});
		});

		layer("dim", function()
		{
			to([224, 1.5, "outsine", -40, "mirror"], {plr: 1});
			jump([246.75, 206.5, "fieldZ"], {plr: [1, 2]});
			jump([247.75, -375, "fieldX"], {plr: 2});
			jump([251, 135, "rate"], {plr: [1, 2]});
			to([252, 1.5, "insine", 0, "dim"], {plr: [1, 2]});
		});

		layer("blind", function()
		{
			to([224, 1.5, "outsine", 100, "dim"], {plr: 1});
			jump([246.75, 0, "bendX"], {plr: 2});
			jump([247, 0, "mirror"], {plr: 1});
			jump([247.75, 200, "fieldY"], {plr: 2});
			jump([251, 276.5, "fieldY"], {plr: [1, 2]});
			to([252, 1.5, "linear", 0, "blind"], {plr: [1, 2]});
		});

		layer("freeze", function()
		{
			to([224, 1.5, "outsine", 100, "blind"], {plr: 1});
			jump([246.75, 2, "bobX"], {plr: 2});
			jump([251, 0, "joltX"], {plr: [1, 2]});
		});

		layer("pinch", function()
		{
			jump([246.75, 240, "fieldX"], {plr: 2});
			jump([251, 0, "fadeFar"], {plr: [1, 2]});
		});

		layer("pinchZ", function()
		{
			jump([246.75, 231.7073, "rate"], {plr: 2});
		});

		layer("mirror", function()
		{
			to([224, 1, "outcubic", 0, "faceZ"], {plr: 1, from: -100});
			jump([246.75, 50, "bobX.speed"], {plr: 2});
		});

		layer("skewX", function()
		{
			jump([246.75, 73, "joltX"], {plr: 2});
		});

		layer("fold", function()
		{
			jump([246.75, 201.5, "fieldY"], {plr: 2});
		});

		layer("fieldY", function()
		{
			jump([246.75, 5, "joltY"], {plr: 2});
		});

		layer("fieldY 2", function()
		{
			jump([246.75, 0, "shiftX0"], {plr: 2});
		});

		layer("fieldY 3", function()
		{
			jump([246.75, 0, "shiftX1"], {plr: 2});
		});

		layer("spare 4", function()
		{
			jump([246.75, 0, "shiftX2"], {plr: 2});
		});

		layer("layer 56", function()
		{
			jump([246.75, 0, "shiftX3"], {plr: 2});
		});

		layer("layer 57", function()
		{
			jump([246.75, -292, "shiftY0"], {plr: 2});
		});

		layer("layer 58", function()
		{
			jump([246.75, -292, "shiftY1"], {plr: 2});
		});

		layer("layer 59", function()
		{
			jump([246.75, -292, "shiftY2"], {plr: 2});
		});

		layer("layer 60", function()
		{
			jump([246.75, -292, "shiftY3"], {plr: 2});
		});

		layer("layer 61", function()
		{
			jump([246.75, 100, "rowCenterX"], {plr: 2});
		});

		layer("layer 62", function()
		{
			jump([246.75, 0, "pinch"], {plr: 2});
		});

		layer("layer 63", function()
		{
			jump([246.75, 109, "fadeFar"], {plr: 2});
		});

		layer("layer 65", function()
		{
			jump([246.75, 500, "drawAhead"], {plr: 2});
		});

		layer("layer 66", function()
		{
			jump([246.75, 0, "drawAhead.fade"], {plr: 2});
		});

		layer("mirror 2", function()
		{
			to([224, 1.75, "insine", 1400, "stage.radius"]);
		});

		layer("cam.z", function()
		{
			to([224, 5, "inoutsine", 46, "cam.z"]);
		});

		// -- pre-chorus 2 @ 256 --
		layer("shiftX", function()
		{
			to([279, 1, "insine", 0, "drunk"], {plr: 2});
			to([280, 3.75, "instant", 100, "hideNotes"], {plr: 1});
			to([284, 0.25, "instant", 0, "hideHits"], {plr: 1});
			jump([285.75, 34.1463, "drawAhead.fade"], {plr: 2});
			to([287.5, 0.5, "insine", 0, "drawAhead.fade"], {plr: 2});
		});

		layer("shiftY", function()
		{
			to([280, 4, "instant", 100, "hideHits"], {plr: 1});
			to([284, 3.5, "instant", 100, "hideHits"], {plr: 2});
			to([287.5, 0.25, "instant", 0, "hideHits"], {plr: 2});
		});

		layer("skewY", function()
		{
			to([280, 3, "linear", 603.5, "rowY"], {plr: 2});
			to([283.5, 2.5, "insine", 0, "rowY"], {plr: 2});
		});

		layer("screen.glitch", function()
		{
			to([283, 1, "insine", 0, "drunk"], {plr: 1});
			to([284, 3, "linear", 609.5, "rowY"], {plr: 1});
			to([287, 1, "insine", 0, "rowY"], {plr: 1});
		});

		layer("cam.shake", function()
		{
			jump([280, 100, "freeze"], {plr: 2});
			jump([284, 100, "freeze"], {plr: 1});
			to([287, 1, "insine", 0, "freeze"], {plr: 1});
		});

		layer("screen.glitch 2", function()
		{
			jump([283.5, 1, "drawAhead"], {plr: 2});
			to([284, 0.25, "instant", 0, "freeze"], {plr: 2});
			to([286, 1, "linear", 500, "drawAhead"], {plr: 2});
		});

		layer("cam.rotZ", function()
		{
			to([256, 16, "insine", 8, "cam.rotX"]);
			to([272, 16, "outsine", -3, "cam.rotX"]);
		});

		layer("faceZ", function()
		{
			to([284, 3.75, "instant", 100, "hideNotes"], {plr: 2});
		});

		layer("cam.rotZ 2", function()
		{
			jump([284, 86.3636, "rate"], {plr: 2});
			to([287, 1, "insine", 86.3636, "rate"], {plr: 1});
		});

		layer("shiftY2", function()
		{
			to([284, 4, "linear", 25, "drawAhead.fade"], {plr: [1, 2]});
		});

		layer("faceX", function()
		{
			to([285.5, 2.5, "insine", 35, "cam.shake"]);
		});

		layer("faceZ0", function()
		{
			jump([285.5, 100, "eyes.become"]);
		});

		layer("spare 3", function()
		{
			to([277, 3, "insine", 0, "joltX"], {plr: [1, 2]});
			to([283, 3.5, "linear", 100, "blind"], {plr: 1});
		});

		layer("faceZ2", function()
		{
			to([287, 1, "outsine", 0, "blind"], {plr: 1});
		});

		// -- chorus 2 @ 288 --
		layer("shiftX", function()
		{
			to([319.5, 0.5, "insine", 248.5, "fieldX"], {plr: 1});
			to([324, 2, "insine", 100, "mirror"], {plr: [1, 2]});
			to([326, 1.9262, "insine", 646, "drawAhead"], {plr: 1});
			to([339, 3, "linear", 0, "flipRow"], {plr: 1});
			to([342, 2, "insine", 329.5, "fieldY"], {plr: 2});
			to([345.5, 1, "linear", 100, "hideNotes"], {plr: 2});
			to([347, 1, "linear", 100, "hideNotes"], {plr: 1});
			to([348.5, 1, "linear", 100, "hideNotes"], {plr: 2});
			to([350, 0.75, "linear", 100, "hideNotes"], {plr: 1});
			to([351, 1, "linear", 100, "hideNotes"], {plr: 2});
		});

		layer("shiftY", function()
		{
			to([319.5, 1, "insine", 397.5, "fieldY"], {plr: 2});
			to([320.5, 1.5, "outsine", 2.5, "fadeFar"], {plr: [1, 2]});
			to([325, 1, "insine", 302, "fieldY"], {plr: 2});
			to([328, 1.9962, "linear", -387.5, "rowY"], {plr: 1});
			to([330, 2, "insine", 0, "mirror"], {plr: [1, 2]});
			to([337, 2, "arc", -159, "fieldX"], {plr: 2});
			to([342, 2, "insine", 245, "fieldY"], {plr: 1});
			to([350, 2, "insine", 100, "blind"], {plr: 2});
		});

		layer("skewY", function()
		{
			to([326, 1, "insine", 323, "fieldY"], {plr: 1});
			to([328, 1.9962, "linear", 379.5, "rowY"], {plr: 2});
			to([330, 1, "outsine", 0, "freeze"], {plr: [1, 2]});
			to([331, 1, "insine", 55, "rate"], {plr: [1, 2]});
			to([334, 2, "linear", -40, "faceZ"], {plr: [1, 2]});
			to([336, 3, "insine", -150, "faceZ"], {plr: [1, 2]});
			to([339, 3, "outsine", -360, "faceZ"], {plr: [1, 2]});
			to([342, 2, "insine", -0.5, "fieldX"], {plr: 1});
			to([350, 2, "insine", 100, "dim"], {plr: 2});
		});

		layer("screen.glitch", function()
		{
			to([288, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([289.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([291, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([292.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([294, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([295, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([296, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([297.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([299, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([300.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([302, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([303, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([304, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([305.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([307, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([308.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([310, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([311, 1, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([312, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([313.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([315, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([316.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([318, 0.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([318.5, 0.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([319, 0.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([319.5, 0.5, "outcubic", 0, "screen.glitch"], {from: 0.25});
			to([320, 3, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([323, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([326, 2, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([328, 3, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([331, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([334, 2, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([336, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([339, 3, "outsine", 0, "screen.glitch"], {from: 0.2});
			to([342, 2, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([344, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([345.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([347, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.2});
			to([348.5, 1.5, "outcubic", 0, "screen.glitch"], {from: 0.2});
		});

		layer("cam.shake", function()
		{
			to([323, 3, "linear", 207, "rate"], {plr: [1, 2]});
			to([327.75, 0.5145, "insine", 150, "rate"], {plr: [1, 2]});
			to([331, 3, "linear", 207, "rate"], {plr: [1, 2]});
			to([342, 2, "insine", -0.5, "fieldX"], {plr: 2});
		});

		layer("screen.glitch 2", function()
		{
			to([323, 2.5, "linear", 0, "drag"], {plr: [1, 2]});
			to([326, 2, "insine", 100, "rate"], {plr: [1, 2]});
			jump([328, 100, "freeze"], {plr: [1, 2]});
			to([331, 3, "linear", 0, "drag"], {plr: 1});
			to([336, 3, "insine", 84, "stage.rotZ"]);
			to([339, 3, "outsine", 180, "stage.rotZ"]);
			to([343, 1, "linear", 208, "drawAhead"], {plr: [1, 2]});
			to([344, 1, "outsine", 0, "drunk"], {plr: [1, 2], from: 200});
			to([345.5, 1, "outsine", 0, "drunk"], {plr: [1, 2], from: -350});
			to([347, 1, "outsine", 0, "drunk"], {plr: [1, 2], from: 350});
			to([348.5, 1, "outsine", 0, "drunk"], {plr: [1, 2], from: -350});
		});

		layer("cam.rotZ", function()
		{
			to([320, 3, "arc", 33.5, "cam.rotZ"], {from: 0});
			to([328, 3, "arc", -150, "cam.rotZ"]);
			to([334, 2, "linear", 40, "cam.rotZ"]);
			to([336, 3, "insine", 150, "cam.rotZ"]);
			to([339, 3, "outsine", 360, "cam.rotZ"]);
			to([343.5, 0.5, "insine", 350, "drunk"], {plr: [1, 2]});
			to([345, 0.5, "insine", -350, "drunk"], {plr: [1, 2]});
			to([346.5, 0.5, "insine", 350, "drunk"], {plr: [1, 2]});
			to([348, 0.5, "insine", -350, "drunk"], {plr: [1, 2]});
			to([349, 3, "linear", 600, "drawAhead"], {plr: [1, 2]});
		});

		layer("faceZ", function()
		{
			to([320, 3, "arc", -33.5, "faceZ"], {plr: [1, 2]});
			to([323, 3, "outsine", 180, "faceZ"], {plr: [1, 2]});
			to([328, 3, "arc", 150, "faceZ"], {plr: [1, 2]});
			to([331, 3, "outsine", 0, "faceZ"], {plr: [1, 2]});
			to([341.25, 0.75, "linear", 33.5, "fadeFar"], {plr: [1, 2]});
			to([343, 1, "insine", -50, "mirror"], {plr: [1, 2]});
			to([344, 1, "insine", -40, "mirror"], {plr: [1, 2], from: -50});
			to([345, 0.5, "insine", -50, "mirror"], {plr: [1, 2]});
			to([345.5, 1, "insine", -40, "mirror"], {plr: [1, 2], from: -50});
			to([346.5, 0.5, "insine", -50, "mirror"], {plr: [1, 2]});
			to([347, 1, "insine", -40, "mirror"], {plr: [1, 2], from: -50});
			to([348, 0.5, "insine", -50, "mirror"], {plr: [1, 2]});
			to([348.5, 3.5, "insine", 0, "mirror"], {plr: [1, 2], from: -50});
		});

		layer("cam.rotZ 2", function()
		{
			to([323, 3, "outsine", -180, "cam.rotZ"]);
			to([330, 1, "insine", 100, "flipRow"], {plr: 2});
			to([331, 3.0615, "outsine", 0, "cam.rotZ"]);
			to([342, 1, "linear", 150, "rate"], {plr: [1, 2, 3]});
			to([343, 1, "insine", -250, "pinch"], {plr: [1, 2]});
			to([344, 1, "insine", -100, "pinch"], {plr: [1, 2]});
			to([345, 0.5, "insine", -250, "pinch"], {plr: [1, 2]});
			to([345.5, 1, "insine", -100, "pinch"], {plr: [1, 2]});
			to([346.5, 0.5, "insine", -250, "pinch"], {plr: [1, 2]});
			to([347, 1, "insine", -100, "pinch"], {plr: [1, 2]});
			to([348, 0.5, "insine", -250, "pinch"], {plr: [1, 2]});
			to([348.5, 3.5, "insine", 0, "pinch"], {plr: [1, 2]});
		});

		layer("shiftY2", function()
		{
			to([330, 1, "insine", 0, "flipRow"], {plr: 1});
			to([344, 1.5, "linear", 86, "dim"], {plr: [1, 2], from: 0});
			to([345.5, 1.5, "linear", 86, "dim"], {plr: [1, 2], from: 0});
			to([347, 1.5, "linear", 86, "dim"], {plr: [1, 2], from: 0});
			to([348.5, 1, "linear", 0, "dim"], {plr: [1, 2], from: 0});
		});

		layer("shiftX3", function()
		{
			to([330, 1, "insine", 0, "rowY"], {plr: [1, 2]});
		});

		layer("faceX", function()
		{
			to([288, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([289, 0.5, "insine", 25, "cam.shake"]);
			to([289.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([290.5, 0.5, "insine", 25, "cam.shake"]);
			to([291, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([292, 0.5, "insine", 25, "cam.shake"]);
			to([292.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([293.5, 0.5, "insine", 25, "cam.shake"]);
			to([294, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([294.5, 0.5, "insine", 25, "cam.shake"]);
			to([295, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([295.5, 0.5, "insine", 25, "cam.shake"]);
			to([296, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([297, 0.5, "insine", 25, "cam.shake"]);
			to([297.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([298.5, 0.5, "insine", 25, "cam.shake"]);
			to([299, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([300, 0.5, "insine", 25, "cam.shake"]);
			to([300.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([301.5, 0.5, "insine", 25, "cam.shake"]);
			to([302, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([302.5, 0.5, "insine", 25, "cam.shake"]);
			to([303, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([303.5, 0.5, "insine", 25, "cam.shake"]);
			to([304, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([305, 0.5, "insine", 25, "cam.shake"]);
			to([305.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([306.5, 0.5, "insine", 25, "cam.shake"]);
			to([307, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([308, 0.5, "insine", 25, "cam.shake"]);
			to([308.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([309.5, 0.5, "insine", 25, "cam.shake"]);
			to([310, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([310.5, 0.5, "insine", 25, "cam.shake"]);
			to([311, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([311.5, 0.5, "insine", 25, "cam.shake"]);
			to([312, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([313, 0.5, "insine", 25, "cam.shake"]);
			to([313.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([314.5, 0.5, "insine", 25, "cam.shake"]);
			to([315, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([316, 0.5, "insine", 25, "cam.shake"]);
			to([316.5, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([317.5, 0.5, "insine", 25, "cam.shake"]);
			to([318, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([318.5, 0.5, "insine", 25, "cam.shake"]);
			to([319, 0.5, "outsine", 0, "cam.shake"], {from: 25});
			to([319.5, 0.5, "insine", 25, "cam.shake"]);
			to([320, 1, "outsine", 0, "cam.shake"], {from: 25});
			jump([351.25, 113.5, "surge"], {plr: 1});
		});

		layer("faceZ0", function()
		{
			to([288, 32, "insine", 180, "stage.rotY"]);
			to([320, 24, "outsine", 360, "stage.rotY"]);
			jump([351.25, 30.5, "spinZ"], {plr: 1});
		});

		layer("faceZ1", function()
		{
			to([288, 16, "insine", 2000, "stage.radius"]);
			to([320, 24, "outsine", -52, "stage.rotX"]);
			to([344, 8, "inoutquad", 0, "stage.rotX"]);
		});

		layer("spare 3", function()
		{
			to([288, 1, "outsine", 0, "cam.rotY"], {from: -6});
			to([289, 0.5, "insine", 6, "cam.rotY"]);
			to([289.5, 1, "outsine", 0, "cam.rotY"], {from: 6});
			to([290.5, 0.5, "insine", 724, "cam.rotZ"], {from: 720});
			to([291, 1, "outsine", 720, "cam.rotZ"], {from: 724});
			to([292, 0.5, "insine", 715, "cam.rotZ"], {from: 720});
			to([292.5, 1, "outsine", 720, "cam.rotZ"], {from: 715});
			to([293.5, 0.5, "insine", -20, "cam.rotY"]);
			to([294, 0.5, "outsine", 0, "cam.rotY"], {from: -20});
			to([294.5, 0.5, "insine", 20, "cam.rotY"]);
			to([295, 0.5, "outsine", 0, "cam.rotY"], {from: 20});
			to([295.5, 0.5, "insine", -12, "cam.rotY"], {from: 0});
			to([296, 1, "outsine", 0, "cam.rotY"], {from: -6});
			to([297, 0.5, "insine", 6, "cam.rotY"]);
			to([297.5, 1, "outsine", 0, "cam.rotY"], {from: 6});
			to([298.5, 0.5, "insine", 724, "cam.rotZ"], {from: 720});
			to([299, 1, "outsine", 720, "cam.rotZ"], {from: 724});
			to([300, 0.5, "insine", 715, "cam.rotZ"], {from: 720});
			to([300.5, 1, "outsine", 720, "cam.rotZ"], {from: 715});
			to([301.5, 0.5, "insine", -10, "cam.rotX"]);
			to([302, 0.5, "outsine", 0, "cam.rotX"], {from: -10});
			to([302.5, 0.5, "insine", 10, "cam.rotX"]);
			to([303, 0.5, "outsine", 0, "cam.rotX"], {from: 10});
			to([303.5, 0.5, "insine", -12, "cam.rotY"], {from: 0});
			to([304, 1, "outsine", 0, "cam.rotY"], {from: -6});
			to([305, 0.5, "insine", 6, "cam.rotY"]);
			to([305.5, 1, "outsine", 0, "cam.rotY"], {from: 6});
			to([306.5, 0.5, "insine", 724, "cam.rotZ"], {from: 720});
			to([307, 1, "outsine", 720, "cam.rotZ"], {from: 724});
			to([308, 0.5, "insine", 715, "cam.rotZ"], {from: 720});
			to([308.5, 1, "outsine", 720, "cam.rotZ"], {from: 715});
			to([309.5, 0.5, "insine", -20, "cam.rotY"]);
			to([310, 0.5, "outsine", 0, "cam.rotY"], {from: -20});
			to([310.5, 0.5, "insine", 20, "cam.rotY"]);
			to([311, 0.5, "outsine", 0, "cam.rotY"], {from: 20});
			to([311.5, 0.5, "insine", -12, "cam.rotY"], {from: 0});
			to([312, 1, "outsine", 0, "cam.rotY"], {from: -6});
			to([313, 0.5, "insine", 6, "cam.rotY"]);
			to([313.5, 1, "outsine", 0, "cam.rotY"], {from: 6});
			to([314.5, 0.5, "insine", 724, "cam.rotZ"], {from: 720});
			to([315, 1, "outsine", 720, "cam.rotZ"], {from: 724});
			to([316, 0.5, "insine", 715, "cam.rotZ"], {from: 720});
			to([316.5, 1, "outsine", 720, "cam.rotZ"], {from: 715});
			to([317.5, 0.5, "insine", -10, "cam.rotX"]);
			to([318, 0.5, "outsine", 0, "cam.rotX"], {from: -10});
			to([318.5, 0.5, "insine", 10, "cam.rotX"]);
			to([319, 0.5, "outsine", 0, "cam.rotX"], {from: 10});
			to([319.5, 0.5, "insine", -12, "cam.rotY"], {from: 0});
			to([320, 0.5, "outsine", 0, "cam.rotY"]);
			jump([351.25, 68.5, "spinY"], {plr: 1});
		});

		layer("faceZ2", function()
		{
			to([351.25, 0.75, "insine", 100, "drunk"], {plr: 1});
		});

		layer("layer 67", function()
		{
			to([351, 1, "insine", 85, "drag"], {plr: 1});
		});

		layer("layer 68", function()
		{
			to([351, 1, "insine", -57, "pinch"], {plr: 1});
		});

		layer("layer 69", function()
		{
			to([350, 2, "insine", 27.5, "cam.rotY"]);
		});

		layer("layer 70", function()
		{
			to([351, 1, "insine", 100, "ghost"], {plr: 1});
		});

		layer("bendX", function()
		{
			jump([288, 67.5, "bendX"], {plr: [0, 1, 2]});
			to([290, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([292.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([295, 1, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			jump([296, -67.5, "bendX"], {plr: [0, 1, 2]});
			to([298, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([300.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([303, 1, "linear", 67.5, "bendX"], {plr: [0, 1, 2]});
			jump([304, 67.5, "bendX"], {plr: [0, 1, 2]});
			to([306, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([308.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([311, 1, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			jump([312, -67.5, "bendX"], {plr: [0, 1, 2]});
			to([314, 2, "linear", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([316.5, 1.5, "linear", 66.5, "bendX"], {plr: [0, 1, 2]});
			to([319, 1, "linear", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([320, 1, "inoutsine", 16.5, "bendX"], {plr: [0, 1, 2]});
			to([322.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([325, 1, "insine", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([327.5, 0.5, "insine", 16, "bendX"], {plr: [0, 1, 2]});
			to([330.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([333, 1, "insine", -67.5, "bendX"], {plr: [0, 1, 2]});
			to([334.5, 0.5, "insine", 67.5, "bendX"], {plr: [0, 1, 2]});
			to([335.5, 0.5, "insine", 16, "bendX"], {plr: [0, 1, 2]});
		});

		layer("joltX", function()
		{
			jump([327.5, 50, "joltX.period"], {plr: 1});
			jump([327.75, 70, "joltX"], {plr: 1});
			jump([330, 0, "joltX"], {plr: 1});
		});

		layer("dim", function()
		{
			to([288, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([289.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([291, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([292.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([294, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([295, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([296, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([297.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([299, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([300.5, 1.5, "inoutsine", 45, "blind"], {plr: [0, 1, 2], from: 0});
			to([302, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([303, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([304, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([305.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([307, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([308.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([310, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([311, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([312, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([313.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([315, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([316.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([318, 1, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([319, 1, "inoutsine", 0, "dim"], {plr: [0, 1, 2], from: 0});
		});

		layer("blind", function()
		{
			to([288, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([289.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([291, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([292.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([294, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([295, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([296, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([297.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([299, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([300.5, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([302, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([303, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([304, 1.5, "inoutsine", 85, "dim"], {plr: [0, 1, 2], from: 0});
			to([305.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([307, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([308.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([310, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([311, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([312, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([313.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([315, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([316.5, 1.5, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([318, 1, "inoutsine", 85, "blind"], {plr: [0, 1, 2], from: 0});
			to([319, 1, "inoutsine", 0, "blind"], {plr: [0, 1, 2], from: 0});
		});

		layer("freeze", function()
		{
			to([288, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([289, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([289.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([290.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([291, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([292, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([292.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([293.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([294, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([294.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([295, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([295.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([296, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([297, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([297.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([298.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([299, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([300, 0.472, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([300.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([301.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([302, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([302.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([303, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([303.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([304, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([305, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([305.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([306.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([307, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([308, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([308.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([309.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([310, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([310.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([311, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([311.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([312, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([313, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([313.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([314.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([315, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([316, 0.472, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([316.5, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([317.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([318, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([318.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
			to([319, 0.25, "instant", 100, "freeze"], {plr: [0, 1, 2]});
			to([319.5, 0.5, "linear", 0, "freeze"], {plr: [0, 1, 2]});
		});

		layer("pinch", function()
		{
			to([288, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([289.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([291, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([292.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([294, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([295, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([296, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([297.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([299, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([300.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([302, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([303, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([304, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([305.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([307, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([308.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([310, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([311.5, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([312.5, 1, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([313.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([315, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([316.5, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([318, 1.5, "outcubic", 0, "pinch"], {plr: [0, 1, 2], from: -150});
			to([323, 2, "incubic", 0, "pinch0"], {plr: [1, 2], from: -255.5});
			to([331, 2, "incubic", 0, "pinch3"], {plr: [1, 2], from: -255.5});
			to([339, 2, "incubic", 0, "pinch3"], {plr: [1, 2], from: -255.5});
		});

		layer("pinchZ", function()
		{
			to([288, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([289.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([291, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([292.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([294, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([295, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([296, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([297.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([299, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([300.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([302, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([303, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([304, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([305.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([307, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([308.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([310, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([311.5, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([312.5, 1, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([313.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([315, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([316.5, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
			to([318, 1.5, "incubic", 0, "pinchZ"], {plr: [0, 1, 2], from: -977.5});
		});

		layer("mirror", function()
		{
			to([289, 0.5, "insine", 100, "mirror"], {plr: [1, 2]});
			to([290.5, 0.5, "insine", 0, "mirror"], {plr: [1, 2]});
			to([293.5, 0.5, "insine", 100, "flipRow"], {plr: 2});
			to([294.5, 0.5, "insine", 0, "flipRow"], {plr: 2});
			to([297, 0.5, "insine", 25, "fieldX"], {plr: 1});
			to([298.5, 0.5, "insine", 553.5, "fieldY"], {plr: 1});
			to([300, 0.5, "insine", 651.5, "fieldY"], {plr: 1});
		});

		layer("skewX", function()
		{
			to([288, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([289.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([291, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([292.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([294, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([295, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([296, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([297.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([299, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([300.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([302, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([303, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([304, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([305.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([307, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([308.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([310, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([311, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([312, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([313.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([315, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([316.5, 1.5, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
			to([318, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: 50});
			to([319, 1, "incubic", 0, "skewX"], {plr: [1, 2], from: -50});
		});

		layer("fold", function()
		{
			to([289, 0.5, "insine", -314.5, "fieldX"], {plr: 1});
			to([290.5, 0.5, "insine", 337.5, "fieldX"], {plr: 1});
			to([292, 0.5, "insine", -314.5, "fieldX"], {plr: 1});
			to([293.5, 0.5, "insine", 0, "flipRow"], {plr: 1});
			to([294.5, 0.5, "insine", 100, "flipRow"], {plr: 1});
			to([295.5, 0.5, "insine", 0, "flipRow"], {plr: 1});
			to([297, 0.5, "insine", 574.5, "fieldY"], {plr: 1});
			to([298.5, 0.5, "insine", 100, "flipRow"], {plr: 1});
			to([300, 0.5, "insine", 0, "flipRow"], {plr: 1});
			to([301.5, 0.5, "insine", -375, "fieldX"], {plr: 2});
			jump([312, 344, "fieldX"], {plr: [1, 3]});
			jump([312.5, -59, "fieldX"], {plr: 1});
			jump([313, -220.5, "fieldX"], {plr: 1});
			jump([313.5, -391.5, "fieldX"], {plr: 1});
			jump([314, 344, "fieldX"], {plr: 2});
			jump([314.5, -59, "fieldX"], {plr: 2});
			jump([315, -391.5, "fieldX"], {plr: 2});
		});

		layer("fieldY", function()
		{
			to([289, 0.5, "insine", 402, "fieldX"], {plr: 2});
			to([290.5, 0.5, "insine", -313.5, "fieldX"], {plr: 2});
			to([292, 0.5, "insine", 402, "fieldX"], {plr: 2});
			to([297, 0.5, "insine", 100, "flipRow"], {plr: 2});
			to([298.5, 0.5, "insine", 0, "flipRow"], {plr: 2});
			to([300, 0.5, "outsine", 100, "flipRow"], {plr: 2});
			to([301.5, 0.5, "insine", 250, "fieldY"], {plr: 2});
			to([303.5, 0.5, "insine", 0, "tiltZ"], {plr: [1, 2]});
			to([305, 0.5, "insine", 0, "flipRow"], {plr: 2});
			jump([312, -246, "fieldX"], {plr: 2});
			jump([312.5, -59, "fieldX"], {plr: 2});
			jump([313, 62.5, "fieldX"], {plr: 2});
			jump([313.5, 460.5, "fieldX"], {plr: 2});
			jump([314, -246, "fieldX"], {plr: 1});
			jump([314.5, -59, "fieldX"], {plr: 1});
			jump([315, 460.5, "fieldX"], {plr: 1});
		});

		layer("fieldY 2", function()
		{
			to([290.5, 0.5, "insine", 100, "flipRow"], {plr: 1});
			to([297, 0.5, "insine", 25, "fieldX"], {plr: 2});
			to([298.5, 0.5, "insine", 32, "fieldY"], {plr: 2});
			to([300, 0.5, "insine", 0, "fieldY"], {plr: 2});
			to([303, 0.5, "insine", -25, "tiltZ"], {plr: [1, 2]});
			to([305, 0.5, "insine", 100, "flipRow"], {plr: 1});
		});

		layer("fieldY 3", function()
		{
			to([297, 0.5, "insine", -96, "fieldY"], {plr: 2});
			to([298.5, 0.5, "insine", 244, "drawAhead"], {plr: [1, 2]});
			to([300, 0.5, "insine", 350, "drawAhead"], {plr: [1, 2]});
			to([301.5, 0.5, "insine", 325, "fieldX"], {plr: 1});
			to([302, 2, "linear", 600, "drawAhead"], {plr: [1, 2]});
			to([304, 1, "outsine", 361.5, "fieldX"], {plr: 2});
			to([306.5, 0.5, "insine", -379, "fieldX"], {plr: 2});
		});

		layer("spare 4", function()
		{
			to([301.5, 0.5, "insine", 250, "fieldY"], {plr: 1});
			to([304, 1, "outsine", -382, "fieldX"], {plr: 1});
			to([306.5, 0.5, "insine", 453, "fieldX"], {plr: 1});
			to([310.5, 0.5, "insine", 100, "mirror"], {plr: [1, 2]});
			to([311.5, 0.5, "insine", 0, "mirror"], {plr: [1, 2]});
		});

		layer("layer 56", function()
		{
			to([301, 1, "insine", 180, "faceZ"], {plr: 2});
			to([307, 1, "outsine", 0, "fold"], {plr: [1, 2], from: 100});
			to([308, 0.5, "insine", -100, "fold"], {plr: [1, 2]});
			to([308.5, 1, "outsine", 0, "fold"], {plr: [1, 2], from: -100});
			to([309.5, 0.5, "insine", 100, "fold"], {plr: [1, 2]});
			to([310, 1, "outsine", 0, "fold"], {plr: [1, 2], from: 100});
		});

		layer("layer 57", function()
		{
			to([301, 1, "insine", -180, "faceZ"], {plr: 1});
			to([303.5, 0.5, "insine", 0, "faceZ"], {plr: [1, 2]});
		});

		// -- verse 3 @ 352 --
		layer("shiftX", function()
		{
			jump([352, 2274.5, "fieldX"], {plr: 2});
			to([354, 2, "linear", 100, "hideNotes"], {plr: 2});
			to([384, 2, "outsine", 0, "pinch2"], {plr: 1, from: -128});
			to([386, 2, "outsine", 0, "pinch3"], {plr: 1, from: -128});
			to([388, 2, "outsine", 0, "pinch2"], {plr: 1, from: -128});
			to([390, 2, "outsine", 0, "pinch2"], {plr: 1, from: -128});
			to([392, 2, "outsine", 0, "pinch0"], {plr: 1, from: -128});
			to([394, 2, "outsine", 0, "pinch1"], {plr: 1, from: -128});
			to([396, 2, "outsine", 0, "pinch0"], {plr: 1, from: -128});
			to([398, 2, "outsine", 0, "pinch2"], {plr: 1, from: -128});
			to([400, 7.75, "outsine", 0, "pinch0"], {plr: 1, from: -128});
			to([408, 7.75, "outsine", 0, "pinch1"], {plr: 1, from: -128});
		});

		layer("shiftY", function()
		{
			to([400, 7.75, "outsine", 0, "pinch1"], {plr: 1, from: -128});
			to([408, 7.75, "outsine", 0, "pinch3"], {plr: 1, from: -128});
		});

		layer("skewY", function()
		{
			to([384, 1, "outcubic", 45, "faceZ2"], {plr: 1});
			to([385, 1, "incubic", 0, "faceZ2"], {plr: 1});
			to([386, 1, "outcubic", -45, "faceZ3"], {plr: 1});
			to([387, 1, "incubic", 0, "faceZ3"], {plr: 1});
			to([388, 1, "outcubic", -45, "faceZ2"], {plr: 1});
			to([389, 1, "incubic", 0, "faceZ2"], {plr: 1});
			to([390, 1, "outcubic", 45, "faceZ3"], {plr: 1});
			to([391, 1, "incubic", 0, "faceZ3"], {plr: 1});
			to([392, 1, "outcubic", 45, "faceZ0"], {plr: 1});
			to([393, 1, "incubic", 0, "faceZ0"], {plr: 1});
			to([394, 1, "outcubic", -45, "faceZ1"], {plr: 1});
			to([395, 1, "incubic", 0, "faceZ1"], {plr: 1});
			to([396, 1, "outcubic", -45, "faceZ0"], {plr: 1});
			to([397, 1, "incubic", 0, "faceZ0"], {plr: 1});
			to([398, 1, "outcubic", 45, "faceZ2"], {plr: 1});
			to([399, 1, "incubic", 0, "faceZ2"], {plr: 1});
			to([415, 1, "insine", 208.5, "zoom"], {plr: 1});
		});

		layer("screen.glitch", function()
		{
			to([378, 6, "insine", 58.5, "fadeNear"], {plr: 1});
			to([396, 4, "insine", 0, "fadeNear"], {plr: 1});
			to([415, 1, "insine", -14, "fieldX"], {plr: 1});
		});

		layer("cam.shake", function()
		{
			to([415, 1, "insine", 344, "fieldY"], {plr: 1});
		});

		layer("screen.glitch 2", function()
		{
			to([415, 1, "insine", 0.4, "screen.glitch"]);
		});

		layer("cam.rotZ 2", function()
		{
			jump([352, 0, "eyes.become"]);
			to([414, 2, "linear", 100, "swell"], {plr: 1});
		});

		layer("faceX", function()
		{
			to([352, 8, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([360, 8, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([368, 8, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([376, 8, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([384, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([385.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([386, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([387.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([388, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([389.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([390, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([391.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([392, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([393.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([394, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([395.25, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([396, 0.75, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([396.75, 1.25, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([398, 2, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([400, 8, "incubic", 0, "screen.glitch"], {from: 0.05});
			to([408, 7, "incubic", 0, "screen.glitch"], {from: 0.05});
		});

		layer("faceZ0", function()
		{
			to([352, 8, "insine", -30.5, "spinZ"], {plr: 1});
			to([360, 8, "insine", 30.5, "spinZ"], {plr: 1});
			to([368, 8, "insine", -30.5, "spinZ"], {plr: 1});
			to([376, 8, "insine", 30.5, "spinZ"], {plr: 1});
		});

		layer("faceZ1", function()
		{
			to([359, 1, "insine", 180, "faceZ"], {plr: 1});
			to([360, 3, "outsine", 360, "faceZ"], {plr: 1, from: 180});
			to([367, 1, "insine", 180, "faceZ"], {plr: 1, from: 360});
			to([368, 3, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([376, 4, "insine", 73.8747, "rate"], {plr: 1});
			to([380, 4, "inoutcubic", 151, "zoom"], {plr: 1});
		});

		layer("spare 3", function()
		{
			to([352, 8, "linear", 0, "drag"], {plr: 1, from: 84.5});
			to([360, 1, "outsine", 68, "drag"], {plr: 1});
			to([361, 6, "outsine", 0, "drag"], {plr: 1, from: 68});
			to([367, 1, "insine", 85, "drag"], {plr: 1});
			to([368, 8, "linear", 0, "drag"], {plr: 1, from: 85});
			to([376, 1, "outsine", 68, "drag"], {plr: 1});
			to([377, 7, "outsine", 0, "drag"], {plr: 1, from: 68});
			to([400, 8, "outsine", 1080, "faceZ"], {plr: 1});
			to([408, 8, "outsine", 0, "faceZ"], {plr: 1});
		});

		layer("faceZ2", function()
		{
			to([360, 1, "insine", 0, "drunk"], {plr: 1});
			to([361, 1, "outsine", -100, "drunk"], {plr: 1});
			to([376, 1, "insine", 0, "drunk"], {plr: 1});
			to([377, 1, "outsine", -100, "drunk"], {plr: 1});
			to([380, 4, "insine", 100, "dim"], {plr: 1});
			to([400, 2, "insine", 123.3747, "rate"], {plr: 1});
		});

		layer("layer 67", function()
		{
			to([375, 1, "insine", -180, "faceZ"], {plr: 1, from: 0});
			to([376, 3, "outsine", -360, "faceZ"], {plr: 1, from: -180});
			jump([380, 0, "faceZ"], {plr: 1});
			to([399, 1, "insine", -25, "mirror"], {plr: 1});
			to([400, 2, "outsine", -50, "mirror"], {plr: 1});
			to([404, 2, "insine", 0, "mirror"], {plr: 1});
			to([407, 1, "insine", -25, "mirror"], {plr: 1});
			to([408, 2, "outsine", -50, "mirror"], {plr: 1});
			to([414, 2, "insine", 0, "mirror"], {plr: 1});
		});

		layer("layer 68", function()
		{
			to([352, 7, "outsine", 0, "pinch"], {plr: 1, from: -57});
			to([359, 1, "insine", -57, "pinch"], {plr: 1});
			to([360, 8, "outsine", 0, "pinch"], {plr: 1, from: -57});
			to([368, 7, "outsine", 0, "pinch"], {plr: 1, from: -57});
			to([375, 1, "insine", -57, "pinch"], {plr: 1});
			to([376, 8, "outsine", 0, "pinch"], {plr: 1, from: -57});
			to([384, 1.25, "outsine", 362.5, "cam.rotZ"]);
			to([385.25, 0.75, "insine", 360, "cam.rotZ"], {from: 362});
			to([386, 1.25, "outsine", 358, "cam.rotZ"]);
			to([387.25, 0.75, "insine", 360, "cam.rotZ"], {from: 358});
			to([388, 1.25, "outsine", 362.5, "cam.rotZ"]);
			to([389.25, 0.75, "insine", 360, "cam.rotZ"], {from: 362});
			to([390, 1.25, "outsine", 358, "cam.rotZ"]);
			to([391.25, 0.75, "insine", 360, "cam.rotZ"], {from: 358});
			to([392, 1.25, "outsine", 362.5, "cam.rotZ"]);
			to([393.25, 0.75, "insine", 360, "cam.rotZ"], {from: 362});
			to([394, 1.25, "outsine", 358, "cam.rotZ"]);
			to([395.25, 0.75, "insine", 360, "cam.rotZ"], {from: 358});
			to([396, 1.25, "outsine", 362.5, "cam.rotZ"]);
			to([397.25, 0.75, "insine", 360, "cam.rotZ"], {from: 362});
			to([398, 1.25, "outsine", 358, "cam.rotZ"]);
			to([399.25, 0.75, "insine", 360, "cam.rotZ"], {from: 358});
			to([415, 1, "insine", 0.25, "stage.invert"]);
		});

		layer("layer 69", function()
		{
			to([352, 8, "outsine", -6.5, "cam.rotY"]);
			to([360, 8, "outsine", 6.5, "cam.rotY"]);
			to([368, 8, "outsine", -6.5, "cam.rotY"]);
			to([376, 8, "outsine", 6.5, "cam.rotY"]);
			to([384, 2.5, "outsine", -16, "cam.rotY"]);
			to([386.5, 1.5, "insine", 0, "cam.rotY"]);
			to([388, 2.5, "outsine", 16, "cam.rotY"]);
			to([390.5, 1.5, "insine", 0, "cam.rotY"]);
			to([392, 2.5, "outsine", -16, "cam.rotY"]);
			to([394.5, 1.5, "insine", 0, "cam.rotY"]);
			to([396, 2.5, "outsine", 16, "cam.rotY"]);
			to([398.5, 1.5, "insine", 0, "cam.rotY"]);
			to([400, 6.5, "outsine", -16, "cam.rotY"]);
			to([406.5, 1.5, "insine", 0, "cam.rotY"]);
			to([408, 5.5, "outsine", 16, "cam.rotY"]);
			to([415, 1, "insine", 1, "stage.gray"]);
		});

		layer("layer 70", function()
		{
			to([359, 1, "outsine", 0, "ghost"], {plr: 1});
			to([360, 1, "outsine", 100, "ghost"], {plr: 1});
			to([367, 1, "outsine", 0, "ghost"], {plr: 1});
			to([368, 1, "outsine", 100, "ghost"], {plr: 1});
			to([375, 1, "outsine", 0, "ghost"], {plr: 1});
			to([376, 1, "outsine", 100, "ghost"], {plr: 1});
			to([382, 2, "insine", 21.5, "fadeNear"], {plr: 1});
			to([400, 2, "insine", -1.5, "fadeNear"], {plr: 1});
			to([415, 1, "outsine", 0, "ghost"], {plr: 1});
		});

		layer("layer 71", function()
		{
			jump([358.75, 100, "dim.fade"], {plr: 1});
			jump([378.75, 0, "dim.fade"], {plr: 1});
			to([382, 2, "insine", -29.4091, "fadeFar.offset"], {plr: 1});
			to([384, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([386, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([388, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([390, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([392, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([394, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([396, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([398, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([415, 1, "insine", 100, "shade"], {plr: 1});
		});

		layer("layer 72", function()
		{
			to([359, 1, "insine", 75, "dim"], {plr: 1});
			to([360, 4, "outsine", 0, "dim"], {plr: 1});
			to([367, 1, "insine", 75, "dim"], {plr: 1});
			to([368, 4, "outsine", 0, "dim"], {plr: 1});
			to([375, 1, "insine", 75, "dim"], {plr: 1});
			to([376, 4, "outsine", 0, "dim"], {plr: 1});
			to([380, 2.5, "insine", 16, "cam.rotY"]);
			to([382.5, 1.5, "insine", 0, "cam.rotY"]);
			to([415, 1, "insine", 0, "fadeNear"], {plr: 1});
		});

		layer("layer 73", function()
		{
			to([415, 1, "insine", 0, "fadeFar.offset"], {plr: 1});
		});

		layer("layer 74", function()
		{
			to([400, 4, "outsine", 0, "cam.shake"], {from: 15});
			to([408, 4, "outsine", 0, "cam.shake"], {from: 15});
		});

		// -- drop @ 416 --
		layer("shiftX", function()
		{
			to([416, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([419, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([422, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([424, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([427, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([430, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([431, 1, "outsine", 0, "cam.shake"], {from: 25});
			to([432, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([435, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([438, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([440, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([443, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([446, 2, "outsine", 0, "cam.shake"], {from: 25});
			to([451, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([454, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([459, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([462, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([467, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([470, 2.5, "outsine", 0, "cam.shake"], {from: 25});
			to([474, 1, "linear", 0, "swell"], {plr: 1});
			to([476, 4, "insine", 37.5, "stage.rotX"]);
		});

		layer("shiftY", function()
		{
			to([416, 2.5, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([419, 2.5, "outsine", 0, "pinch1"], {plr: 1, from: -200.5});
			to([422, 2, "outsine", 0, "pinch2"], {plr: 1, from: -200.5});
			to([424, 2.5, "outsine", 0, "pinch3"], {plr: 1, from: -200.5});
			to([427, 2.5, "outsine", 0, "pinch2"], {plr: 1, from: -200.5});
			to([430, 2, "outsine", 0, "pinch1"], {plr: 1, from: -200.5});
			to([432, 2.5, "outsine", 0, "pinch3"], {plr: 1, from: -200.5});
			to([435, 2.5, "outsine", 0, "pinch2"], {plr: 1, from: -200.5});
			to([438, 2, "outsine", 0, "pinch1"], {plr: 1, from: -200.5});
			to([440, 2.5, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([443, 2.5, "outsine", 0, "pinch1"], {plr: 1, from: -200.5});
			to([446, 2, "outsine", 0, "pinch2"], {plr: 1, from: -200.5});
			to([450.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([451, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([453, 1, "insine", -100, "bendX"], {plr: 1});
			to([454, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([458.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([459, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([461, 1, "insine", -100, "bendX"], {plr: 1});
			to([462, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([466.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([467, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([469, 1, "insine", -100, "bendX"], {plr: 1});
			to([470, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			jump([474, 125, "rate"], {plr: 1});
			to([475, 2, "insine", 0, "dim"], {plr: 1});
		});

		layer("skewY", function()
		{
			to([416, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([418, 1, "insine", -100, "bendX"], {plr: 1});
			to([419, 2.5, "outsine", 0, "bendX"], {plr: 1, from: -100});
			to([422, 1.5, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([423.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([424, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([426, 1, "insine", -100, "bendX"], {plr: 1});
			to([427, 2.5, "outsine", 0, "bendX"], {plr: 1, from: -100});
			to([430, 1.5, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([431.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([432, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([434, 1, "insine", -100, "bendX"], {plr: 1});
			to([435, 2.5, "outsine", 0, "bendX"], {plr: 1, from: -100});
			to([438, 1.5, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([439.5, 0.5, "insine", -100, "bendX"], {plr: 1});
			to([440, 2, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([442, 1, "insine", -100, "bendX"], {plr: 1});
			to([443, 2.5, "outsine", 0, "bendX"], {plr: 1, from: -100});
			to([446, 1.5, "outsine", 0, "bendX"], {plr: 1, from: 126});
			to([447.5, 0.5, "insine", 17.5, "bendX"], {plr: 1});
			to([451, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([454, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([459, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([462, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([467, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([470, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			jump([475.75, 20, "drawAhead.fade"], {plr: 1});
		});

		layer("screen.glitch", function()
		{
			to([416, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([419, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([422, 2, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([424, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([427, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([430, 2, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([432, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([435, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([438, 2, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([440, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([443, 3, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([446, 2, "outsine", 0, "mirror"], {plr: 1, from: -20});
			to([450.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([451, 2, "outsine", 0, "screen.glitch"]);
			to([453, 1, "insine", 0.4, "screen.glitch"]);
			to([454, 2, "outsine", 0, "screen.glitch"]);
			to([458.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([459, 2, "outsine", 0, "screen.glitch"]);
			to([461, 1, "insine", 0.4, "screen.glitch"]);
			to([462, 0.5, "outsine", 0, "screen.glitch"]);
			to([462.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([463, 1, "outsine", 0, "screen.glitch"]);
			to([466.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([467, 2, "outsine", 0, "screen.glitch"]);
			to([469, 1, "insine", 0.4, "screen.glitch"]);
			to([470, 2, "outsine", 0, "screen.glitch"]);
			to([476, 4, "insine", 240, "stage.rotY"]);
		});

		layer("cam.shake", function()
		{
			to([416, 2, "outsine", 0, "screen.glitch"]);
			to([418, 1, "insine", 0.4, "screen.glitch"]);
			to([419, 2, "outsine", 0, "screen.glitch"]);
			to([421, 1, "insine", 0.4, "screen.glitch"]);
			to([422, 1.5, "outsine", 0, "screen.glitch"]);
			to([423.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([424, 2, "outsine", 0, "screen.glitch"]);
			to([426, 1, "insine", 0.4, "screen.glitch"]);
			to([427, 2, "outsine", 0, "screen.glitch"]);
			to([429, 1, "insine", 0.4, "screen.glitch"]);
			to([430, 0.5, "outsine", 0, "screen.glitch"]);
			to([430.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([431, 0.5, "outsine", 0, "screen.glitch"]);
			to([431.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([432, 2, "outsine", 0, "screen.glitch"]);
			to([434, 1, "insine", 0.4, "screen.glitch"]);
			to([435, 2, "outsine", 0, "screen.glitch"]);
			to([437, 1, "insine", 0.4, "screen.glitch"]);
			to([438, 1.5, "outsine", 0, "screen.glitch"]);
			to([439.5, 0.5, "insine", 0.4, "screen.glitch"]);
			to([440, 2, "outsine", 0, "screen.glitch"]);
			to([442, 1, "insine", 0.4, "screen.glitch"]);
			to([443, 2, "outsine", 0, "screen.glitch"]);
			to([445, 1, "insine", 0.4, "screen.glitch"]);
			to([446, 1.5, "outsine", 0, "screen.glitch"]);
			to([451, 2.5, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([454, 2.5, "outsine", 0, "pinch3"], {plr: 1, from: -200.5});
			to([459, 2.5, "outsine", 0, "pinch3"], {plr: 1, from: -200.5});
			to([462, 1, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([463, 1, "outsine", 0, "pinch1"], {plr: 1, from: -200.5});
			to([467, 2.5, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([470, 2.5, "outsine", 0, "pinch3"], {plr: 1, from: -200.5});
			jump([475.75, 0, "fadeFar"], {plr: 1});
			to([476, 4, "insine", 125, "stage.rotZ"]);
		});

		layer("screen.glitch 2", function()
		{
			to([431, 1, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([447, 1, "outsine", 0, "pinch0"], {plr: 1, from: -200.5});
			to([450.5, 0.5, "insine", 0, "cam.rotY"]);
			to([451, 2, "outsine", 10, "cam.rotY"]);
			to([453, 1, "insine", 0, "cam.rotY"]);
			to([458.5, 0.5, "insine", 0, "cam.rotY"]);
			to([459, 2, "outsine", 10, "cam.rotY"]);
			to([461, 1, "insine", 0, "cam.rotY"]);
			to([466.5, 0.5, "insine", 0, "cam.rotY"]);
			to([467, 2, "outsine", 10, "cam.rotY"]);
			to([469, 1, "insine", 0, "cam.rotY"]);
			jump([471.25, 100, "eyes.become"]);
			to([472.5, 5.25, "instant", 100, "hideHits"], {plr: 1});
			to([477.75, 0.5, "instant", 0, "hideHits"], {plr: 1});
		});

		layer("cam.rotZ", function()
		{
			to([416, 2, "outsine", -10, "cam.rotY"]);
			to([418, 1, "insine", 0, "cam.rotY"]);
			to([419, 2, "outsine", 20, "cam.rotY"]);
			to([421, 1, "insine", 0, "cam.rotY"]);
			to([422, 1.5, "outsine", -10, "cam.rotY"]);
			to([423.5, 0.5, "insine", 0, "cam.rotY"]);
			to([424, 2, "outsine", 20, "cam.rotY"]);
			to([426, 1, "insine", 0, "cam.rotY"]);
			to([427, 2, "outsine", -10, "cam.rotY"]);
			to([429, 1, "insine", 0, "cam.rotY"]);
			to([430, 1, "outsine", 20, "cam.rotY"]);
			to([431, 1, "outsine", -10, "cam.rotY"]);
			to([432, 2, "insine", -10, "cam.rotY"]);
			to([434, 1, "insine", 0, "cam.rotY"]);
			to([435, 2, "outsine", 20, "cam.rotY"]);
			to([437, 1, "insine", 0, "cam.rotY"]);
			to([438, 1.5, "outsine", -10, "cam.rotY"]);
			to([439.5, 0.5, "insine", 0, "cam.rotY"]);
			to([440, 2, "outsine", 20, "cam.rotY"]);
			to([442, 1, "insine", 0, "cam.rotY"]);
			to([443, 1.5, "outsine", -10, "cam.rotY"]);
			to([444.5, 0.5, "insine", 0, "cam.rotY"]);
			to([446, 2, "insine", 0, "dim"], {plr: 1});
			to([450, 1, "insine", 100, "dim"], {plr: 1});
			to([451, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([454, 1, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([458, 1, "insine", 100, "dim"], {plr: 1});
			to([459, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([462, 1, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([466, 1, "insine", 100, "dim"], {plr: 1});
			to([467, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([470, 1, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([472.5, 5.25, "linear", 0, "stage.invert"], {from: 0.25});
		});

		layer("faceZ", function()
		{
			to([416, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([419, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([422, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([424, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([427, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([430, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([432, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([435, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([438, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([440, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([443, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([446, 2, "outsine", 0, "faceZ"], {plr: 1, from: 180});
			to([453, 2, "insine", 0, "dim"], {plr: 1});
			to([460, 1.5, "insine", 0, "dim"], {plr: 1});
			to([472.5, 5.25, "linear", 100, "hideNotes"], {plr: 1});
		});

		layer("cam.rotZ 2", function()
		{
			to([446, 2, "inoutsine", 100, "zoom"], {plr: 1});
			to([450, 1, "insine", 150, "zoom"], {plr: 1});
			to([451, 3, "outsine", 150, "zoom"], {plr: 1, from: 250});
			to([458, 1, "insine", 150, "zoom"], {plr: 1});
			to([459, 3, "outsine", 150, "zoom"], {plr: 1, from: 250});
			to([462, 2, "inoutsine", 100, "zoom"], {plr: 1});
			to([466, 1, "insine", 150, "zoom"], {plr: 1});
			to([467, 3, "outsine", 150, "zoom"], {plr: 1, from: 250});
			to([470, 2, "inoutsine", 100, "zoom"], {plr: 1});
			to([472.5, 5.25, "linear", 0, "stage.gray"], {from: 1});
		});

		layer("shiftY2", function()
		{
			to([446, 2, "insine", 0, "spinZ"], {plr: 1});
			to([452.5, 1.5, "insine", 100, "flipRow"], {plr: 1});
			to([469, 1.5, "insine", 0, "flipRow"], {plr: 1});
			to([472.5, 5.25, "linear", 0, "shade"], {plr: 1, from: 100});
		});

		layer("shiftX3", function()
		{
			to([446, 2, "insine", 0, "spinY"], {plr: 1});
			to([453.5, 1.5, "inoutsine", 100, "zoom"], {plr: 1});
		});

		layer("fieldX", function()
		{
			to([446, 2, "insine", 0, "drunk"], {plr: 1});
		});

		layer("spare", function()
		{
			to([447, 1, "insine", 0, "surge"], {plr: 1});
			to([450, 1, "insine", 100, "surge"], {plr: 1});
			to([454, 1, "insine", 0, "surge"], {plr: 1});
			to([458, 1, "insine", 100, "surge"], {plr: 1});
			to([462, 1, "insine", 0, "surge"], {plr: 1});
			to([466, 1, "insine", 100, "surge"], {plr: 1});
			to([470, 1, "insine", 0, "surge"], {plr: 1});
		});

		layer("spare 2", function()
		{
			to([445, 2, "outsine", 20, "cam.rotY"]);
			to([447, 2, "outsine", 0, "cam.rotY"]);
			to([469, 1, "insine", 0, "dim"], {plr: 1});
			to([472, 2, "outsine", 100, "dim"], {plr: 1});
		});

		layer("shiftX 2", function()
		{
			jump([467, 443.5, "shiftX3"], {plr: 3});
			jump([467.25, -400, "shiftY0"], {plr: 3});
			jump([467.5, -500, "shiftY2"], {plr: 3});
			jump([467.75, -50, "shiftX1"], {plr: 3});
			jump([468.25, -550, "fieldX"], {plr: 3});
			jump([468.5, -248.5, "fieldX"], {plr: 3});
			jump([468.75, 424, "shiftX3"], {plr: 2});
			jump([469, -400, "shiftY0"], {plr: 2});
			jump([469.25, -500, "shiftY2"], {plr: 2});
			jump([469.5, -50, "shiftX1"], {plr: 2});
			jump([469.75, 261, "fieldZ"], {plr: 3});
			jump([470, -235, "fieldX"], {plr: 2});
			to([472, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([473.5, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([475, 1, "outsine", 0, "cam.shake"], {from: 35});
			to([476.5, 1, "outsine", 0, "cam.shake"], {from: 35});
			jump([477.75, 100, "hideHits"], {plr: 2});
		});

		layer("shiftY 2", function()
		{
			jump([467, 225, "shiftY3"], {plr: 3});
			jump([467.25, -775, "shiftX0"], {plr: 3});
			jump([467.5, -50, "shiftX2"], {plr: 3});
			jump([467.75, 225, "shiftY1"], {plr: 3});
			jump([468.25, 43, "fieldY"], {plr: 3});
			jump([468.5, -491, "fieldY"], {plr: 3});
			jump([468.75, 225, "shiftY3"], {plr: 2});
			jump([469, -775, "shiftX0"], {plr: 2});
			jump([469.25, -50, "shiftX2"], {plr: 2});
			jump([469.5, 225, "shiftY1"], {plr: 2});
			jump([470, -490, "fieldY"], {plr: 2});
			jump([471.75, 0, "hideHits"], {plr: 2});
			jump([475.5, 56.5, "bendX"], {plr: 1});
			jump([478, -1070.5, "fieldY"], {plr: 2});
		});

		layer("tiltZ", function()
		{
			jump([466.75, -944.5, "fieldZ"], {plr: 3});
			to([470, 2, "insine", 0, "dim"], {plr: 2, from: 100});
			to([472, 0.5, "linear", 100, "dim"], {plr: 2});
			to([473.5, 0.5, "linear", 100, "dim"], {plr: 2});
			to([475, 0.5, "linear", 100, "dim"], {plr: 2});
			to([476.5, 0.5, "linear", 100, "dim"], {plr: 2});
			to([477, 2.75, "insine", 0, "bendX"], {plr: 1, from: 56});
		});

		layer("hideNotes 2", function()
		{
			to([467, 13, "linear", 100, "hideNotes"], {plr: [2, 3]});
		});

		layer("pinch 2", function()
		{
			jump([466, 83.6364, "shade"], {plr: 3});
			to([467.75, 0.25, "instant", 100, "dim"], {plr: [2, 3]});
			to([470, 2, "linear", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([472.25, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([473.75, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
			to([475.25, 1.25, "outsine", -315.5, "pinch"], {plr: 2, from: 576.5});
		});

		layer("pinch 3", function()
		{
			to([469, 2, "instant", -315.5, "pinch"], {plr: 3, from: 576.5});
			to([472.25, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
			to([473.75, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
			to([475.25, 1.25, "outsine", 0, "dim"], {plr: 2, from: 100});
		});

		layer("dim 2", function()
		{
			to([469, 3, "insine", 35, "dim"], {plr: 3, from: 100});
			to([476.5, 2, "insine", 100, "dim"], {plr: 3});
		});

		layer("pinch 4", function()
		{
			to([466.25, 5.75, "instant", 100, "hideHits"], {plr: 3});
			to([472, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([473.5, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([475, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
			to([476.5, 1, "linear", -315, "pinch"], {plr: 3, from: -417});
		});

		layer("faceZ 2", function()
		{
			to([469, 3, "linear", 0, "faceZ"], {plr: [2, 3], from: 25});
			to([472, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: -25});
			to([473.5, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: 25});
			to([475, 1, "outsine", 0, "faceZ"], {plr: [2, 3], from: -25});
			to([476.5, 2, "insine", 0, "faceZ"], {plr: [2, 3], from: 25});
		});

		layer("layer 75", function()
		{
			jump([468.5, 206.5, "fieldZ"], {plr: 3});
		});

		layer("layer 76", function()
		{
			jump([468.5, 132.8747, "rate"], {plr: 3});
		});

		layer("layer 77", function()
		{
			jump([468.5, 16, "bendX"], {plr: 3});
		});

		layer("layer 78", function()
		{
			jump([468.5, 6.5, "bobX"], {plr: 3});
		});

		layer("layer 79", function()
		{
			jump([468.5, 50, "bobX.speed"], {plr: 3});
		});

		layer("layer 80", function()
		{
			jump([468.5, 5, "joltY"], {plr: 3});
		});

		layer("layer 81", function()
		{
			jump([468.5, 100, "rowCenterX"], {plr: 3});
		});

		layer("layer 82", function()
		{
			jump([468.5, 465, "pinch"], {plr: 3});
		});

		layer("layer 83", function()
		{
			jump([468.5, 100, "flipRow"], {plr: 3});
		});

		layer("layer 84", function()
		{
			jump([468.5, 87.5, "fadeFar"], {plr: 3});
		});

		layer("layer 85", function()
		{
			jump([468.5, 98.0785, "dim"], {plr: 3});
		});

		layer("layer 88", function()
		{
			jump([468.5, 600, "drawAhead"], {plr: 3});
		});

		layer("layer 89", function()
		{
			jump([468.5, 0, "drawAhead.fade"], {plr: 3});
		});

		layer("pinch 5", function()
		{
			to([479.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
		});

		layer("mirror 2", function()
		{
			to([473.25, 0.75, "instant", 244.3171, "fadeFar"], {plr: 1, from: 0});
			to([478, 2, "insine", 100, "beat"], {plr: 1});
		});

		layer("cam.z", function()
		{
			to([474, 3, "insine", 7.3171, "fadeFar"], {plr: 1, from: 100});
			to([478, 2, "insine", 249, "fieldY"], {plr: 1});
		});

		layer("layer 90", function()
		{
			to([476, 2, "insine", 45, "surge"], {plr: 1});
			to([478, 2, "linear", 368.5, "drawAhead"], {plr: 1});
		});

		// -- chorus 3 @ 480 --
		layer("shiftX", function()
		{
			to([480, 26, "outsine", 298.5, "stage.rotX"]);
			to([506, 6, "insine", 360, "stage.rotX"]);
		});

		layer("shiftY", function()
		{
			to([480, 26, "outsine", 0, "stage.rotY"]);
			to([506, 6, "insine", 18, "stage.rotY"]);
		});

		layer("skewY", function()
		{
			to([480, 26, "outsine", 0, "stage.rotZ"]);
			to([506, 6, "insine", 90, "stage.rotZ"]);
		});

		layer("screen.glitch 2", function()
		{
			to([480, 26, "outsine", 524, "stage.radius"]);
			to([506, 6, "insine", 3581.5, "stage.radius"]);
		});

		layer("faceZ", function()
		{
			to([480, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([481.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([483, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([484, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([485.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([487, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([488, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([489.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([491, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([492, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([493.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([495, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([496, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([497.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([499, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([500, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([501.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([503, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([504, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([505.5, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([507, 1, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([508, 1.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([509.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.1});
			to([510, 2, "insine", 0.15, "screen.glitch"]);
		});

		layer("shiftX 2", function()
		{
			jump([480, 100, "blind"], {plr: [2, 3]});
		});

		layer("tiltZ", function()
		{
			jump([480, 100, "dim"], {plr: [2, 3]});
		});

		layer("pinch 5", function()
		{
			to([480, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([481.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([482, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([483.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([484, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([485.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([486, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([487.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([488, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([489.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([490, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([491.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([492, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([493.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([494, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([495.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([496, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([497.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([498, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([499.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([500, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([501.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([502, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([503.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([504, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			jump([505, 0, "fadeFar.fade"], {plr: 1});
			to([505.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([506, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
			to([507.5, 0.5, "incubic", 150, "drunk"], {plr: 1});
			to([508, 1, "outcubic", 0, "drunk"], {plr: 1, from: 150});
			to([509.5, 0.5, "incubic", -150, "drunk"], {plr: 1});
			to([510, 1, "outcubic", 0, "drunk"], {plr: 1, from: -150});
		});

		layer("mirror 2", function()
		{
			to([505.5, 0.5, "insine", 17.5, "fadeFar"], {plr: 1});
			to([507, 1.25, "insine", 0, "fadeFar"], {plr: 1});
			to([510, 2, "insine", 50, "cam.shake"]);
		});

		layer("cam.z", function()
		{
			to([481, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([483, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: -100});
			to([485, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([487, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: -100});
			to([489, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([491, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: -100});
			to([493, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([495, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: -100});
			to([496.5, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([499, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: -100});
			to([501, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([502, 0.5, "outsine", 0, "tipsy"], {plr: 1, from: 100});
			to([503, 1, "outsine", 0, "tipsy"], {plr: 1, from: -200});
			jump([510.75, 35, "drawAhead.fade"], {plr: 1});
		});

		layer("layer 90", function()
		{
			to([480, 16, "insine", 180, "tiltZ"], {plr: 1});
			to([504, 5.5, "linear", 100, "flipRow"], {plr: 1});
			to([511, 1, "linear", 250, "drawAhead"], {plr: 1});
		});

		layer("layer 91", function()
		{
			to([480, 16, "insine", -180, "faceZ"], {plr: 1});
			to([496, 0.5, "insine", 100, "mirror"], {plr: 1});
			to([497, 1.25, "outsine", 0, "fold"], {plr: 1, from: -50});
			to([499.5, 0.5, "insine", 0, "mirror"], {plr: 1});
			to([501.5, 0.5, "insine", 100, "mirror"], {plr: 1});
			to([502.5, 0.5, "outsine", 0, "fold"], {plr: 1, from: -50});
		});

		layer("layer 99", function()
		{
			to([496, 4, "arc", 190, "tiltZ"], {plr: 1});
			to([500, 4, "arc", 160, "tiltZ"], {plr: 1});
			to([504, 4, "arc", 190, "tiltZ"], {plr: 1});
			to([508, 4, "arc", 160, "tiltZ"], {plr: 1});
		});

		layer("layer 92", function()
		{
			jump([510.5, 100, "hideHits"], {plr: [0, 2, 3]});
			to([511, 1, "insine", 0, "surge"], {plr: 1});
		});

		layer("layer 93", function()
		{
			to([511, 1, "insine", -150, "shiftX"], {plr: 1});
		});

		layer("layer 94", function()
		{
			to([503, 7.25, "arc", 250, "rate"], {plr: 1});
			to([511, 1, "insine", 150, "rate"], {plr: 1});
		});

		layer("layer 95", function()
		{
			to([511, 1, "insine", 0, "bobX"], {plr: 1});
		});

		layer("layer 96", function()
		{
			to([510, 2, "insine", 371.5, "drawAhead"], {plr: 1});
		});

		layer("layer 98", function()
		{
			to([510, 2, "insine", 0, "beat"], {plr: 1});
		});

		// -- teleporting @ 512 --
		layer("shiftX", function()
		{
			to([512, 32, "outsine", 720, "stage.rotX"]);
		});

		layer("shiftY", function()
		{
			to([512, 32, "outsine", 360, "stage.rotY"]);
		});

		layer("skewY", function()
		{
			to([512, 32, "outsine", 360, "stage.rotZ"]);
		});

		layer("cam.rotZ", function()
		{
			to([512, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([512.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([513, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([513.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([514, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([514.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([515, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([515.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([516, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([516.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([517, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([517.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([518, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([518.5, 1.5, "insine", 50, "cam.shake"]);
			to([520, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([520.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([521, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([521.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([522, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([522.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([523, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([523.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([524, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([524.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([525, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([525.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([526, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([526.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([527, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([527.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([528, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([528.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([529, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([529.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([530, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([530.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([531, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([531.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([532, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([532.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([533, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([533.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([534, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([534.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([535, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([535.5, 0.5, "outsine", 0, "cam.shake"], {from: 45});
			to([536, 1.5, "outsine", 0, "cam.shake"], {from: 25});
			to([538, 1.5, "outsine", 0, "cam.shake"], {from: 25});
			to([540, 1.5, "outsine", 0, "cam.shake"], {from: 25});
			to([542, 1.5, "outsine", 0, "cam.shake"], {from: 25});
			to([544, 4, "outsine", 0, "cam.shake"], {from: 25});
		});

		layer("faceZ", function()
		{
			to([512, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([512.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([513, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([513.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([514, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([514.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([515, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([515.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([516, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([516.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([517, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([517.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([518, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([518.5, 1.5, "outsine", 0.15, "screen.glitch"]);
			to([520, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([520.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([521, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([521.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([522, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([522.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([523, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([523.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([524, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([524.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([525, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([525.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([526, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([526.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([527, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([527.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([528, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([528.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([529, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([529.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([530, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([530.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([531, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([531.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([532, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([532.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([533, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([533.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([534, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([534.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([535, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([535.5, 0.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([536, 1.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([538, 1.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([540, 1.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([542, 1.5, "outsine", 0, "screen.glitch"], {from: 0.15});
			to([544, 4, "insine", 0, "screen.glitch"], {from: 0.15});
		});

		layer("layer 90", function()
		{
			to([532, 4, "linear", 500, "drawAhead"], {plr: 1});
		});

		layer("layer 92", function()
		{
			to([512, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([512.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([513, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([513.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([514, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([514.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([515, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([515.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([516, 2, "insine", 300, "cam.rotZ"], {from: 360});
			to([518, 2, "insine", 180, "cam.rotZ"], {from: 300});
			to([520, 0.5, "outsine", 180, "cam.rotZ"], {from: 200});
			to([520.5, 0.5, "outsine", 180, "cam.rotZ"], {from: 140});
			to([521, 0.5, "outsine", 180, "cam.rotZ"], {from: 200});
			to([521.5, 0.5, "outsine", 180, "cam.rotZ"], {from: 140});
			to([522, 0.5, "outsine", 180, "cam.rotZ"], {from: 200});
			to([522.5, 0.5, "outsine", 180, "cam.rotZ"], {from: 140});
			to([523, 0.5, "outsine", 180, "cam.rotZ"], {from: 200});
			to([523.5, 0.5, "outsine", 180, "cam.rotZ"], {from: 140});
			to([524, 2, "insine", 90, "cam.rotZ"], {from: 180});
			to([526, 2, "outsine", 0, "cam.rotZ"], {from: 90});
			to([528, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([528.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([529, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([529.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([530, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([530.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([531, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([531.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([532, 0.5, "insine", 360, "cam.rotZ"], {from: 380});
			to([532.5, 0.5, "outsine", 360, "cam.rotZ"], {from: 360});
			to([534, 2, "insine", 100, "drunk"], {plr: 1});
			to([536, 1, "insine", -50, "bendX"], {plr: 1});
			to([537.5, 1, "insine", 50, "bendX"], {plr: 1});
			to([539, 1, "insine", -50, "bendX"], {plr: 1});
			to([541, 1.75, "insine", 50, "bendX"], {plr: 1});
			to([544, 2.75, "insine", -50, "bendX"], {plr: 1});
			jump([554, 0, "eyes.become"]);
			to([575, 1, "insine", 0.1, "screen.glitch"]);
		});

		layer("layer 93", function()
		{
			to([512, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([512.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([513, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([513.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([514, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([514.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([515, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([515.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([516, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([516.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([517, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([517.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([520, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([520.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([521, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([521.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([522, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([522.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([523, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([523.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([524, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([524.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([525, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([525.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([528, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([528.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([529, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([529.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([530, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([530.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([531, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([531.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([532, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: -150});
			to([532.5, 0.5, "outsine", 0, "shiftX"], {plr: 1, from: 150});
			to([533, 3, "insine", 150, "shiftX"], {plr: 1});
			to([536, 3, "outsine", -150, "shiftX"], {plr: 1});
			to([539, 1, "insine", 0, "shiftX"], {plr: 1});
			to([540, 3, "outsine", 150, "shiftX"], {plr: 1});
			to([543, 1, "insine", 0, "shiftX"], {plr: 1});
			to([544, 3, "outsine", -150, "shiftX"], {plr: 1});
			jump([554, 0, "eyes.reach"]);
			to([570, 4, "insine", 100, "eyes.reach"]);
			to([576, 4, "insine", 1, "screen.glitch"], {from: 0.1});
		});

		layer("layer 94", function()
		{
			to([512, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 70});
			to([512.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([513, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([513.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([514, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([514.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([515, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([515.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([516, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([516.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([517, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([517.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([520, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([520.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([521, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([521.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([522, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([522.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([523, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([523.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([524, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([524.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([525, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([525.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([528, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 70});
			to([528.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([529, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([529.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([530, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([530.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([531, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([531.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([532, 0.5, "outsine", 0, "bendX"], {plr: 1, from: 150});
			to([532.5, 0.5, "outsine", 0, "bendX"], {plr: 1, from: -150});
			to([533, 3, "outsine", 50, "bendX"], {plr: 1});
			to([544, 30, "linear", 389, "cam.rotZ"]);
			to([576, 4, "insine", 100, "fade"]);
		});

		layer("layer 95", function()
		{
			to([512, 2, "arc", 8, "cam.rotX"]);
			to([514, 2, "arc", -8, "cam.rotX"]);
			to([516, 2, "arc", 8, "cam.rotX"]);
			to([518, 2, "arc", 24, "cam.rotX"]);
			to([520, 2, "arc", 8, "cam.rotX"]);
			to([522, 2, "arc", -8, "cam.rotX"]);
			to([524, 2, "arc", 8, "cam.rotX"]);
			to([526, 2, "arc", 24, "cam.rotX"]);
			to([528, 2, "arc", 8, "cam.rotX"]);
			to([530, 2, "arc", -8, "cam.rotX"]);
			to([532, 2, "arc", 8, "cam.rotX"]);
			to([534, 2, "insine", 100, "swell"], {plr: 1});
			to([544, 30, "linear", 1090.5, "cam.z"]);
			to([574, 2, "insine", 360, "cam.rotZ"]);
			to([576, 20, "insine", 315, "cam.rotZ"]);
		});

		layer("layer 96", function()
		{
			to([516, 2.5, "insine", 60, "shade"], {plr: 1});
			to([519.5, 1, "outsine", 0, "shade"], {plr: 1});
			to([524, 2.5, "insine", 60, "shade"], {plr: 1});
			to([527.5, 1, "outsine", 0, "shade"], {plr: 1});
			to([574, 2, "insine", -332.5, "cam.z"]);
			to([576, 20, "insine", -92, "cam.z"]);
		});

		layer("layer 97", function()
		{
			to([516, 3.5, "outsine", 1, "stage.invert"]);
			to([519.5, 1, "outsine", 0, "stage.invert"]);
			to([524, 3.5, "outsine", 1, "stage.invert"]);
			to([527.5, 1, "outsine", 0, "stage.invert"]);
			to([533, 11, "insine", 150, "mirror"], {plr: 1});
			to([576, 20, "insine", 231, "cam.fov"]);
		});

		layer("layer 98", function()
		{
			to([516, 4, "insine", 0, "faceZ"], {plr: 1});
			to([524, 4, "insine", 180, "faceZ"], {plr: 1});
			to([533, 11, "insine", 150, "zoom"], {plr: 1});
		});

		layer("layer 100", function()
		{
			to([519.5, 0.5, "outsine", 0, "mirror"], {plr: 1});
			to([527.5, 0.5, "outsine", 100, "mirror"], {plr: 1});
			to([542, 5, "insine", 100, "dim"], {plr: 1});
		});

		layer("layer 101", function()
		{
			to([518, 1, "linear", 200, "rate"], {plr: 1});
			to([520, 1, "linear", 150, "rate"], {plr: 1});
			to([526, 1, "linear", 200, "rate"], {plr: 1});
			to([528, 1, "linear", 150, "rate"], {plr: 1});
		});
	}
}
