const LESSON_ID = 'fonctions_trigonometriques';

function createPlots(dimensions) {
    functionPlot({
        title: 'Repère trigonométrique',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        xAxis: {domain: [-3, 3]},
        data: [
            {
                fn: 'x * x + y * y - 1',
                fnType: 'implicit'
            },
            {
                points: [
                    [0, 1],
                    [1, 0]
                ],
                fnType: 'points',
                graphType: 'scatter'
            },
            {
                title: 'J(0; 1)',
                fn: '1',
                range: [0, 0]
            },
            {
                title: 'I(1; 0)',
                fn: '0',
                range: [1, 1]
            },
            {
                vector: [0, 1],
                offset: [0, 0],
                graphType: 'polyline',
                fnType: 'vector',
                color: 'red'
            },
            {
                vector: [1, 0],
                offset: [0, 0],
                graphType: 'polyline',
                fnType: 'vector',
                color: 'red'
            }
        ]
    });

    let x = Math.cos(Math.PI / 4); // cos(pi/4) = sin(pi/4) = sqrt(2) / 2

    functionPlot({
        title: 'cos(x + pi) = -cos(x)',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        xAxis: {domain: [-3, 3]},
        data: [
            {
                fn: 'x * x + y * y - 1',
                fnType: 'implicit'
            },
            {
                points: [
                    [x, x],
                    [-x, x]
                ],
                fnType: 'points',
                graphType: 'scatter'
            },
            {
                title: 'Distance OM',
                fn: 'x',
                range: [0, x]
            },
            {
                title: 'Distance OM\'',
                fn: '-x',
                range: [-x, 0]
            },
            {
                title: 'M(x; y)',
                fn: 'cos(PI / 4)',
                range: [x, x]
            },
            {
                title: 'M\'(x + pi; y + pi)',
                fn: 'sin(PI / 4)',
                range: [-x, -x]
            },
        ]
    });

    functionPlot({
        title: 'La fonction cosinus',
        target: '#representation-3',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'cos(x)',
                fn: 'cos(x)'
            }
        ]
    });

    functionPlot({
        title: 'La fonctions sinus',
        target: '#representation-4',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'sin(x)',
                fn: 'sin(x)'
            }
        ]
    });
}