var canvas_pfd = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_pfd] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/pfd.svg", {'font-mapper': font_mapper});
		var svg_keys = ["horizon"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.horizon.set("clip", "rect(40, 273, 263, 72)");# top,right,bottom,left
		m.group = canvasGroup;
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
