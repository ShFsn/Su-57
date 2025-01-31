var ap_heading = 0;
var ap_auto = 0;
var ap_pitch = 0;
var ap_altitude = 0;

# Generic System Libraries
var engineStart = func {
    if(getprop("fdm/jsbsim/electric/sources/ac-bus1") > 100 and
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
    setprop("fdm/jsbsim/electric/switches/fms", 1);
    setprop("fdm/jsbsim/electric/switches/apu", 1);
    setprop("fdm/jsbsim/electric/switches/apu-gen", 1);
    setprop("controls/engines/engine[0]/starter", "true");
    setprop("controls/engines/engine[1]/starter", "true");
    settimer(func {
        setprop("controls/engines/engine[0]/cutoff", "false");
        setprop("controls/engines/engine[1]/cutoff", "false");
        setprop("fdm/jsbsim/electric/switches/hud", 1);
        setprop("fdm/jsbsim/electric/switches/ac-gen1", 1);
        setprop("fdm/jsbsim/electric/switches/ac-gen2", 1);
    }, 5);
    settimer(func {
        setprop("fdm/jsbsim/electric/switches/apu-gen", 0);
        setprop("fdm/jsbsim/electric/switches/apu", 0);
    }, 25);
}

var autopilot = func(input = 0) {
    if(getprop("fdm/jsbsim/electric/sources/dc-bus") > 17 and input > 0) {
        if(input == 1) {
            if(ap_heading > 0) {
                setprop("autopilot/locks/heading", "");
                ap_heading = 0;
            }
            else {
                setprop("autopilot/locks/heading", "wing-leveler");
                ap_heading = 1;
            }
        }
        if(input == 3) {
            if(ap_altitude > 0) {
                setprop("autopilot/locks/altitude", "");
                ap_altitude = 0;
            }
            else {
                setprop("autopilot/locks/altitude", "vertical-speed-hold");
                setprop("autopilot/settings/vertical-speed-fpm", 0);
                ap_altitude = 1;
            }
        }
    }
    else {
        setprop("autopilot/locks/heading", "");
        setprop("autopilot/locks/altitude", "");
        ap_heading = 0;
        ap_altitude = 0;
    }

    setprop("sim/gui/dialogs/autopilot/heading-active", ap_heading);
    setprop("sim/gui/dialogs/autopilot/altitude-active", ap_altitude);
}

#var prop = "payload/armament/fire-control";
#var actuator_fc = compat_failure_modes.set_unserviceable(prop);
#FailureMgr.add_failure_mode(prop, "Fire control", actuator_fc);
