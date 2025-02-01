var hud_clip = {
	new: func(canvasGroup, instance)
	{
		var m = { parents: [hud_clip] };
		m.tmp = 0;
		m.group = canvasGroup;
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/HUD/hud_clip.svg");

		var svg_keys = ["top", "left", "right"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		
		var center = m.right.getCenter();
		m.right.createTransform().setTranslation(-center[0], -center[1]);
		m.right_scale = m.right.createTransform();
		m.right.createTransform().setTranslation(center[0], center[1]);

		m.input = {
			y: "sim/current-view/x-offset-m",
			z: "sim/current-view/y-offset-m",
		};
		foreach(var name; keys(m.input)) {
			m.input[name] = props.globals.getNode(m.input[name], 1);
		}

		return m;
	},
	update: func()
	{
		me.top.setScale(1, (me.input.z.getValue()-1.1)*5000);

		me.tmp = me.input.y.getValue();
		if(me.tmp < 0) {
			me.left.setScale(-me.tmp*5000, 1);
		}
		else {
			me.left.setScale(0, 1);
		}
		
		if(me.tmp > 0) {
			me.right_scale.setScale(me.tmp*10000, 1);
		}
		else {
			me.right_scale.setScale(0, 1);
		}
	},
	show: func()
	{
		me.group.show();
	},
	hide: func()
	{
		me.group.hide();
	}
};
