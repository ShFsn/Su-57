var PanelInstance = {};

var PageEnum = {
    COM:    0,
    NAV:    1,
    WPN:    2,
};

var Panel = {
    new: func(group) {
        var m = {parents:[Panel], Pages:{}};
        m.ActivePage = 0;
        m.OldPage = 0;

        m.Pages[PageEnum.COM] = panel_radio.new(group.createChild('group'));
        m.Pages[PageEnum.NAV] = panel_nav.new(group.createChild('group'));
        m.Pages[PageEnum.WPN] = panel_wpn.new(group.createChild('group'));
        m.Power = props.globals.getNode("fdm/jsbsim/electric/output/mfd", 1);

        m.ActivatePage(PageEnum.NAV);
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
    BtClick: func(location, input)
    {
        if(location == 1) {
            if(input == 0) {
                me.ActivatePage(PageEnum.NAV);
            }
            else {
                me.Pages[PageEnum.WPN].setMode(input);
                me.ActivatePage(PageEnum.WPN);
            }
        }
        if(location == 2) {
            if(input == 0) {
                me.ActivatePage(PageEnum.COM);
            }
            else {
                me.Pages[me.ActivePage].btClick(location, input);
            }
        }
    }
};

var hudBtClick = func(location = 0, input = -1) {
    HUDInstance.BtClick(location, input);
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
