// Generated by CoffeeScript 1.6.2
(function() {
  var calc;

  calc = angular.module('calc', []);

  calc.controller('CalcCtrl', function($scope) {
    var allowDigits, calculate, displayResult, formatResult, getResult, modifyArr, operands, operator;

    operands = [8, 333334];
    operator = '/';
    allowDigits = 11;
    $scope.display = operands[operands.length - 1];
    $scope.keys = ['mc', 'm+', 'm-', 'mr', 7, 8, 9, '/', 4, 5, 6, 'x', 1, 2, 3, '-', 0, '.', '=', '+'];
    formatResult = function(result) {
      var _decDigitsNeeded, _indexDot, _intDigits, _numLen, _resS;

      _resS = result.toString();
      _numLen = _resS.length;
      _indexDot = _resS.indexOf('.');
      _intDigits = +_resS.slice(0, _indexDot).length;
      _decDigitsNeeded = allowDigits - _intDigits - 1;
      return _resS = +result.toFixed(_decDigitsNeeded);
    };
    calculate = function(firstOperand, operator, secondOperand) {
      var _fOper, _sOper;

      _fOper = firstOperand;
      _sOper = secondOperand;
      switch (operator) {
        case 'x':
          return _fOper * _sOper;
        case '/':
          if (_sOper === 0) {
            return 'Error';
          }
          return _fOper / _sOper;
        case '-':
          return _fOper - _sOper;
        case '+':
          return _fOper + _sOper;
      }
    };
    getResult = function() {
      var _result;

      return _result = formatResult(calculate(operands[0], operator, operands[1]));
    };
    modifyArr = function(result) {
      operands.shift();
      return operands.push(result);
    };
    displayResult = function(result) {
      if (result !== 'Error') {
        $scope.display = operands[1];
        operator = 'x';
        return modifyArr(result);
      } else {
        return setTimeout(function() {
          operands = [];
          return operator = '';
        }, 1000);
      }
    };
    return displayResult(getResult());
  });

}).call(this);
