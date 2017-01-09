$(document).ready(function() {
	var searchTerm = getQueryVariable('keywords');
	if(!searchTerm) {
		displaySearchResults(0, 0);
		return;
	}
	var idx = lunr(function() {
		this.field('id');
		this.field('title', {
			boost: 10
		});
		this.field('excerpt');
		this.field('content');
	});

	for(var page in pages) { // Add the data to lunr
		idx.add({
			'id': page,
			'title': pages[page].title,
			'excerpt': pages[page].excerpt,
			'content': pages[page].content
		});

		var results = idx.search(searchTerm); // Get lunr to perform a search
		displaySearchResults(results, pages);
	}
});

/**
* Extracts a variable from the url.
*/

function getQueryVariable(variable) {
	var query = window.location.search.substring(1);
	var vars = query.split('&');

	for(var i = 0; i < vars.length; i++) {
		var pair = vars[i].split('=');

		if(pair[0] === variable) {
			return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
		}
	}
}

/**
* Displays the search results on the page.
*/

function displaySearchResults(results, pages) {
	var searchResults = $('article ul');

	if(results.length) { // Are there any results?
		var appendString = '';

		for(var i = 0; i < results.length; i++) {	// Iterate over the results
			var item = pages[results[i].ref];
			appendString += '<li><a href="' + item.url + '"><h3>' + item.title + '</h3></a>';
			appendString += '<p>' + item.excerpt + '</p></li>';
		}

		searchResults.html(appendString);
	}
	else {
		searchResults.html('<li>Aucun résultat.</li>');
	}
	$('.glyphicon-refresh').css('display', 'none');
	searchResults.css('display', '');
}