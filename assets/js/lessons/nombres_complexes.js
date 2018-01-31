$(document).ready(function() {
	createPlots(computeDimension());
});

$(window).resize(function() {
	createPlots(computeDimension());
});

function createPlots(dimensions) {
	if(!canSVG) {
		$('#representation-1').html(innerImage('assets/img/nombres_complexes', 'representation-1'));
		$('#representation-2').html(innerImage('assets/img/nombres_complexes', 'representation-2'));
		return;
	}
	
	functionPlot({
		title: 'Représentation de z',
		target: '#representation-1',
		grid: true,
		height: dimensions.height,
		width: dimensions.width,
		data: [
			{
				points: [
					[1, 1]
				],
				fnType: 'points',
				graphType: 'scatter'
			},
			{
				title: 'M(1; 1)',
				fn: '1',
				range: [1, 1]
			}
		]
	});
	
	functionPlot({
		title: 'Représentation de z\'',
		target: '#representation-2',
		grid: true,
		height: dimensions.height,
		width: dimensions.width,
		data: [
			{
				fn: 'x * x + y * y - 2',
				fnType: 'implicit'
			},
			{
				points: [
					[1, 1]
				],
				fnType: 'points',
				graphType: 'scatter'
			},
			{
				title: 'Module de z\'',
				fn: 'x',
				range: [0, 1]
			},
			{
				title: 'M(1; 1)',
				fn: '1',
				range: [1, 1]
			}
		]
	});
}