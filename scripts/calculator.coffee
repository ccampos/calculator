calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    operands = [8, 333334]
    allowDigits = 11
    $scope.display = operands[operands.length - 1]
    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

    formatResult = (result) ->
        _resS = result.toString()
        _numLen = _resS.length
        _indexDot = _resS.indexOf('.')
        _intDigits = +_resS.slice(0, _indexDot).length
        _decDigitsNeeded = allowDigits - _intDigits - 1 # minus dot
        _resS = +result.toFixed(_decDigitsNeeded)

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

    result = formatResult calculate('/', 3)

    unless result is 'Error'
        operands.push result
        operands.shift()
        $scope.display = operands[operands.length - 1]
    else
        operands = []

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
