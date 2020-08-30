$(document).ready(function () {
    let width = $(window).width();
    let threshold = width <= 768 ? 0.1 : 0.5;
    sal({
        threshold: threshold,
    });
});