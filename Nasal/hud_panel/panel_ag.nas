var panel_ag = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_ag, panel_base.new(canvasGroup)] };

		m.L1A.setText("");
		m.L1B.setText("В-П");
		m.L1C.setText("");

		m.L2A.setText("");
		m.L2B.setText("АСП НЕ ВЫБРАНО К РАБОТЕ");
		m.L2C.setText("");

		m.L3A.setText("");
		m.L3B.setText("");
		m.L3C.setText("");
		m.L3D.setText("");

		m.L4A.setText("< - - - -");
		m.L4B.setText("");
		m.L4C.setText("");
		m.L4D.setText("- - - - >");

		m.L5A.setText("");
		m.L5B.setText("");
		m.L5C.setText("");
		m.L5D.setText("");

		m.L6A.setText("");
		m.L6B.setText("");
		m.L6C.setText("");
		m.L6D.setText("");

		m.path1.hide();
		return m;
	},
	update: func()
	{
	}
};
