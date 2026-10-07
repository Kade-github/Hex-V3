// exported by mod-ed

package kade.hex.modchart.charts;

import kade.hex.chart.Chart;

class RightPaceModchart extends Chart
{
	public function new()
	{
		super("rightpace_modchart", 100);
	}

	override function setup():Void
	{
		quantSkin("gameplay/hex/me-quant-notes");
	}

	override function build():Void
	{
		layer("main", function()
		{
			jump([0, 100, "dim"], {plr: 0});
		});

		layer("layer 2", function()
		{
			jump([0, 100, "rowCenterX"]);
		});
	}
}
