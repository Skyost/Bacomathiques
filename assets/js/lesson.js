$(document).ready(function() {
	// TABLE OF CONTENTS
	
	var h2Index = 1;
	var h3Index = 1;
	$('article h2, article h3').each(function() {
		var title = $(this);
		if(title.prop('tagName') == 'H3') {
			title.html((h3Index++) + '. ' + title.html() + ' ' + '<a class="anchor" href="#' + $(this).attr('id') + '"></a>');
		}
		else {
			h3Index = 1;
			title.html(romanize(h2Index++) + ' - ' + title.html() + ' ' + '<a class="anchor" href="#' + $(this).attr('id') + '"></a>');
		}
	});

	var menu = $('.nav .dropdown-menu');
	menu.toc({
		selectors: 'h2,h3',
		container: 'article'
	});
	menu.html($('.nav .dropdown-menu ul').html());
	
	// EXPORT SETTINGS
	
	var exportTitle = $($('h1').get(0)).text();
	$('#export-pdf').click(function() {
		pdfFile = replaceAll(replaceAll(exportTitle, 'é', 'e'), 'É', 'E')
		window.open('/assets/pdf/lessons/' + encodeURI(pdfFile) + '.pdf', '_blank', '');
	});
	$('#export-print').click(function() {
		$('article').print({
			title: exportTitle
		});
	});
	
	// BACK TO TOP BUTTON
	
	$(window).scroll(function() {
		if($(this).scrollTop() > 50) {
			$('#back-to-top').fadeIn();
		}
		else {
			$('#back-to-top').fadeOut();
		}
	});
	// scroll body to 0px on click
	$('#back-to-top').click(function() {
		$('#back-to-top').tooltip('hide');
		$('body, html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});
	
	$('#back-to-top').tooltip('show');
	
	// ANCHORS NEXT TO H2 & H3
});

/**
* Found here : http://stackoverflow.com/a/9083076/3608831
*/
function romanize(num) {
	if(!+num)
		return false;
	var digits = String(+num).split(""),
		key = ["","C","CC","CCC","CD","D","DC","DCC","DCCC","CM",
				"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC",
				"","I","II","III","IV","V","VI","VII","VIII","IX"],
		roman = "",
		i = 3;
	while(i--)
		roman = (key[+digits.pop() + (i * 10)] || "") + roman;
	return Array(+digits.join("") + 1).join("M") + roman;
}

/**
* Found here : http://stackoverflow.com/a/1144788/3608831
*/
function replaceAll(str, find, replace) {
	return str.replace(new RegExp(find, 'g'), replace);
}