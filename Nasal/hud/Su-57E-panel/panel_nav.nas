var panel_nav = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_nav, panel_base.new(canvasGroup)] };
		
		m.input = {
			fuel:	"consumables/fuel/total-fuel-gal_us",
			mmhg:	"instrumentation/altimeter/setting-hpa",
		};

		return m;
	},
	show: func()
	{
		me.group.show();
	},
	update: func()
	{
	},
	btClick: func(location, input)
	{
		me.show();
	}
};
