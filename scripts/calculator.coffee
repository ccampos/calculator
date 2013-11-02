calc = angular.module 'calc', []

calc.controller 'CalcCtrl', ($scope) ->
    $scope.hello = 'hello'
    $scope.keys = [
        'mc', 'm+', 'm-', 'mr',
        7, 8, 9, '/',
        4, 5, 6, 'x',
        1, 2, 3, '-',
        0, '.', '=', '+'
    ]
