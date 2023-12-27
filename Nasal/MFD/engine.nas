var canvas_engine = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_engine, Device.new(0)] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/engine.svg", {'font-mapper': font_mapper});

		append(m.Pages, canvas_gear.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_refueling.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_empty.new(canvasGroup.createChild('group')));

		m.SkInstance = canvas_skBottom.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[MenuEnum.ENGINE].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "instrumentation/mfd/engine")); # engines
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(1, m, "ТОПЛ", 0, 2)); # fuel
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(2, m, "ППС", 0, 0));  # fire protection
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(3, m, "ГПС", 0, 2));  # hydraulic and pneumatic systems
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(4, m, "СЖО", 0, 2));  # life supporting system
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(5, m, "ДЗП", 0, 1));  # aerial refueling
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(6, m, "С\nЗ\nС"));  # voltage
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(7, m, "П\nМ\nТ"));
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(8, m, "М\nН\nВ\nР"));  # maneuver
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(9, m, "С\nИ\nС"));  # notifications

		m.ActivatePage(0, 2);

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
