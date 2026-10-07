package kade.hex.objects;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import funkin.group.FunkinGroup;
import kade.hex.menus.Anim;

class BetterAtlasText extends FunkinGroup<FlxSprite>
{
  public var letterSpacing(default, set):Float = 3.0;
  public var lineSpacing(default, set):Float = 4.0;
  public var textScale(default, set):Float = 1.0;
  public var wrapWidth(default, set):Float = 0;

  public var animFps:Int = 24;
  public var alignment(default, set):String = "LEFT";
  public var lineHeightOverride(default, set):Float = -1;

  public var text(default, set):String = "";

  var _imagePath:String;
  var _xmlPath:String;

  function set_text(v:String):String
  {
    if (text != v) _dirty = true;
    text = v;
    return v;
  }

  function set_textScale(v:Float):Float
  {
    if (textScale != v) _dirty = true;
    textScale = v;
    return v;
  }

  function set_letterSpacing(v:Float):Float
  {
    if (letterSpacing != v) _dirty = true;
    letterSpacing = v;
    return v;
  }

  function set_lineSpacing(v:Float):Float
  {
    if (lineSpacing != v) _dirty = true;
    lineSpacing = v;
    return v;
  }

  function set_wrapWidth(v:Float):Float
  {
    if (wrapWidth != v) _dirty = true;
    wrapWidth = v;
    return v;
  }

  function set_alignment(v:String):String
  {
    if (alignment != v) _dirty = true;
    alignment = v;
    return v;
  }

  function set_lineHeightOverride(v:Float):Float
  {
    if (lineHeightOverride != v) _dirty = true;
    lineHeightOverride = v;
    return v;
  }

  var _glyphIndex:Map<String, Int> = new Map();
  var _glyphFrameLists:Array<Array<String>> = [];
  var _glyphWidths:Array<Float> = [];
  var _glyphHeights:Array<Float> = [];

  var _fontHeight:Float = 0;
  var _spaceW:Float = 12.0;

  var _offsets:Map<String, FlxPoint> = new Map();
  var _atlas:FlxAtlasFrames;

  var _dirty:Bool = false;

  static var _zeroOffset:FlxPoint = null;

  public function new(imagePath:String, xmlPath:String, x:Float = 0, y:Float = 0, initial:String = "")
  {
    super(x, y);

    _imagePath = imagePath;
    _xmlPath = xmlPath;

    _atlas = FlxAtlasFrames.fromSparrow(imagePath, xmlPath);
    if (_atlas == null)
    {
      trace("Failed to load atlas frames for BetterAtlasText: " + imagePath + ", " + xmlPath);
      return;
    }

    _buildGlyphMap();

    text = initial;
  }

  override public function draw():Void
  {
    if (_dirty)
    {
      _rebuild();
      _dirty = false;
    }
    super.draw();
  }

  override public function destroy():Void
  {
    for (p in _offsets) p.put();
    _offsets = new Map();
    super.destroy();
  }

  function _buildGlyphMap():Void
  {
    _glyphIndex = new Map();
    _glyphFrameLists = [];
    _glyphWidths = [];
    _glyphHeights = [];
    _fontHeight = 0;

    for (frame in _atlas.frames)
    {
      var rawName:String = frame.name;
      var baseName:String = _stripFrameIndex(rawName);
      var glyphKey:String = _longNameToChar(baseName);

      if (!_glyphIndex.exists(glyphKey))
      {
        _glyphIndex.set(glyphKey, _glyphFrameLists.length);
        _glyphFrameLists.push([rawName]);
        _glyphWidths.push(frame.sourceSize.x);
        _glyphHeights.push(frame.sourceSize.y);
      }
      else
      {
        var idx:Int = _glyphIndex.get(glyphKey);
        _glyphFrameLists[idx].push(rawName);
        if (frame.sourceSize.x > _glyphWidths[idx]) _glyphWidths[idx] = frame.sourceSize.x;
        if (frame.sourceSize.y > _glyphHeights[idx]) _glyphHeights[idx] = frame.sourceSize.y;
      }
    }

    for (h in _glyphHeights)
    {
      if (h > _fontHeight) _fontHeight = h;
    }

    for (frameList in _glyphFrameLists)
    {
      frameList.sort(_compareFrameNames);
    }

    var space:Int = _glyphIndexOf("A");
    if (space == -1) space = _glyphIndexOf("a");
    _spaceW = space != -1 ? _glyphWidths[space] * 0.5 : 12.0;
  }

  static function _compareFrameNames(a:String, b:String):Int
  {
    var na:Int = _trailingNumber(a);
    var nb:Int = _trailingNumber(b);
    if (na != -1 && nb != -1 && na != nb) return na - nb;
    return a < b ? -1 : a > b ? 1 : 0;
  }

  static function _trailingNumber(name:String):Int
  {
    if (StringTools.endsWith(name, ".png")) name = name.substr(0, name.length - 4);

    var end:Int = name.length;
    var start:Int = end;
    while (start > 0)
    {
      var c:Int = name.charCodeAt(start - 1);
      if (c >= "0".code && c <= "9".code) start--;
      else break;
    }
    if (start == end) return -1;
    return Std.parseInt(name.substr(start));
  }

  static function _stripFrameIndex(name:String):String
  {
    var n:String = StringTools.endsWith(name, ".png") ? name.substr(0, name.length - 4) : name;
    var start:Int = n.length;
    while (start > 1)
    {
      var c:Int = n.charCodeAt(start - 1);
      if (c >= "0".code && c <= "9".code) start--;
      else break;
    }
    return n.substr(0, start);
  }

  static function _longNameToChar(name:String):String
  {
    if (StringTools.endsWith(name, ".png")) name = name.substr(0, name.length - 4);

    if (StringTools.endsWith(name, " capital")) return name.charAt(0).toUpperCase();
    if (StringTools.endsWith(name, " lowercase")) return name.charAt(0).toLowerCase();

    // Spelled out names come both bare and wrapped in dashes ("-period-").
    var bare:String = name;
    if (bare.length > 2 && StringTools.startsWith(bare, "-") && StringTools.endsWith(bare, "-")) bare = bare.substr(1, bare.length - 2);

    switch (bare)
    {
      case "ampersand": return "&";
      case "left parenthesis": return "(";
      case "right parenthesis": return ")";
      case "left bracket": return "[";
      case "right bracket": return "]";
      case "colon": return ":";
      case "semicolon": return ";";
      case "exclamation point": return "!";
      case "question mark": return "?";
      case "apostraphie", "apostrophe": return "'";
      case "percent": return "%";
      case "plus": return "+";
      case "equals": return "=";
      case "hashtag", "number sign": return "#";
      case "at sign": return "@";
      case "asterisk": return "*";
      case "underscore": return "_";
    }

    return switch (name)
    {
      case "-comma-": ",";
      case "-period-": ".";
      case "-exclamation point-": "!";
      case "-question mark-": "?";
      case "-dash-": "-";
      case "-apostraphie-": "'";
      case "-quote-": "\"";
      case "-back slash-": "\\";
      case "-forward slash-": "/";
      case "comma": ",";
      case "period": ".";
      case "exclamation": "!";
      case "question": "?";
      case "dash": "-";
      case "apostrophe": "'";
      case "quote": "\"";
      case "backslash": "\\";
      case "forwardslash": "/";
      case "space": " ";
      case "ampersand": "&";
      case "left parenthesis": "(";
      case "right parenthesis": ")";
      case "left bracket": "[";
      case "right bracket": "]";
      case "left brace": "{";
      case "right brace": "}";
      case "semicolon": ";";
      case "colon": ":";
      case "equals": "=";
      case "plus": "+";
      case "minus": "-";
      case "asterisk": "*";
      case "slash": "/";
      case "percent": "%";
      case "at": "@";
      case "hash": "#";
      case "dollar": "$";
      case "caret": "^";
      case "underscore": "_";
      case "tilde": "~";
      case "backtick": "`";
      case "pipe": "|";
      default: name;
    };
  }

  public function getTextWidth():Float
  {
    var w:Float = 0;
    for (line in _wrapLines(text.split("\n")))
    {
      w = Math.max(w, _measureLine(line));
    }
    return w * scale.x;
  }

  public function getLineHeight():Float
  {
    var h:Float = lineHeightOverride >= 0 ? lineHeightOverride : _fontHeight * textScale;
    return h * scale.y;
  }

  public function setCharOffset(ch:String, x:Float, y:Float):Void
  {
    var p:FlxPoint = _offsets.get(ch);
    if (p == null) _offsets.set(ch, FlxPoint.get(x, y));
    else p.set(x, y);
    _dirty = true;
  }

  public function clearCharOffset(ch:String):Void
  {
    var p:FlxPoint = _offsets.get(ch);
    if (p == null) return;
    _offsets.remove(ch);
    p.put();
    _dirty = true;
  }

  public function clearAllCharOffsets():Void
  {
    for (p in _offsets) p.put();
    _offsets = new Map();
    _dirty = true;
  }

  function _getCharOffset(ch:String):FlxPoint
  {
    var p:FlxPoint = _offsets.get(ch);
    if (p != null) return p;

    if (_zeroOffset == null) _zeroOffset = FlxPoint.get(0, 0);
    return _zeroOffset;
  }

  function _glyphIndexOf(ch:String):Int
  {
    var idx:Null<Int> = _glyphIndex.get(ch);
    if (idx == null) idx = _glyphIndex.get(ch.toUpperCase());
    if (idx == null) idx = _glyphIndex.get(ch.toLowerCase());
    return idx == null ? -1 : idx;
  }

  function _wrapLines(lines:Array<String>):Array<String>
  {
    if (wrapWidth <= 0) return lines;

    var result:Array<String> = [];
    var spaceW:Float = _spaceWidth();

    for (line in lines)
    {
      var words:Array<String> = line.split(" ");
      var curLine:String = "";
      var curLineW:Float = 0;

      for (wi in 0...words.length)
      {
        var word:String = words[wi];
        var wordW:Float = _measureLine(word);

        if (curLine.length == 0)
        {
          curLine = word;
          curLineW = wordW;
        }
        else
        {
          var needed:Float = curLineW + spaceW + wordW;
          if (needed > wrapWidth)
          {
            result.push(curLine);
            curLine = word;
            curLineW = wordW;
          }
          else
          {
            curLine += " " + word;
            curLineW = needed;
          }
        }
      }

      if (curLine.length > 0) result.push(curLine);
    }

    return result;
  }

  function _rebuild():Void
  {
    for (child in children) child.destroy();
    children = [];

    if (text == null || text.length == 0) return;
    
    // Fetched again rather than reusing _atlas: clearing the old glyphs can leave the font image
    // unused for a moment, and flixel frees it, so a held atlas would point at a freed image.
    var frames:FlxAtlasFrames = FlxAtlasFrames.fromSparrow(_imagePath, _xmlPath);
    if (frames == null) return;

    var lines:Array<String> = _wrapLines(text.split("\n"));

    var lineWidths:Array<Float> = [];
    for (line in lines) lineWidths.push(_measureLine(line));

    var globalLineH:Float = lineHeightOverride >= 0 ? lineHeightOverride : _fontHeight * textScale;
    var spaceW:Float = _spaceWidth();

    var cursorY:Float = 0;

    for (lineIdx in 0...lines.length)
    {
      var line:String = lines[lineIdx];
      var cursorX:Float = _startX(lineWidths[lineIdx]);

      for (i in 0...line.length)
      {
        var ch:String = line.charAt(i);

        var idx:Int = ch == " " ? -1 : _glyphIndexOf(ch);
        if (idx == -1)
        {
          cursorX += spaceW;
          continue;
        }

        var sprite:FlxSprite = _makeGlyphSprite(idx, frames);

        var glyphW:Float = _glyphWidths[idx] * textScale;
        var glyphH:Float = _glyphHeights[idx] * textScale;

        var offset:FlxPoint = _getCharOffset(ch);
        sprite.localX = cursorX + offset.x * textScale;
        sprite.localY = cursorY + (globalLineH - glyphH) + offset.y * textScale;

        cursorX += glyphW + letterSpacing;

        children.push(sprite);
      }

      cursorY += globalLineH + lineSpacing;
    }

    updateChildren();
  }

  function _measureLine(line:String):Float
  {
    var cursorX:Float = 0;
    var lastGlyphRight:Float = 0;
    var spaceW:Float = _spaceWidth();
    for (i in 0...line.length)
    {
      var ch:String = line.charAt(i);
      var idx:Int = ch == " " ? -1 : _glyphIndexOf(ch);
      if (idx == -1)
      {
        cursorX += spaceW;
        continue;
      }
      lastGlyphRight = cursorX + _glyphWidths[idx] * textScale;
      cursorX = lastGlyphRight + letterSpacing;
    }
    return lastGlyphRight;
  }

  inline function _startX(lineWidth:Float):Float
  {
    return switch (alignment)
    {
      case "CENTER": -lineWidth / 2;
      case "RIGHT": -lineWidth;
      default: 0;
    };
  }

  inline function _spaceWidth():Float
  {
    return _spaceW * textScale;
  }

  function _makeGlyphSprite(idx:Int, frames:FlxAtlasFrames):FlxSprite
  {
    var frameNames:Array<String> = _glyphFrameLists[idx];

    var sprite:FlxSprite = new FlxSprite();
    sprite.frames = frames;

    Anim.addByNames(sprite, "idle", frameNames, animFps, true);
    // Force frame 0 so every glyph animates in step.
    Anim.play(sprite, "idle", true, false, 0);

    sprite.origin.set(0, 0);
    sprite.offset.set(0, 0);
    sprite.localScale.set(textScale, textScale);

    return sprite;
  }
}
