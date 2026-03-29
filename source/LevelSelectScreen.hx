package;

import Type;
import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

class LevelSelectScreen extends FlxState
{
    private var _levelArray:Array<LevelIcon> = [];
    private var _levelStateArray:Array<Class<FlxState>> = [];
    
    public static var _pos:Int = 0;
    private var _dest:Int = 0;
    private var _once:Bool = false;
    
    public static var _currentUnlockedLevel:Int = 0; 
    private var _currentLevel:Int = 0;

    override public function create():Void
    {
        _currentUnlockedLevel = LevelsCompleted.levels; //
        _dest = _pos;
        
        FlxG.camera.bgColor = 0xff161616; //
        FlxG.mouse.visible = false; //

        // Populate the state array with actual Haxe classes
        _levelStateArray = [
            Level1BAW, Level2BAW,Level3BAW, Level4BAW, Level5BAW,
           Level1//, Level2, Level3, Level4, Level5,
           // Level6, Level7, Level8, Level9, Level10,
          //  Level11, Level12, Level13, Level14, Level15,
           // Level16, Level17, Level18, Level19, Level20
        ];

        // Create the slider icons
        for (i in 0...25) {
            // This assumes you have ImgL1, ImgL2, etc. in Sources.hx
            var graphic:String = Reflect.field(Sources, "ImgL" + (i + 1));
            var icon = new LevelIcon(this, new FlxPoint(100 + (i * 500), 0), graphic, i + 1);
            _levelArray.push(icon);
            add(icon);
        }

        super.create();
    }

    override public function update(elapsed:Float):Void 
    {
        if (!_once) {
            _currentLevel = Math.round(-(_pos - 100) / 500); //
        }

        // Keep world bounds synced with camera
        FlxG.worldBounds.set(FlxG.camera.x, FlxG.camera.y, FlxG.camera.width, FlxG.camera.height);
        
        // Navigation logic
        if (FlxG.keys.justPressed.LEFT && !_once && _pos < 0) {
            FlxG.sound.play(Sources.Select);
            _dest = _pos + 500;
            _once = true;
        }
        
        if (FlxG.keys.justPressed.RIGHT && !_once && _pos > -(24 * 500)) {
            FlxG.sound.play(Sources.Select);
            _dest = _pos - 500;
            _once = true;
        }

        // Selection logic
        if (FlxG.keys.justPressed.SPACE && !_once && _currentLevel < _currentUnlockedLevel) {
            FlxG.sound.playMusic(Sources.Music);
            var nextState = Type.createInstance(_levelStateArray[_currentLevel], []);
            FlxG.switchState(nextState);
        }

        // Manual tweening
        if (_pos < _dest) {
            _pos += 10;
        } else if (_pos > _dest) {
            _pos -= 10;
        } else {
            _once = false;
        }

        super.update(elapsed);
    }
}