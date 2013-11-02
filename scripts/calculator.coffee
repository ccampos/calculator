calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    $scope.display = 'hello'
    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]

calculate = (operator, number) ->

# press an 'operator key' -> returns result if previous operand
# press a 'number' key -> adds 'number' to display
