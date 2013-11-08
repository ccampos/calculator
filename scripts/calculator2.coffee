calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    calcArr = []
    allowDigits = 10
    memory = undefined

    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

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

    concatNumber = (number, number2) ->
        _number = number.toString() + number2
        +_number

    format = (result) ->
        _resS = result.toString()
        _numLen = _resS.length
        _indexDot = _resS.indexOf('.')
        _intDigits = +_resS.slice(0, _indexDot).length
        _decDigitsNeeded = allowDigits - _intDigits
        _result = +result.toFixed(_decDigitsNeeded)

    $scope.next = (key) ->

        # operands and operators
        if calcArr.length is 0
            if typeof key is 'number'
                _number = key
                calcArr.push _number

        else if calcArr.length is 1
            if typeof key is 'number'
                _number = key
                calcArr[0] = concatNumber calcArr[0], _number
            else
                _operator = key
                switch key
                    when '/', 'x', '-', '+'
                        calcArr.push _operator

        else if calcArr.length is 2
            if typeof key is 'number'
                _number = key
                calcArr.push _number

        else if calcArr.length is 3
            if typeof key is 'number'
                _number = key
                calcArr[2] = concatNumber calcArr[2], _number
            else
                _operator = key
                switch key
                    when '/', 'x', '-', '+', '='
                        _result = calculate calcArr[0], calcArr[1], calcArr[2]
                        calcArr.push format _result
                        calcArr.shift()
                        calcArr.shift()
                        calcArr.shift()

        # memory
        switch key
            when 'mc'
                memory = undefined
            when 'm+'
                memory = $scope.display
            when 'mr'
                if memory?
                    $scope.next memory

        # todo: innovation
        # add:
        #   m+
        #   m-
        # refactor $scope.next key
        # switch from mc to c

        $scope.display = calcArr[calcArr.length - 1]
