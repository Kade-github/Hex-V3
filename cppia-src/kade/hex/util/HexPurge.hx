package kade.hex.util;

import flixel.FlxG;
import funkin.assets.FunkinAssetCache;

class HexPurge
{
  public static function next(collect:Bool = true):Void
  {
    FunkinAssetCache.instance.preparePurgeCache();

    FlxG.signals.postStateSwitch.addOnce(function()
    {
      FunkinAssetCache.instance.purgeCache(collect);
    });
  }
}
