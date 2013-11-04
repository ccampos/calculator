calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    operands = []
    operator = '/'
    allowDigits = 10

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
        _decDigitsNeeded = allowDigits - _intDigits
        _result = +result.toFixed(_decDigitsNeeded)

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

    $scope.nextCalculation = (key) ->
        if key is '/' or key is 'x' or key is '-' or key is '+'
            operator = key

            if operands.length is 2
                _result = getResult()
                displayResult _result
                modifyOperands(_result)
            else
                console.log 'another operand needed'
        else
            _number = key
            if $scope.display is undefined
                $scope.display = _number
            else
                displayS = $scope.display.toString()
                if displayS.length < allowDigits
                    $scope.display = +(displayS + _number.toString())

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
