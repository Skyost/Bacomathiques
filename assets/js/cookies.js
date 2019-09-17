$(document).ready(function() {
	if(readCookie('cookie_consent') === null) {
		showCookieBanner();
	}
});

function showCookieBanner() {
	let html = '<div id="cookie-banner" style="position: fixed; bottom: 0; left: 0; right: 0; background-color: #2c3e50; text-align: center; padding: 20px;">';
	html += '<p style="color: white;">🍪 Ce site web utilise des cookies. En continuant la navigation, vous consentez à l\'utilisation des cookies nécessaires au bon fonctionnement du site et au suivi statistique anonyme.</p>';
	html += '<button type="button" class="btn btn-success" onclick="hideCookieBanner();">Fermer ce message</button>';
	html += '</div>';
	$('body').append($(html));
}

function hideCookieBanner() {
	$('#cookie-banner').remove();
	createCookie('cookie_consent', true, 1461);
}

function createCookie(name, value, days) {
	let expires = '';
	if(days) {
		let date = new Date();
		date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
		expires = "; expires=" + date.toGMTString();
	}

	document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    let nameEQ = name + "=";
    let ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}