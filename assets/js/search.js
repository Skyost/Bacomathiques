$(document).ready(function() {
	var searchTerm = getQueryVariable('keywords');
	if(!searchTerm) {
		$('#keywords').text('vide');
		displaySearchResults(0, 0);
		return;
	}
	$('#keywords').text(searchTerm);
	var idx = lunr(function() {
		this.field('id');
		this.field('title', {
			boost: 10
		});
		this.field('excerpt');
		this.field('content');
		
		for(var page in pages) {
			this.add({
				'id': page,
				'title': pages[page].title,
				'excerpt': pages[page].excerpt,
				'content': pages[page].content
			});
		}
	});
	var results = idx.search(searchTerm);
	displaySearchResults(results, pages);
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
	var searchResults = $('article .row');

	if(results.length) {
		$('#numbers').text(results.length);
		var appendString = '';

		for(var i = 0; i < results.length; i++) {
			var item = pages[results[i].ref];
			appendString += '<div class="col-xs-12 col-sm-6 col-md-4">';
			appendString += '<div class="card">';
			appendString += '<div class="card-block">';
			appendString += '<h2>' + item.title + '</h2>';
			appendString += '<p class="card-text">' + item.excerpt + '</p>';
			appendString += '<a href="' + item.url + '" class="btn btn-primary">Lien vers la page</a>';
			appendString += '</div>';
			appendString += '</div>';
			appendString += '</div>';
		}

		searchResults.html(appendString);
		searchResults.css('display', '');
		
		$('.card-block h2').matchHeight();
		$('.card-text').matchHeight();
	}
	$('.fa-spinner').css('display', 'none');
}