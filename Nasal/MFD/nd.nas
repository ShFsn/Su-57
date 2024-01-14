var canvas_nd = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_nd, Device.new(0)] };

		append(m.Pages, canvas_map.new(canvasGroup.createChild('group')));

		m.SkInstance = canvas_skND.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkItem.new(0, m, "ТО", "tactical situation"));

		m.ActivateMenu(0);
		m.ActivatePage(0, 0);

		m.group = canvasGroup;
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
