var hud_nav = {
	new: func(canvasGroup, instance)
	{
		var m = { parents: [hud_nav] };
		m.group = canvasGroup;
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/HUD/hud_nav.svg");
		m.tmp = 0;

		var svg_keys = ["heading", "roll", "vv", "asi", "mach", "alt"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.input = {
			alpha:    "orientation/alpha-deg",
			ias:      "velocities/airspeed-kt",
			mach:     "velocities/mach",
			alt:      "instrumentation/altimeter/indicated-altitude-ft",
			pitch:    "orientation/pitch-deg",
			roll:     "orientation/roll-deg",
			hdg:      "orientation/heading-deg",
			vsi:      "velocities/vertical-speed-fps",
			loc:      "instrumentation/nav/in-range",
			gs:       "instrumentation/nav/gs-in-range",
		};
		foreach(var name; keys(m.input))
			m.input[name] = props.globals.getNode(m.input[name], 1);

		m.heading.set("clip", "rect(0, 169, 256, 100)"); #top,right,bottom,left

		return m;
	},
	update: func()
	{
		me.asi.setText(sprintf("%d", me.input.ias.getValue()));
		me.alt.setText(sprintf("%d", 0.3*me.input.alt.getValue()));
		me.mach.setText(sprintf("%.2f", 0.3*me.input.mach.getValue()));
		
		me.tmp = me.input.hdg.getValue();
		if(me.tmp < 180) {
			me.heading.setTranslation(-me.tmp*2.44,0);
		}
		else {
			me.heading.setTranslation((360-me.tmp)*2.44,0);
		}

		me.roll.setRotation(me.input.roll.getValue()*D2R, me.roll.getCenter());
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
