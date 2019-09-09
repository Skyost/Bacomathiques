function createPlots(dimensions) {
    functionPlot({
        title: 'La fonction exponentielle',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'exp(x)',
                fn: 'exp(x)'
            },
            {
                title: 'y = x + 1',
                fn: 'x + 1'
            }
        ]
    });
}