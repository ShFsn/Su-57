var canvas_overlay = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_overlay] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "Helvetica.txf";
			}
		};
		
		canvas.parsesvg(canvasGroup, "Aircraft/Su-57/Nasal/MFD/overlay.svg", {'font-mapper': font_mapper});

		var svg_keys = ["sk0","sk1","sk2","sk3","sk4","sk5","sk6","sk7","sk8","sk9"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}
		return m;
	},
	setSoftkeys: func(softkeys, selectedSoftkeys)
	{
		for(me.tmp1 = 0; me.tmp1 < 10; me.tmp1+=1) {
			if(selectedSoftkeys[me.tmp1] == 1) {
				me["sk"~(me.tmp1)].setText(softkeys[me.tmp1]).setColor(0,0,0).setColorFill(0,255,0);
			}
			else {
				me["sk"~(me.tmp1)].setText(softkeys[me.tmp1]).setColor(0,255,0).setColorFill(0,0,0);
			}
		}
	}
};
