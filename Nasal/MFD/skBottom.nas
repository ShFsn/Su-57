var canvas_skBottom = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skBottom] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/skBottom.svg", {'font-mapper': font_mapper});

		var svg_keys = ["sk0","sk1","sk2","sk3","sk4","sk5","sk6"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		m.path = canvasGroup.createChild("path").setStrokeLineWidth(3).set("stroke", "rgba(0,255,0,1)");
		return m;
	},
	resetFrames: func()
	{
		me.path.reset();
	},
	drawRect: func(coordinates, padding=0)
	{
		me.path.moveTo(coordinates[0]-padding,coordinates[1])
			.lineTo(coordinates[2]+padding,coordinates[1])
			.lineTo(coordinates[2]+padding,coordinates[3]+padding+10)
			.lineTo(coordinates[0]-padding,coordinates[3]+padding+10)
			.lineTo(coordinates[0]-padding,coordinates[1]);
	},
	setSoftkeys: func(softkeys, selectedSoftkeys)
	{
		for(me.i = 0; me.i < 7; me.i+=1) {
			me["sk"~(me.i)].setText(softkeys[me.i]);

			if(selectedSoftkeys[me.i] == 1) {
				me.center = me["sk"~(me.i)].getCenter();
				me.bbox = me["sk"~(me.i)].getBoundingBox();

				me.drawRect([me.center[0]+me.bbox[0], me.center[1]+me.bbox[1],
							 me.center[0]+me.bbox[2], me.center[1]+me.bbox[3]], 5);
			}
		}
	}
};
