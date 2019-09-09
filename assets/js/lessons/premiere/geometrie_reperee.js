function createPlots(dimensions) {
    functionPlot({
        title: 'Vecteur directeur de D:y=x',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'y = x',
                fn: 'x',
            },
            {
                vector: [2, 2],
                offset: [0, 0],
                graphType: 'polyline',
                fnType: 'vector',
                color: 'red'
            },
            {
                points: [
                    [0, 0],
                    [2, 2]
                ],
                fnType: 'points',
                graphType: 'scatter'
            },
            {
                title: 'A(0; 0)',
                fn: '0',
                range: [0, 0]
            },
            {
                title: 'B(2; 2)',
                fn: '2',
                range: [2, 2],
            },
        ]
    });

    functionPlot({
        title: 'Vecteur normal à D:y=x',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'y = x',
                fn: 'x',
            },
            {
                vector: [-2, 2],
                offset: [1, 1],
                graphType: 'polyline',
                fnType: 'vector',
                color: 'red'
            },
        ]
    });
}