function createPlots(dimensions) {
    functionPlot({
        title: 'Exemple (par récurrence)',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'Droite y=x',
                fn: 'x',
            },
            {
                title: 'f(x) = x/2',
                fn: 'x/2',
            },
            {
                points: [
                    [3, 0],
                    [3, 1.5],
                    [0, 1.5],
                    [1.5, 1.5],

                    [1.5, 0],
                    [1.5, 0.75],
                    [0, 0.75],
                    [0.75, 0.75],

                    [0.75, 0],
                ],
                fnType: 'points',
                graphType: 'polyline'
            },
            {
                points: [
                    [3, 0],
                    [3, 1.5],
                    [0, 1.5],
                    [1.5, 1.5],

                    [1.5, 0],
                    [1.5, 0.75],
                    [0, 0.75],
                    [0.75, 0.75],

                    [0.75, 0],
                ],
                fnType: 'points',
                graphType: 'scatter'
            },
            {
                title: 'A1(3; 0)',
                fn: '0',
                range: [3, 3]
            },
            {
                title: 'B1(3; 1.5)',
                fn: '1.5',
                range: [3, 3]
            },
            {
                title: 'C1(0; 1.5)',
                fn: '1.5',
                range: [0, 0]
            },
            {
                title: 'D1(1.5; 1.5)',
                fn: '1.5',
                range: [1.5, 1.5]
            },
            {
                title: 'A2(1.5; 0)',
                fn: '0',
                range: [1.5, 1.5]
            },
            {
                title: 'B2(1.5; 0.75)',
                fn: '0.75',
                range: [1.5, 1.5]
            },
            {
                title: 'C2(0; 0.75)',
                fn: '0.75',
                range: [0, 0]
            },
            {
                title: 'D2(0.75; 0.75)',
                fn: '0.75',
                range: [0.75, 0.75]
            },
            {
                title: 'A3(0.75; 0)',
                fn: '0',
                range: [0.75, 0.75]
            },
        ]
    });

    functionPlot({
        title: 'Exemple (explicite)',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                points: [
                    [0, 1],
                    [1, 2],
                    [2, 4],
                ],
                fnType: 'points',
                graphType: 'scatter'
            },
            {
                title: '(0; 1)',
                fn: '1',
                range: [0, 0]
            },
            {
                title: '(1; 2)',
                fn: '2',
                range: [1, 1]
            },
            {
                title: '(2; 4)',
                fn: '4',
                range: [2, 2]
            }
        ]
    });
}