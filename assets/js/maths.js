var canSVG = !!(document.createElementNS && document.createElementNS('http://www.w3.org/2000/svg','svg').createSVGRect);

var graphHeight = 400;
var graphWidth = 600;

function computeDimension() {
	var height = graphHeight;
	var width = graphWidth;
	
	var ratio = height / width;
	
	if($(window).width() < graphWidth + 200) {
		width = $(window).width() / 1.5;
		height = height * ratio;
	}
	
	return {
		height: height,
		width: width
	};
}

function innerImage(path, name) {
	return '<img src="' + path + name + '.png" title="' + name + '" alt="' + name + '"/>';
}