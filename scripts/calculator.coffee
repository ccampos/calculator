calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    operands = [8, 7]
    $scope.display = operands[operands.length - 1]
    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

    calculate = (operator, newOperand) ->
        firstOperand = $scope.display
        switch operator
            when 'x' then firstOperand * newOperand
            when '/'
                if newOperand is 0
                    return 'Error'
                firstOperand / newOperand
            when '-' then firstOperand - newOperand
            when '+' then firstOperand + newOperand

    result = calculate('/', 3)
    numberLength = result.toString().length
    indexDot = result.toString().indexOf('.')
    integersNumberDigits = +result.toString().slice(0, indexDot).length
    decimalsNumberDigits = +result.toString().slice(indexDot, numberLength).length
    neededNumberOfDecimals = 'we\'ll see'

    unless result is 'Error'
        operands.push result
        operands.shift()
    else
        operands = []

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
