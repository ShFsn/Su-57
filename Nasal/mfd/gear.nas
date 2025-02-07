var canvas_gear = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_gear] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/mfd/gear.svg", {'font-mapper': font_mapper});

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
