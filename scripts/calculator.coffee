calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    operands = [8, 333334]
    operator = '/'
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
            else
                console.log 'operator not found'

    getResult = ->
        _result = formatResult calculate(operands[0], operator, operands[1])

    displayResult = (result) ->
        unless result is 'Error'
            $scope.display = result
        else
            setTimeout ->
                operands = []
                operator = ''
            , 1000

    modifyOperands = (result) ->
        operands.shift()
        operands.shift()
        operands.push result

    nextCalculation = (newOperator) ->
        operator = newOperator # new operator
        if operands.length > 1
            _result = getResult()
            displayResult _result
            modifyOperands(_result)
        else
            console.log 'another operand needed'

    nextCalculation 'x'

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
