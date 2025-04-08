var panel_wpn = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_wpn, panel_base.new(canvasGroup)] };
		m.Mode = 1;

		m.L1A.setText("");
		m.L1B.setText("");
		m.L1C.setText("");

		m.L2A.setText("");
		m.L2B.setText("");
		m.L2C.setText("");

		m.L3A.setText("");
		m.L3B.setText("");
		m.L3C.setText("");
		m.L3D.setText("");

		m.L4A.setText("< - - - -");
		m.L4B.setText("");
		m.L4C.setText("");
		m.L4D.setText("- - - - >");

		m.L5A.setText("");
		m.L5B.setText("");
		m.L5C.setText("");
		m.L5D.setText("");

		m.L6A.setText("");
		m.L6B.setText("");
		m.L6C.setText("");
		m.L6D.setText("");

		m.path1.hide();
		return m;
	},
	show: func()
	{
		me.group.show();
		setprop("instrumentation/hud/l1", "unused");
		setprop("instrumentation/hud/l3", "unused");
		setprop("instrumentation/hud/r1", "unused");
		setprop("instrumentation/hud/r3", "unused");

		if(me.Mode == 1) {
			me.L1B.setText("ДБП");
			me.L2B.setText("АСП НЕ ВЫБРАНО К РАБОТЕ");
			me.L3A.setText("");
			me.L3D.setText("");
			setprop("instrumentation/hud/l2", "unused");
			setprop("instrumentation/hud/r2", "unused");
		}
		if(me.Mode == 2) {
			me.L1B.setText("ББП");
			me.L2B.setText("АСП НЕ ВЫБРАНО К РАБОТЕ");
			me.L3A.setText("");
			me.L3D.setText("");
			setprop("instrumentation/hud/l2", "unused");
			setprop("instrumentation/hud/r2", "unused");
		}
		if(me.Mode == 3) {
			me.L1B.setText("ББВ");
			me.L2B.setText("");
			me.L3A.setText("Р-73");
			me.L3D.setText("Р-77");
			setprop("instrumentation/hud/l2", "Select R-73");
			setprop("instrumentation/hud/r2", "Select R-77");
		}
		if(me.Mode == 4) {
			me.L1B.setText("ДБВ");
			me.L2B.setText("");
			me.L3A.setText("Р-73");
			me.L3D.setText("Р-77");
			setprop("instrumentation/hud/l2", "Select R-73");
			setprop("instrumentation/hud/r2", "Select R-77");
		}
	},
	btClick: func(location, input)
	{
		if(location == 2) {
			if(input == 5 or input == 8) {
				pylons.fcs.cycleAA();
			}
		}
	},
	setMode: func(mode)
	{
		me.Mode = mode;
	}
};
