var panel_base = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_base] };
		m.group = canvasGroup;

		var font_mapper = func(family, weight)
		{
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/hud_panel/panel.svg", {'font-mapper': font_mapper});

		var svg_keys = ["HL", "HC", "HR",
						"L1L", "L1C", "L1R",
						"L2L", "L2C", "L2R",
						"L3L", "L3C", "L3R",
						"L4L", "L4C", "L4R",
						"L5L", "L5C", "L5R",
						"path1"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		return m;
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
