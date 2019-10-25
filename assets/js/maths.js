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
    let windowWidth = $(window).width();
    let scale = 1;
    if (windowWidth < 992) {
        scale = 2;
    }
    if (windowWidth < 768) {
        scale = 4;
    }

    return new GGBApplet({
        'id': materialId,
        'material_id': materialId,
        'showResetIcon': true,
        'enableLabelDrags': false,
        'scale': scale,
        'allowUpscale': true,
        'scaleContainerClass': 'plot',
        //'showZoomButtons': true,
        'preventFocus': true,
        'enableShiftDragZoom': true,
        'borderColor': 'rgba(0, 0, 0, 0.5)',
    }, true);
}