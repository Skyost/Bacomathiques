$(document).ready(function() {
	createPlots(computeDimension());
});

$(window).resize(function() {
	createPlots(computeDimension());
});

function createPlots(dimensions) {
	if(!canSVG) {
		$('#representation-1').html(innerImage('assets/img/fonction_logarithme', 'representation-1'));
		$('#representation-2').html(innerImage('assets/img/fonction_logarithme', 'representation-2'));
		return;
	}
	
	functionPlot({
		title: 'Le logarithme néperien',
		target: '#representation-1',
		grid: true,
		height: dimensions.height,
		width: dimensions.width,
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
		grid: true,
		height: dimensions.height,
		width: dimensions.width,
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
}