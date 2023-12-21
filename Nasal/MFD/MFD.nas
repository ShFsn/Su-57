var MfdInstances = [{}, {}];

var mfdListener = 0;

var MenuEnum = {
	ENGINE:    0,
	MAP:       1,
	REFUELING: 2
};

var MFD = {
	new: func(group, instance)
	{
		var m = { parents: [MFD, Device.new(instance)] };

		# create pages
		m.PFD = canvas_pfd.new(group.createChild('group'));
		
		append(m.Pages, canvas_engine.new(group.createChild('group')));
		append(m.Pages, canvas_refueling.new(group.createChild('group')));

		m.SkInstance = canvas_overlay.new(group.createChild('group'));

		# create menus
		append(m.Menus, SkMenu.new(0, m, ""));

		# create softkeys
		m.Menus[MenuEnum.ENGINE].AddItem(SkItem.new(0, m, ""));

		return m;
	}
};

var mfdBtClick = func(index = 0, input = -1) {

	if (input < 10) {
		MfdInstances[index].BtClick(input);
	}
}

mfdListener = setlistener("/sim/signals/fdm-initialized", func () {

	var mfd1Canvas = canvas.new({
		"name": "MFD1",
		"size": [512, 512],
		"view": [768, 576],
		"mipmapping": 1
	});
	var mfd2Canvas = canvas.new({
		"name": "MFD1",
		"size": [512, 512],
		"view": [768, 576],
		"mipmapping": 1
	});

	mfd1Canvas.addPlacement({"node": "mfd1_screen"});
	mfd2Canvas.addPlacement({"node": "mfd2_screen"});
	MfdInstances[0] = MFD.new(mfd1Canvas.createGroup(), 0);
	MfdInstances[1] = MFD.new(mfd2Canvas.createGroup(), 0);

	removelistener(mfdListener);
});
