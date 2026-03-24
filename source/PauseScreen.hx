package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseScreen extends FlxSprite
{
    // Must be public and non-static for the Proxy to "see" it on the instance
    public var colorVal:Int = 0xffffffff;
    public var textBlock:FlxText;

    public function new() 
    {
        // Positioned off-screen by default
        super(128, -1000);
        
        loadGraphic(Sources.ImgPaused); 
        scrollFactor.set(0, 0);
        
        textBlock = new FlxText(this.x + 50, this.y + 200, 290, "R To Return To Menu");
        textBlock.scrollFactor.set(0, 0);
        textBlock.setFormat(null, 8, 0x808080, "center");
    }

    override public function update(elapsed:Float):Void 
    {
        // Use the Proxy's state check
        if (FlxGProxy.isPaused) 
        {
            this.visible = true;
            textBlock.visible = true;
            
            // Sync text position to the sprite
            textBlock.x = this.x + 50;
            textBlock.y = this.y + 200;

            // Apply the colorVal to the sprite tint
            this.color = colorVal;

            if (FlxG.keys.justPressed.R) 
            {
                FlxGProxy.setPaused(false);
                FlxG.switchState(new Menu());
            }
        }
        else 
        {
            this.visible = false;
            textBlock.visible = false;
        }

        super.update(elapsed);
    }
}