var PageEnum = {
	GEAR:	    0,
	HYDRAULICS:	1,
	REFUELING:	2,
	ELECTRICAL:	3,
	EMPTY:	    4,
};

var canvas_kis = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_kis, Device.new(0)] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/kis.svg", {'font-mapper': font_mapper});
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/engine.svg", {'font-mapper': font_mapper});

		append(m.Pages, canvas_gear.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_hydraulics.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_refueling.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_elec.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_empty.new(canvasGroup.createChild('group')));

		m.SkInstance = canvas_skBottom.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "instrumentation/mfd/engine")); # engines
		m.Menus[0].AddItem(SkMenuPageActivateItem.new(1, m, "ТОПЛ", 0, PageEnum.EMPTY)); # fuel
		m.Menus[0].AddItem(SkMenuPageActivateItem.new(2, m, "ППС", 0, PageEnum.GEAR));  # fire protection
		m.Menus[0].AddItem(SkMenuPageActivateItem.new(3, m, "ГПС", 0, PageEnum.HYDRAULICS));  # hydraulic and pneumatic systems
		m.Menus[0].AddItem(SkMenuPageActivateItem.new(4, m, "СЖО", 0, PageEnum.ELECTRICAL));  # life supporting system
		m.Menus[0].AddItem(SkMenuPageActivateItem.new(5, m, "ДЗП", 0, PageEnum.REFUELING));  # aerial refueling
		m.Menus[0].AddItem(SkItem.new(6, m, "С\nЗ\nС"));  # voltage
		m.Menus[0].AddItem(SkItem.new(7, m, "П\nМ\nТ"));
		m.Menus[0].AddItem(SkItem.new(8, m, "М\nН\nВ\nР"));  # maneuver
		m.Menus[0].AddItem(SkItem.new(9, m, "С\nИ\nС"));  # notifications

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
