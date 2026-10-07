package kade.hex.songs;

import flixel.FlxG;
import flixel.addons.display.FlxRuntimeShader;
import flixel.graphics.frames.FlxFrame;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;
import funkin.Assets;
import funkin.Conductor;
import funkin.Paths;
import funkin.PlayerSettings;
import funkin.graphics.FunkinSprite;
import funkin.modding.module.Module;
import funkin.modding.module.ModuleHandler;
import funkin.play.PlayState;
import funkin.play.character.BaseCharacter;
import funkin.play.character.BaseCharacter.CharacterType;
import funkin.modding.events.ScriptEvent;
import funkin.modding.events.ScriptEvent.NoteScriptEvent;
import funkin.modding.events.ScriptEvent.SongLoadScriptEvent;
import funkin.modding.events.ScriptEvent.SongRetryEvent;
import funkin.modding.events.ScriptEvent.SongTimeScriptEvent;
import funkin.modding.events.ScriptEvent.UpdateScriptEvent;
import funkin.play.song.Song;
import funkin.play.stage.Stage;
import funkin.play.stage.StageProp;
import kade.hex.util.HexTouch;

class Eye2EyeSong extends Song {
    var barPollCooldown:Float = 0;

    static inline var GRID:Int = 3;
    static inline var SPACING:Float = 0.85;

    static inline var STRIP_SPEED:Float = 38;
    static inline var STRIP_REPEAT:Float = 720;

    static inline var STRIP_PATH:String = "gameplay/stages/iris_void/Eye2Eye_BG_1";
    static inline var LID_PATH:String = "gameplay/stages/iris_void/iris-detached/Iris_Eyelid";
    static inline var IRIS_PATH:String = "gameplay/stages/iris_void/iris-detached/Iris_Iris";

    static inline var IRIS_REST_X:Float = 576;
    static inline var IRIS_REST_Y:Float = 317;

    static inline var IRIS_ROOM:Float = 45;

    static final OUTLINE:Array<Float> = [
        254, 247, 233, 215, 200, 188, 175, 165, 158, 150, 145, 142, 140, 138, 135, 133, 133, 134,
        133, 135, 137, 139, 142, 144, 148, 154, 160, 167, 175, 182, 189, 200, 214, 226, 238, 244,
        231, 218, 205, 195, 183, 176, 169, 163, 159, 156, 154, 152, 149, 146, 145, 146, 146, 146,
        146, 148, 150, 152, 155, 158, 162, 165, 169, 173, 179, 186, 195, 202, 211, 222, 232, 241
    ];

    var strips:FunkinSprite = null;
    var stripShader:FlxRuntimeShader = null;
    var lids:Array<FunkinSprite> = [];
    var irises:Array<FunkinSprite> = [];
    var bodies:Array<FunkinSprite> = [];

    // the frames of each eye's idle, picked by prefix once, so a frame is set without the animation controller
    var lidFrames:Array<Array<FlxFrame>> = [];
    var irisFrames:Array<Array<FlxFrame>> = [];

    var eyesShown:Bool = false;

    var text1:StageProp = null;
    var text2:StageProp = null;

    var close:StageProp = null;
    var your:StageProp = null;
    var eyes:StageProp = null;

    var skip:FlxText = null;

    var realHealth:Float = 2;
    var eventIndex:Int = 0;

    public var additionalGlitch:Float = 0;

    var lastBeat:Float = -1;

    var skipped:Bool = false;

    var skipQueued:Bool = false;

    var hud:Module = null;
    var sceneModule:Module = null;

    public function new(?id:String) {
        super("eye2eye");
    }

    public override function onSongLoaded(event:SongLoadScriptEvent):Void {
        loadModchart();

        hud = ModuleHandler.getModule("HEX-HUD");
        sceneModule = null;

        super.onSongLoaded(event);

        var state = PlayState.instance;
        lastBeat = -1;
        skipped = false;
        skipQueued = false;

        FlxG.camera.filters = null;
        state.camHUD.filters = null;

        realHealth = 2;
        state.health = realHealth;

        var hexOg:BaseCharacter = state.currentStage.getDad();

        hexOg.visible = false;

        if (skip != null) skip.destroy();

        skip = new FlxText(0, FlxG.height - 20, FlxG.width, HexTouch.mobile ? "Press RIGHT to skip intro" : "Press BACKSPACE to skip intro");
        skip.zIndex = 1000;
        skip.setFormat(Paths.font("vcr.ttf"), 16, 0xFFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
        state.add(skip);

        // On the stage camera with the rest, pinned to the screen.
        skip.visible = true;
        skip.scrollFactor.set(0, 0);
        skip.cameras = [state.camGame];

        // popup position
        var popup = state.comboPopUps;

        @:privateAccess popup.offsets[0] = 60;
        @:privateAccess popup.offsets[1] = -150;

        // hide health bar
        state.healthBar.alpha = 0;
        state.iconP2.alpha = 0;
        state.iconP1.alpha = 0;

        // disable bopping
        state.cameraBopIntensity = 1;
        state.hudCameraZoomIntensity = 0;

        text1 = state.currentStage.getNamedProp("text1");
        text1.x = -75;
        text1.y = -75;

        text2 = state.currentStage.getNamedProp("text2");
        text2.x = -75;
        text2.y = -75;

        text1.visible = false;
        text2.visible = false;

        close = state.currentStage.getNamedProp("text3");

        close.x = (FlxG.width / 2) - (close.width / 2);
        close.y += 75;

        your = state.currentStage.getNamedProp("text4");

        your.x = (FlxG.width / 2) - (your.width / 2);
        your.y += 75;

        eyes = state.currentStage.getNamedProp("text5");

        eyes.x = (FlxG.width / 2) - (eyes.width / 2);
        eyes.y += 75;

        close.scrollFactor.set(0, 0);
        your.scrollFactor.set(0, 0);
        eyes.scrollFactor.set(0, 0);
        text1.scrollFactor.set(0, 0);
        text2.scrollFactor.set(0, 0);

        close.visible = false;
        your.visible = false;
        eyes.visible = false;

        makeEyes();
        showEyes(false);
    }

    public override function onNoteMiss(event:NoteScriptEvent):Void {
        var kind:Null<String> = event.note.noteData.kind;
        if (kind == "mine") {
            event.cancel();
            return;
        }
        realHealth -= 0.035;

        super.onNoteMiss(event);
    }

    public override function onSongRetry(event:SongRetryEvent):Void {
        super.onSongRetry(event);

        var state = PlayState.instance;

        eventIndex = 0;
        lastBeat = -1;
        skipped = false;
        skipQueued = false;

        var hexOg:BaseCharacter = state.currentStage.getDad(true);
        var bfOg:BaseCharacter = state.currentStage.getBoyfriend(true);
        var gf:BaseCharacter = state.currentStage.getGirlfriend(true);

        state.currentStage.addCharacter(gf, CharacterType.GF);
        state.currentStage.addCharacter(hexOg, CharacterType.DAD);
        state.currentStage.addCharacter(bfOg, CharacterType.BF);

        // disable bopping
        state.cameraBopIntensity = 1;
        state.hudCameraZoomIntensity = 0;

        // flash red
        FlxG.camera.flash(0xFFFF0000, 1);

        hexOg.visible = false;

        showEyes(false);

        skip.visible = true;
        realHealth = 2;
        state.health = realHealth;

        loadModchart();
    }

    function scene():Module {
        if (sceneModule == null) sceneModule = ModuleHandler.getModule("eye2eye_scene");
        return sceneModule;
    }

    function sceneGlitch():Float {
        var s = scene();
        if (s == null) return 0;

        var v:Dynamic = s.scriptGet("glitch");
        return v == null ? 0 : v;
    }

    // every frame of the sheet whose name starts with the prefix, in name order, as addByPrefix would pick them
    static function framesByPrefix(sprite:FunkinSprite, prefix:String):Array<FlxFrame> {
        var out:Array<FlxFrame> = [];
        if (sprite.frames == null) return out;

        for (f in sprite.frames.frames) {
            if (f.name != null && f.name.indexOf(prefix) == 0) out.push(f);
        }

        out.sort(function(a:FlxFrame, b:FlxFrame):Int {
            return a.name < b.name ? -1 : (a.name > b.name ? 1 : 0);
        });
        return out;
    }

    function makeEyes():Void {
        var state = PlayState.instance;
        var stage:Stage = state.currentStage;
        var dad:BaseCharacter = stage.getDad();

        dropEyes();

        var fullW:Float = FlxG.width / stage.camZoom;
        var fullH:Float = FlxG.height / stage.camZoom;
        var tileW:Float = fullW * SPACING;
        var tileH:Float = fullH * SPACING;
        var midX:Float = dad.cameraFocusPoint.x;
        var midY:Float = dad.cameraFocusPoint.y;

        stripShader = new FlxRuntimeShader(Assets.getText(Paths.frag("ui/shaders/eye_strips")));
        stripShader.setFloat("uTilesX", GRID);
        stripShader.setFloat("uTilesY", GRID);
        stripShader.setFloat("uTileW", fullW);
        stripShader.setFloat("uTileH", fullH);
        stripShader.setFloat("uScroll", 0);

        strips = new FunkinSprite(0, 0);
        strips.loadTexture(STRIP_PATH);
        strips.antialiasing = true;
        strips.shader = stripShader;
        strips.zIndex = 10;
        stage.add(strips);

        strips.scale.set(GRID * tileW / strips.frameWidth, GRID * tileH / strips.frameHeight);
        strips.updateHitbox();
        strips.x = midX - tileW * GRID / 2;
        strips.y = midY - tileH * GRID / 2;

        var fromX:Float = dad.x - dad.offset.x;
        var fromY:Float = dad.y - dad.offset.y;

        for (row in -1...2) {
            for (col in -1...2) {
                if (row == 0 && col == 0) continue;

                var lid:FunkinSprite = FunkinSprite.createSparrow(0, 0, LID_PATH);
                var lidIdle:Array<FlxFrame> = framesByPrefix(lid, "IRIS_Eyelid");
                if (lidIdle.length > 0) lid.frame = lidIdle[0];
                lid.antialiasing = true;
                lid.zIndex = 24;
                stage.add(lid);
                lid.x = fromX + col * tileW;
                lid.y = fromY + row * tileH;

                var iris:FunkinSprite = FunkinSprite.createSparrow(0, 0, IRIS_PATH);
                var irisIdle:Array<FlxFrame> = framesByPrefix(iris, "IRIS_Iris");
                if (irisIdle.length > 0) iris.frame = irisIdle[0];
                iris.antialiasing = true;
                iris.zIndex = 25;
                stage.add(iris);

                var body:FunkinSprite = new FunkinSprite(0, 0);
                body.frames = dad.frames;
                body.antialiasing = true;
                body.zIndex = 23;
                body.alpha = 0;
                body.visible = false;
                stage.add(body);

                lids.push(lid);
                irises.push(iris);
                bodies.push(body);
                lidFrames.push(lidIdle);
                irisFrames.push(irisIdle);
            }
        }

        stage.refresh();
        placeEyes();
    }

    function dropEyes():Void {
        var stage:Stage = PlayState.instance.currentStage;
        var all:Array<FunkinSprite> = [strips].concat(lids).concat(irises).concat(bodies);

        for (s in all) {
            if (s == null) continue;
            if (stage.members.indexOf(s) >= 0) {
                stage.remove(s, true);
                s.destroy();
            }
        }

        strips = null;
        stripShader = null;
        lids = [];
        irises = [];
        bodies = [];
        lidFrames = [];
        irisFrames = [];
    }

    function showEyes(on:Bool):Void {
        eyesShown = on;

        if (strips != null) strips.visible = on;
        for (lid in lids) lid.visible = on;
        for (iris in irises) iris.visible = on;
        for (body in bodies) body.visible = false;
    }

    function placeEyes():Void {
        if (lids.length == 0) return;

        var s = scene();
        var angles:Array<Dynamic> = s == null ? null : s.scriptGet("eyeAngle");
        var reaches:Array<Dynamic> = s == null ? null : s.scriptGet("eyeReach");
        var becomes:Array<Dynamic> = s == null ? null : s.scriptGet("eyeBecome");

        var dad:BaseCharacter = PlayState.instance.currentStage.getDad();

        var frame:Int = Math.floor(Conductor.instance.songPosition * 0.024) % 24;
        if (frame < 0) frame += 24;

        for (i in 0...lids.length) {
            var much:Float = becomes == null ? 0 : becomes[i];
            if (much < 0) much = 0;
            if (much > 1) much = 1;

            var lidIdle:Array<FlxFrame> = lidFrames[i];
            if (lidIdle.length > 0) lids[i].frame = lidIdle[frame % lidIdle.length];
            var irisIdle:Array<FlxFrame> = irisFrames[i];
            if (irisIdle.length > 0) irises[i].frame = irisIdle[frame % irisIdle.length];

            lids[i].alpha = 1 - much;
            irises[i].alpha = 1 - much;
            lids[i].visible = eyesShown && much < 1;
            irises[i].visible = eyesShown && much < 1;

            var angle:Float = angles == null ? 0 : angles[i];
            var reach:Float = reaches == null ? 0 : reaches[i];
            placeIris(i, angle, reach * (1 - much));

            wearDad(i, dad, much);
        }
    }

    function wearDad(i:Int, dad:BaseCharacter, much:Float):Void {
        var body:FunkinSprite = bodies[i];
        if (body == null || dad == null) return;

        body.visible = eyesShown && much > 0;
        body.alpha = much;

        if (!body.visible) return;

        if (dad.frame != null) body.frame = dad.frame;

        body.origin.set(dad.origin.x, dad.origin.y);
        body.offset.set(dad.offset.x, dad.offset.y);
        body.scale.set(dad.scale.x, dad.scale.y);
        body.flipX = dad.flipX;
        body.flipY = dad.flipY;
        body.color = dad.color;

        body.x = lids[i].x + dad.offset.x;
        body.y = lids[i].y + dad.offset.y;
    }

    function placeIris(i:Int, angle:Float, reach:Float):Void {
        if (reach < 0) {
            reach = -reach;
            angle += 180;
        }
        if (reach > 100) reach = 100;

        var room:Float = outlineAt(angle) - IRIS_ROOM;
        if (room < 0) room = 0;

        var far:Float = room * reach / 100;
        var turn:Float = angle * Math.PI / 180;

        irises[i].x = lids[i].x + IRIS_REST_X + Math.cos(turn) * far;
        irises[i].y = lids[i].y + IRIS_REST_Y + Math.sin(turn) * far;
    }

    function outlineAt(angle:Float):Float {
        var a:Float = angle % 360;
        if (a < 0) a += 360;

        var at:Float = a / 5;
        var i:Int = Math.floor(at);
        var lo:Float = OUTLINE[i % 72];
        var hi:Float = OUTLINE[(i + 1) % 72];

        return lo + (hi - lo) * (at - i);
    }

    function loadModchart():Void {
        var modchart:Dynamic = ModuleHandler.getModule("eye2eye_modchart");
        if (modchart == null) return;

        modchart.load(PlayState.instance.currentDifficulty);
    }

    public override function onSongStart(event:ScriptEvent):Void {
        super.onSongStart(event);
        PlayState.instance.hudCameraZoomIntensity = 0;
    }

    function showIntro(currentBeat:Float):Void {
        var hexOg:BaseCharacter = PlayState.instance.currentStage.getDad();

        var past:Bool = currentBeat >= 32;
        if (past && lastBeat >= 0 && lastBeat < 32) {
            // flash red
            FlxG.camera.flash(0xFFFF0000, 0.75);
        }
        lastBeat = currentBeat;

        hexOg.visible = past;

        showEyes(past);

        if (past) {
            close.visible = false;
            your.visible = false;
            eyes.visible = false;

            text1.visible = false;
            text2.visible = false;
            skip.visible = false;
            return;
        }

        // slowly fade in text1 (beat 0-14), then out (beat 14-17)
        var a1:Float = 0;
        if (currentBeat >= 0 && currentBeat < 14) a1 = currentBeat / 14;
        else if (currentBeat >= 14 && currentBeat < 17) a1 = 1 - (currentBeat - 14) / 3;
        if (a1 > 1) a1 = 1;
        if (a1 < 0) a1 = 0;
        text1.visible = currentBeat >= 0 && currentBeat < 18;
        text1.alpha = a1;

        // slowly fade in text2 (beat 18-28)
        var a2:Float = 0;
        if (currentBeat >= 18 && currentBeat < 28) a2 = (currentBeat - 18) / 10;
        if (a2 > 1) a2 = 1;
        text2.visible = currentBeat >= 18 && currentBeat < 28;
        text2.alpha = a2;

        close.visible = currentBeat >= 28 && currentBeat < 29;
        your.visible = currentBeat >= 29 && currentBeat < 30;
        eyes.visible = currentBeat >= 30 && currentBeat < 32;
        eyes.alpha = 1;

        skip.visible = !skipped && currentBeat < 28;
    }

    function jumpPastIntro(state:PlayState):Void {
        FlxG.sound.music.time = 9000; // 9s

        var reach:Dynamic = state;
        reach.handleSkippedNotes();
        Conductor.instance.update(FlxG.sound.music.time);
        reach.resyncVocals();
    }

    public override function onBeatHit(event:SongTimeScriptEvent):Void {
        super.onBeatHit(event);
    }

    public override function onUpdate(event:UpdateScriptEvent):Void {
        var state = PlayState.instance;
        if (state == null) {
            super.onUpdate(event);
            return;
        }

        barPollCooldown -= event.elapsed;

        if (hud != null && barPollCooldown <= 0) {
            barPollCooldown = 0.25;

            var shown:Dynamic = hud.scriptCall("isHealthBarShown");
            if (shown == true) {
                hud.scriptCall("hideBars");
                hud.scriptCall("hideHealth");
            }
        }

        var currentBeat:Float = Conductor.instance.currentBeatTime;

        var playing:Bool = FlxG.state == state;

        if (skipQueued && playing && FlxG.sound.music != null && FlxG.sound.music.playing && Conductor.instance.songPosition >= 0) {
            skipQueued = false;
            jumpPastIntro(state);
            return;
        }

        if (skip != null && skip.visible && playing) {
            state.camHUD.zoom = state.defaultHUDCameraZoom;
            if ((FlxG.keys.justPressed.BACKSPACE || (HexTouch.mobile && PlayerSettings.player1.controls.NOTE_RIGHT_P)) && currentBeat < 32 && FlxG.sound.music != null) {
                skipped = true;
                skip.visible = false;

                if (FlxG.sound.music.playing && Conductor.instance.songPosition >= 0) {
                    jumpPastIntro(state);
                    return;
                }

                skipQueued = true;
            }
        }

        var s = scene();
        if (s != null) s.scriptCall("glitchAt", [((1 - (state.health / 2)) * 0.1) + additionalGlitch + sceneGlitch()]);

        if (additionalGlitch > 0) additionalGlitch -= 10 * event.elapsed;
        else additionalGlitch = 0;

        state.health = realHealth;

        @:privateAccess
        if (state.rightWatermarkText != null) {
            @:privateAccess
            state.rightWatermarkText.visible = false;
            var dad:BaseCharacter = state.currentStage.getDad();
            state.cameraFollowPoint.setPosition(dad.cameraFocusPoint.x, dad.cameraFocusPoint.y);
        }

        showIntro(currentBeat);

        if (stripShader != null) {
            var slid:Float = STRIP_SPEED * Conductor.instance.songPosition / 1000;
            slid -= Math.floor(slid / (2 * STRIP_REPEAT)) * 2 * STRIP_REPEAT;
            stripShader.setFloat("uScroll", slid);
        }

        placeEyes();

        super.onUpdate(event);
    }

    public override function listDifficulties(?variationId:String, ?variationIds:Array<String>, showLocked:Bool = false, showHidden:Bool = false):Array<String> {
        return [];
    }
}
