package kade.hex.states;

import kade.hex.util.HexPurge;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSort;
import funkin.Assets;
import funkin.Paths;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.ui.MusicBeatState;
import kade.hex.menus.objects.gallery.GalleryImage;
import kade.hex.menus.objects.gallery.GalleryItem;
import kade.hex.menus.objects.gallery.GalleryMetaDot;
import kade.hex.objects.BetterAtlasText;
import kade.hex.objects.HexTransitional;
import kade.hex.util.HexTouch;
import openfl.filters.ShaderFilter;

/**
 * The gallery state for Hex.
 */
class HexGallery extends MusicBeatState
{
  var bg:FlxSprite;

  var swirly:FlxRuntimeShader;
  var swirlTime:Float = 0;

  var topBar:FlxSprite;
  var bottomBar:FlxSprite;

  var controlsText:FlxSprite;
  var controlsTwo:FlxSprite;
  var topCircle:FlxSprite;
  var bottomCircle:FlxSprite;

  var selectionSprite:FunkinSprite;

  var transition:HexTransitional;

  var blurShader:FlxRuntimeShader;

  var header1:GalleryItem;
  var header2:GalleryItem;

  var image:GalleryImage;

  var invertShader:FlxRuntimeShader;

  public var selectionIndex:Int = 0;
  public var metaIndex:Int = 0;
  public var pageIndex:Int = 0;

  var toppers:Array<String> = [
    "1. Go Miku, Go!", "2. The Week Duo", "3. Corruption, Oh No", "4. Losing Head", "5. TV Head Crew", "6. Corpo Party", "7. Laundromat", "8. Halloween",
    "9. Shoe Shopping", "10. Summer Boyz", "1. The First Drawing", "2. OG Sprites", "3. Glitcher Concepts", "4. Bonus Song 2", "5. The Server Room",
    "6. Company from Hell", "7. Remix Update", "8. New Interface", "9. Slasher's Origins", "10. Scrapped Material"
  ];

  var descriptions:Array<String> = [
    "The idea for Hex being a Hatsune Miku stan came to my mind after he got a cameo in Evdial's Miku Mod. I think he can relate to her since she has elements of both a human and a machine.",
    "There would be no Hex without Whitty! Whitty has definitely inspired me to look into FNF Modding myself, which lead to the creation of Hex.",
    "This was drawn before Full Week Update was even considered. I've been wondering how exactly a robot could get corrupted. Honestly, it doesn't have to make sense since it looks cool anyway.",
    "Before the development period of V3, Hex was featured in a lot of more surreal drawings of mine. This one, inspired by Basement Jaxx's \"Where's Your Head At\" has visuals that still hold up to this day.",
    "It was so fun to see people making their own FNF TV Head OCs. And it's even more fun to make them into friends! Robot power!",
    "Even a company like IRIS has corpo parties. Since Slasher is technically an employee he gets to participate as well. He certainly likes taking photos, much to Iris' indifference.",
    "A drawing showing the aftermath of Slasher's job well done. Funnily enough, it's also the first drawing where Slasher's regular shoes are shown, standing next to him.",
    "Spooky Month means a visit from Skid & Pump! Definitely one of Hex's favorite holidays since he gets to dress up and give away candy. This year he dressed up as Omega Flowey.",
    "Even for someone not usually wearing shoes, Hex can appreciate a pair of kicks once in a while. A shopping spree alongside BF and GF certainly means a fun time.",
    "Beach shenanigans commence! An entourage consisting of Hex, Whitty, Ruv, Agoti, Tabi, Garcello, Void and Zardy will surely do something soon that will result in Hex having to pay for the damages...",
    "The first ever drawing of Hex made on February 5th, 2021. He didn't even have a name back then. The idea for arrows to appear on his screen was made before I've even finished the first sketch.",
    "Originally the poses for Hex were much more wider horizontally. However, due to the limitations of Daddy Dearest's sprite sheet, I had to make them a bit more tight.",
    "At one point of the development, Hex was very different personality wise. He was a stubborn narcissist who insisted on the idea that robots are better than humans. Pretty different, huh?",
    "Before the idea to make another week came, \"Detected\" was supposed to be released as a bonus song, just like \"Encore.\"",
    "Before the plot with IRIS came, I've had no idea how to explain what exactly is \"The Virus\". There was an idea to make it some sort of powerful botnet, but I wasn't feeling it too much.",
    "IRIS is known for its shady practices, even by The Underworld's standard. Powered by sheer pettiness they've managed to regain their footing in the business world. Largely due to Iris himself.",
    "Right, The Remix Update. This idea never came to be because I didn't feel the need to remix already good existing songs, Glitcher was just an exception.",
    "Originally, the main menu was much more ethereal, taking inspiration from Persona 3 Reload. Eventually however, it became the more colorful, final version.",
    "Slasher was actually created before Funkin'. There are two canons, normally he's just a serial killer. But in FNF he's also a cyborg built from Hex's data.",
    "There are three songs that didn't make it to V3. The first one was \"Hoopmania\", which was a song with Hex and Metal Sonic. It was scrapped since FNF has too many Sonic songs at this point."
  ];

  var metaIndexDescriptions:Array<String> = [
    "The same fate also applied to the Freeplay Menu. Before the \"swirly\" aesthetic became consistent across all menus Freplay had a lot more TVs.",
    "A very obscure fact. On April Fools Day 2021, I've posted this image \"teasing\" a new mod featuring Slasher. I deleted it minutes later cuz' too many people actually believed it.",
    "Next is \"Jawdrop\", this is a song that carried over from VS. Coda Mod, I've never drew a Hex concept for it since it was scrapped early due to being too similar to \"Headbasher\"",
    "The second iteration of the Freeplay Menu. The TV on right much more resembles the final one. However besides that everything here was scrapped.",
    "Based on the fact that the voice samples used in Headbasher had a British accent to them, I've decided at random that Slasher should be British. Lol.",
    "Lastly, Aquamarine was gonna be a song featuring the \"FNF Minus\" variants of Hex, BF and GF. Ultimately tho, besides the gimmick there was nothing else going for this song, hence its removal.",
  ];

  var description:BetterAtlasText;

  var metaTopper:BetterAtlasText;

  var fullscreenBg:FlxSprite;

  var items:Array<GalleryItem> = [];
  var itemPos:Array<Array<Float>> = [
    [715, 141], [704, 190], [724, 236], [692, 272], [712, 341], [723, 379], [703, 438], [718, 489], [686, 532], [713, 595]
  ];

  var oItems:Array<GalleryItem> = [];
  var oItemPos:Array<Array<Float>> = [
    [713, 140], [706, 195], [723, 236], [692, 272], [711, 340], [722, 361], [702, 433], [717, 486], [686, 532], [713, 595]
  ];

  var metaDots:Array<GalleryMetaDot> = [];

  var camInfront:FlxCamera;
  var uberTop:FlxCamera;
  var isTweening:Bool = false;

  var lastItem:GalleryItem = null;

  var additions:Array<Float> = [0, 60, 90, 140, 190, 250, 290, 330, 390, 440];

  var lerpBlurTime:Float = 0;
  var lastLerpBlur:Float = 0;
  var lerpBlurTarget:Float = 0;
  var currentBlur:Float = 0;

  var hasPlayedIn:Bool = false;
  var inFullScreen:Bool = false;

  var isResetting:Bool = false;
  var zoomTarget:Float = 1.0;
  var scrollTargetX:Float = 0;
  var scrollTargetY:Float = 0;
  var scrollVelX:Float = 0;
  var scrollVelY:Float = 0;

  var isMiddleMousePanning:Bool = false;
  var middleMouseStartX:Float = 0;
  var middleMouseStartY:Float = 0;
  var middleMouseScrollStartX:Float = 0;
  var middleMouseScrollStartY:Float = 0;

  var shouldInvert:Bool = false;
  var invertIntensity:Float = 0;

  public function new()
  {
    super();
  }

  override public function create():Void
  {
    super.create();

    camInfront = new FlxCamera();
    uberTop = new FlxCamera();

    camInfront.bgColor = 0x00000000;
    uberTop.bgColor = 0x00000000;

    FlxG.cameras.add(camInfront, false);
    FlxG.cameras.add(uberTop, false);

    invertShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/better_invertColor")));

    bg = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/bg");
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    add(bg);

    var bgCover:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/bgCover");
    bgCover.updateHitbox();
    add(bgCover);

    swirly = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/swirl")));
    swirly.setFloat("uTime", 0);
    swirly.setFloat("uMix", 0.6);
    swirly.setFloatArray("uColor1", [0.588, 0.686, 0.286]);
    swirly.setFloatArray("uColor2", [0.27, 0.51, 0.26]);
    swirly.setFloat("uIntensity", 30.0);

    header1 = new GalleryItem(0, "header");
    header1.x = 710;
    header1.y = 110;
    header2 = new GalleryItem(1, "header");
    header2.x = 937;
    header2.y = 84;

    add(header1);
    add(header2);

    for (i in 0...10)
    {
      var it:GalleryItem = new GalleryItem(i, "drawings");
      items.push(it);
      it.x = itemPos[i][0];
      it.y = itemPos[i][1];
      add(it);

      var oIt:GalleryItem = new GalleryItem(i, "development");
      oItems.push(oIt);
      oIt.x = oItemPos[i][0];
      oIt.y = oItemPos[i][1];
      oIt.visible = false;
      add(oIt);
    }

    var borderInside:FunkinSprite = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/windowLeftNoBorder");
    add(borderInside);

    borderInside.shader = swirly;

    var borderLeft:FunkinSprite = FunkinSprite.create(375, 0, "ui/hex/hex_gallery/borderLeft");
    add(borderLeft);

    selectionSprite = FunkinSprite.create(0, 0, "ui/hex/hex_gallery/selector");
    add(selectionSprite);

    image = new GalleryImage();
    image.x = 45;
    image.y = 70;
    add(image);

    metaDots = [new GalleryMetaDot(), new GalleryMetaDot(), new GalleryMetaDot()];
    var mInd:Int = 0;
    for (metaDot in metaDots)
    {
      metaDot.x = 520 + mInd * (metaDot.width + 8);
      metaDot.y = FlxG.height - 90;
      add(metaDot);
      metaDot.visible = false;
      mInd++;
    }

    image.expandCallback = onExpand;

    var yingsNote:FunkinSprite = FunkinSprite.create(45, 70, "ui/hex/hex_gallery/yingsNote");
    add(yingsNote);

    description = new BetterAtlasText(Paths.image("ui/fonts/hex_meta"), Paths.xml("ui/fonts/hex_meta"), 0, 0, "");
    description.alignment = "LEFT";
    description.letterSpacing = 1;
    description.setCharOffset("g", 0, 3);
    description.setCharOffset("y", 0, 3);
    description.setCharOffset("p", 0, 5);
    description.setCharOffset("q", 0, 3);
    description.setCharOffset("j", 0, 3);
    description.setCharOffset("y", 0, 5);
    description.setCharOffset("f", 0, 3);
    description.setCharOffset("'", 1, -12);
    description.setCharOffset("\"", 1, -12);
    description.setCharOffset(",", 1, 3);
    description.setCharOffset("!", 2, 0);
    add(description);
    description.x = 45;

    description.wrapWidth = 480;

    fullscreenBg = new FlxSprite(0, 0);
    fullscreenBg.makeGraphic(FlxG.width, Std.int(FlxG.height / 1.25), 0xFF000000);
    fullscreenBg.alpha = 0;
    add(fullscreenBg);
    fullscreenBg.updateHitbox();
    fullscreenBg.y = FlxG.height / 2 - fullscreenBg.height / 2;
    topBar = new FlxSprite(0, 0);
    topBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(topBar);

    metaTopper = new BetterAtlasText(Paths.image("ui/fonts/hex_meta_white"), Paths.xml("ui/fonts/hex_meta_white"), 0, 0, "");
    metaTopper.alignment = "CENTER";
    metaTopper.letterSpacing = 0;
    metaTopper.setCharOffset("g", 0, 3);
    metaTopper.setCharOffset("y", 0, 3);
    metaTopper.setCharOffset("p", 0, 3);
    metaTopper.setCharOffset("q", 0, 3);
    metaTopper.setCharOffset("j", 0, 3);
    metaTopper.setCharOffset("y", 0, 3);
    add(metaTopper);

    metaTopper.y = 15;
    metaTopper.lineHeightOverride = 30;

    bottomBar = new FlxSprite(0, FlxG.height - 50);
    bottomBar.makeGraphic(FlxG.width, 50, 0xFF000000);
    add(bottomBar);

    topCircle = new FlxSprite();
    topCircle.loadGraphic(Paths.image("ui/hex/hex_gallery/circleTop"));
    add(topCircle);

    topCircle.x = 0;
    topCircle.y = 0;

    bottomCircle = new FlxSprite();
    bottomCircle.loadGraphic(Paths.image("ui/hex/hex_gallery/circleBottom"));
    add(bottomCircle);

    bottomCircle.x = FlxG.width - bottomCircle.width;
    bottomCircle.y = FlxG.height - bottomCircle.height;

    controlsText = new FlxSprite(15, FlxG.height - 40);
    controlsText.loadGraphic(Paths.image("ui/hex/hex_gallery/controlsTextUnselected"));
    add(controlsText);

    controlsTwo = new FlxSprite(15, FlxG.height - 38);
    controlsTwo.loadGraphic(Paths.image("ui/hex/hex_gallery/controlsTextSelected"));
    add(controlsTwo);
    controlsTwo.visible = false;

    var galleryWatermark:FunkinSprite = FunkinSprite.create(FlxG.width - 10, 10, "ui/hex/hex_gallery/menuIdentifier");
    galleryWatermark.x = FlxG.width - (galleryWatermark.width + 18);
    add(galleryWatermark);

    transition = new HexTransitional();
    add(transition);
    transition.forceIn();

    fullscreenBg.zIndex = 198;
    bottomBar.zIndex = 200;
    topBar.zIndex = 200;
    topCircle.zIndex = 200;
    bottomCircle.zIndex = 200;
    controlsText.zIndex = 200;
    transition.zIndex = 200;

    setPageIndex(0);
    setSelectionIndex(0);

    blurShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/real_gaus_blur")));
    blurShader.setFloat("uSize", 0);
    blurShader.setFloat("uDirections", 12);
    blurShader.setFloat("uQuality", 4);

    FlxG.camera.filters = [new ShaderFilter(blurShader)];

    yingsNote.x = image.x + 5;
    yingsNote.y = image.y + image.height + 10;

    description.x = yingsNote.x + 5;
    description.y = yingsNote.y + yingsNote.height - 5;

    controlsText.cameras = [uberTop];
    controlsTwo.cameras = [uberTop];
    topBar.cameras = [uberTop];
    bottomBar.cameras = [uberTop];
    topCircle.cameras = [uberTop];
    bottomCircle.cameras = [uberTop];
    fullscreenBg.cameras = [camInfront];
    metaTopper.cameras = [uberTop];
    transition.cameras = [uberTop];
    galleryWatermark.cameras = [uberTop];
  }

  function onExpand(full:FunkinSprite, back:Bool):Void
  {
    if (isTweening) return;

    if (back)
    {
      setBlurTarget(0);
      isTweening = true;
      controlsText.visible = true;
      controlsTwo.visible = false;

      scrollVelX = 0;
      scrollVelY = 0;
      zoomTarget = 1.0;
      scrollTargetX = 0;
      scrollTargetY = 0;
      isResetting = true;

      FlxTween.tween(fullscreenBg, {alpha: 0}, 0.5, {ease: FlxEase.circInOut});
      FlxTween.tween(full, {alpha: 0}, 0.5, {ease: FlxEase.circInOut}).onComplete = function(_)
      {
        remove(full);
        isTweening = false;
      };
    }
    else
    {
      setBlurTarget(8);
      add(full);
      full.zIndex = 199;
      isTweening = true;
      full.cameras = [camInfront];
      full.setGraphicSize(Std.int(FlxG.width / 1.25), Std.int(FlxG.height / 1.25));
      full.updateHitbox();
      full.x = FlxG.width / 2 - full.width / 2;
      full.y = FlxG.height / 2 - full.height / 2;
      full.alpha = 0;
      controlsText.visible = false;
      controlsTwo.visible = true;
      FlxTween.tween(full, {alpha: 1}, 0.5, {ease: FlxEase.circInOut});
      FlxTween.tween(fullscreenBg, {alpha: 0.8}, 0.5, {ease: FlxEase.circInOut}).onComplete = function(_)
      {
        isTweening = false;
      };
    }

    sort(byY, FlxSort.ASCENDING);
  }

  static function byY(order:Int, a:FlxBasic, b:FlxBasic):Int
  {
    return FlxSort.byY(order, cast a, cast b);
  }

  function setSelectionIndex(index:Int):Void
  {
    selectionIndex = index;

    if (selectionIndex < 0) selectionIndex = 9;
    if (selectionIndex > 9) selectionIndex = 0;

    if (lastItem != null)
    {
      lastItem.selectedItem.shader = null;
      lastItem.setSelected(false);
    }

    if (pageIndex == 0)
    {
      items[selectionIndex].setSelected(true);
      lastItem = items[selectionIndex];
    }
    else
    {
      oItems[selectionIndex].setSelected(true);
      lastItem = oItems[selectionIndex];
    }

    var e:Int = -1;
    if (pageIndex == 1 && selectionIndex >= 7)
    {
      var i:Int = 0;
      for (metaDot in metaDots)
      {
        metaDot.setSelected(i == metaIndex);
        metaDot.visible = true;
        i++;
      }
      e = metaIndex;
    }
    else
    {
      for (metaDot in metaDots) metaDot.visible = false;
      metaIndex = 0;
    }

    image.loadPair((pageIndex == 0 ? "drawings" : "development"), selectionIndex, e);
    metaTopper.text = toppers[selectionIndex + (pageIndex * 10)];
    metaTopper.x = FlxG.width / 2;
    metaTopper.y = metaTopper.height / 2 - 5;

    selectionSprite.x = lastItem.x - 90;
    selectionSprite.y = 150 + additions[selectionIndex];
    selectionSprite.offset.set(0, 0);

    lastItem.selectedItem.shader = invertShader;

    description.text = descriptions[selectionIndex + (pageIndex * 10)];
    if (pageIndex == 1 && selectionIndex >= 7 && metaIndex != 0)
    {
      // Meta index 0 is the regular description. Past that each meta index owns three entries,
      // one per item from 7 up.
      var metaDescriptionIndex:Int = (metaIndex - 1) * 3 + (selectionIndex - 7);
      description.text = metaIndexDescriptions[metaDescriptionIndex];
    }
  }

  function setPageIndex(index:Int):Void
  {
    pageIndex = index;
    var first:Bool = pageIndex == 0;
    header1.setSelected(first);
    header2.setSelected(!first);
    for (i in 0...10)
    {
      items[i].visible = first;
      oItems[i].visible = !first;
    }
  }

  function setBlurTarget(target:Float):Void
  {
    lastLerpBlur = currentBlur;
    currentBlur = target;
    lerpBlurTarget = target;
    lerpBlurTime = 0;
  }

  static inline function clamp(value:Float, min:Float, max:Float):Float
  {
    return Math.max(min, Math.min(max, value));
  }

  function goBack():Void
  {
    if (!hasPlayedIn || isResetting || isTweening) return;

    if (inFullScreen)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));
      image.expand(true);
      return;
    }

    transition.transitionIn();

    transition.onComplete = function(out:Bool)
    {
      var mm:HexMainMenu = new HexMainMenu();
      mm.skipTitle();
      mm.selectionIndex = 2;
      HexPurge.next();
      FlxG.switchState(function() return mm);
    };
  }

  override public function destroy():Void
  {
    HexTouch.clear();
    super.destroy();
  }

  override public function update(elapsed:Float):Void
  {
    HexTouch.update(this, goBack);
    HexTouch.controls(controlsText, "hex_gallery/controlsTextUnselected");
    HexTouch.controls(controlsTwo, "hex_gallery/controlsTextSelected");
    super.update(elapsed);

    if (shouldInvert)
    {
      invertIntensity = FlxMath.lerp(invertIntensity, 0, 0.09 * FlxG.elapsed * 60);

      if (invertIntensity < 0.01)
      {
        shouldInvert = false;
        invertIntensity = 0;
      }

      invertShader.setFloat("uIntensity", invertIntensity);
    }

    selectionSprite.offset.x = -10 + Math.sin(swirlTime * 6) * 8;

    lerpBlurTime += elapsed;
    var blurLerp:Float = FlxMath.lerp(lastLerpBlur, lerpBlurTarget, Math.min(lerpBlurTime / 0.5, 1));
    blurShader.setFloat("uSize", blurLerp);

    swirlTime += elapsed;
    swirly.setFloat("uTime", swirlTime * 0.2);

    if (!hasPlayedIn && swirlTime > 0.1)
    {
      hasPlayedIn = true;
      transition.transitionOut();
      setSelectionIndex(0);
    }

    if (inFullScreen)
    {
      var moveSpeed:Float = 1000 * elapsed;

      var dx:Float = 0.0;
      var dy:Float = 0.0;

      if (FlxG.keys.pressed.LEFT) dx -= moveSpeed;
      if (FlxG.keys.pressed.RIGHT) dx += moveSpeed;
      if (FlxG.keys.pressed.UP) dy -= moveSpeed;
      if (FlxG.keys.pressed.DOWN) dy += moveSpeed;

      scrollVelX += dx;
      scrollVelY += dy;

      var damp:Float = Math.pow(0.02, elapsed);
      scrollVelX *= damp;
      scrollVelY *= damp;

      if (!isResetting)
      {
        if (FlxG.mouse.justPressedMiddle)
        {
          isMiddleMousePanning = true;
          middleMouseStartX = FlxG.mouse.x;
          middleMouseStartY = FlxG.mouse.y;
          middleMouseScrollStartX = camInfront.scroll.x;
          middleMouseScrollStartY = camInfront.scroll.y;
        }

        if (FlxG.mouse.justReleasedMiddle) isMiddleMousePanning = false;

        var touchPanning:Bool = HexTouch.pressed && FlxG.touches.list.length == 1;
        if (touchPanning && HexTouch.touch.justPressed)
        {
          middleMouseScrollStartX = camInfront.scroll.x;
          middleMouseScrollStartY = camInfront.scroll.y;
        }

        zoomTarget += HexTouch.pinch() * 0.005;

        if (isMiddleMousePanning || touchPanning)
        {
          var dragX:Float = touchPanning ? HexTouch.dragX : FlxG.mouse.x - middleMouseStartX;
          var dragY:Float = touchPanning ? HexTouch.dragY : FlxG.mouse.y - middleMouseStartY;
          camInfront.scroll.x = middleMouseScrollStartX - dragX / camInfront.zoom;
          camInfront.scroll.y = middleMouseScrollStartY - dragY / camInfront.zoom;
          FlxG.camera.scroll.x = camInfront.scroll.x;
          FlxG.camera.scroll.y = camInfront.scroll.y;
          scrollVelX = 0;
          scrollVelY = 0;
        }
      }

      if (isResetting)
      {
        var lerpSpeed:Float = 1.0 - Math.pow(0.01, elapsed);
        camInfront.scroll.x += (scrollTargetX - camInfront.scroll.x) * lerpSpeed;
        camInfront.scroll.y += (scrollTargetY - camInfront.scroll.y) * lerpSpeed;
        FlxG.camera.scroll.x = camInfront.scroll.x;
        FlxG.camera.scroll.y = camInfront.scroll.y;

        if (Math.abs(camInfront.scroll.x) < 0.5 && Math.abs(camInfront.scroll.y) < 0.5 && Math.abs(camInfront.zoom - 1.0) < 0.01)
        {
          camInfront.scroll.set(0, 0);
          FlxG.camera.scroll.set(0, 0);
          isResetting = false;
          inFullScreen = false;
        }
      }
      else
      {
        camInfront.scroll.x += scrollVelX * elapsed;
        camInfront.scroll.y += scrollVelY * elapsed;
        FlxG.camera.scroll.x = camInfront.scroll.x;
        FlxG.camera.scroll.y = camInfront.scroll.y;
      }

      var wheel:Int = FlxG.mouse.wheel;
      if (wheel != 0) zoomTarget += 0.1 * wheel;
      if (FlxG.keys.pressed.Z) zoomTarget += 1.5 * elapsed;
      if (FlxG.keys.pressed.X) zoomTarget -= 1.5 * elapsed;
      zoomTarget = clamp(zoomTarget, 1.0, 3.0);

      if (FlxG.keys.justPressed.R)
      {
        zoomTarget = 1.0;
        scrollVelX = 0;
        scrollVelY = 0;
        camInfront.scroll.set(0, 0);
        FlxG.camera.scroll.set(0, 0);
      }

      var zoomLerp:Float = 1.0 - Math.pow(0.01, elapsed);
      camInfront.zoom += (zoomTarget - camInfront.zoom) * zoomLerp;
      FlxG.camera.zoom = camInfront.zoom;

      var maxX:Float = FlxG.width / 2 * (1 - 1 / camInfront.zoom);
      var maxY:Float = FlxG.height / 2 * (1 - 1 / camInfront.zoom);

      camInfront.scroll.x = clamp(camInfront.scroll.x, -maxX, maxX);
      camInfront.scroll.y = clamp(camInfront.scroll.y, -maxY, maxY);

      if (camInfront.scroll.x == -maxX || camInfront.scroll.x == maxX) scrollVelX = 0;
      if (camInfront.scroll.y == -maxY || camInfront.scroll.y == maxY) scrollVelY = 0;

      FlxG.camera.scroll.x = camInfront.scroll.x;
      FlxG.camera.scroll.y = camInfront.scroll.y;
    }

    if (FlxG.keys.justPressed.ESCAPE && !isResetting && !isTweening)
    {
      goBack();
      if (inFullScreen) return;
    }

    var tappedItem:Int = -1;
    var tappedExpand:Bool = false;
    var tappedPage:Int = -1;
    var tappedMeta:Int = -1;

    if (hasPlayedIn && !inFullScreen && !isResetting && !isTweening && HexTouch.tapped())
    {
      var pageItems:Array<GalleryItem> = pageIndex == 0 ? items : oItems;
      for (i in 0...pageItems.length)
      {
        if (HexTouch.overlaps(pageItems[i])) tappedItem = i;
      }

      for (i in 0...metaDots.length)
      {
        if (metaDots[i].visible && HexTouch.overlaps(metaDots[i])) tappedMeta = i;
      }

      if (HexTouch.overlaps(header1)) tappedPage = 0;
      else if (HexTouch.overlaps(header2)) tappedPage = 1;

      tappedExpand = tappedItem == selectionIndex || (tappedItem == -1 && tappedMeta == -1 && tappedPage == -1 && HexTouch.overlaps(image));
    }

    if ((FlxG.keys.justPressed.ENTER || tappedExpand) && !isResetting && !inFullScreen && !isTweening)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_click"));

      if (image.full != null)
      {
        inFullScreen = true;
        shouldInvert = true;
        invertIntensity = 1.0;
        image.expand(false);
      }
    }

    if (inFullScreen || isResetting || isTweening) return;

    if (tappedMeta != -1 && tappedMeta != metaIndex)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      metaIndex = tappedMeta;
      setSelectionIndex(selectionIndex);
    }
    else if (tappedPage != -1 && tappedPage != pageIndex)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setPageIndex(tappedPage);
      setSelectionIndex(selectionIndex);
    }
    else if (tappedItem != -1 && tappedItem != selectionIndex)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setSelectionIndex(tappedItem);
    }

    if (FlxG.keys.justPressed.UP)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setSelectionIndex(selectionIndex - 1);
    }
    else if (FlxG.keys.justPressed.DOWN)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      setSelectionIndex(selectionIndex + 1);
    }
    else if (FlxG.keys.justPressed.LEFT || HexTouch.justSwipedRight)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      if (selectionIndex >= 7 && pageIndex == 1)
      {
        metaIndex--;
        if (metaIndex < 0) metaIndex = 2;
        setSelectionIndex(selectionIndex);
        return;
      }
      pageIndex--;
      if (pageIndex < 0) pageIndex = 1;
      setPageIndex(pageIndex);
      setSelectionIndex(selectionIndex);
    }
    else if (FlxG.keys.justPressed.RIGHT || HexTouch.justSwipedLeft)
    {
      FunkinSound.playOnce(Paths.sound("ui/hex/sounds/title_select"));
      if (selectionIndex >= 7 && pageIndex == 1)
      {
        metaIndex++;
        if (metaIndex > 2) metaIndex = 0;
        setSelectionIndex(selectionIndex);
        return;
      }
      pageIndex++;
      if (pageIndex > 1) pageIndex = 0;
      setPageIndex(pageIndex);
      setSelectionIndex(selectionIndex);
    }
  }
}
