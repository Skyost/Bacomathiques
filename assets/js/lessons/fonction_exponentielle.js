$(document).ready(function() {
	functionPlot({
		title: 'La fonction exponentielle',
		target: '#representation-1',
		disableZoom: true,
		grid: true,
		data: [
			{
				title: 'exp(x)',
				fn: 'exp(x)'
			},
			{
				title: 'y = x + 1',
				fn: 'x + 1'
			}
		]
	});
});