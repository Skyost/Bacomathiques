const GRAPH_HEIGHT = 400;
const GRAPH_WIDTH = 600;

$(document).ready(function () {
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