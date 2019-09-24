$(document).ready(function () {
    if (typeof createPlots !== 'undefined' && $.isFunction(createPlots)) {
        createPlots();
    }
});

/*$(window).resize(function () {
    if (typeof createPlots !== 'undefined' && $.isFunction(createPlots)) {
        createPlots();
    }
});*/

function createGeoGebraInstance(materialId) {
	return new GGBApplet({
        'id': materialId,
        'material_id': materialId,
        'showResetIcon': true,
        'enableLabelDrags': false,
        //'showZoomButtons': true,
        'scaleContainerClass': 'plot',
        'preventFocus': true,
        'enableShiftDragZoom': true,
        'borderColor': 'rgba(0, 0, 0, 0.5)',
	}, true);
}