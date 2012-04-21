import Common;

class City {

	public var game : Game;
	public var x : Int;
	public var y : Int;
	
	public function new(g, x, y) {
		game = g;
		this.x = x;
		this.y = y;
	}
	
}

class Entity {
	
	public var game : Game;
	public var x : Int;
	public var y : Int;
	public var kind : NpcKind;
	public var mc : BMP;
	
	public var moving : Bool;
	
	public var frame : Float;
	public var curFrame : Int;
	public var px : Float;
	public var py : Float;
	
	public var mspeed : Float;
	
	public function new(x, y, k) {
		game = Game.inst;
		kind = k;
		mspeed = 0.12;
		this.x = x;
		this.y = y;
		moving = false;
		px = x;
		py = y;
		this.mc = new BMP(null,flash.display.PixelSnapping.ALWAYS);
		game.dm.add(mc,Game.PLAN_NPC);
		frame = Math.random() * 10;
		curFrame = -1;
	}
	
	public function canMove() {
		var d = Math.abs(px - x) + Math.abs(py - y);
		return d <= mspeed;
	}
	
	public function remove() {
		mc.parent.removeChild(mc);
	}
	
	public function update() {
		frame += 0.12 * (1 + Math.random() * 0.02);
		var dx = Math.abs(px - x);
		if( dx > 0 ) {
			if( dx > mspeed ) {
				dx = mspeed;
				moving = true;
			} else
				moving = false;
			px += px > x ? -dx : dx;
		}
		var dy = Math.abs(py - y);
		if( dy > 0 ) {
			if( dy > mspeed ) {
				dy = mspeed;
				moving = true;
			} else
				moving = false;
			py += py > y ? -dy : dy;
		}
		
		this.mc.x = Std.int(px * 5) - 1;
		this.mc.y = Std.int(py * 5) - 2;
		var t = game.tiles.s[Type.enumIndex(kind)];
		var iframe = Std.int(frame) % t.length;
		if( iframe != curFrame ) {
			curFrame = iframe;
			mc.bitmapData = t[iframe];
		}
	}
	
	function dist(p1, p2) {
		game.world.initPath(p1.x, p1.y);
		return game.world.getDist(p2.x, p2.y);
	}
	
}
