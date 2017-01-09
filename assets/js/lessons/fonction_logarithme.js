$(document).ready(function() {
	functionPlot({
		title: 'Le logarithme néperien',
		target: '#representation-1',
		disableZoom: true,
		grid: true,
		data: [
			{
				title: 'ln(x)',
				fn: 'log(x)'
			}
		]
	});
	
	functionPlot({
		title: 'Relation de symétrie',
		target: '#representation-2',
		disableZoom: true,
		grid: true,
		data: [
			{
				title: 'exp(x)',
				fn: 'exp(x)'
			},
			{
				title: 'x',
				fn: 'x'
			},
			{
				title: 'ln(x)',
				fn: 'log(x)'
			}
		]
	});
});