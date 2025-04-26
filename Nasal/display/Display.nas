var DisplayInstance = {};

var displayListener = 0;

var canvas_display = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_display] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};

		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/display/Display.svg", {'font-mapper': font_mapper});
		var svg_keys = ["horizon", "aircraft"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.h_trans = m.horizon.createTransform();
		m.horizon.set("clip", "rect(40, 500, 445, 140)");# top,right,bottom,left

		m.pitch = props.globals.getNode("orientation/pitch-deg");
		m.roll = props.globals.getNode("orientation/roll-deg");
		
		m.group = canvasGroup;
		m.Timer = maketimer(0.1, m, m.update);
		m.Timer.start();
		return m;
	},
	update: func()
	{
		me.h_trans.setTranslation(0, me.pitch.getValue()*10.5);
		me.aircraft.setRotation(me.roll.getValue()*D2R);
	}
};

displayListener = setlistener("/sim/signals/fdm-initialized", func () {

	var displayCanvas = canvas.new({
		"name": "Display",
		"size": [512, 512],
		"view": [640, 480],
		"mipmapping": 1
	});

	displayCanvas.addPlacement({"node": "Display.Screen"});
	DisplayInstance = canvas_display.new(displayCanvas.createGroup());

	removelistener(displayListener);
});
