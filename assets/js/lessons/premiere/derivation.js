function createPlots(dimensions) {
    functionPlot({
        title: 'Dérivée de x² + 3x - 1',
        target: '#representation-1',
        grid: true,
        height: dimensions.height,
        width: dimensions.width,
        data: [
            {
                title: 'x² + 3x - 1',
                fn: 'x^2 + 3x - 1',
                derivative: {
                    fn: '2x + 3',
                    updateOnMouseMove: true
                }
            }
        ]
    });
}