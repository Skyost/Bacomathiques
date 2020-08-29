let searchInput = $('#page-navbar input');
searchInput.keyup(handleChange);
searchInput.on('search', handleChange);

function handleChange() {
    let items = $('.lesson-item');
    let value = $(this).val();
    if(typeof value === 'undefined') {
        value = '';
    }

    value = value.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, '');
    items.each(function() {
        let item = $(this);
        if(item.attr('data-search').indexOf(value) === -1) {
            item.addClass('d-none');
        }
        else {
            item.removeClass('d-none');
        }
    });

    $('#page-navbar .dropdown-header').each(function() {
        let header = $(this);
        if(header.attr('data-size') - $('.lesson-item[data-level="' + header.attr('data-level') + '"].d-none').length === 0) {
            header.addClass('d-none');
        }
        else {
            header.removeClass('d-none')
        }
    });
}

$(window).on('load', function() {
    let navbar = $('#page-navbar');

    let height = navbar.outerHeight(true);
    navbar.addClass('shrinked');
    let shrinkedHeight = navbar.outerHeight(true);
    navbar.removeClass('shrinked');

    let spacer = $('<div></div>');
    spacer.attr('id', 'page-navbar-spacer');
    spacer.css('height', height);

    $('body').prepend(spacer);

    $(document).scrollTop(Math.max($(document).scrollTop() - height, 0));

    let difference = height - shrinkedHeight;
    $(window).scroll(function() {
        navbar.toggleClass('shrinked', $(document).scrollTop() > difference);
    });
});

