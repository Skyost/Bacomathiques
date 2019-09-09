function createPlots(dimensions) {
    functionPlot({
        title: 'Le logarithme néperien',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'ln(x)',
                fn: 'log(x)'
            }
        ]
    });

    functionPlot({
        title: 'Relation de symétrie',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'exp(x)',
                fn: 'exp(x)'
            },
            {
                title: 'x',
                fn: 'x'
            },
            {
                title: 'ln(x)',
                fn: 'log(x)'
            }
        ]
    });
}