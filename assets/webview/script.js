const CAN_SVG = !!(document.createElementNS && document.createElementNS('http://www.w3.org/2000/svg','svg').createSVGRect);
const BASE_URL = '{base_url}';
const PAGE_ID = '{page_id}';
const ANCHOR = '{anchor}';

window.onload = function(event) {
	var h2Index = 1;
	var h3Index = 1;

	var headings = document.querySelectorAll('h2, h3');
	for(var i = 0; i < headings.length; i++) {
		var title = headings[i];
		if(title.tagName == 'H3') {
			title.innerHTML = (h3Index++) + '. ' + title.innerHTML;
		}
		else {
			h3Index = 1;
			title.innerHTML = romanize(h2Index++) + ' - ' + title.innerHTML;
		}

		var baseId = urlify(title.textContent);

		var id = baseId;
		var index = 1;
		while(document.getElementById(id) != undefined) {
		    id = baseId + "-" + (index++);
		}

		title.id = id;
	}

	if(typeof ANCHOR !== 'undefined') {
	    location.hash = "#" + ANCHOR;
	}

	var images = document.getElementsByTagName('img');
	for(var i = 0; i < images.length; i++) {
		var image = images[i];
		image.src = BASE_URL + image.src.replace('http://localhost:8080/', '');
		if(!CAN_SVG) {
        	image.src = image.src.replace('.svg', '.png');
        }
        image.outerHTML = '<a href="' + image.src + '">' + image.outerHTML + '</a>';
	}

	var representations = document.querySelectorAll('[id^=representation-]');
	for(var i = 0; i < representations.length; i++) {
		var representation = representations[i];
		representation.innerHTML = '<a href="' + BASE_URL + 'assets/img/lessons/' + PAGE_ID + "/" + representation.id + '.png"><img src="' + BASE_URL + 'assets/img/lessons/' + PAGE_ID + "/" + representation.id + '.png" title="' + representation.id + '" alt="' + representation.id + '"/></a>';
	}
};

function romanize(num) {
	if(!+num) {
		return false;
	}
	var digits = String(+num).split(""),
		key = ["","C","CC","CCC","CD","D","DC","DCC","DCCC","CM",
				"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC",
				"","I","II","III","IV","V","VI","VII","VIII","IX"],
		roman = "",
		i = 3;
	while(i--) {
		roman = (key[+digits.pop() + (i * 10)] || "") + roman;
	}
	return Array(+digits.join("") + 1).join("M") + roman;
}

function urlify(text) {
	var nonsafeChars = /[& +$,:;=?@"#{}|^~[`%!'<>\]\.\/\(\)\*\\\n\t\b\v]/g;
	return text.trim()
           	    .replace(/\'/gi, '')
           		.replace(nonsafeChars, '-')
           		.replace(/-{2,}/g, '-')
           		.replace(/^-+|-+$/gm, '')
           		.toLowerCase();
}