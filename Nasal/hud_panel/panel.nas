var PanelInstance = {};

var Panel = {
    new: func(group) {
        var m = {parents:[Panel], Pages:{}};
        m.ActivePage = 0;
        m.OldPage = 0;

        m.Pages[0] = panel_nav.new(group.createChild('group'));
        m.Pages[1] = panel_radio.new(group.createChild('group'));
        m.Power = props.globals.getNode("fdm/jsbsim/electric/output/mfd", 1);

        m.ActivatePage(0);
        m.Timer = maketimer(0.05, m, m.Update);
        m.Timer.start();
        m.group = group;

        return m;
    },
    ActivatePage: func(input = -1)
    {
        me.OldPage = me.ActivePage;
        me.ActivePage = 0;
        for(var i=0; i < size(me.Pages); i=i+1) {
            if(i == input) {
                me.Pages[i].update();
                me.Pages[i].show();
                me.ActivePage = i;
            }
            else {
                me.Pages[i].hide();
            }
        }
    },
    Update: func()
    {
        me.Pages[me.ActivePage].update();
        me.group.show();
    },
    BtClick: func(location = 0, input = -1)
    {
        if(location == 0) {
            if(me.ActivePage == 0) {
                me.ActivatePage(me.OldPage);
            }
            else {
                me.ActivatePage(0);
            }
        }
        else {
        }
    }
};

var panelBtClick = func(location = 0, input = -1) {
    PanelInstance.BtClick(location, input);
}

var panelListener = setlistener("/sim/signals/fdm-initialized", func () {

	var panelCanvas = canvas.new({
		"name": "HUD.Display",
		"size": [512, 512],
		"view": [800, 480],
		"mipmapping": 1
	});

	panelCanvas.addPlacement({"node": "HUD.Display"});
	PanelInstance = Panel.new(panelCanvas.createGroup());

	removelistener(panelListener);
});
