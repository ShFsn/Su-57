var panel_wpn = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_wpn, panel_base.new(canvasGroup)] };
		m.Mode = 1;

		return m;
	},
	show: func()
	{
		me.group.show();
	},
	btClick: func(location, input)
	{
	},
	setMode: func(mode)
	{
		me.Mode = mode;
	}
};
