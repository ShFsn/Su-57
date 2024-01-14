var MfdInstances = [{}, {}];

var mfdListener = 0;

var MenuEnum = {
	TO:		0,
	KIS:	1,
};

var MFD = {
	new: func(group, instance)
	{
		var m = { parents: [MFD, Device.new(instance)] };

		# create pages
		m.PFD = canvas_pfd.new(group.createChild('group'));

		append(m.Pages, canvas_to.new(group.createChild('group')));
		append(m.Pages, canvas_kis.new(group.createChild('group')));

		m.SkInstance = canvas_skMFD.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(MenuEnum.TO, m, ""));
		append(m.Menus, SkMenu.new(MenuEnum.KIS, m, ""));

		# create softkeys
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(0, m, "ПИЛ", ""));
		m.Menus[MenuEnum.TO].AddItem(SkMenuPageActivateItem.new(1, m, "ТО", "tactical situation", MenuEnum.TO, MenuEnum.TO));
		m.Menus[MenuEnum.TO].AddItem(SkMenuPageActivateItem.new(2, m, "КИС", "controlling and informational system", MenuEnum.KIS, MenuEnum.KIS));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(3, m, "ОПС", ""));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(5, m, "<=>", "swap screens"));
		m.Menus[MenuEnum.TO].AddItem(SkItem.new(6, m, "", ""));

		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(0, m, "ПИЛ", ""));
		m.Menus[MenuEnum.KIS].AddItem(SkMenuPageActivateItem.new(1, m, "ТО", "tactical situation", MenuEnum.TO, MenuEnum.TO));
		m.Menus[MenuEnum.KIS].AddItem(SkMenuPageActivateItem.new(2, m, "КИС", "controlling and informational system", MenuEnum.KIS, MenuEnum.KIS));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(3, m, "ОПС", ""));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(5, m, "<=>", "swap screens"));
		m.Menus[MenuEnum.KIS].AddItem(SkItem.new(6, m, "О\nЧ\nР", "next message"));

		m.ActivateMenu(MenuEnum.KIS);
		m.ActivatePage(MenuEnum.KIS, 2);
		m.Update();
		m.Timer = maketimer(0.1, m, m.Update);
		m.Timer.start();
		return m;
	},
	Update: func()
	{
		me.PFD.update();
		me.Pages[MenuEnum.KIS].update();
	},
	SubBtClick: func(input)
	{
		if(input == 9) {
			me.Pages[MenuEnum.KIS].pmt();
		}
		else {
			me.Pages[MenuEnum.KIS].BtClick(input);
		}
	}
};

var mfdBtClick = func(index = 0, location = 0, input = -1) {

	if(getprop("instrumentation/mfd/swap") or 0) {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 0);
		}
		
		if(index) {
			index = 0;
		}
		else {
			index = 1;
		}
	}
	else {
		if(location == 0 and input == 11) {
			setprop("instrumentation/mfd/swap", 1);
		}
	}
	
	if(location == 0) {
		if (input > 5) {
			MfdInstances[index].BtClick(input-6);
		}
	}
	else if(location == 1) {
		if (input > 5) {
			MfdInstances[index].SubBtClick(input-6);
		}
	}
	else if(location == 3) {
		if (input > 0) {
			MfdInstances[index].SubBtClick(13-input);
		}
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

	mfd1Canvas.addPlacement({"node": "mfd1_screen1"});
	mfd1Canvas.addPlacement({"node": "mfd2_screen2"});
	mfd2Canvas.addPlacement({"node": "mfd2_screen1"});
	mfd2Canvas.addPlacement({"node": "mfd1_screen2"});
	MfdInstances[0] = canvas_nd.new(mfd1Canvas.createGroup(), 0);
	MfdInstances[1] = MFD.new(mfd2Canvas.createGroup(), 0);

	removelistener(mfdListener);
});
