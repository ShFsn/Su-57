var PageEnum = {
	GEAR:	    0,
	HYDRAULICS:	1,
	OXY:		2,
	REFUELING:	3,
	ELECTRICAL:	4,
	EMPTY:	    5,
};

var canvas_kis = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_kis, Device.new(1)], SubPages: [] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/kis.svg", {'font-mapper': font_mapper});
		
		append(m.SubPages, canvasGroup.createChild('group'));
		append(m.SubPages, canvasGroup.createChild('group'));
		canvas.parsesvg(m.SubPages[0], "Aircraft/Su-57/Nasal/MFD/panel.svg", {'font-mapper': font_mapper});
		canvas.parsesvg(m.SubPages[1], "Aircraft/Su-57/Nasal/MFD/nozzle.svg", {'font-mapper': font_mapper});
		m.ActiveSubPage = 0;

		append(m.Pages, canvas_gear.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_hydraulics.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_oxy.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_refueling.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_elec.new(canvasGroup.createChild('group')));
		append(m.Pages, canvas_empty.new(canvasGroup.createChild('group')));

		m.SkInstance = canvas_skBottom.new(canvasGroup.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));
		append(m.Menus, SkMenu.new(1, m, ""));
		append(m.Menus, SkMenu.new(2, m, ""));

		# create softkeys
		m.Menus[0].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[0].AddItem(SkItem.new(1, m, "ТОПЛ", "fuel"));
		m.Menus[0].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[0].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[0].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[0].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[0].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[0].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[0].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 1));
		m.Menus[0].AddItem(SkItem.new(11, m, "М\nН\nВ\nР", "maneuver"));
		m.Menus[0].AddItem(SkPageActivateItem.new(12, m, "С\nИ\nС", "system notifications", PageEnum.EMPTY));

		m.Menus[1].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[1].AddItem(SkItem.new(1, m, "ТОПЛ", "fuel"));
		m.Menus[1].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[1].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[1].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[1].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[1].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[1].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[1].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 2));
		m.Menus[1].AddItem(SkPageActivateItem.new(11, m, "С\nИ\nС", "system notifications", PageEnum.EMPTY));
		m.Menus[1].AddItem(SkItem.new(12, m, "С\nТ\nР", "page"));

		m.Menus[2].AddItem(SkSwitchItem.new(0, m, "ДВИГ", "engines", "instrumentation/mfd/engine"));
		m.Menus[2].AddItem(SkItem.new(1, m, "ТОПЛ", "fuel"));
		m.Menus[2].AddItem(SkPageActivateItem.new(2, m, "ППС", "gear and flap indicator", PageEnum.GEAR));
		m.Menus[2].AddItem(SkPageActivateItem.new(3, m, "ГПС", "hydraulic and pneumatic systems", PageEnum.HYDRAULICS));
		m.Menus[2].AddItem(SkPageActivateItem.new(4, m, "СЖО", "life supporting system", PageEnum.OXY));
		m.Menus[2].AddItem(SkPageActivateItem.new(5, m, "ДЗП", "aerial refueling", PageEnum.REFUELING));
		m.Menus[2].AddItem(SkPageActivateItem.new(6, m, "С\nЭ\nС", "electrical supply system", PageEnum.ELECTRICAL));
		m.Menus[2].AddItem(SkItem.new(9, m, "П\nМ\nТ", "Parameters of Maneuver Technique"));
		m.Menus[2].AddItem(SkMenuActivateItem.new(10, m, "", "move down", 0));
		m.Menus[2].AddItem(SkItem.new(11, m, "С\nТ\nР", "page"));
		m.Menus[2].AddItem(SkItem.new(12, m, "М\nН\nВ\nР", "maneuver"));

		m.ActivateMenu(0);
		m.ActivatePage(0, 2);
		m.pmt();

		m.group = canvasGroup;
		return m;
	},
	pmt: func()
	{
		me.ActiveSubPage += 1;
		
		if(me.ActiveSubPage > 2) {
			me.ActiveSubPage = 0;
		}
		
		me.SubPages[0].hide();
		me.SubPages[1].hide();
		
		if(me.ActiveSubPage == 1) {
			me.SubPages[0].show();
		}
		if(me.ActiveSubPage == 2) {
			me.SubPages[1].show();
		}
	},
	update: func()
	{
		print("update");
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
