var canvas_skTop = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_skTop] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/skTop.svg", {'font-mapper': font_mapper});

		var svg_keys = ["sk0","sk1","sk2","sk3","sk4","sk5","sk6"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		return m;
	},
	setSoftkeys: func(softkeys, selectedSoftkeys)
	{
		for(me.tmp1 = 0; me.tmp1 < 7; me.tmp1+=1) {
			if(selectedSoftkeys[me.tmp1] == 1) {
				me["sk"~(me.tmp1)].setText(softkeys[me.tmp1]).setColor(0,0,0).setColorFill(0,255,0);
			}
			else {
				me["sk"~(me.tmp1)].setText(softkeys[me.tmp1]).setColor(0,255,0).setColorFill(0,0,0);
			}
		}
	}
};
