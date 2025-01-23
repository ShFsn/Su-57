# Generic System Libraries
var engineStart = func {
    if(getprop("fdm/jsbsim/electric/sources/ac-bus") > 100 and
    getprop("fdm/jsbsim/electric/switches/select-mode") == 2) {
        if(getprop("fdm/jsbsim/electric/switches/select-engine") == 0) {
            setprop("controls/engines/engine[0]/starter", 1);
        }
        if(getprop("fdm/jsbsim/electric/switches/select-engine") == 2) {
            setprop("controls/engines/engine[1]/starter", 1);
        }
    }
}

var autostart = func {
    setprop("fdm/jsbsim/electric/switches/battery1", 1);
    setprop("fdm/jsbsim/electric/switches/battery2", 1);
    setprop("fdm/jsbsim/electric/switches/apu", 1);
    setprop("fdm/jsbsim/electric/switches/apu-gen", 1);
    setprop("controls/engines/engine[0]/starter", "true");
    setprop("controls/engines/engine[1]/starter", "true");
    settimer(func {
        setprop("controls/engines/engine[0]/cutoff", "false");
        setprop("controls/engines/engine[1]/cutoff", "false");
        setprop("fdm/jsbsim/electric/switches/hud", 1);
        setprop("fdm/jsbsim/electric/switches/ac1-gen", 1);
        setprop("fdm/jsbsim/electric/switches/ac2-gen", 1);
    }, 5);
    settimer(func {
        setprop("fdm/jsbsim/electric/switches/apu-gen", 0);
        setprop("fdm/jsbsim/electric/switches/apu", 0);
    }, 25);
}

#var prop = "payload/armament/fire-control";
#var actuator_fc = compat_failure_modes.set_unserviceable(prop);
#FailureMgr.add_failure_mode(prop, "Fire control", actuator_fc);
