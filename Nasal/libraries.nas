parameters = {
    alpha:  "orientation/alpha-deg",
    alt:    "instrumentation/altimeter/indicated-altitude-ft",
    fuel:   "consumables/fuel/total-fuel-gal_us",
    gear:   "gear/gear[0]/position-norm",
    gload:  "fdm/jsbsim/accelerations/Nz",
    ias:    "velocities/airspeed-kt",
    power:  "fdm/jsbsim/electric/sources/dc-bus",
    pullUp: "instrumentation/mk-viii/outputs/discretes/gpws-warning",
};
foreach(var name; keys(parameters)) {
    parameters[name] = props.globals.getNode(parameters[name], 1);
}

# Generic System Libraries
var engineStart = func {
    if( getprop("fdm/jsbsim/electric/sources/ac-bus1") > 100 and
        getprop("fdm/jsbsim/electric/switches/select-mode") == 2 and
        getprop("fdm/jsbsim/pneumatics/sources/bus") > 0.5) {
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
    setprop("fdm/jsbsim/pneumatics/switches/master", 1);
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

var ap_heading = 0;
var ap_auto = 0;
var ap_pitch = 0;
var ap_altitude = 0;
var autopilot = func(input = 0) {
    if(parameters.power.getValue() > 17 and input > 0) {
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

# from Sidi Liang
var Sound = {
    new: func(filename, volume = 1, path=nil, queue="chatter") {
        var m = props.Node.new({
            path : path,
            file : filename,
            volume : volume,
            queue : queue
        });
        return m;
     },
};

var playAudio = func(file, audioVolume=1, audioPath="", queue="followme_fx") { #//Plays audio files in Aircrafts/Sounds
    if(!audioPath) audioPath = props.getNode("/",1).getValue("sim/aircraft-dir") ~ '/Sounds';
    props.getNode("/sim/sound", 1).getNode(queue, 1).getNode("enabled", 1).setValue("true");#//Enable the queue
    fgcommand("play-audio-sample", Sound.new(filename: file, volume: audioVolume, path: audioPath, queue: queue));
}

var aoa = 0;
var fuel = 0;
var ground = 0;
var speed = 0;

var EventHandler = func {
    if(parameters.power.getValue() > 17) {
        if(parameters.fuel.getValue()*3.6 < 1500) {
            if(fuel == 0) {
                screen.log.write("1500kg Fuel remaining", 1, 0.8, 0);
                playAudio("misc/warning.wav");
                playAudio("misc/1500kg.wav");
                fuel = 1500;
            }
        }
        else{
            fuel = 0;
        }

        if( parameters.ias.getValue() > 40 and
            parameters.alpha.getValue() > 6 and
            parameters.gload.getValue() > 3 and
            aoa == 0)
        {
            playAudio("misc/warning.wav");
            screen.log.write("Critical AOA and G-Load", 1, 0.8, 0);
            playAudio("misc/aoa.wav");
            playAudio("misc/g-load.wav");
            aoa = 7;
        }
        if(aoa > 0) {
            aoa -= 1;
        }

        if( parameters.ias.getValue() > 40 and
            parameters.alpha.getValue() > 12 and
            aoa == 0)
        {
            screen.log.write("Critical AOA", 1, 0.8, 0);
            playAudio("misc/warning.wav");
            playAudio("misc/aoa.wav");
            aoa = 7;
        }

        if( parameters.ias.getValue() > 650 and
            parameters.alt.getValue() < 9000 and
            speed == 0)
        {
            screen.log.write("Dangerous Speed", 1, 0.8, 0);
            playAudio("misc/warning.wav");
            playAudio("misc/speed.wav");
            speed = 7;
        }
        if(speed > 0) {
            speed -= 1;
        }

        if(parameters.pullUp.getValue() > 0 and ground == 0) {
            if(parameters.ias.getValue() > 250) {
                screen.log.write("Dangerous Altitude", 1, 0.8, 0);
                playAudio("misc/warning.wav");
                playAudio("misc/altitude.wav");
                ground = 7;
            }
            else if(parameters.gear.getValue() < 1) {
                screen.log.write("Extend Gear", 1, 0.8, 0);
                playAudio("misc/warning.wav");
                playAudio("misc/gear.wav");
                ground = 7;
            }
        }
        if(ground > 0) {
            ground -= 1;
        }
    }
}

var Timer = maketimer(1, EventHandler);
var eventListener = setlistener("sim/signals/fdm-initialized", func () {
    Timer.start();
    removelistener(eventListener);
});

#var prop = "payload/armament/fire-control";
#var actuator_fc = compat_failure_modes.set_unserviceable(prop);
#FailureMgr.add_failure_mode(prop, "Fire control", actuator_fc);
