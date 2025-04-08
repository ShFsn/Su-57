var PanelInstance = {};

var Power = props.globals.getNode("fdm/jsbsim/electric/output/hud", 1);
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
    }
};

var location = 0;
var input = 0;
var hudBtClick = func(x = 0, y = 0) {
    if(Power.getValue() > 20) {
        #print(x, " " , y);

        location = -1;
        if(y > 0.76) {
            location = 1;
        }
        if(y < 0.23) {
            location = 2;
        }

        input = -1;
        if(x < 0.085) {
            input = 0;
        }
        else if(x < 0.170) {
            input = 1;
        }
        else if(x < 0.255) {
            input = 2;
        }
        else if(x < 0.340) {
            input = 3;
        }
        else if(x > 0.915) {
            input = 7;
        }
        else if(x > 0.830) {
            input = 6;
        }
        else if(x > 0.745) {
            input = 5;
        }
        else if(x > 0.660) {
            input = 4;
        }

        if(location > -1 and input > -1) {
            #print(location, " ", input);
            HUDInstance.BtClick(location, input);
            #PanelInstance.BtClick(location, input);
        }
    }
}

var panelListener = setlistener("/sim/signals/fdm-initialized", func () {

    var panelCanvas = canvas.new({
        "name": "HUD.Display",
        "size": [512, 512],
        "view": [640, 256],
        "mipmapping": 1
    });
    panelCanvas.addPlacement({"node": "HUD.Display"});
    PanelInstance = Panel.new(panelCanvas.createGroup());

    removelistener(panelListener);
});
