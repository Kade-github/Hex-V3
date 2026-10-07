package kade.hex.modules;

import funkin.modding.events.ScriptEvent;
import funkin.modding.events.ScriptEvent.SongRetryEvent;
import funkin.modding.events.ScriptEvent.UpdateScriptEvent;
import funkin.modding.module.Module;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.notes.NoteHoldCover;
import funkin.play.notes.Strumline;
import funkin.play.notes.SustainTrail;

class HoldCoverScale extends Module
{
  static inline final ID:String = "HoldCoverScale";
  static inline final RESCAN:Int = 30;

  public static var instance:HoldCoverScale = null;

  public static function ensure():Void
  {
    var found = ModuleHandler.getModule(ID);
    if (found != null && Std.isOfType(found, HoldCoverScale))
    {
      instance = cast found;
      return;
    }

    instance = new HoldCoverScale();

    @:privateAccess
    {
      ModuleHandler.addToModuleCache(instance);
      ModuleHandler.reorderModuleCache();
    }
  }

  var movedCover:Array<NoteHoldCover> = [];
  var movedHold:Array<SustainTrail> = [];

  var extra:Array<Strumline> = [];
  var owner:PlayState = null;
  var wait:Int = 0;

  public function new(?id:String)
  {
    super(ID);
    instance = this;
  }

  public override function onUpdate(event:UpdateScriptEvent)
  {
    super.onUpdate(event);

    var ps = PlayState.instance;
    if (ps == null) return;

    if (owner != ps || --wait <= 0)
    {
      owner = ps;
      wait = RESCAN;
      extra.resize(0);

      for (one in ps.members)
      {
        if (one == null || one == ps.playerStrumline || one == ps.opponentStrumline) continue;
        if (Std.isOfType(one, Strumline)) extra.push(cast one);
      }
    }

    try
    {
      fixLine(ps.playerStrumline);
      fixLine(ps.opponentStrumline);

      for (line in extra)
        fixLine(line);
    }
    catch (e:Dynamic)
    {
      wait = 0;
    }
  }

  public override function onSongRetry(event:SongRetryEvent)
  {
    super.onSongRetry(event);
    forget();
  }

  public override function onStateCreate(event:ScriptEvent)
  {
    super.onStateCreate(event);
    forget();
  }

  function forget():Void
  {
    movedCover = [];
    movedHold = [];
    extra.resize(0);
    owner = null;
  }

  function fixLine(line:Strumline):Void
  {
    if (line == null || line.noteHoldCovers == null || line.noteHoldCovers.members == null) return;

    for (cover in line.noteHoldCovers.members)
    {
      if (cover == null || !cover.alive || !cover.visible || cover.holdNote == null || cover.glow == null || cover.glow.scale == null) continue;

      var at:Int = movedCover.indexOf(cover);
      if (at >= 0 && movedHold[at] == cover.holdNote) continue;

      if (at < 0)
      {
        movedCover.push(cover);
        movedHold.push(cover.holdNote);
      }
      else movedHold[at] = cover.holdNote;

      var full:Float = designScale(line);
      if (full == 0) continue;

      var k:Float = cover.glow.scale.x / full;
      if (Math.abs(k - 1) < 0.001) continue;

      var receptor = line.getByIndex(cover.holdNote.noteDirection);
      if (receptor == null || receptor.offset == null || receptor.origin == null) continue;
      if (cover.glow.offset == null || cover.glow.origin == null) continue;

      var rx:Float = receptor.x - receptor.offset.x + receptor.origin.x;
      var ry:Float = receptor.y - receptor.offset.y + receptor.origin.y;
      var cx:Float = cover.glow.x - cover.glow.offset.x + cover.glow.origin.x;
      var cy:Float = cover.glow.y - cover.glow.offset.y + cover.glow.origin.y;

      cover.x += (rx - cx) * (1 - k);
      cover.y += (ry - cy) * (1 - k);
    }
  }

  function designScale(line:Strumline):Float
  {
    try
    {
      @:privateAccess
      var s:Dynamic = line.noteStyle._data.assets.holdNoteCover.scale;
      if (s != null && s > 0) return s;
    }
    catch (e:Dynamic) {}
    return 1.0;
  }
}
