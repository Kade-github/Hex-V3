package kade.hex.notes;

import kade.hex.modules.KE_QOL;
import flixel.FlxG;
import funkin.Conductor;
import funkin.Paths;
import funkin.PlayerSettings;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.input.PreciseInputManager;
import funkin.modding.events.ScriptEvent.NoteScriptEvent;
import funkin.modding.events.ScriptEvent.HitNoteScriptEvent;
import funkin.modding.events.ScriptEvent.UpdateScriptEvent;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.notes.NoteSprite;
import funkin.play.notes.notekind.NoteKind;
import funkin.util.Constants;
import funkin.util.GRhythmUtil;

// stepmania based mine base class
class MineReg extends NoteKind
{
	static inline var MINE_WINDOW:Float = 75;
	static inline var STALE_MS:Float = -1000;

	static inline var COLUMNS:Int = 4;

	public var pressed:Array<Bool> = [false, false, false, false];

	var tapDur:Array<Float> = [0, 0, 0, 0];

	var explosions:Array<FunkinSprite> = [];
	var explosionPool:Array<FunkinSprite> = [];
	var mineBuffer:Array<NoteSprite> = [];
	var otherBuffer:Array<NoteSprite> = [];

	var columnKeys:Array<Dynamic> = [];
	var columnKeysFor:Dynamic = null;

	var hitSound:String = "ui/hex/sounds/mine_reg_hit";

	public function new()
	{
		super("mine_reg", "A mine that explodes when hit!", "hex_mine_reg");
		scoreable = false;
	}

	override public function onNoteMiss(event:NoteScriptEvent):Void
	{
		event.note.visible = false;
		event.cancel();
	}

	override public function onNoteHit(event:HitNoteScriptEvent):Void
	{
		event.cancel();
	}

	override public function onUpdate(event:UpdateScriptEvent):Void
	{
		if (PlayState.instance == null) return;

		super.onUpdate(event);

		var elapsedMs:Float = event.elapsed * 1000;

		sweepExplosions();
		readKeys(elapsedMs);
		collectNotes();

		var mines:Array<NoteSprite> = mineBuffer;
		var others:Array<NoteSprite> = otherBuffer;

		for (mine in mines)
		{
			if (!mine.visible) continue;

			syncMineFrame(mine);
			trackMine(mine);

			mine.hasBeenHit = true;

			var diff:Float = mine.strumTime - Conductor.instance.songPosition;

			if (diff < STALE_MS)
			{
				mine.visible = false;
				mine.kill();
				continue;
			}

			if (diff > 0) continue;

			var startRange:Float = -MINE_WINDOW;

			for (other in others)
			{
				if (other.hasBeenHit) continue;
				if (other.noteData.data != mine.noteData.data) continue;

				var gap:Float = other.strumTime - mine.strumTime;

				if (Math.abs(gap) > Constants.HIT_WINDOW_MS + MINE_WINDOW) continue;

				var window = GRhythmUtil.getHitWindow(other);
				if (window.start > mine.strumTime + MINE_WINDOW) continue;
				if (window.end < mine.strumTime - MINE_WINDOW) continue;

				if (gap > 0)
				{
					var share:Float = -gap * 0.5;
					if (share > startRange) startRange = share;
				}
				else
				{
					var apart:Float = -gap;
					var trim:Float = Math.min(apart / 2, apart - tapDur[other.noteData.getDirection()]);
					if (-trim > startRange) startRange = -trim;
				}
			}

			if (diff < startRange) continue;
			if (!pressed[mine.noteData.getDirection()]) continue;

			explode(mine);
		}
	}

	function trackMine(mine:NoteSprite):Void {}

	function phaseFor(mine:NoteSprite, frames:Int):Int
	{
		var seed:Int = Std.int(mine.strumTime * 10) ^ (mine.noteData.data * 7919);
		seed = (seed ^ (seed >>> 16)) * 0x45d9f3b;
		seed = (seed ^ (seed >>> 16)) * 0x45d9f3b;
		seed = seed ^ (seed >>> 16);

		return (seed & 0x7fffffff) % frames;
	}

	function syncMineFrame(mine:NoteSprite):Void
	{
		var anim = mine.animation.curAnim;
		if (anim == null || anim.numFrames <= 1 || anim.frameRate <= 0) return;

		anim.paused = true;

		var frame:Int = Math.floor((Conductor.instance.songPosition - mine.strumTime) / 1000 * anim.frameRate);

		if (anim.looped)
		{
			frame = (frame + phaseFor(mine, anim.numFrames)) % anim.numFrames;
			if (frame < 0) frame += anim.numFrames;
		}
		else if (frame < 0) frame = 0;
		else if (frame >= anim.numFrames) frame = anim.numFrames - 1;

		anim.curFrame = frame;
	}

	function readKeys(elapsedMs:Float):Void
	{
		if (columnKeys.length != COLUMNS || columnKeysFor != PlayState.instance)
		{
			columnKeysFor = PlayState.instance;
			columnKeys = [];
			for (i in 0...COLUMNS)
				columnKeys.push(PreciseInputManager.getKeysForDirection(PlayerSettings.player1.controls, i));
		}

		for (i in 0...COLUMNS)
		{
			pressed[i] = PreciseInputManager.instance.anyPressed(columnKeys[i]);

			if (pressed[i]) tapDur[i] += elapsedMs;
			else tapDur[i] = 0;
		}
	}

	function collectNotes():Void
	{
		mineBuffer.resize(0);
		otherBuffer.resize(0);

		gatherFrom(PlayState.instance.playerStrumline.notes.members);
		gatherFrom(PlayState.instance.opponentStrumline.notes.members);
	}

	function gatherFrom(members:Array<NoteSprite>):Void
	{
		for (note in members)
		{
			if (note == null || note.noteData == null || !note.visible) continue;

			if (note.noteData.kind == this.noteKind) mineBuffer.push(note);
			else otherBuffer.push(note);
		}
	}

	function explode(mine:NoteSprite):Void
	{
		mine.visible = false;
		mine.kill();
		mine.hasBeenHit = true;

		if (hitSound != null) FunkinSound.playOnce(Paths.sound(hitSound));

		var boom:FunkinSprite = explosionPool.pop();

		if (boom == null)
		{
			boom = FunkinSprite.createSparrow(0, 0, "ui/hex/hex_mine_explosion");
			boom.animation.addByPrefix("explode", "mineBoom", 24, false);
			boom.cameras = [PlayState.instance.camHUD];
		}
		else
		{
			boom.revive();
		}

		boom.x = mine.x + (mine.width - boom.width) * 0.5;
		boom.y = mine.y + (mine.height - boom.height) * 0.5;
		boom.animation.play("explode", true);

		explosions.push(boom);
		PlayState.instance.add(boom);

		@:privateAccess
		PlayState.instance.applyScore(-1000, "miss", -0.1, false);

		var keQOL:KE_QOL = KE_QOL.instance;
		if (keQOL != null)
		{
			keQOL.misses++;
			keQOL.hitANote = true;
			keQOL.updateScore();
		}
	}

	function sweepExplosions():Void
	{
		var i:Int = explosions.length;
		while (i-- > 0)
		{
			var boom:FunkinSprite = explosions[i];

			if (boom == null)
			{
				explosions.splice(i, 1);
				continue;
			}

			if (!boom.animation.finished) continue;

			PlayState.instance.remove(boom);
			boom.kill();
			explosions.splice(i, 1);
			explosionPool.push(boom);
		}
	}
}
