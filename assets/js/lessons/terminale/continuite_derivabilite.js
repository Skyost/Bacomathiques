function createPlots(dimensions) {
    functionPlot({
        title: 'La fonction partie entière',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: '[x]',
                fn: 'floor(x)',
                graphType: 'polyline'
            }
        ]
    });

    functionPlot({
        title: 'Une fonction et sa dérivée',
        target: '#representation-2',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'f(x)',
                fn: 'x^2-x-1',
                derivative: {
                    fn: '2x-1',
                    updateOnMouseMove: true
                }
            }
        ]
    });
}