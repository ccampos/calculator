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
        unless operands[1] is 0
            _result = formatResult calculate(operands[0], operator, operands[1])
        else
            _result = calculate(operands[0], operator, operands[1])


    displayResult = (result) ->
        unless result is 'Error'
            $scope.display = result
        else
            operands = []
            operator = ''
            $scope.display = 'Error: div 0'
            setTimeout ->
                console.log $scope.display = 0
                console.log 'timeout'
                return
            , 1000
            return

    modifyOperands = (result) ->
        operands.shift()
        operands.shift()
        operands.push result

    # for numbers and '.'
    concat = (key) ->
        if $scope.display is undefined
            $scope.display = key
        else
            displayS = $scope.display.toString()
            if displayS.length < allowDigits
                if key is '.'
                    $scope.display = displayS + key
                else
                    $scope.display = +(displayS + key.toString())

    $scope.nextCalculation = (key) ->
        switch key
            when '/', 'x', '-', '+'
                operands.push $scope.display

                if operands.length is 2
                    _result = getResult()
                    displayResult _result
                    modifyOperands(_result)
                else
                    console.log 'another operand needed'
                    $scope.display = ''

                operator = key

            when '.'
                concat key

        if typeof key is 'number'
            concat key

    # press an 'operator key' -> returns result if previous operand
    # press a 'number' key -> adds 'number' to display
