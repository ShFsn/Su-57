var HUDInstance = {};

var HUD = {
    new: func(group, instance) {
        var m = {parents:[HUD], Pages:{}};
        m.Instance = instance;

        # HUD .ac coords: upper-left lower-right
        HudMath.init([-5.750,-0.078,0.717-0.35], [-5.750,0.082,0.557-0.35], [256,256], [0,1], [1,0], 0);

        m.Pages[0] = hud_nav.new(group.createChild('group'), instance);
        m.Power = props.globals.getNode("fdm/jsbsim/electric/output/hud", 1);
        m.Knob = props.globals.getNode("instrumentation/hud/knob", 1);
        m.HudMode = props.globals.getNode("instrumentation/hud/hud_mode", 1);
        m.TargetMode = props.globals.getNode("instrumentation/hud/target_mode", 1);

        m.ActivatePage(0);
        m.Timer = maketimer(0.05, m, m.Update);
        m.Timer.start();
        m.group = group;

        return m;
    },
    ActivatePage: func(input = -1)
    {
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
        if(me.Power.getValue() > 20) {
            me.Pages[me.ActivePage].update();
            me.group.show();
        }
        else {
            me.group.hide();
        }
    }
};

var hudListener = setlistener("sim/signals/fdm-initialized", func () {

    var hudCanvas = canvas.new({
        "name": "HUD.Screen",
        "size": [1024, 1024],
        "view": [256, 256],
        "mipmapping": 1
    });
    hudCanvas.addPlacement({"node": "HUD.Screen"});
    hudCanvas.set("additive-blend", 1);
    hudCanvas.setColorBackground(0, 0, 0, 0);
    HUDInstance = HUD.new(hudCanvas.createGroup(), 0);
    removelistener(hudListener);
});
