package kade.hex.notes;

import funkin.Conductor;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.notes.NoteSprite;
import funkin.util.GRhythmUtil;

// my super evil #muhahaha
class MineSlasher extends MineReg
{
	var playedNotes:Array<Float> = [];

	var lastSongPosition:Float = 0;

	public function new()
	{
		super();

		noteKind = "mine_slasher";
		description = "Slasher specific mine, instantly kills you. lol";
		noteStyleId = "slasher_hb_1";

		hitSound = null;
	}

	override function trackMine(mine:NoteSprite):Void
	{
		var songPosition:Float = Conductor.instance.songPosition;

		if (songPosition < lastSongPosition) playedNotes.resize(0);

		lastSongPosition = songPosition;

		mine.hasBeenHit = false;

		var res = GRhythmUtil.processWindow(mine, false);
		if (!res.botplayHit || playedNotes.contains(mine.strumTime)) return;

		playedNotes.push(mine.strumTime);

		var slasher = PlayState.instance.currentStage.getDad();
		if (slasher == null || !slasher.canPlayOtherAnims) return;

		slasher.playSingAnimation(mine.noteData.getDirection(), false);
		slasher.holdTimer = 0;
	}

	override function explode(mine:NoteSprite):Void
	{
		super.explode(mine);

		var hex = ModuleHandler.getModule("HEX-HUD");
		if (hex != null) hex.scriptCall("evilDeathScreen", []);
	}
}
