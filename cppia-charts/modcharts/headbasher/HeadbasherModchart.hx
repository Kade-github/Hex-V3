// exported by mod-ed

package modcharts.headbasher;

import kade.hex.chart.Chart;
import funkin.play.PlayState;
import Math;

class HeadbasherModchart extends Chart
{
	public function new()
	{
		super("headbasher_modchart");
	}

	override function setup():Void
	{
		virtual("camShake");
		quantSkin("gameplay/hex/me-quant-notes");

		addField(0);
	}

	var shookX:Float = 0;
	var shookY:Float = 0;

	var hudShookX:Float = 0;
	var hudShookY:Float = 0;

	static var HUD_FROM:Float = 504;
	static var HUD_TO:Float = 512;

	static var SHAKE_STEP:Float = 25;
	static var SHAKE_FIELDS:Int = 3;

	function shakeHard():Float
	{
		var most:Float = 0;

		for (pn in 0...SHAKE_FIELDS)
		{
			var one:Float = read("camShake", pn);
			if (one < 0)
				one = -one;

			if (one > most)
				most = one;
		}

		return most;
	}

	static function jitter(n:Float):Float
	{
		var s:Float = Math.sin(n * 12.9898 + 78.233) * 43758.5453;
		return (s - Math.floor(s)) * 2 - 1;
	}

	override function frame(beat:Float):Void
	{
		var state = PlayState.instance;
		if (state == null || state.camGame == null || state.camGame.scroll == null)
			return;

		var hud = state.camHUD;
		if (hud != null && hud.scroll == null)
			hud = null;

		state.camGame.scroll.x -= shookX;
		state.camGame.scroll.y -= shookY;

		if (hud != null)
		{
			hud.x -= hudShookX;
			hud.y -= hudShookY;
		}

		shookX = 0;
		shookY = 0;
		hudShookX = 0;
		hudShookY = 0;

		var hard:Float = shakeHard();
		if (hard == 0)
			return;

		var step:Float = Math.floor(songTime() / SHAKE_STEP);

		shookX = jitter(step) * hard;
		shookY = jitter(step + 7.3) * hard;

		state.camGame.scroll.x += shookX;
		state.camGame.scroll.y += shookY;

		if (hud != null && beat >= HUD_FROM && beat < HUD_TO)
		{
			hudShookX = shookX;
			hudShookY = shookY;

			hud.x += hudShookX;
			hud.y += hudShookY;
		}
	}
	override function build():Void
	{
		// == main : layer 1, layer 2, layer 3, layer 7, layer 8, layer 19 ==
		// == category 2 : layer 4, layer 5, layer 6, layer 9 ==
		// == category 3 : layer 10, layer 11, layer 12, layer 13, layer 14, layer 15, layer 16, layer 17, layer 18 ==

		layer("layer 1", function()
		{
			jump([0, -43.5, "fieldX"], {plr: 2});
			jump([0, 311.5, "fieldX"], {plr: 0});
			jump([0, 63.5, "fieldX"], {plr: 1});
			to([174, 2, "insine", 528, "fieldX"], {plr: 1});
			to([192, 2, "outsine", -28, "fieldX"], {plr: 0});
			jump([237.5, 798, "bobX.speed"], {plr: 2});
			to([237.75, 0.75, "insine", 23, "bobX"], {plr: 2});
		});

		layer("layer 2", function()
		{
			jump([0, 88, "zoom"], {plr: [0, 1, 2]});
			to([174, 2, "insine", -551.5, "fieldX"], {plr: 2});
			to([192, 2, "outsine", 93, "fieldX"], {plr: 1, from: 875.5});
		});

		layer("layer 3", function()
		{
			jump([0, 50, "blind", 50, "dim"], {plr: [0, 2]});
			to([192, 2, "outsine", 329.5, "fieldX"], {plr: 2, from: 1137});
		});

		layer("layer 8", function()
		{
			jump([237.5, 100, "hideHits"], {plr: 2});
		});

		layer("layer 4", function()
		{
			to([238, 2, "insine", -145, "shiftX"], {plr: 1});
		});

		layer("layer 5", function()
		{
			to([238, 2, "insine", 91.5, "shiftX"], {plr: 0});
		});

		layer("layer 6", function()
		{
			to([237.25, 0.75, "insine", 15, "camShake"]);
			to([238, 2, "insine", 100, "zoom"]);
		});

		layer("layer 9", function()
		{
			to([238, 4.25, "insine", 0, "camShake"], {from: 15});
		});

		layer("layer 10", function()
		{
			to([238.4454, 1.8058, "insine", 664.5, "shiftY0"], {plr: 2});
		});

		layer("layer 14", function()
		{
			to([238.4454, 1.5, "outsine", 0.5, "faceZ.rate"], {plr: 2});
		});

		layer("layer 15", function()
		{
			to([238.4454, 1.5, "insine", -64.5, "shiftX0"], {plr: 2});
		});

		// -- hit @ 238.5 --
		layer("layer 1", function()
		{
			to([238.5, 2, "insine", 0, "bobX"], {plr: 2});
			to([443.75, 0.5, "insine", 25, "camShake"], {plr: 2});
			to([502, 2, "insine", 3, "camShake"], {plr: 2});
			jump([512, -392.5, "shiftX"], {plr: 1});
		});

		layer("layer 2", function()
		{
			to([238.5, 2.0745, "insine", 100, "blind"], {plr: 2});
			to([502, 2, "insine", 100, "dim"], {plr: [0, 1, 2]});
			jump([512, -1004, "shiftX"], {plr: 0});
		});

		layer("layer 3", function()
		{
			to([238.5, 2.0745, "insine", 100, "dim"], {plr: 2});
			to([448, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([449, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([450, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([451, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([452, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([453, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([454, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([455, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([456, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([457, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([458, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([459, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([460, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([461, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([462, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([463, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([464, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([465, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([466, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([467, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([468, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([469, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([470, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([471, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([472, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([473, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([474, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([475, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([476, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([477, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([478, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([479, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([480, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([481, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([482, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([483, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([484, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([485, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([486, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([487, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([488, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([489, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([490, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([491, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([492, 2, "insine", 0, "camShake"], {plr: 2, from: 10});
			to([502, 2, "insine", 100, "blind"], {plr: [0, 1, 2]});
			to([512, 2, "outsine", 0, "camShake"], {plr: 2});
			to([522, 3, "outsine", 0, "dim"], {plr: 1, from: 100});
		});

		layer("layer 7", function()
		{
			to([503, 1, "insine", 100, "hideHits"]);
			jump([520, 0, "hideHits"], {plr: 1});
			to([522, 3, "outsine", 0, "blind"], {plr: 1, from: 100});
		});

		layer("layer 8", function()
		{
			to([512, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([513, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([514, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([515, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([516, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([517, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([518, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([519, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([520, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([521, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([522, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([523, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([524, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([525, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([526, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([527, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([528, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([529, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([530, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([531, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([532, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([533, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([534, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([535, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([536, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([537, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([538, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([539, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([540, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([541, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([542, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([543, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([544, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([545, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([546, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([547, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([548, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([549, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([550, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([551, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([552, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([553, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([554, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([555, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([556, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([557, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([558, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([559, 1, "outsine", 0, "camShake"], {plr: 2, from: 10});
			to([560, 2, "insine", 0, "camShake"], {plr: 2, from: 10});
			to([564, 2, "insine", 0, "camShake"], {plr: 2, from: 10});
			to([568, 4, "insine", 0, "camShake"], {plr: 2, from: 10});
		});

		layer("layer 11", function()
		{
			to([238.6954, 1.5558, "insine", 664.5, "shiftY1"], {plr: 2});
		});

		layer("layer 12", function()
		{
			to([238.9454, 1.3058, "insine", 664.5, "shiftY2"], {plr: 2});
		});

		layer("layer 13", function()
		{
			to([239.1954, 1.0558, "insine", 664.5, "shiftY3"], {plr: 2});
		});

		layer("layer 16", function()
		{
			to([238.6954, 1.25, "insine", -22.5, "shiftX1"], {plr: 2});
		});

		layer("layer 17", function()
		{
			to([238.9454, 1, "insine", 11.5, "shiftX2"], {plr: 2});
		});

		layer("layer 18", function()
		{
			to([239.1954, 0.75, "insine", 35.5, "shiftX3"], {plr: 2});
		});
	}
}
