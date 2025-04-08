var hud_base = {
	new: func(canvasGroup)
	{
		var m = { parents: [hud_base] };
		m.group = canvasGroup;
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/hud/screen/hud_base.svg");
		m.tmp = 0;
		m.kmh = 1;

		var svg_keys = ["heading", "horizon", "roll", "gearL", "gearR", "asi", "ias", "mach", "alt", "vsi", "vv"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.input = {
			alpha:    "orientation/alpha-deg",
			ias:      "velocities/airspeed-kt",
			mach:     "velocities/mach",
			alt:      "instrumentation/altimeter/indicated-altitude-ft",
			pitch:    "orientation/pitch-deg",
			hdg:      "orientation/heading-deg",
			roll:     "orientation/roll-deg",
			gear:     "gear/gear[0]/position-norm",
			vsi:      "velocities/vertical-speed-fps",
			loc:      "instrumentation/nav/in-range",
			gs:       "instrumentation/nav/gs-in-range",
		};
		foreach(var name; keys(m.input))
			m.input[name] = props.globals.getNode(m.input[name], 1);

		m.heading.set("clip", "rect(0, 648, 256, 376)"); #top,right,bottom,left
		m.horizon.set("clip", "rect(280, 1024, 520, 0)"); #top,right,bottom,left
		m.vv.hide();

		return m;
	},
	update: func()
	{
		# asi
		if(me.kmh) {
			me.ias.hide();
		}
		else {
			me.ias.show();
		}
		if(me.input.ias.getValue() > 40) {
			me.asi.setText(sprintf("%d", me.input.ias.getValue()*(me.kmh?1.85:1)));
			me.mach.setText(sprintf("%.2f", me.input.mach.getValue()));
		}
		else {
			me.asi.setText("0");
			me.mach.setText("0.00");
		}
		me.alt.setText(sprintf("%d", 0.3*me.input.alt.getValue()));

		# heading
		me.tmp = me.input.hdg.getValue();
		if(me.tmp < 180) {
			me.heading.setTranslation(-me.tmp*2.44,0);
		}
		else {
			me.heading.setTranslation((360-me.tmp)*2.44, 0);
		}

		# pitch
		me.horizon.setTranslation(0, me.input.pitch.getValue()*4);

		# roll
		me.roll.setRotation(me.input.roll.getValue()*D2R);

		# gear
		if(me.input.gear.getValue() > 0.9) {
			me.gearL.show();
			me.gearR.show();
		}
		else {
			me.gearL.hide();
			me.gearR.hide();
		}

		# vsi
		me.tmp = 0.5*me.input.vsi.getValue();
		if(me.tmp > 50) me.tmp = 50;
		if(me.tmp < -50) me.tmp = -50;
		me.vsi.setRotation(me.tmp*D2R);
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
