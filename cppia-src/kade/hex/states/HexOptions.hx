package kade.hex.states;

import kade.hex.util.HexPurge;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import funkin.Assets;
import funkin.Paths;
import funkin.PlayerSettings;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.input.Controls;
import funkin.input.PreciseInputManager;
import funkin.mobile.input.ControlsHandler;
import funkin.Preferences;
import funkin.save.Save;
import funkin.ui.MusicBeatState;
import kade.hex.objects.HexTransitional;
import kade.hex.objects.PersonaSelection;
import kade.hex.objects.options.HexCheckBox;
import kade.hex.objects.options.HexControlItem;
import kade.hex.objects.options.HexDataBox;
import kade.hex.objects.options.HexHeaderItem;
import kade.hex.objects.options.HexOptionItem;
import kade.hex.objects.options.OptionsBacking;
import kade.hex.util.HexTouch;
import openfl.filters.ShaderFilter;

class HexOptions extends MusicBeatState
{
  var bg:FlxSprite;

  var transition:HexTransitional;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;

  var controlsText:FlxSprite;

  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var windowRight:FlxSprite;
  var windowRightBorder:FlxSprite;

  var items:FlxSprite;

  var personaSelection:PersonaSelection;
  var swirly:FlxRuntimeShader;
  var swirly2:FlxRuntimeShader;

  var selectionIndex:Int = 0;
  var selectionIndex2:Int = 0;
  var page:Int = 0;

  var blurShader:FlxRuntimeShader;

  var camInfront:FlxCamera;

  var optionsBacking:OptionsBacking;

  var itemsVisible:Bool = true;

  var isRebinding:Bool = false;
  var rebindingItem:HexControlItem = null;
  var rebindingSlot:Int = 0;

  var popupData:FunkinSprite;
  var popupOffsets:FunkinSprite;

  var okText:FunkinSprite;

  var lerpBlurTime:Float = 0;
  var lastLerpBlur:Float = 0;
  var lerpBlurTarget:Float = 0;
  var currentBlur:Float = 0;

  var shaderTime:Float = 0;
  var hasPlayedIn:Bool = false;

  var changedRenderSizeX:Float = 1;

  var holdDelay:Float = 0;
  var howLong:Float = 0;

  public function new()
  {
    super();
  }

  function startRebind(item:HexControlItem):Void
  {
    isRebinding = true;
    rebindingItem = item;
    rebindingSlot = item.focusedBinding;
    item.selectBinding();
    holdDelay = 0;
    howLong = 0;
  }

  function cancelRebind():Void
  {
    if (rebindingItem == null) return;
    var c:Controls = PlayerSettings.player1.controls;
    var keys:Array<String> = getKeys(c.getKeysForAction(rebindingItem.controlName));
    if (rebindingSlot == 0) rebindingItem.valueLabel.text = keys[0];
    else rebindingItem.valueLabel2.text = keys[1];

    isRebinding = false;
    rebindingItem = null;
  }

  static final QUADS:Array<Array<Float>> = [
    [735, 270, 806, 264, 1039, 118, 857, 143],
    [796, 299, 823, 329, 1010, 275, 943, 247],
    [863, 361, 800, 391, 1011, 415, 1138, 365],
    [784, 454, 853, 510, 1138, 537, 1106, 482]
  ];

  static final DESKTOP_ONLY:Array<String> = ["Unlocked Framerate", "VSync", "Frame Cap", "Auto Pause", "Fullscreen Launch", "Hide Mouse"];

  var dragScrollStart:Float = 0;
  var dragScrolling:Bool = false;
  var dragAdjusting:Bool = false;
  var dragSteps:Int = 0;
  var dragRow:Int = -1;

  function goBack():Void
  {
    if (!hasPlayedIn) return;

    if (itemsVisible) leave();
    else if (popupData.visible || popupOffsets.visible) closePopup();
    else if (isRebinding)
    {
      cancelRebind();
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    }
    else closeList();
  }

  function leave():Void
  {
    transition.transitionIn();
    personaSelection.mix = 0;
    personaSelection.enabled = false;

    transition.onComplete = function(out:Bool)
    {
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 4;
      HexPurge.next();
      FlxG.switchState(function() return mm);
    };
  }

  function closePopup():Void
  {
    setBlurTarget(0);
    itemsVisible = true;
    personaSelection.mix = 0;

    hidePopup();
    setPersonaQuadByIndex();
    forceQuadUpdate();
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
  }

  function closeList():Void
  {
    setBlurTarget(0);
    itemsVisible = true;
    personaSelection.mix = 0;

    FlxTween.tween(optionsBacking, {alpha: 0}, 0.5,
      {
        ease: FlxEase.circOut,
        onComplete: function(_) optionsBacking.visible = false,
        onUpdate: function(_) personaSelection.mix = 0
      });
    FlxTween.tween(optionsBacking.scrollBar, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(optionsBacking.scrollBarBall, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(optionsBacking._bg, {alpha: 0}, 0.5, {ease: FlxEase.circOut});

    setPersonaQuadByIndex();
    forceQuadUpdate();
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
  }

  function enterCategory():Void
  {
    if (selectionIndex == 1 && HexTouch.active && !ControlsHandler.hasExternalInputDevice)
    {
      FunkinSound.playOnce(Paths.sound("ui/main-menu/cancel-menu"));
      return;
    }

    itemsVisible = false;
    setBlurTarget(8);
    setPage(selectionIndex);
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
  }

  function touchList():Void
  {
    if (!optionsBacking.visible || optionsBacking.children.length == 0 || HexTouch.touch == null) return;

    if (HexTouch.touch.justPressed)
    {
      dragScrollStart = optionsBacking.scrollTarget;
      dragScrolling = false;
      dragAdjusting = false;
      dragSteps = 0;
      dragRow = rowAt(HexTouch.touch.gameX, HexTouch.touch.gameY);
    }

    if (HexTouch.pressed && !dragScrolling && !dragAdjusting && dragRow >= 0 && Math.abs(HexTouch.dragX) > 20
      && Math.abs(HexTouch.dragX) > Math.abs(HexTouch.dragY))
    {
      var child:HexOptionItem = optionsBacking.children[dragRow];
      if (!child.isControl && child.valueLabel != null)
      {
        dragAdjusting = true;
        selectRow(dragRow);
      }
    }

    if (HexTouch.pressed && dragAdjusting)
    {
      var steps:Int = Std.int(HexTouch.dragX / 40);
      while (dragSteps != steps)
      {
        var dir:Int = steps > dragSteps ? 1 : -1;
        dragSteps += dir;
        optionsBacking.children[dragRow].adjust(dir);
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
      }
      return;
    }

    if (HexTouch.pressed && (dragScrolling || Math.abs(HexTouch.dragY) > 20))
    {
      dragScrolling = true;
      optionsBacking.scrollTarget = dragScrollStart - HexTouch.dragY;
      optionsBacking.clampScroll();
      return;
    }

    if (!HexTouch.tapped()) return;

    var touchX:Float = HexTouch.touch.gameX;
    var i:Int = rowAt(touchX, HexTouch.touch.gameY);
    if (i < 0) return;

    if (i != selectionIndex2)
    {
      selectRow(i);
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      return;
    }

    var child:HexOptionItem = optionsBacking.children[i];
    if (child.isControl) startRebind(cast child);
    else if (child.valueLabel != null) child.adjust(touchX < optionsBacking.x + optionsBacking._bg.width / 2 ? -1 : 1);
    else child.select();
    FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
  }

  function rowAt(touchX:Float, touchY:Float):Int
  {
    if (touchX < optionsBacking.x || touchX > optionsBacking.x + optionsBacking._bg.width) return -1;
    if (touchY < optionsBacking.y + 10 || touchY > optionsBacking.y + optionsBacking.getViewableHeight()) return -1;

    for (i in 0...optionsBacking.children.length)
    {
      var child:HexOptionItem = optionsBacking.children[i];
      var childY:Float = optionsBacking.y + child.localY;
      if (!child.isHeader && touchY >= childY && touchY <= childY + child.height) return i;
    }

    return -1;
  }

  function selectRow(i:Int):Void
  {
    if (i == selectionIndex2) return;

    var prev:HexOptionItem = optionsBacking.children[selectionIndex2];
    if (prev.isControl) prev.setFocus(0);

    selectionIndex2 = i;
    scrollToSelected();
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    super.destroy();
  }

  public function setPersonaQuadByIndex():Void
  {
    if (!itemsVisible && (popupData.visible || popupOffsets.visible))
    {
      setPersonaQuad(okText.x - 5, okText.y - 10, okText.x + okText.width + 5, okText.y - 10, okText.x + okText.width + 5, okText.y + okText.height + 5,
        okText.x - 5, okText.y + okText.height + 5);
      return;
    }

    if (items == null || itemsVisible)
    {
      var q:Array<Float> = QUADS[selectionIndex];
      if (q != null) setPersonaQuad(q[0], q[1], q[2], q[3], q[4], q[5], q[6], q[7]);
      return;
    }

    if (optionsBacking.children.length == 0) return;

    if (selectionIndex2 > optionsBacking.children.length - 1) selectionIndex2 = 0;
    if (selectionIndex2 < 0) selectionIndex2 = optionsBacking.children.length - 1;

    var child:HexOptionItem = optionsBacking.children[selectionIndex2];

    if (child.isHeader) return;

    var childX:Float = optionsBacking.x + child.localX;
    var childY:Float = optionsBacking.y + child.localY;

    var addition:Float = 0;

    if (child.isControl)
    {
      var vl = child.focusedBinding == 1 ? child.valueLabel2 : child.valueLabel;
      if (vl.width <= 30) childX -= 15;
      childX += vl.localX - vl.width - 25;
      addition = vl.width - 60;
    }
    else if (child.valueLabel != null)
    {
      addition = child.valueLabel.width - 90;
    }

    if (child.isButton)
    {
      addition = child.label.width - 90;
      childX -= 15;
    }

    if (addition < 0) addition = 0;

    setPersonaQuad(childX + 35, childY - 25, childX + 115 + addition, childY + 15, childX + 80 + addition, childY + 90, childX - 5, childY + 40);
  }

  public function forceQuadUpdate():Void
  {
    personaSelection.lerpPos = personaSelection.pos;
  }

  public function setPersonaQuad(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float):Void
  {
    var clipTop:Float = Math.NEGATIVE_INFINITY;
    var clipBottom:Float = Math.POSITIVE_INFINITY;

    var sx:Float = FlxG.scaleMode.scale.x;
    var sy:Float = FlxG.scaleMode.scale.y;

    if (optionsBacking != null && optionsBacking.visible)
    {
      clipTop = (optionsBacking.y + 10) * sy;
      clipBottom = (optionsBacking.y + optionsBacking.getViewableHeight()) * sy;
    }

    var sy1:Float = Math.max(clipTop, Math.min(clipBottom, y1 * sy));
    var sy2:Float = Math.max(clipTop, Math.min(clipBottom, y2 * sy));
    var sy3:Float = Math.max(clipTop, Math.min(clipBottom, y3 * sy));
    var sy4:Float = Math.max(clipTop, Math.min(clipBottom, y4 * sy));

    personaSelection.pos = [[x1 * sx, sy1], [x2 * sx, sy2], [x3 * sx, sy3], [x4 * sx, sy4]];
  }

  static function fromAscii(ascii:Int):String
  {
    switch (ascii)
    {
      case 65: return "A";
      case 66: return "B";
      case 67: return "C";
      case 68: return "D";
      case 69: return "E";
      case 70: return "F";
      case 71: return "G";
      case 72: return "H";
      case 73: return "I";
      case 74: return "J";
      case 75: return "K";
      case 76: return "L";
      case 77: return "M";
      case 78: return "N";
      case 79: return "O";
      case 80: return "P";
      case 81: return "Q";
      case 82: return "R";
      case 83: return "S";
      case 84: return "T";
      case 85: return "U";
      case 86: return "V";
      case 87: return "W";
      case 88: return "X";
      case 89: return "Y";
      case 90: return "Z";
      case 48: return "0";
      case 49: return "1";
      case 50: return "2";
      case 51: return "3";
      case 52: return "4";
      case 53: return "5";
      case 54: return "6";
      case 55: return "7";
      case 56: return "8";
      case 57: return "9";
      case 33: return "PAGEUP";
      case 34: return "PAGEDOWN";
      case 36: return "HOME";
      case 35: return "END";
      case 45: return "INSERT";
      case 27: return "ESCAPE";
      case 189: return "MINUS";
      case 187: return "PLUS";
      case 46: return "DELETE";
      case 8: return "BACKSPACE";
      case 219: return "LBRACKET";
      case 221: return "RBRACKET";
      case 220: return "BACKSLASH";
      case 20: return "CAPSLOCK";
      case 145: return "SCROLL_LOCK";
      case 144: return "NUMLOCK";
      case 186: return "SEMICOLON";
      case 222: return "QUOTE";
      case 13: return "ENTER";
      case 16: return "SHIFT";
      case 188: return "COMMA";
      case 190: return "PERIOD";
      case 191: return "SLASH";
      case 192: return "GRAVEACCENT";
      case 17: return "CONTROL";
      case 18: return "ALT";
      case 32: return "SPACE";
      case 38: return "UP";
      case 40: return "DOWN";
      case 37: return "LEFT";
      case 39: return "RIGHT";
      case 9: return "TAB";
      case 15: return "WINDOWS";
      case 302: return "MENU";
      case 301: return "PRINTSCREEN";
      case 19: return "BREAK";
      case 112: return "F1";
      case 113: return "F2";
      case 114: return "F3";
      case 115: return "F4";
      case 116: return "F5";
      case 117: return "F6";
      case 118: return "F7";
      case 119: return "F8";
      case 120: return "F9";
      case 121: return "F10";
      case 122: return "F11";
      case 123: return "F12";
      case 96: return "NUMPAD0";
      case 97: return "NUMPAD1";
      case 98: return "NUMPAD2";
      case 99: return "NUMPAD3";
      case 100: return "NUMPAD4";
      case 101: return "NUMPAD5";
      case 102: return "NUMPAD6";
      case 103: return "NUMPAD7";
      case 104: return "NUMPAD8";
      case 105: return "NUMPAD9";
      case 109: return "NUMPAD-";
      case 107: return "NUMPAD+";
      case 110: return "NUMPAD.";
      case 106: return "NUMPAD*";
      case 111: return "NUMPAD/";
      default: return "UNKNOWN";
    }
  }

  function getKeys(keys:Array<FlxKey>):Array<String>
  {
    var result:Array<String> = [];
    for (key in keys)
    {
      var code:Int = key;
      result.push(fromAscii(code));
    }
    return result;
  }

  function addControl(controlName:String, label:String):Void
  {
    var bindings:Array<String> = getKeys(PlayerSettings.player1.controls.getKeysForAction(controlName));
    var item:HexControlItem = new HexControlItem(0, 0, label, bindings[0], bindings[1], function(v:String, v2:String) return v);
    item.controlName = controlName;
    optionsBacking.add(item);
  }

  public function setPage(newPage:Int):Void
  {
    page = newPage;

    selectionIndex2 = 0;
    optionsBacking.scrollOffset = 0;
    optionsBacking.scrollTarget = 0;

    optionsBacking.visible = true;
    optionsBacking.alpha = 0;
    optionsBacking.scrollBar.alpha = 0;
    optionsBacking.scrollBarBall.alpha = 0;
    optionsBacking._bg.alpha = 0;
    FlxTween.tween(optionsBacking, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(optionsBacking.scrollBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(optionsBacking.scrollBarBall, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(optionsBacking._bg, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    optionsBacking.clean();
    optionsBacking.centerItems = false;

    switch (page)
    {
      case 0:
        optionsBacking.add(new HexCheckBox(0, 0, "Naughtyness", Preferences.naughtyness, function(checked:Bool)
        {
          Preferences.naughtyness = checked;
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Downscroll", Preferences.downscroll, function(checked:Bool)
        {
          Preferences.downscroll = checked;
        }));

        optionsBacking.add(new HexDataBox(0, 0, "Strumline Background", Std.string(Preferences.strumlineBackgroundOpacity) + "%",
          function(last_value:String, change:Int):String
          {
            var current:Int = Std.parseInt(StringTools.replace(last_value, "%", ""));
            current += change < 0 ? -25 : 25;
            if (current > 100) current = 0;
            if (current < 0) current = 100;
            Preferences.strumlineBackgroundOpacity = current;
            return Std.string(current) + "%";
          }));

        optionsBacking.add(new HexCheckBox(0, 0, "Flashing Lights", Preferences.flashingLights, function(checked:Bool)
        {
          Preferences.flashingLights = checked;
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Unlocked Framerate", Preferences.unlockedFramerate, function(checked:Bool)
        {
          Preferences.unlockedFramerate = checked;
        }));

        var vsyncType:Int = Preferences.vsyncMode;
        var vsync:String = "Off";
        switch (vsyncType)
        {
          case -1:
            vsync = "Adaptive";
          case 0:
            vsync = "Off";
          case 1:
            vsync = "On";
        }

        optionsBacking.add(new HexDataBox(0, 0, "VSync", vsync, function(last_value:String, change:Int):String
        {
          var new_value:Int = 0;
          if (change == -1)
          {
            switch (last_value)
            {
              case "Off":
                new_value = -1;
              case "On":
                new_value = 0;
              case "Adaptive":
                new_value = 1;
            }
          }
          else
          {
            switch (last_value)
            {
              case "Off":
                new_value = 1;
              case "On":
                new_value = -1;
              case "Adaptive":
                new_value = 0;
            }
          }

          Preferences.vsyncMode = new_value;

          switch (new_value)
          {
            case -1:
              return "Adaptive";
            case 0:
              return "Off";
          }
          return "On";
        }));

        optionsBacking.add(new HexDataBox(0, 0, "Frame Cap", Std.string(Preferences.framerate), function(last_value:String, change:Int):String
        {
          var current:Int = Std.parseInt(last_value);
          current += change < 0 ? -5 : 5;
          if (current > 365) current = 30;
          if (current < 30) current = 365;
          Preferences.framerate = current;
          return Std.string(current);
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Camera Zooms", Preferences.zoomCamera, function(checked:Bool)
        {
          Preferences.zoomCamera = checked;
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Auto Pause", Preferences.autoPause, function(checked:Bool)
        {
          Preferences.autoPause = checked;
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Fullscreen Launch", Preferences.autoFullscreen, function(checked:Bool)
        {
          Preferences.autoFullscreen = checked;
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Hide Mouse", Preferences.shouldHideMouse, function(checked:Bool)
        {
          Preferences.shouldHideMouse = checked;
        }));

        if (HexTouch.mobile)
        {
          for (child in optionsBacking.children.copy())
          {
            if (child.label == null || DESKTOP_ONLY.indexOf(child.label.text) == -1) continue;

            optionsBacking.remove(child, true);
            child.destroy();
          }
        }

        if (HexTouch.active)
        {
          var bag:Dynamic = Save.instance.getModOptions("hex");
          optionsBacking.add(new HexCheckBox(0, 0, "Four Lanes", bag != null && bag.fourLanes == true, function(checked:Bool)
          {
            var bag:Dynamic = Save.instance.getModOptions("hex");
            if (bag == null) return;

            bag.fourLanes = checked;
            Save.instance.setModOptions("hex", bag);
          }));
        }

        var chartBag:Dynamic = Save.instance.getModOptions("modchart-engine");

        optionsBacking.add(new HexHeaderItem(0, 0, "Modchart"));

        optionsBacking.add(new HexCheckBox(0, 0, "Quant Notes", chartBag != null && chartBag.quants == true, function(checked:Bool)
        {
          var bag:Dynamic = Save.instance.getModOptions("modchart-engine");
          if (bag == null) return;

          bag.quants = checked;
          Save.instance.setModOptions("modchart-engine", bag);
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Judgements", chartBag == null || chartBag.showJudge != false, function(checked:Bool)
        {
          var bag:Dynamic = Save.instance.getModOptions("modchart-engine");
          if (bag == null) return;

          bag.showJudge = checked;
          Save.instance.setModOptions("modchart-engine", bag);
        }));

        optionsBacking.add(new HexCheckBox(0, 0, "Colored Judgements", chartBag != null && chartBag.coloredJudge == true, function(checked:Bool)
        {
          var bag:Dynamic = Save.instance.getModOptions("modchart-engine");
          if (bag == null) return;

          bag.coloredJudge = checked;
          Save.instance.setModOptions("modchart-engine", bag);
        }));
      case 1:
        optionsBacking.add(new HexHeaderItem(0, 0, "Notes"));
        addControl("note_left", "Left");
        addControl("note_down", "Down");
        addControl("note_up", "Up");
        addControl("note_right", "Right");

        optionsBacking.add(new HexHeaderItem(0, 0, "UI"));
        addControl("ui_left", "Left");
        addControl("ui_down", "Down");
        addControl("ui_up", "Up");
        addControl("ui_right", "Right");
        addControl("accept", "Accept");
        addControl("back", "Back");
        addControl("pause", "Pause");
        addControl("reset", "Reset");

        optionsBacking.add(new HexHeaderItem(0, 0, "Cutscene"));
        addControl("window_fullscreen", "Fullscreen");

        optionsBacking.add(new HexHeaderItem(0, 0, "Volume"));
        addControl("cutscene_advance", "Cutscene Skip");
        addControl("volume_up", "Volume Up");
        addControl("volume_down", "Volume Down");
        addControl("volume_mute", "Volume Mute");
      case 2:
        optionsBacking.visible = false;
        showPopup(1);
        setPersonaQuadByIndex();
        forceQuadUpdate();
        return;
      case 3:
        optionsBacking.visible = false;
        showPopup(0);
        setPersonaQuadByIndex();
        forceQuadUpdate();
        return;
    }

    snapToFirstSelectable();
    scrollToSelected();
    setPersonaQuadByIndex();
    forceQuadUpdate();
  }

  function setBlurTarget(target:Float):Void
  {
    lastLerpBlur = currentBlur;
    currentBlur = target;
    lerpBlurTarget = target;
    lerpBlurTime = 0;
  }

  override public function create():Void
  {
    super.create();

    camInfront = new FlxCamera();

    FlxG.cameras.add(camInfront, false);

    camInfront.bgColor = 0x00000000;

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.8);
    swirly.setFloatArray("uColor1", [0.169, 0.365, 0.337]);
    swirly.setFloatArray("uColor2", [0.286, 0.565, 0.427]);
    swirly.setFloat("uIntensity", 35.0);

    swirly2 = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirlAlpha")));
    swirly2.setFloat("uTime", 0);
    swirly2.setFloat("uMix", 0.8);
    swirly2.setFloatArray("uColor1", [0.161, 0.251, 0.239]);
    swirly2.setFloatArray("uColor2", [0.161, 0.251, 0.239, 0.0]);
    swirly2.setFloat("uIntensity", 35.0);

    bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image("ui/hex/hex_options/bg"));
    add(bg);
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.scrollFactor.set();
    bg.updateHitbox();

    personaSelection = new PersonaSelection();
    personaSelection.initShader(camInfront);

    add(personaSelection);

    personaSelection.mix = 0;
    personaSelection.enabled = true;

    windowRight = new FlxSprite(0, 0);
    windowRight.loadGraphic(Paths.image("ui/hex/hex_options/windowRight"));
    windowRight.setGraphicSize(FlxG.width, FlxG.height);
    windowRight.scrollFactor.set();
    windowRight.updateHitbox();
    add(windowRight);

    var overlay:FlxSprite = new FlxSprite(0, 0);
    overlay.loadGraphic(Paths.image("ui/hex/hex_options/overlay"));
    overlay.setGraphicSize(FlxG.width, FlxG.height);
    overlay.scrollFactor.set();
    overlay.updateHitbox();
    add(overlay);

    var overlayFill:FlxSprite = new FlxSprite(0, 0);
    overlayFill.loadGraphic(Paths.image("ui/hex/hex_options/overlayGreen"));
    overlayFill.setGraphicSize(FlxG.width, FlxG.height);
    overlayFill.scrollFactor.set();
    overlayFill.updateHitbox();
    add(overlayFill);

    windowRight.shader = swirly;
    overlayFill.shader = swirly2;

    windowRightBorder = new FlxSprite(0, 0);
    windowRightBorder.loadGraphic(Paths.image("ui/hex/hex_options/borderRight"));
    windowRightBorder.setGraphicSize(FlxG.width, FlxG.height);
    windowRightBorder.scrollFactor.set();
    windowRightBorder.updateHitbox();
    add(windowRightBorder);

    items = new FlxSprite(0, 0);
    items.loadGraphic(Paths.image("ui/hex/hex_options/optionsItems"));
    add(items);
    items.setGraphicSize(FlxG.width, FlxG.height);
    items.scrollFactor.set();
    items.updateHitbox();

    optionsBacking = new OptionsBacking();
    optionsBacking.visible = false;
    add(optionsBacking._bg);
    add(optionsBacking);
    add(optionsBacking.scrollBar);
    add(optionsBacking.scrollBarBall);

    optionsBacking.center();

    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    topBar.scrollFactor.set();
    add(topBar);

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    bottomBar.scrollFactor.set();
    add(bottomBar);

    controlsText = new FlxSprite(0, 0);
    controlsText.loadGraphic(Paths.image("ui/hex/hex_options/controlsText"));
    controlsText.setGraphicSize(FlxG.width, FlxG.height);
    controlsText.updateHitbox();
    controlsText.scrollFactor.set();
    add(controlsText);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/hex_options/circleTop"));
    topCircle.scrollFactor.set();
    add(topCircle);

    topCircle.scale.set(0.75, 0.75);

    topCircle.x = -topCircle.width * 0.18;
    topCircle.y = -topCircle.height * 0.18;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/hex_options/circleBottom"));
    bottomCircle.scrollFactor.set();
    add(bottomCircle);

    bottomCircle.scale.set(0.75, 0.75);

    bottomCircle.x = FlxG.width - bottomCircle.width * 0.85;
    bottomCircle.y = FlxG.height - bottomCircle.height * 0.82;

    popupData = FunkinSprite.create(0, 0, "ui/hex/hex_options/smallPopUpData");
    popupOffsets = FunkinSprite.create(0, 0, "ui/hex/hex_options/smallPopUpOffset");
    okText = FunkinSprite.create(0, 0, "ui/hex/hex_options/textOk");

    popupData.scale.set(0.75, 0.75);
    popupOffsets.scale.set(0.75, 0.75);
    okText.scale.set(0.75, 0.75);

    popupData.scrollFactor.set();
    popupOffsets.scrollFactor.set();
    okText.scrollFactor.set();

    popupData.updateHitbox();
    popupOffsets.updateHitbox();
    okText.updateHitbox();

    popupData.x = FlxG.width / 2 - popupData.width / 2;
    popupData.y = FlxG.height / 2 - popupData.height / 2;

    okText.x = popupData.x + popupData.width / 2 - okText.width / 2 - 10;
    okText.y = popupData.y + popupData.height - 208;

    popupOffsets.x = FlxG.width / 2 - popupOffsets.width / 2;
    popupOffsets.y = FlxG.height / 2 - popupOffsets.height / 2;

    popupData.visible = false;
    popupOffsets.visible = false;
    okText.visible = false;

    add(popupData);
    add(popupOffsets);
    add(okText);

    transition = new HexTransitional();
    add(transition);
    transition.forceIn();

    blurShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/real_gaus_blur")));
    blurShader.setFloat("uSize", 0);
    blurShader.setFloat("uDirections", 12);
    blurShader.setFloat("uQuality", 4);

    FlxG.camera.filters = [new ShaderFilter(blurShader), personaSelection._internalShaderFilter];

    bottomCircle.cameras = [camInfront];
    optionsBacking._bg.cameras = [camInfront];
    optionsBacking.scrollBar.cameras = [camInfront];
    optionsBacking.scrollBarBall.cameras = [camInfront];
    topCircle.cameras = [camInfront];
    transition.cameras = [camInfront];
    controlsText.cameras = [camInfront];
    topBar.cameras = [camInfront];
    bottomBar.cameras = [camInfront];
    optionsBacking.cameras = [camInfront];
    popupData.cameras = [camInfront];
    popupOffsets.cameras = [camInfront];
    okText.cameras = [camInfront];

    setPersonaQuadByIndex();
    forceQuadUpdate();
  }

  function showPopup(type:Int):Void
  {
    switch (type)
    {
      case 0:
        popupData.alpha = 0;
        FlxTween.tween(popupData, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

        popupData.visible = true;
        popupOffsets.visible = false;
      case 1:
        popupOffsets.alpha = 0;
        FlxTween.tween(popupOffsets, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

        popupData.visible = false;
        popupOffsets.visible = true;
    }
    okText.visible = true;
    okText.alpha = 0;
    FlxTween.tween(okText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
  }

  function hidePopup():Void
  {
    FlxTween.tween(popupData, {alpha: 0}, 0.5,
      {
        ease: FlxEase.circIn,
        onComplete: function(_) popupData.visible = false,
        onUpdate: function(_) personaSelection.mix = 0
      });
    FlxTween.tween(popupOffsets, {alpha: 0}, 0.5, {ease: FlxEase.circIn, onComplete: function(_) popupOffsets.visible = false});
    FlxTween.tween(okText, {alpha: 0}, 0.5, {ease: FlxEase.circIn, onComplete: function(_) okText.visible = false});
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    HexTouch.controls(controlsText, "hex_options/controlsText");
    super.update(elapsed);

    lerpBlurTime += elapsed;
    var blurLerp:Float = FlxMath.lerp(lastLerpBlur, lerpBlurTarget, Math.min(lerpBlurTime / 0.5, 1));
    blurShader.setFloat("uSize", blurLerp);

    if (changedRenderSizeX != FlxG.scaleMode.scale.x)
    {
      changedRenderSizeX = FlxG.scaleMode.scale.x;
      setPersonaQuadByIndex();
      forceQuadUpdate();
    }

    if (!hasPlayedIn && shaderTime > 0.02)
    {
      hasPlayedIn = true;
      transition.transitionOut();
    }

    shaderTime += elapsed;
    swirly.setFloat("uTime", shaderTime / 4);
    swirly2.setFloat("uTime", shaderTime / 4);

    personaSelection.updateShader(elapsed);

    if (!hasPlayedIn) return;

    if (itemsVisible)
    {
      if (personaSelection.mix < 1)
      {
        personaSelection.mix += elapsed * 2;
        if (personaSelection.mix > 1) personaSelection.mix = 1;
      }
      if (FlxG.keys.justPressed.UP)
      {
        selectionIndex--;
        if (selectionIndex < 0) selectionIndex = 3;
        setPersonaQuadByIndex();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      }
      else if (FlxG.keys.justPressed.DOWN)
      {
        selectionIndex++;
        if (selectionIndex > 3) selectionIndex = 0;
        setPersonaQuadByIndex();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      }

      var tappedIndex:Int = HexTouch.tappedQuad(QUADS);
      if (tappedIndex != -1 && tappedIndex != selectionIndex)
      {
        selectionIndex = tappedIndex;
        setPersonaQuadByIndex();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      }
      else if (FlxG.keys.justPressed.ENTER || tappedIndex != -1) enterCategory();

      if (FlxG.keys.justPressed.ESCAPE) leave();
      return;
    }

    if (popupData.visible || popupOffsets.visible)
    {
      if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE || HexTouch.tapped()) closePopup();
      return;
    }

    setPersonaQuadByIndex();

    if (isRebinding)
    {
      if (FlxG.keys.justPressed.ESCAPE)
      {
        cancelRebind();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        return;
      }

      var pressed:Int = FlxG.keys.firstJustPressed();
      if (pressed == -1) return;

      var keyName:String = fromAscii(pressed);

      if (rebindingItem.valueLabel.text == keyName || rebindingItem.valueLabel2.text == keyName)
      {
        cancelRebind();
        FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        return;
      }

      var c:Controls = PlayerSettings.player1.controls;
      var bound:Array<FlxKey> = c.getKeysForAction(rebindingItem.controlName);
      var oldInt:Int = rebindingSlot < bound.length ? bound[rebindingSlot] : 0;

      if (rebindingSlot == 0) rebindingItem.setValue(keyName);
      else rebindingItem.setValue2(keyName);

      c.replaceBinding(c.getControlFromName(rebindingItem.controlName), c.getDeviceFromName("KEYS"), pressed, oldInt);
      PlayerSettings.player1.saveControls();
      Save.instance.flush();

      PreciseInputManager.instance.initializeKeys(c);

      isRebinding = false;
      rebindingItem = null;
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
      return;
    }

    if (FlxG.keys.justPressed.ESCAPE) closeList();

    touchList();

    if (FlxG.keys.justPressed.UP)
    {
      stepSelection(-1);
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
    }
    else if (FlxG.keys.justPressed.DOWN)
    {
      stepSelection(1);
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
    }

    if (optionsBacking.visible && optionsBacking.children.length > 0)
    {
      var leftJustPressed:Bool = FlxG.keys.justPressed.LEFT;
      var rightJustPressed:Bool = FlxG.keys.justPressed.RIGHT;

      if (leftJustPressed || rightJustPressed)
      {
        holdDelay = 0.5;
        howLong = 0;
      }

      if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
      {
        howLong += elapsed;
        if (holdDelay <= 0)
        {
          if (FlxG.keys.pressed.LEFT) leftJustPressed = true;
          else if (FlxG.keys.pressed.RIGHT) rightJustPressed = true;
          holdDelay = 0.08;
          if (howLong > 1.5) holdDelay = 0.01;
        }

        holdDelay -= elapsed;
      }

      if (leftJustPressed || rightJustPressed)
      {
        var child:HexOptionItem = optionsBacking.children[selectionIndex2];
        if (child.isControl)
        {
          if (leftJustPressed && child.focusedBinding == 0) child.setFocus(1);
          else if (rightJustPressed && child.focusedBinding == 1) child.setFocus(0);
          else child.setFocus(leftJustPressed ? 0 : 1);

          setPersonaQuadByIndex();
          FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
        }
        else if (child.valueLabel != null)
        {
          child.adjust(leftJustPressed ? -1 : 1);
          setPersonaQuadByIndex();
          FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
        }
      }
    }

    if (FlxG.keys.justPressed.ENTER && optionsBacking.children.length > 0)
    {
      var child:HexOptionItem = optionsBacking.children[selectionIndex2];
      if (child.isControl) startRebind(cast child);
      else child.select();
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
    }
  }

  function snapToFirstSelectable():Void
  {
    selectionIndex2 = 0;
    if (optionsBacking.children.length == 0) return;

    var guard:Int = 0;
    while (optionsBacking.children[selectionIndex2].isHeader && guard < optionsBacking.children.length)
    {
      selectionIndex2++;
      if (selectionIndex2 > optionsBacking.children.length - 1) selectionIndex2 = 0;
      guard++;
    }
  }

  function stepSelection(dir:Int):Void
  {
    var prev:HexOptionItem = optionsBacking.children[selectionIndex2];
    if (prev.isControl) prev.setFocus(0);

    selectionIndex2 += dir;

    if (selectionIndex2 < 0) selectionIndex2 = optionsBacking.children.length - 1;
    if (selectionIndex2 > optionsBacking.children.length - 1) selectionIndex2 = 0;

    var guard:Int = 0;
    while (optionsBacking.children[selectionIndex2].isHeader && guard < optionsBacking.children.length)
    {
      selectionIndex2 += dir;
      if (selectionIndex2 < 0) selectionIndex2 = optionsBacking.children.length - 1;
      if (selectionIndex2 > optionsBacking.children.length - 1) selectionIndex2 = 0;
      guard++;
    }

    scrollToSelected();
  }

  function scrollToSelected():Void
  {
    if (optionsBacking.children.length == 0) return;

    var itemCenterY:Float = optionsBacking.getItemCenterY(selectionIndex2);
    var viewH:Float = optionsBacking.getViewableHeight();

    var itemBottom:Float = itemCenterY + optionsBacking.children[selectionIndex2].height / 2;
    if (itemBottom - optionsBacking.scrollTarget > viewH) optionsBacking.scrollTarget = itemBottom - viewH + 10;

    var headerTopY:Float = -1;
    var i:Int = selectionIndex2 - 1;
    if (i >= 0 && optionsBacking.children[i].isHeader)
    {
      headerTopY = optionsBacking.getItemCenterY(i) - optionsBacking.children[i].height / 2;
    }

    var scrollTop:Float = headerTopY >= 0 ? headerTopY : (itemCenterY - optionsBacking.children[selectionIndex2].height / 2);
    if (scrollTop - optionsBacking.scrollTarget < 50) optionsBacking.scrollTarget = scrollTop - 50 - 10;

    optionsBacking.clampScroll();
  }
}
