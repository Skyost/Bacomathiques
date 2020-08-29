$(document).ready(createPlots);

/*$(window).resize(createPlots);*/

function createPlots() {
    $('.plot').each(function() {
        if (typeof GGBApplet === 'undefined') {
            let plot = $(this);
            let imageUrl = BASE_URL + '/assets/img/lessons/' + LEVEL + '/' + LESSON + "/" + plot.attr('id') + '.png';
            plot.html('<a href="' + imageUrl + '"><img src="' + imageUrl + '" title="' + plot.attr('id') + '" alt="' + plot.attr('id') + '"></a>');
        }
        else {
            createGeoGebraInstance($(this).attr('data-api-v2-geogebra-id')).inject($(this).attr('id'));
        }
    });
}

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