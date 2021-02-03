package;

import flixel.FlxState;

class PlayState extends FlxState
{
	public var dialogueBox:DialogueBox;

	override public function create()
	{
		super.create();

		dialogueBox = new DialogueBox();
		add(dialogueBox);

		// dialogueBox.cameras = [uiCamera];

		dialogueBox.scrollFactor.set(0, 0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		handleDialogBox();
	}

	function handleDialogBox()
	{
		if (FlxG.keys.justPressed.Z)
		{
			if (dialogueBox.visible)
			{
				if (!dialogueBox.typeText._typing)
				{
					FlxTween.tween(gameCamera, {zoom: 2}, 0.5, {ease: FlxEase.backOut});
					Reg.canMove = true;
					dialogueBox.visible = false;
				}
				else
				{
					dialogueBox.typeText.skip();
				}
			}
			else if (!dialogueBox.visible)
			{
				for (member in npcs)
				{
					if (FlxMath.isDistanceWithin(member, player, 50))
					{
						dialogueBox.say(member.text);
						FlxTween.tween(gameCamera, {zoom: 4}, 0.5, {ease: FlxEase.backOut});
					}
				}
			}
		}
	}
}
