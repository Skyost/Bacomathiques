function createPlots(dimensions) {
    functionPlot({
        title: 'Une parabole',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'x²',
                fn: 'x^2',
            }
        ]
    });
}