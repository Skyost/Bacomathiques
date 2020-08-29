$(document).ready(async function () {
    adjustPreviewHeight();
    handleOptions();
    addTitles();
    await window.MathJax.startup.promise;
    handleProofs();
    numberizeTitles();
    addAnchors();
    handleNavbar();
    addAds();
});

$(window).resize(adjustPreviewHeight);

function numberizeTitles() {
    let h2Index = 1;
    let h3Index = 1;
    $('article h2, article h3').each(function () {
        let title = $(this);
        if (title.prop('tagName') === 'H3') {
            title.html((h3Index++) + '. ' + title.html());
        } else {
            h3Index = 1;
            title.html(romanize(h2Index++) + ' – ' + title.html());
        }
    });
}

function addAnchors() {
    anchors.add('article h2, article h3');
}

function adjustPreviewHeight() {
    let preview = $('.header-image');
    preview.css('height', preview.outerWidth());
}

function handleNavbar() {
    tocbot.init({
        tocSelector: '#lesson-navigation',
        contentSelector: '#page-content',
        headingSelector: 'h2, h3',
        hasInnerContainers: true,
        disableTocScrollSync: false,
    });

    let navbar = $('#page-navbar');
    navbar.addClass('shrinked');

    let navigation = $('#lesson-navigation');
    navigation.css('top', navbar.height() + 5);

    navbar.removeClass('shrinked');
}

function handleProofs() {
    $('.proof').each(function () {
        let proof = $(this);
        let proofLabel = $('<span class="proof-label"><i class="fa fa-angle-right" aria-hidden="true"></i> Démonstration</span>');
        let proofContent = $('<div class="proof-content d-none clearfix tex2jax_ignore"></div>');
        proofContent.html(proof.html());
        proofContent.append($('<span class="proof-end float-right"><i class="fa fa-square" aria-hidden="true"></i></span>'));

        proofLabel.click(function () {
            proofContent.toggleClass('d-none');
            proofLabel.find('.fa').toggleClass('fa-angle-right').toggleClass('fa-angle-down');

            if (proofContent.hasClass('tex2jax_ignore')) {
                proofContent.removeClass('tex2jax_ignore');
                MathJax.typeset([proofContent.get(0)]);
            }
        });

        proof.empty();
        proof.append(proofLabel);
        proof.append(proofContent);
    });
}

function addTitles() {
    $('div[data-api-v2-title]').each(function() {
        $(this).prepend('<h4>' + $(this).attr('data-api-v2-title') + '</h4>');
    });
    MathJax.typesetPromise($('div[data-api-v2-title] h4').get());
}

function handleOptions() {
    $('#options-button').click(function() {
       $('.options').toggleClass('expanded');
    });

    $('#option-pdf').click(function() {
        window.open($(this).attr('data-link'));
    });
}

function addAds() {
    let ad = `
    <ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-7167241518798106"
     data-ad-slot="4882057404"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
    `;

    $(ad).insertBefore($('article h2:not(:first)'));
    $('.adsbygoogle').each(function () {
        (adsbygoogle = window.adsbygoogle || []).push({});
    });
}

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