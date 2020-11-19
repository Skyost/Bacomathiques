$(document).ready(function () {
    initializeCommentsForm();
});

function initializeCommentsForm() {
    let commentAvatar = $('#comment-avatar');
    let commentAuthor = $('#comment-author');
    commentAvatar.height(commentAuthor.outerHeight());
    commentAuthor.css('padding-left', (commentAvatar.height() + 10) + 'px');

    let updateTimeout;
    commentAuthor.on('change', function () {
        clearTimeout(updateTimeout);
        updateTimeout = setTimeout(function () {
            commentAvatar.attr('src', getAvatarUrl(commentAuthor.val()));
        }, 200);
    });

    $('#comment-form').submit(onCommentSent);
}

function onCommentSent(event) {
    let commentAuthor = $('#comment-author');

    let username = commentAuthor.val();
    let message = $('#comment-message').val();

    if (username.length === 0 || message.length === 0) {
        return false;
    }

    $('#comment-form button').attr('disabled', true);

    event.preventDefault();
    $.post('https://postman.bacomathiqu.es/v3/entry/github/Skyost/Bacomathiques/master/comments', $(this).serialize(), function () {
        $('#comment-success').removeClass('d-none');
        commentAuthor.val('');
        $('#comment-message').val('');
    })
        .fail(function (err) {
            console.log(err);
            $('#comment-error').removeClass('d-none');
            $('#comment-form button').attr('disabled', '');
        });
}

function getAvatarUrl(username) {
    if(username == null || username.length === 0) {
        username = 'Anonyme';
    }
    return 'https://avatars.dicebear.com/api/bottts/' + username + '.svg';
}
