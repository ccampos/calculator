calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    $scope.display = operands[operands.length - 1]
    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

operands = [8, 7]
calculate = (operator, newOperand) ->
    firstOperand = operands[operands.length - 1]
    switch operator
        when 'x' then firstOperand * newOperand
        when '/'
            if newOperand is 0
                return 'Error'
            firstOperand / newOperand
        when '-' then firstOperand - newOperand
        when '+' then firstOperand + newOperand

result = calculate('/', 2)

unless result is 'Error'
    operands.push result
    operands.shift()
    $scope.display = result

# press an 'operator key' -> returns result if previous operand
# press a 'number' key -> adds 'number' to display
