var ndlayers = [{name:'APT',style:{scale_factor:0.3,label_font_color:[0,1,0],color_default:[0,1,0],line_width:3}},
		{name:'WPT',style:{scale_factor:0.3,color:[0,1,0]}},
		{name:'RTE',style:{scale_factor:0.3,color:[0,1,0],line_width:1}}];

var canvas_to = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_to] };
		m.map = canvasGroup.createChild('map');

		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/to.svg", {'font-mapper': font_mapper});

		var ctrl_ns = canvas.Map.Controller.get("Aircraft position");
		var source = ctrl_ns.SOURCES["to-map"];
		if (source == nil) {
			var source = ctrl_ns.SOURCES["to-map"] = {
			getPosition: func subvec(geo.aircraft_position().latlon(), 0, 2),
			getAltitude: func getprop('/position/altitude-ft'),
			getHeading:  func { 0 },
			aircraft_heading: 1,
			};
		}

		m.map.setRange(50);
		m.map.setTranslation(768, 256);
		m.map.setController("Aircraft position");

		foreach(var layer; ndlayers) {
			m.map.addLayer(
				factory: canvas.SymbolLayer,
				type_arg: layer.name,
				visible: 1,
				style: layer.style,
				priority: layer['z-index']
			);
		}
		m.group = canvasGroup;
		return m;
	},
	show: func()
	{
		me.group.show();
	},
	hide: func()
	{
		me.group.hide();
	}
};
