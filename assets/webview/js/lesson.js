'use strict';

const BASE_URL = '{base_url}';
const LEVEL = '{level}';
const LESSON = '{lesson}';
const ANCHOR = '{anchor}';

$(document).ready(async function () {
    $('a').click(handleLinksClick);
    addTitles();
    await window.MathJax.startup.promise;
    handleProofs();
    numberizeTitles();
    addAnchors();
    goToHash(event, ANCHOR);
});

function addAnchors() {
    anchors.add('article h2, article h3');
}

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

function handleProofs() {
    $('.proof').each(function () {
        let proof = $(this);
        let proofLabel = $('<span class="proof-label"><span class="toggle-icon">&#9654;</span> Démonstration</span>');
        let proofContent = $('<div class="bubble proof-content d-none clearfix tex2jax_ignore"></div>');
        proofContent.html(proof.html());
        proofContent.append($('<span class="float-right">&#8718;</span>'));

        proofLabel.click(function () {
            proofContent.toggleClass('d-none');
            proofLabel.toggleClass('mb-0');

            if(proofContent.hasClass('d-none')) {
                proofLabel.find('.toggle-icon').html('&#9654;');
            }
            else {
                proofLabel.find('.toggle-icon').html('&#9660;');
            }

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

function handleLinksClick(event) {
    let level = $(this).attr('data-api-v2-level');
    let lesson = $(this).attr('data-api-v2-lesson');
    let hash = $(this).attr('data-api-v2-hash');
    if (typeof level !== 'undefined' && typeof lesson !== 'undefined') {
        let object = {
            level: level,
            lesson: lesson,
        }

        if (typeof hash !== 'undefined') {
            object['hash'] = hash;
        }

        Navigation.postMessage(JSON.stringify(object));
        event.preventDefault();
        return;
    }

    if (typeof hash !== 'undefined') {
        goToHash(event, decodeURI(this.hash));
    }
}

function addTitles() {
    $('div[data-api-v2-title]').each(function() {
        $(this).prepend('<h4>' + $(this).attr('data-api-v2-title') + '</h4>');
    });
    MathJax.typesetPromise($('div[data-api-v2-title] h4').get());
}

function handleHighlighting() {
    $('.highlight code').each(function() {
       let code = $(this);
       code.html(code.html().replace(new RegExp('\t', 'g'), '    '))
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
}