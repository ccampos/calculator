// Generated by CoffeeScript 1.6.2
(function() {
  var calc, calculate;

  calc = angular.module('calc', []);

  calc.controller('CalcCtrl', function($scope) {
    $scope.hello = 'hello';
    return $scope.keys = ['mc', 'm+', 'm-', 'mr', 7, 8, 9, '/', 4, 5, 6, 'x', 1, 2, 3, '-', 0, '.', '=', '+'];
  });

  calculate = function(operator, number) {};

}).call(this);
