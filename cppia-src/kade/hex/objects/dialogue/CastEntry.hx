package kade.hex.objects.dialogue;

/**
 * A character standing on the sprite mode stage.
 */
class CastEntry
{
  public var id:String;
  public var pool:Int;
  public var spoke:Float;

  public function new(id:String, pool:Int, spoke:Float)
  {
    this.id = id;
    this.pool = pool;
    this.spoke = spoke;
  }
}
