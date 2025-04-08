var panel_radio = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_radio, panel_base.new(canvasGroup)] };

		return m;
	},
	show: func()
	{
		me.group.show();
	},
	btClick: func(location, input)
	{
		me.show();
	}
};
