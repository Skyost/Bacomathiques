const IS_SVG_SUPPORTED = !!(document.createElementNS && document.createElementNS('http://www.w3.org/2000/svg', 'svg').createSVGRect);

const GRAPH_HEIGHT = 400;
const GRAPH_WIDTH = 600;

$(document).ready(function () {
	if(!IS_SVG_SUPPORTED) {
		if(LESSON_ID) {
			let i = 1;
			let representation = null;
			do {
				representation = $('#representation-' + i);
				representation.html(innerImage('assets/img/' + LESSON_ID, 'representation-' + (i++)));
			}
			while (representation.length > 0);
		}
	}

	if(typeof createPlots !== 'undefined' && $.isFunction(createPlots)) {
		createPlots(computeGraphDimension());
	}
});

$(window).resize(function () {
	if(typeof createPlots !== 'undefined' && $.isFunction(createPlots)) {
		createPlots(computeGraphDimension());
	}
});

function computeGraphDimension() {
	let height = GRAPH_HEIGHT;
	let width = GRAPH_WIDTH;

	let ratio = height / width;
	
	if($(window).width() < GRAPH_WIDTH + 200) {
		width = $(window).width() / 1.5;
		height = height * ratio;
	}
	
	return {
		height: height,
		width: width
	};
}

function innerImage(path, name) {
	return '<a href="' + path + name + '.png"><img src="' + path + name + '.png" title="' + name + '" alt="' + name + '"/></a>';
}