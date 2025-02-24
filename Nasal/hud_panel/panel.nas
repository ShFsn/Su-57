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
        else {
            me.Pages[me.ActivePage].btClick(location, input);
        }
    }
};

var hudBtClick = func(location = 0, input = -1) {
    if(Power.getValue() > 20) {
        HUDInstance.BtClick(location, input);
        PanelInstance.BtClick(location, input);
    }
}

var font_mapper = func(family, weight) {
    return "LiberationFonts/LiberationSans-Bold.ttf";
};

var load_texture = func {
    var panelTexture = canvas.new({
        "name": "HUD.Panel",
        "size": [1024, 1024],
        "view": [1024, 1024],
        "mipmapping": 1
    });
    panelTexture.addPlacement({"node": "Info"});
    panelTexture.addPlacement({"node": "BT.NAV"});
    panelTexture.addPlacement({"node": "BT.BVR_AG"});
    panelTexture.addPlacement({"node": "BT.WVR_AG"});
    panelTexture.addPlacement({"node": "BT.BVR_AA"});
    panelTexture.addPlacement({"node": "BT.WVR_AA"});
    panelTexture.addPlacement({"node": "BT.NVD"});
    panelTexture.addPlacement({"node": "BT.COM"});
    panelTexture.addPlacement({"node": "BT.IFF"});
    panelTexture.addPlacement({"node": "BT.GS"});
    panelTexture.addPlacement({"node": "BT.L1"});
    panelTexture.addPlacement({"node": "BT.L2"});
    panelTexture.addPlacement({"node": "BT.L3"});
    panelTexture.addPlacement({"node": "BT.R1"});
    panelTexture.addPlacement({"node": "BT.R2"});
    panelTexture.addPlacement({"node": "BT.R3"});
    panelTexture.addPlacement({"node": "BT.MVP"});
    panelTexture.addPlacement({"node": "BT.NM"});
    panelTexture.addPlacement({"node": "BT.GSV"});
    panelTexture.addPlacement({"node": "BT.Left"});
    panelTexture.addPlacement({"node": "BT.1Plus"});
    panelTexture.addPlacement({"node": "BT.2"});
    panelTexture.addPlacement({"node": "BT.3"});
    panelTexture.addPlacement({"node": "BT.4"});
    panelTexture.addPlacement({"node": "BT.5"});
    panelTexture.addPlacement({"node": "BT.Right"});
    panelTexture.addPlacement({"node": "BT.ARJA"});
    panelTexture.addPlacement({"node": "BT.CLR"});
    panelTexture.addPlacement({"node": "BT.6"});
    panelTexture.addPlacement({"node": "BT.7"});
    panelTexture.addPlacement({"node": "BT.8"});
    panelTexture.addPlacement({"node": "BT.9"});
    panelTexture.addPlacement({"node": "BT.0Minus"});
    panelTexture.addPlacement({"node": "BT.ENT"});
    panelTexture.addPlacement({"node": "BT.ACK"});
    canvas.parsesvg(panelTexture.createGroup(), "Aircraft/Su-57/Nasal/hud_panel/texture.svg", {'font-mapper': font_mapper});
}

var panelListener = setlistener("/sim/signals/fdm-initialized", func () {

    load_texture();

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
