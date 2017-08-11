$(document).ready(function() {
	$('.preview').lazy({
		effect: 'fadeIn',
		effectTime: 700
	});
	
	$('.card-header').matchHeight();
	$('.card-body').matchHeight();
});