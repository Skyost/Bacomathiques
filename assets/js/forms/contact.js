$(document).ready(function () {
    // Setup reCaptcha.
    grecaptcha.ready(function () {
        grecaptcha.execute('6LeleK0ZAAAAAE1AyIgnyM60UZ1I9d2YPB5_zuyw', {action: 'contact'}).then(function (token) {
            $('#recaptcha-response').val(token);
        });
    });

    // Get the form elements defined in your form HTML above.
    let form = document.getElementById('contact-form');
    let submitButton = $('#contact-submit');

    // Success and error functions for after the form is submitted.
    function success() {
        form.reset();
        submitButton.addClass('d-none');
        $('#contact-success').removeClass('d-none');
    }

    function error() {
        submitButton.attr('disabled', '');
        $('#contact-error').removeClass('d-none');
    }

    // Handle the form submission event.
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        submitButton.attr('disabled', 'disabled');
        ajax(form.method, form.action, new FormData(form), success, error);
    });
});

// Helper function for sending an AJAX request.
function ajax(method, url, data, success, error) {
    let xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.onreadystatechange = function () {
        if (xhr.readyState !== XMLHttpRequest.DONE) {
            return;
        }
        if (xhr.status === 200) {
            success(xhr.response, xhr.responseType);
        } else {
            error(xhr.status, xhr.response, xhr.responseType);
        }
    };
    xhr.send(data);
}