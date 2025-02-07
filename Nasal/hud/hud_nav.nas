var hud_nav = {
	new: func(canvasGroup)
	{
		var m = { parents: [hud_nav] };
		m.group = canvasGroup;
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/hud/hud_nav.svg");

		return m;
	},
	update: func()
	{
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
