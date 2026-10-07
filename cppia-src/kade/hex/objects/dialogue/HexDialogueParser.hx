package kade.hex.objects.dialogue;

/**
 * Line types:
 *   // comment                      skipped
 *   cutscenes: weekX_CUT            which cutsceneMode folder [CUTn] points at
 *   playMusic: <key>                story/music/<key>.ogg, "none" fades the current track out
 *   musicVolume: <0-1>              volume for the next playMusic
 *   musicLoop: true|false           whether the next playMusic repeats, sticks until set back
 *   musicEffect: fadeout|fadein|stop
 *                                   acts on the track that is already playing
 *   screenEffect: fadeout|fadein    black curtain over the scene, bars and circles stay put.
 *                                   The script holds until the curtain has finished crossing
 *   playerControls: enabled|disabled
 *                                   disabled hands pacing to the script, lines advance on their own
 *   playSound: <key>                story/sounds/<key>.ogg, one shot
 *   loopSound: <key>                same, but loops until the scene ends
 *   playVideo: <key>                story/videos/<key>.mp4 fullscreen, script waits for it
 *   wait: <seconds>                 hold with no text, then advance on its own
 *   blackScreen                     hide the scene, keep the bars
 *   clearSprites                    empty the sprite mode stage right away, no walk off
 *   startSong                       terminator, loads the PlayState
 *   backToMenu                      terminator, returns to the story menu
 *   - Cutscene Mode -               switch modes
 *   - Sprite Mode - [bg_normal_N]   switch modes and set the backdrop
 *   [bg_normal_N]                   change backdrop while in sprite mode
 *   [CUTn]                          change panel while in cutscene mode
 *   NAME: text [TAG]                spoken line, TAG optional
 *   text [TAG]                      narration line with no nametag
 */
class HexDialogueParser
{
  static var DIRECTIVES:Array<String> = [
    "cutscenes", "playmusic", "musicvolume", "musicloop", "musiceffect", "playsound", "loopsound", "wait", "playvideo", "screeneffect",
    "playercontrols"
  ];

  static var KEYWORDS:Array<String> = ["startsong", "backtomenu", "blackscreen", "clearsprites"];

  public static function parse(raw:String):Array<DialogueCommand>
  {
    var out:Array<DialogueCommand> = [];
    if (raw == null) return out;

    var lines:Array<String> = StringTools.replace(raw, "\r", "").split("\n");

    for (i in 0...lines.length)
    {
      var line:String = StringTools.trim(lines[i]);
      if (line == "" || StringTools.startsWith(line, "//")) continue;

      var lower:String = line.toLowerCase();

      if (StringTools.startsWith(lower, "- cutscene mode -"))
      {
        var cmd:DialogueCommand = new DialogueCommand("mode");
        cmd.mode = "cutscene";
        cmd.tag = lastTag(line);
        out.push(cmd);
        continue;
      }

      if (StringTools.startsWith(lower, "- sprite mode -"))
      {
        var cmd:DialogueCommand = new DialogueCommand("mode");
        cmd.mode = "sprite";
        cmd.tag = lastTag(line);
        out.push(cmd);
        continue;
      }

      if (KEYWORDS.indexOf(lower) != -1)
      {
        out.push(new DialogueCommand(lower));
        continue;
      }

      var colon:Int = line.indexOf(":");

      if (colon > 0 && DIRECTIVES.indexOf(lower.substr(0, colon)) != -1)
      {
        var cmd:DialogueCommand = new DialogueCommand("directive");
        cmd.name = lower.substr(0, colon);
        cmd.value = StringTools.trim(line.substr(colon + 1));
        out.push(cmd);
        continue;
      }

      var bare:String = lastTag(line);
      if (bare != null && StringTools.startsWith(line, "[") && StringTools.endsWith(line, "]"))
      {
        var cmd:DialogueCommand = new DialogueCommand("tag");
        cmd.tag = bare;
        out.push(cmd);
        continue;
      }

      var who:String = null;
      var body:String = line;

      if (colon > 0 && colon <= 10 && line.substr(0, colon).indexOf(" ") == -1)
      {
        who = StringTools.trim(line.substr(0, colon));
        body = StringTools.trim(line.substr(colon + 1));
      }

      var tag:String = lastTag(body);
      if (tag != null) body = StringTools.trim(body.substr(0, body.lastIndexOf("[")));

      var cmd:DialogueCommand = new DialogueCommand("line");
      cmd.who = who;
      cmd.text = body;
      cmd.tag = tag;
      out.push(cmd);
    }

    return out;
  }

  public static function lastTag(line:String):String
  {
    var open:Int = line.lastIndexOf("[");
    var close:Int = line.lastIndexOf("]");
    if (open == -1 || close == -1 || close < open) return null;
    return StringTools.trim(line.substring(open + 1, close));
  }

  public static function folderForTag(tag:String):String
  {
    if (tag == null) return null;
    var under:Int = tag.indexOf("_");
    if (under == -1) return null;
    return tag.substr(0, under);
  }

  public static function isCutTag(tag:String):Bool
  {
    return tag != null && StringTools.startsWith(tag.toUpperCase(), "CUT");
  }

  public static function isBackgroundTag(tag:String):Bool
  {
    return tag != null && StringTools.startsWith(tag.toLowerCase(), "bg_");
  }
}
