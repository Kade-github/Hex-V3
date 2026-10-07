package kade.hex.menus.objects.credits;

import funkin.Paths;
import kade.hex.objects.BetterAtlasText;

/**
 * A page in the credits for past versions of the mod.
 */
class CreditPagePast extends CreditPage
{
  public function new(pastCredits:Array<{name:String, role:String}>, ?localPositions:Array<{x:Float, y:Float}>)
  {
    super("", "", "", "");

    for (i in 0...pastCredits.length)
    {
      var entry = pastCredits[i];

      var text:BetterAtlasText = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, "");
      add(text);
      text.text = entry.name;

      var roleText:BetterAtlasText = new BetterAtlasText(Paths.image("ui/fonts/hex_artist"), Paths.xml("ui/fonts/hex_artist"), 0, 0, "");
      add(roleText);
      roleText.text = entry.role;

      text.textScale = 0.65;
      roleText.textScale = 1.15;

      setupText(text);
      setupText(roleText);
      roleText.letterSpacing = -1;

      if (localPositions != null && i < localPositions.length)
      {
        text.localX = localPositions[i].x;
        text.localY = localPositions[i].y;
        roleText.localX = localPositions[i].x;
        roleText.localY = localPositions[i].y + 70;
      }
    }
  }

  override public function openLink():Void {}
}
