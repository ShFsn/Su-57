var panel_nav = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_nav, panel_base.new(canvasGroup)] };
		
		m.input = {
			fuel:	"consumables/fuel/total-fuel-gal_us",
			mmhg:	"instrumentation/altimeter/setting-hpa",
		};
		foreach(var name; keys(m.input)) {
			m.input[name] = props.globals.getNode(m.input[name], 1);
		}
		m.Mode = 0;
		m.Airfield = 0;

		m.L1A.setText("01").setColor(0,1,0);
		m.L1B.setText("НВГ");
		m.L1C.setText("Р ЗЕМ");

		m.L2A.setColor(0,1,0);
		m.L2B.setText("");
		m.L2C.setColor(0,1,0);

		m.L3A.setText("029° /").setColor(0,1,0);
		m.L3B.setText("9999КМ").setColor(0,1,0);
		m.L3C.setText("");
		m.L3D.setText("МТУ");

		m.L4A.setText("Gp");
		m.L4B.setColor(0,1,0);
		m.L4C.setText("");
		m.L4D.setText("ПУТ").setColor(0,1,0);

		m.L5A.setText("Тз");
		m.L5B.setText("- - : - - : - -").setColor(0,1,0);
		m.L5C.setText("");
		m.L5D.setText("");

		m.L6A.setText("Тр");
		m.L6B.setText("- - : - - : - -").setColor(0,1,0);
		m.L6C.setText("");
		m.L6D.setText("");

		m.path1.hide();
		return m;
	},
	show: func()
	{
		me.group.show();
		setprop("instrumentation/hud/l1", "unused");
		setprop("instrumentation/hud/l2", "unused");
		setprop("instrumentation/hud/l3", "unused");
		setprop("instrumentation/hud/r1", "unused");
		setprop("instrumentation/hud/r2", "unused");
		setprop("instrumentation/hud/r3", "unused");
		
		if(me.Mode == 0) {
			me.L2A.setText("14 XXX");
			me.L2B.setText("МРШ01");
		}

		if(me.Mode == 1) {
			me.L2A.setText("");
			me.L2B.setText("ПЗК");
		}

		if(me.Mode == 2) {
			me.L2A.setText(sprintf("%02d OAIX", me.Airfield+1));
			me.L2B.setText("ВЗВ");
		}
	},
	update: func()
	{
		me.L2C.setText(sprintf("%.1f", me.input.mmhg.getValue()*0.75));
		me.L4B.setText(sprintf("%dКГ", me.input.fuel.getValue()*3.1));
	},
	btClick: func(location, input)
	{
		if(location == 4) {
			if(input == 2) {
				me.Mode = 0;
			}
			if(input == 4) {
				me.Mode = 1;
			}
			if(input == 5) {
				if(me.Mode == 2) {
					me.Airfield += 1;
				}
				else {
					me.Mode = 2;
					me.Airfield = 0;
				}
			}
		}
		me.show();
	}
};
