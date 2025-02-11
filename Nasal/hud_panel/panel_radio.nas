var panel_radio = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_radio, panel_base.new(canvasGroup)] };

		m.L1A.setText("РАДИО1");
		m.L1B.setText("РС1");
		m.L1C.setText("РАДИО2");

		m.L2A.setText("УКВ1").setColor(0,1,0);
		m.L2B.setText("");
		m.L2C.setText("КВ").setColor(0,1,0);

		m.L3A.setText("К01").setColor(0,1,0);
		m.L3B.setText("");
		m.L3C.setText("");
		m.L3D.setText("00.0000").setColor(0,1,0);

		m.L4A.setText("100.000").setColor(0,1,0);
		m.L4B.setText("AM ").setColor(0,1,0);
		m.L4C.setText(" OM").setColor(0,1,0);
		m.L3D.setText("00.0000").setColor(0,1,0);

		m.L5A.setText("СА");
		m.L5B.setText("");
		m.L5C.setText("");
		m.L5D.setText("СА");

		m.L6A.setText("БКЛ");
		m.L6B.setText("ОТКЛ ").setColor(0,1,0);
		m.L6C.setText(" БКЛ");
		m.L6D.setText("ОТКЛ").setColor(0,1,0);

		return m;
	},
	update: func()
	{
	}
};
