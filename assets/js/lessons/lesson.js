$(document).ready(function () {
    // TITLE NUMBERING

    let h2Index = 1;
    let h3Index = 1;
    $('article h2, article h3').each(function () {
        let title = $(this);
        if (title.prop('tagName') === 'H3') {
            title.html((h3Index++) + '. ' + title.html());
        } else {
            h3Index = 1;
            title.html(romanize(h2Index++) + ' - ' + title.html());
        }
    });

    // ANCHORS

    anchors.add('article h2, article h3');

    if (window.location.hash.length > 0) {
        goToHash(undefined, decodeURI(window.location.hash));
    }

    $('a[href*=\\#]').on('click', function (event) {
        goToHash(event, decodeURI(this.hash));
    });

    // TABLE OF CONTENTS

    tocbot.init({
        tocSelector: '#nav-toc',
        contentSelector: 'article',
        headingSelector: 'h2, h3',
        extraListClasses: 'no-style'
    });

    // EXPORT SETTINGS

    let exportTitle = $($('h1').get(0)).text();
    $('#export-pdf').click(function () {
        let pdfFile = replaceAll(replaceAll(exportTitle, 'é', 'e'), 'É', 'E');
        window.open('/assets/pdf/lessons/' + encodeURI(pdfFile) + '.pdf', '_blank', '');
    });
    $('#export-print').click(function () {
        $('article').print({
            title: exportTitle
        });
    });

    // BACK TO TOP BUTTON

    let backToTop = $('#back-to-top');

    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            backToTop.fadeIn();
        } else {
            backToTop.fadeOut();
        }
    });

    backToTop.click(function () {
        $('body, html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
    backToTop.tooltip();

    // NAVBAR

    let navBar = $('#navbar');
    let navigation = $('#nav-toc');
    navigation.css('max-width', navigation.width());

    let marginPadding = parseInt(navigation.css('margin-top')) + parseInt(navigation.css('padding-top'));
    $(window).scroll(function () {
        if (navigation.height() + (marginPadding * 2) > $(window).height() || $(window).width() < 768) {
            resetPosition(navigation);
            return;
        }
        if (navBar.is(':in-viewport')) {
            resetPosition(navigation);
        } else {
            navigation.css('position', 'fixed');
        }
    });

    $(window).resize(function () {
        if (navBar.is(':in-viewport')) {
            navigation.css('max-width', '');
            navigation.css('max-width', navigation.width());
        }
        if (navigation.height() + (marginPadding * 2) > $(window).height() || $(window).width() < 768) {
            resetPosition(navigation);
        }
    });

    // SVG HANDLING

    if (!IS_SVG_SUPPORTED) {
        $('img[src$=".svg"]').each(function () {
            this.src = replaceAll(this.src, '.svg', '.png');
        });
    }

    // ADSENSE

    let firstH2 = true;
    $('article h2').each(function () {
        if (firstH2) {
            firstH2 = false;
            return true;
        }
        $(this).before('<ins class="adsbygoogle no-print" style="margin-top: 40px;" data-ad-client="ca-pub-7167241518798106" data-ad-slot="2776038870" data-ad-format="auto"></ins>');
    });

    // COMMENTS

    let commentAvatar = $('#comment-avatar');
    let commentAuthor = $('#comment-author');
    commentAvatar.height(commentAuthor.outerHeight());
    commentAuthor.css('padding-left', (commentAvatar.height() + 10) + 'px');

    let updateTimeout;
    commentAuthor.change(function () {
        clearTimeout(updateTimeout);
        updateTimeout = setTimeout(function () {
            commentAvatar.attr('src', getAvatarUrl(commentAuthor.val()));
        }, 200);
    });

    $('#comment-form').submit(function (event) {
        let username = commentAuthor.val();
        let message = $('#comment-message').val();

        if (username.length === 0 || message.length === 0) {
            return false;
        }

        let button = $('#comment-form button');
        button.attr('disabled', true);

        event.preventDefault();
        $.post('https://dev.staticman.net/v3/entry/github/Skyost/Bacomathiques/master/comments', $(this).serialize());

        setTimeout(function () {
            let commentsAlert = $('#comments .alert');
            commentsAlert.css('display', 'block');
            $('html, body').animate({
                scrollTop: commentsAlert.top
            }, 500);
            button.removeAttr('disabled');
        }, 3000);
    });
});

/**
 * Found here : http://stackoverflow.com/a/9083076/3608831
 */

function romanize(num) {
    if (!+num) {
        return false;
    }
    let digits = String(+num).split(""),
        key = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM",
            "", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC",
            "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"],
        roman = "",
        i = 3;
    while (i--) {
        roman = (key[+digits.pop() + (i * 10)] || "") + roman;
    }
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
    if (hash.length === 0) {
        return;
    }
    let jqueryHash = $(hash);
    if (!jqueryHash.length) {
        return;
    }
    if (typeof event !== 'undefined') {
        event.preventDefault();
    }
    $('html, body').animate({
        scrollTop: jqueryHash.offset().top
    }, 500);
    if (history.pushState) {
        history.pushState(null, null, hash);
    } else {
        location.hash = hash;
    }
}

/**
 * Resets the nativation position.
 */

function resetPosition(navigation) {
    navigation.css('position', '');
}

/**
 * Returns the username avatar url.
 */

function getAvatarUrl(username) {
    return 'https://api.adorable.io/avatars/56/' + username + '.png';
}