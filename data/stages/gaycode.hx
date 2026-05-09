var canRot:Bool=true;

function postCreate() {
	strumLines.members[1].onHit.add((e)->{
		strumLines.members[1].characters[0].angle = 0;
		canRot=false;
		new FlxTimer().start(1, (_)->{
			canRot=true;
			_.destroy();
		});
	});
}
function update(elapsed:Float) {
	sprite_5.angle++;
	if(canRot) strumLines.members[1].characters[0].angle+=8;
}

function onPlayerHit(e) {
	var bf = strumLines.members[0].characters[0];
	switch(e.direction) {
		case 0: bf.x-=5; bf.angle-=5;
		case 1: bf.y-=5;
		case 2: bf.y+=5;
		case 3: bf.x+=5; bf.angle+=5;
	}
}

var g:Bool=false;
function beatHit(beat:Int) {
	g=!g;
	if(g) {
		FlxTween.tween(strumLines.members[0].characters[0].scale, {x: 2, y: 0.5}, (Conductor.stepCrochet/1000*2), {ease: FlxEase.elasticOut});
	}else{
		FlxTween.tween(strumLines.members[0].characters[0].scale, {x: 0.5, y: 2}, (Conductor.stepCrochet/1000*2), {ease: FlxEase.elasticOut});
	}
}