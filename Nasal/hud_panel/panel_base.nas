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

		var svg_keys = ["L1A", "L1B", "L1C",
						"L2A", "L2B", "L2C",
						"L3A", "L3B", "L3C", "L3D",
						"L4A", "L4B", "L4C", "L4D",
						"L5A", "L5B", "L5C", "L5D",
						"L6A", "L6B", "L6C", "L6D",
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
