$(document).ready(function() {
	let searchTerm = getQueryVariable('keywords');
	if(!searchTerm) {
		$('#keywords').text('vide');
		displaySearchResults(0, 0);
		return;
	}
	$('#keywords').text(searchTerm);
	let idx = lunr(function() {
		this.field('id');
		this.field('title', {
			boost: 10
		});
		this.field('excerpt');
		this.field('content');
		
		for(let page in pages) {
			this.add({
				'id': page,
				'title': pages[page].title,
				'excerpt': pages[page].excerpt,
				'content': pages[page].content
			});
		}
	});
	let results = idx.search(searchTerm);
	displaySearchResults(results, pages);
});

/**
* Extracts a variable from the url.
*/

function getQueryVariable(variable) {
	let query = window.location.search.substring(1);
	let vars = query.split('&');

	for(let i = 0; i < vars.length; i++) {
		let pair = vars[i].split('=');

		if(pair[0] === variable) {
			return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
		}
	}
}

/**
* Displays the search results on the page.
*/

function displaySearchResults(results, pages) {
	let searchResults = $('article .row');

	if(results.length) {
		$('#numbers').text(results.length);
		let appendString = '';

		for(let i = 0; i < results.length; i++) {
			let item = pages[results[i].ref];
			appendString += '<div class="col-xs-12 col-md-6 col-lg-4">';
			appendString += '<div class="card bg-light">';
			appendString += '<div class="card-header d-flex align-items-center"><h2 class="w-100">' + item.title + '</h2></div>';
			appendString += '<div class="card-body">';
			appendString += '<p class="card-text">' + item.excerpt + '</p>';
			appendString += '<a href="' + item.url + '" class="btn btn-primary pull-right">Lien vers la page <i class="fa fa-arrow-right" aria-hidden="true"></i></a>';
			appendString += '</div>';
			appendString += '</div>';
			appendString += '</div>';
		}

		searchResults.html(appendString);
		searchResults.removeClass('d-none');
		
		$('.card-header').matchHeight();
		$('.card-text').matchHeight();
	}
	$('.fa-spinner').addClass('d-none');
}