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