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

    calculate = (firstOperand, operator, secondOperand) ->
        _fOper = firstOperand
        _sOper = secondOperand
        switch operator
            when 'x' then _fOper * _sOper
            when '/'
                if _sOper is 0
                    return 'Error'
                _fOper / _sOper
            when '-' then _fOper - _sOper
            when '+' then _fOper + _sOper

    result = formatResult calculate(1000000, '/', 3)

    unless result is 'Error'
        operands.shift()
        operands.shift()
        operands.push result
        $scope.display = operands[0]
    else
        operands = []

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
