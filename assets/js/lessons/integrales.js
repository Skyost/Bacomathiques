$(document).ready(function() {
	functionPlot({
		title: 'L\'Unité d\'Aire (U.A.)',
		target: '#representation-1',
		grid: true,
		data: [
			{
				fn: '1',
				range: [0, 1],
				closed: true
			}
		]
	});
	
	functionPlot({
		title: 'Intégrale sur [-2;2] de x²+x-2',
		target: '#representation-2',
		grid: true,
		data: [
			{
				title: 'x^2+x-2',
				fn: 'x^2+x-2',
				range: [-2, 2],
				closed: true
			},
			{
				title: 'x^2+x-2',
				fn: 'x^2+x-2'
			}
		]
	});
	
	functionPlot({
		title: 'Intégrale positive',
		target: '#representation-3',
		grid: true,
		data: [
			{
				title: 'x',
				fn: 'x',
				range: [0, 2],
				closed: true
			},
			{
				title: 'x',
				fn: 'x'
			}
		]
	});
	
	functionPlot({
		title: 'Intégrale négative',
		target: '#representation-4',
		grid: true,
		data: [
			{
				title: 'x',
				fn: 'x',
				range: [-2, 0],
				closed: true
			},
			{
				title: 'x',
				fn: 'x'
			}
		]
	});
});