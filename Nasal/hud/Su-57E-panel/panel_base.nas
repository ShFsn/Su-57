var panel_base = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_base] };
		m.group = canvasGroup;

		var font_mapper = func(family, weight)
		{
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/hud/Su-57E-panel/panel.svg", {'font-mapper': font_mapper});

		var svg_keys = ["L1A", "L1B", "L1C", "L1D", "L1E", "L1F", "L1G", "L1H",
						"L2A", "L2B", "L2C", "L2D", "L2E", "L2F", "L2G", "L2H"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.L1A.setText("НВГ");
		m.L1B.setText("ДБВ");
		m.L1C.setText("ББВ");
		m.L1D.setText("ББП");
		m.L1E.setText("ДБП");
		m.L1F.setText("");
		m.L1G.setText("");
		m.L1H.setText("НВД");

		m.L2A.setText("");
		m.L2B.setText("");
		m.L2C.setText("");
		m.L2D.setText("");
		m.L2E.setText("");
		m.L2F.setText("");
		m.L2G.setText("");
		m.L2H.setText("");

		return m;
	},
	show: func()
	{
		me.group.show();
	},
	hide: func()
	{
		me.group.hide();
	},
	update: func()
	{
	},
	btClick: func(location, input)
	{
	}
};
