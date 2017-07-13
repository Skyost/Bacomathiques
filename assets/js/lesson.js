$(document).ready(function() {
	// TITLE NUMBERING
	
	var h2Index = 1;
	var h3Index = 1;
	$('article h2, article h3').each(function() {
		var title = $(this);
		if(title.prop('tagName') == 'H3') {
			title.html((h3Index++) + '. ' + title.html());
		}
		else {
			h3Index = 1;
			title.html(romanize(h2Index++) + ' - ' + title.html());
		}
	});
	
	// ANCHORS
	
	anchors.add();
	
	if(window.location.hash.length > 0) {
		goToHash(undefined, window.location.hash);
	}
	
	$('a[href*=\\#]').on('click', function(event) {
		goToHash(event, this.hash);
	});
	
	// TABLE OF CONTENTS

	var menu = $('#nav-toc');
	menu.toc({
		selectors: 'h2,h3',
		container: 'article'
	});
	menu.html($('.nav .dropdown-menu ul').html());
	$('#nav-toc ul').addClass('hidden-md-down no-style');
	
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
	
	var backToTop = $('#back-to-top');
	
	$(window).scroll(function() {
		if($(this).scrollTop() > 50) {
			backToTop.fadeIn();
		}
		else {
			backToTop.fadeOut();
		}
	});

	backToTop.click(function() {
		$('body, html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});
	backToTop.tooltip();
	
	// NAVBAR
	
	var navigation = $('#nav-toc ul');
	navigation.css('max-width', navigation.width());
	$(window).scroll(function() {
		if(navigation.height() > $(window).height()) {
			resetPosition(navigation);
			return;
		}
		if($(window).width() < 768) {
			resetPosition(navigation);
			return;
		}
		if($('#navbar').is(':in-viewport')) {
			resetPosition(navigation);
		}
		else {
			navigation.css('position', 'fixed');
			navigation.css('top', '50%');
			navigation.css('transform', 'translateY(-50%)');
		}
	});
	
	$(window).resize(function() {
		if(navigation.height() > $(window).height()) {
			resetPosition(navigation);
			return;
		}
		if($(window).width() < 768) {
			resetPosition(navigation);
			return;
		}
	});
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

/**
* Found here : https://stackoverflow.com/a/18365991/3608831
*/

function goToHash(event, hash) {
	if(hash.length == 0) {
		return;
	}
	var jqueryHash = $(hash);
	if(!jqueryHash.length) {
		return;
	}
	if(!typeof event === 'undefined') {
		event.preventDefault();
	}
	$('html, body').animate({
		scrollTop: jqueryHash.offset().top
	}, 500);
	if(history.pushState) {
		history.pushState(null, null, hash);
	}
	else {
		location.hash = hash;
	}
}

function resetPosition(navigation) {
	navigation.css('position', '');
	navigation.css('top', '');
	navigation.css('transform', '');
}