package kade.hex.objects.dialogue;

/**
 * One parsed line of a story script.
 */
class DialogueCommand
{
  public var type:String;
  public var mode:String = null;
  public var tag:String = null;
  public var name:String = null;
  public var value:String = null;
  public var who:String = null;
  public var text:String = null;

  public function new(type:String)
  {
    this.type = type;
  }
}
