const LESSON_ID = 'probabilites';

function createPlots(dimensions) {
    let gauss = [
        {
            title: 'f(x)',
            fn: '(1/(sqrt(2*PI)))*exp((-1/2)*x^2)',
            closed: true
        },
        {
            title: 'f(x)',
            fn: '(1/(sqrt(2*PI)))*exp((-1/2)*x^2)'
        }
    ];

    functionPlot({
        title: 'Une fonction densité de probabilité',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        yAxis: {
            domain: [-0.6, 0.6]
        },
        data: gauss
    });

    a = -2;
    b = 4;

    functionPlot({
        title: 'Une loi uniforme',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        yAxis: {
            domain: [-0.6, 0.6]
        },
        data: [
            {
                title: 'f(x)',
                fn: '1/(' + (b - a) + ')',
                range: [a, b],
                color: 'lightblue',
                closed: true
            },
            {
                title: 'f(x)',
                fn: '0',
                color: 'lightblue'
            }
        ],
        annotations: [
            {
                x: a,
                text: 'x = a'
            },
            {
                x: b,
                text: 'x = b'
            }
        ]
    });

    let lambda = 4;

    functionPlot({
        title: 'Une loi exponentielle',
        target: '#representation-3',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'f(x)',
                fn: lambda + '*exp(-x*' + lambda + ')'
            }
        ]
    });

    functionPlot({
        title: 'La loi normale centrée réduite',
        target: '#representation-4',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        yAxis: {
            domain: [-0.6, 0.6]
        },
        data: gauss
    });

    let mu = -2;
    let sigma = Math.sqrt(0.5);

    functionPlot({
        title: 'Une loi normale',
        target: '#representation-5',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        yAxis: {
            domain: [-0.6, 0.6]
        },
        data: [
            {
                title: 'f(x)',
                fn: '(1/(' + sigma + '*sqrt(2*PI)))*exp((-1/2)*((x-' + mu + ')/' + sigma + ')^2)'
            }
        ]
    });
}