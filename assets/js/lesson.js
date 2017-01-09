$(document).ready(function() {	
	var h2Index = 1;
	var h3Index = 1;
	$('article h2, article h3').each(function() {
		var title = $(this);
		if(title.prop('tagName') == 'H3') {
			title.text((h3Index++) + '. ' + title.text());
		}
		else {
			h3Index = 1;
			title.text(romanize(h2Index++) + ' - ' + title.text());
		}
	});

	$('#nav-toc-contents').toc({
		selectors: 'h2,h3',
		container: 'article'
	});
	$('#nav-toc-contents ul').addClass('dropdown-menu');
	
	var exportTitle = $($('h1').get(0)).text();
	$('#export-pdf').click(function() {
		window.open('/assets/pdf/lessons/' + exportTitle + '.pdf', '_blank', '');
	});
	$('#export-print').click(function() {
		$('article').print({
			title: exportTitle
		});
	});
});

/**
* Found here : http://stackoverflow.com/a/9083076/3608831.
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