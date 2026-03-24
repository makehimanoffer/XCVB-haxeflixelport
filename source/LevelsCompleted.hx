package;

import flixel.util.FlxSave;

class LevelsCompleted
{
    private static var _save:FlxSave;
    private static var _temp:Int = 1; // Default to 1 so Level 1 is unlocked [cite: 71]
    private static var _loaded:Bool = false;

    /**
     * Returns the number of levels that the player has completed.
     * Uses the saved data if bind() worked, otherwise uses temporary memory. [cite: 73, 74]
     */
    public static var levels(get, set):Int;

    private static function get_levels():Int
    {
        if (_loaded && _save.data.levels != null)
        {
            return _save.data.levels;
        }
        return _temp;// [cite: 74]
    }

    private static function set_levels(value:Int):Int
    {
        if (_loaded)
        {
            _save.data.levels = value;
            _save.flush(); // Ensure data is written to disk
        }
        else
        {
            _temp = value;// [cite: 75]
        }
        return value;
    }

    /**
     * Setup LevelsCompleted and bind to the local SharedObject. [cite: 75]
     */
    public static function load():Void
    {
        _save = new FlxSave();
        _loaded = _save.bind("XCVBLevelData"); //[cite: 76]

        if (_loaded && _save.data.levels == null)
        {
            _save.data.levels = 1; // Standard start is level 1 [cite: 76]
            _save.flush();
        }
    }
}