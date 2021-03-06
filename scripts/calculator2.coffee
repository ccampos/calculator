calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    calcArr = []
    allowDigits = 10
    memory = undefined
    hasResult = false

    $scope.keys = [
        'C', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

    # helper functions
    concatNumber = (_number, _key) ->
        _numberString = _number.toString() + _key
        if _key is '.'
            _numberString
        else if typeof _key is 'number'
            +_numberString

    format = (_result) ->
        _resultString = _result.toString()
        _indexDot = _resultString.indexOf('.')
        _integerNumberDigits = +_resultString.slice(0, _indexDot).length
        _decimalDigitsNeeded = allowDigits - _integerNumberDigits
        if _integerNumberDigits >= allowDigits
            _result.toExponential(allowDigits - 5) # to allow for space
        else
            _result = +_result
            +_result.toFixed(_decimalDigitsNeeded)

    #main functions
    operate = (_firstOperand, _operator, _secondOperand) ->
        switch _operator
            when 'x' then _firstOperand * _secondOperand
            when '/'
                if _secondOperand is 0
                    return 'Error'
                _firstOperand / _secondOperand
            when '-' then _firstOperand - _secondOperand
            when '+' then _firstOperand + _secondOperand
            else
                console.log 'operator not found'

    calculate = (_key) ->
        if calcArr.length is 0
            if typeof _key is 'number'
                _number = _key
                calcArr.push _number

        else if calcArr.length is 1
            if typeof _key is 'number'
                if hasResult
                    calcArr[0] = _key
                    hasResult = false
                else
                    if calcArr[0].toString().length < allowDigits
                        _number = _key
                        calcArr[0] = concatNumber calcArr[0], _number
            else if _key is '.'
                calcArr[0] = concatNumber calcArr[0], _key
            else
                _operator = _key
                switch _key
                    when '/', 'x', '-', '+'
                        calcArr.push _operator

        else if calcArr.length is 2
            if typeof _key is 'number'
                _number = _key
                calcArr.push _number

        else if calcArr.length is 3
            if typeof _key is 'number'
                if calcArr[2].toString().length < allowDigits
                    _number = _key
                    calcArr[2] = concatNumber calcArr[2], _number
            else if _key is '.'
                calcArr[2] = concatNumber calcArr[2], _key
            else
                _operator = _key
                switch _key
                    when '/', 'x', '-', '+', '='
                        _result = operate calcArr[0], calcArr[1], calcArr[2]
                        calcArr.push format _result
                        calcArr.shift()
                        calcArr.shift()
                        calcArr.shift()
                        hasResult = true

    manageMemory = (_key) ->
        el = angular.element $ '.mr'

        switch _key
            when 'mc'
                memory = undefined
            when 'm+'
                memory = if memory is undefined then $scope.display else memory + $scope.display
            when 'm-'
                memory = if memory is undefined then $scope.display else memory - $scope.display
            when 'mr'
                if memory?
                    calculate format memory

        if memory?
            unless $scope.keys.indexOf('C') is -1
                _index = $scope.keys.indexOf 'C'

                $scope.keys[_index] = 'mc'

            # highlight 'mr' key
            el.addClass 'highlight'
        else
            unless $scope.keys.indexOf('mc') is -1
                _index = $scope.keys.indexOf('mc')

                $scope.keys[_index] = 'C'

            el.removeClass 'highlight'

    # entry function
    $scope.handleNext = (_key) ->
        switch _key
            when 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, '/', 'x', '-', '+', '=', '.'
                calculate _key

            when 'mc', 'm+', 'm-', 'mr', 'C'
                manageMemory _key

                if _key is 'C'
                    calcArr = []

        $scope.display = calcArr[calcArr.length - 1]
