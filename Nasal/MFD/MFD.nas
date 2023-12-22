var MfdInstances = [{}, {}];

var mfdListener = 0;

var MenuEnum = {
	ENGINE:	0,
	MAP:	1,
};

var MFD = {
	new: func(group, instance)
	{
		var m = { parents: [MFD, Device.new(instance)] };

		# create pages
		m.PFD = canvas_pfd.new(group.createChild('group'));
		
		m.Engine = canvas_engine.new(group.createChild('group'));
		#append(m.Pages, canvas_engine.new(group.createChild('group')));
		append(m.Pages, canvas_gear.new(group.createChild('group')));
		append(m.Pages, canvas_refueling.new(group.createChild('group')));

		m.SkInstance = canvas_overlay.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(0, m, "ДВИГ")); # engines
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(1, m, "ТОПЛ")); # fuel
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(2, m, "ППС", 0, 0));  # fire protection
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(3, m, "ГПС"));  # hydraulic and pneumatic systems
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(4, m, "СЖО"));  # life supporting system
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(5, m, "ДЗП", 0, 1));  # aerial refueling
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(6, m, "С\nЗ\nС"));  # voltage

		m.ActivatePage(0);
		m.ActivateMenu(MenuEnum.ENGINE);
		return m;
	}
};

var mfdBtClick = func(index = 0, location = 0, input = -1) {
	#print(index, location, input);
	
	if (input > 6) {
		MfdInstances[index].BtClick(input-6);
	}
}

mfdListener = setlistener("/sim/signals/fdm-initialized", func () {

	var mfd1Canvas = canvas.new({
		"name": "MFD1",
		"size": [1024, 1024],
		"view": [1024, 768],
		"mipmapping": 1
	});
	var mfd2Canvas = canvas.new({
		"name": "MFD1",
		"size": [1024, 1024],
		"view": [1024, 768],
		"mipmapping": 1
	});

	mfd1Canvas.addPlacement({"node": "mfd1_screen"});
	mfd2Canvas.addPlacement({"node": "mfd2_screen"});
	#MfdInstances[0] = MFD.new(mfd1Canvas.createGroup(), 0);
	MfdInstances[1] = MFD.new(mfd2Canvas.createGroup(), 0);

	removelistener(mfdListener);
});
