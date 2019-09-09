$(document).ready(function() {
    $('#lessons-list .btn').click(function() {
        $('#lessons-list .btn').removeClass('active');
        $('#lessons-list ul').addClass('d-none');
        $('#lessons-list-' + $(this).attr('data-level')).removeClass('d-none');
        $(this).addClass('active');
    });
    $('#lessons-list .btn[data-level="terminale"]').click();
});