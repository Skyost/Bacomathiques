---
---

const pages = {
    {% for levelHash in site.data.levels %}
        {% assign level = levelHash[1] %}
        {% for data in site.data.lessons[level.id] %}
            {% assign lesson = data[1] %}
            {% capture lessonContent %}{% include {{ lesson.path }} %}{% endcapture %}
            {% assign parts = lessonContent | split: "---" %}
            {% assign lessonContent = parts[2] %}
            {% assign image = '/assets/img/lessons/' | append: lesson.level | append: '/' | append: lesson.id | append: '/preview.jpg' %}

            '{{ lesson.id }}': {
                caption: '{{ lesson.caption | replace: "'", "\\'" }}',
                image: '{{ image }}',
                title: "{{ lesson.title | xml_escape }} ({{ level.name }})",
                excerpt: "{{ lesson.excerpt | strip_html }}",
                htmlExcerpt: "{{ lesson.excerpt | replace: "'", "\\'" }}",
                content: "{{ lessonContent | strip_html | xml_escape | strip_newlines | truncatewords: 20 | textilize }}",
                url: "/cours/{{ site.data.levels[lesson.level].url }}/{{ lesson.url }}/"
            },
        {% endfor %}
    {% endfor %}
    'index-des-cours-html': {
        title: 'Index des cours',
        excerpt: 'Index des cours disponibles sur {{ site.title }}.',
        content: 'Retrouvez ici la liste des cours ainsi qu\'une brève description et une petite illustration.',
        url: '/cours/'
    },
};

$(document).ready(function () {
    let searchTerm = getQueryVariable('keywords');
    let keywords = $('.result-keywords');
    if (!searchTerm) {
        keywords.text('vide');
        displaySearchResults(0, 0);
        return;
    }
    keywords.text(searchTerm);
    let idx = lunr(function () {
        this.field('id');
        this.field('title', {
            boost: 10,
        });
        this.field('excerpt');
        this.field('content');

        for (let page in pages) {
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

function getQueryVariable(variable) {
    let query = window.location.search.substring(1);
    let vars = query.split('&');

    for (let i = 0; i < vars.length; i++) {
        let pair = vars[i].split('=');

        if (pair[0] === variable) {
            return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
        }
    }
}

function displaySearchResults(results, pages) {
    let searchResults = $('#page-content .row');

    if (results.length && results.length > 0) {
        $('.no-result').remove();

        {% assign firstLesson = site.data.lessons['premiere']['suites'] %}
        {% capture lessonPlaceholder %}
        {% include _includes/components/cards/lesson_card.html lesson=firstLesson %}
        {% endcapture %}

        let lessonPlaceholder = $('{{ lessonPlaceholder | replace: "'", "\\'" | strip_newlines }}');

        $('.result-count').text(results.length);
        for (let i = 0; i < results.length; i++) {
            let item = pages[results[i].ref];
            let element = lessonPlaceholder.clone();
            if (item.image) {
                element.find('.flat-card-image').attr('src', item.image);
            }
            if (item.caption) {
                element.find('.lesson-caption').text(item.caption);
            }
            else {
                element.find('.lesson-caption').remove();
            }
            element.find('.lesson-title').text(item.title);
            if (item.htmlExcerpt) {
                element.find('.lesson-description').html(item.htmlExcerpt);
            }
            else {
                element.find('.lesson-description').html(item.excerpt);
            }
            element.find('.lesson-link').attr('href', item.url);
            element.appendTo(searchResults);
        }
    }


}