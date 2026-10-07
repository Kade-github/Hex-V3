package kade.hex.menus.objects.credits;

import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.group.FunkinGroup;
import funkin.util.WindowUtil;
import kade.hex.objects.BetterAtlasText;

/**
 * A page in the credits.
 */
class CreditPage extends FunkinGroup<FlxSprite>
{
  var icon:FunkinSprite;

  public var invertShader(default, set):FlxRuntimeShader;

  function set_invertShader(value:FlxRuntimeShader):FlxRuntimeShader
  {
    invertShader = value;
    for (child in children)
    {
      child.shader = invertShader;
    }
    return value;
  }

  var header:BetterAtlasText;
  var roles:BetterAtlasText;

  var link:String;

  function setupText(text:BetterAtlasText):Void
  {
    text.alignment = "CENTER";
    text.letterSpacing = 0;
    text.setCharOffset("g", 0, 3);
    text.setCharOffset("y", 0, 3);
    text.setCharOffset("p", 0, 5);
    text.setCharOffset("q", 0, 3);
    text.setCharOffset("j", 0, 3);
    text.setCharOffset("y", 0, 5);
    text.setCharOffset("f", 0, 3);
    text.setCharOffset("'", 1, -12);
    text.setCharOffset("-", 0, -6);
    text.setCharOffset("\"", 1, -12);
    text.setCharOffset(",", -4, 4);
    text.setCharOffset("!", 2, 0);
  }

  public function new(iconPath:String, headerText:String, rolesText:String, toOpen:String)
  {
    super();

    invertShader = null;

    if (iconPath == "" && headerText == "" && rolesText == "") return;

    link = toOpen;

    icon = FunkinSprite.create(0, 0, iconPath);
    add(icon);

    icon.localX -= icon.width / 2;
    icon.localY -= icon.height / 2;

    icon.localX += 120;
    icon.localY += 160;

    header = new BetterAtlasText(Paths.image("ui/fonts/hex_title"), Paths.xml("ui/fonts/hex_title"), 0, 0, "");
    add(header);

    header.text = headerText;

    roles = new BetterAtlasText(Paths.image("ui/fonts/hex_artist"), Paths.xml("ui/fonts/hex_artist"), 0, 0, "");
    add(roles);
    roles.text = rolesText;

    header.alignment = "CENTER";
    header.letterSpacing = 0;
    header.textScale = 0.5;
    header.localY = 315;

    roles.localX = 100;
    header.localX = 100;
    roles.localY = 300 + 80;

    setupText(roles);
    roles.letterSpacing = -1;
  }

  public function openLink():Void
  {
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    WindowUtil.openURL(link);
  }
}
