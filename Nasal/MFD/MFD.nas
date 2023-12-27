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

		append(m.Pages, canvas_map.new(group.createChild('group')));
		append(m.Pages, canvas_engine.new(group.createChild('group')));

		m.SkInstance = canvas_skTop.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(0, m, "ПИЛ"));
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(1, m, "ТО", 0, 0));
		m.Menus[MenuEnum.ENGINE].AddItem(SkMenuPageActivateItem.new(2, m, "КИС", 0, 1));
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(3, m, "ОПС"));
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(5, m, "<=>"));
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(6, m, "О\nЧ\nР"));

		m.ActivatePage(1, 2);
		m.ActivateMenu(MenuEnum.ENGINE);
		return m;
	},
	SubBtClick: func(input)
	{
		me.Pages[1].BtClick(input);
	}
};

var mfdBtClick = func(index = 0, location = 0, input = -1) {
	input -= 6;
	
	if(location == 0) {
		if (input > 0) {
			MfdInstances[index].BtClick(input);
		}
	}
	else if(location == 1) {
		MfdInstances[index].SubBtClick(input);
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
