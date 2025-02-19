var panel_radio = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_radio, panel_base.new(canvasGroup)] };
		m.Radio1 = 0;
		m.Radio2 = 0;
		m.SA1 = 0;
		m.SA2 = 0;

		m.L1A.setText("РАДИО1");
		m.L1B.setText("РС1");
		m.L1C.setText("РАДИО2");

		m.L2A.setColor(0,1,0);
		m.L2B.setText("");
		m.L2C.setColor(0,1,0);

		m.L3A.setColor(0,1,0);
		m.L3B.setText("");
		m.L3C.setText("");
		m.L3D.setColor(0,1,0);

		m.L4A.setColor(0,1,0);
		m.L4B.setColor(0,1,0);
		m.L4C.setColor(0,1,0);
		m.L4D.setColor(0,1,0);

		m.L5A.setText("СА");
		m.L5B.setText("");
		m.L5C.setText("");
		m.L5D.setText("СА");

		m.L6A.setText("БКЛ");
		m.L6B.setText("ОТКЛ");
		m.L6C.setText("БКЛ");
		m.L6D.setText("ОТКЛ");

		return m;
	},
	show: func()
	{
		me.group.show();
		setprop("instrumentation/hud/l2", "unused");
		setprop("instrumentation/hud/r2", "unused");

		if(me.Radio1) {
			me.L2A.setText("КВ");
			me.L3A.setText("00.000");
			me.L4A.setText("00.000");
			me.L4B.setText("OM");
			setprop("instrumentation/hud/l1", "HF");
		}
		else {
			me.L2A.setText("УКВ1");
			me.L3A.setText("К01");
			me.L4A.setText("100.000");
			me.L4B.setText("AM");
			setprop("instrumentation/hud/l1", "VHF1");
		}
		if(me.Radio2) {
			me.L2C.setText("КВ");
			me.L3D.setText("00.000");
			me.L4D.setText("00.000");
			me.L4C.setText("OM");
			setprop("instrumentation/hud/r1", "HF");
		}
		else {
			me.L2C.setText("УКВ1");
			me.L3D.setText("К01");
			me.L4D.setText("100.000");
			me.L4C.setText("AM");
			setprop("instrumentation/hud/r1", "VHF1");
		}

		if(me.SA1) {
			me.L6A.setColor(0,1,0);
			me.L6B.setColor(1,1,1);
			setprop("instrumentation/hud/l3", "SA ON");
		}
		else {
			me.L6A.setColor(1,1,1);
			me.L6B.setColor(0,1,0);
			setprop("instrumentation/hud/l3", "SA OFF");
		}
		if(me.SA2) {
			me.L6C.setColor(0,1,0);
			me.L6D.setColor(1,1,1);
			setprop("instrumentation/hud/r3", "SA ON");
		}
		else {
			me.L6C.setColor(1,1,1);
			me.L6D.setColor(0,1,0);
			setprop("instrumentation/hud/r3", "SA OFF");
		}
	},
	update: func()
	{
	},
	btClick: func(location, input)
	{
		if(location == 2) {
			if(input == 4) {
				me.Radio1 = me.Radio1?0:1;
			}
			if(input == 7) {
				me.Radio2 = me.Radio2?0:1;
			}
			if(input == 6) {
				me.SA1 = me.SA1?0:1;
			}
			if(input == 9) {
				me.SA2 = me.SA2?0:1;
			}
		}
		me.show();
	}
};
