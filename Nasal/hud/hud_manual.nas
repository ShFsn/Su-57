var hud_manual = {
	new: func(canvasGroup)
	{
		var m = { parents: [hud_manual] };
		m.group = canvasGroup;
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/hud/hud_manual.svg");
		
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
