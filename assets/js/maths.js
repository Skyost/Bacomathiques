var graphHeight = 400;
var graphWidth = 600;

$(document).ready(function() {
	MathJax.Hub.Config({
		tex2jax: {
			inlineMath: [
				['$','$'],
				['\\(','\\)']
			]
		},
		'HTML-CSS': {
			scale: 90,
			webFont: 'Asana-Math',
			preferredFont: 'Asana-Math', 
			availableFonts: [
				'Asana-Math',
				'TeX'
			], 
			extensions: ['handle-floats.js']
		},
		messageStyle: 'none',
		showMathMenu: false
	});
});

function computeDimension() {
	var height = graphHeight;
	var width = graphWidth;
	
	var ratio = height / width;
	
	if($(window).width() < 800) {
		width = $(window).width() / 1.5;
		height = height * ratio;
	}
	
	return {
		height: height,
		width: width
	};
}