package kade.hex.util;

import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import funkin.assets.Assets;
import funkin.assets.Assets.AssetType;
import funkin.assets.Paths.AssetPath;
import funkin.ui.transition.Transition;

/**
 * Loading screen
 */
class HexAssets
{
  static final SHARED:Array<String> = ["ui/hex/sounds/", "ui/shaders/", "ui/fonts/hex_", "ui/fonts/Arista"];

  /**
   * Every asset of a type under the shared folders and the given ones.
   * @param folders Path prefixes, end them with a slash to match a whole folder.
   * @param skip Assets whose path contains any of these are left out.
   */
  public static function inFolders(type:AssetType, folders:Array<String>, ?skip:Array<String>):Array<AssetPath>
  {
    var results:Array<AssetPath> = [];
    for (folder in SHARED.concat(folders))
    {
      for (path in Assets.listInPath(folder, type))
      {
        if (skipped(path, skip)) continue;
        results.push(path);
      }
    }
    return results;
  }

  static function skipped(path:AssetPath, skip:Array<String>):Bool
  {
    var id:String = path.toString();
    if (!HexTouch.mobile && id.indexOf("-mobile") != -1) return true;
    if (skip == null) return false;
    for (part in skip)
    {
      if (id.indexOf(part) != -1) return true;
    }
    return false;
  }

  public static function go(target:Void->FlxState, query:AssetType->Array<AssetPath>):Void
  {
    Transition.switchState(target, {
      assetQuery: query,
      transition: LoadingScreen(None, None),
      onConstruct: function(state:FlxState)
      {
        if (Std.isOfType(state, FlxTransitionableState))
        {
          var trans:FlxTransitionableState = cast state;
          trans.transIn = null;
          trans.transOut = null;
        }
      }
    });
  }
}
