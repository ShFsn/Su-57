var panel_nav = {
	new: func(canvasGroup)
	{
		var m = { parents: [panel_nav, panel_base.new(canvasGroup)] };
		m.HL.setText("01").setColor(0,1,0);
		m.HC.setText("НВГ");
		m.HR.setText("Р ЗЕМ");

		m.L1L.setText("14 XXX").setColor(0,1,0);
		m.L1C.setText("МРШ01");
		m.L1R.setText("753.0").setColor(0,1,0);

		m.L2L.setText("029°/9999КМ").setColor(0,1,0);
		m.L2C.setText("");
		m.L2R.setText("МТУ");

		m.L3L.setText("Gp   0КГ");
		m.L3C.setText("");
		m.L3R.setText("ПУТ").setColor(0,1,0);

		m.L4L.setText("");
		m.L4C.setText("");
		m.L4R.setText("");

		m.L5L.setText("");
		m.L5C.setText("");
		m.L5R.setText("---->").setColor(0,1,0);

		m.path1.hide();
		return m;
	},
	update: func()
	{
	}
};
