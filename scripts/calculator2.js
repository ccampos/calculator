// Generated by CoffeeScript 1.6.2
(function() {
  var calc;

  calc = angular.module('calc', []);

  calc.controller('CalcCtrl', function($scope) {
    var allowDigits, calcArr, calculate, concatNumber, format, hasResult, manageMemory, memory, operate;

    calcArr = [];
    allowDigits = 10;
    memory = void 0;
    hasResult = false;
    $scope.keys = ['C', 'm+', 'm-', 'mr', 7, 8, 9, '/', 4, 5, 6, 'x', 1, 2, 3, '-', 0, '.', '=', '+'];
    concatNumber = function(_number, _key) {
      var _numberString;

      _numberString = _number.toString() + _key;
      if (_key === '.') {
        return _numberString;
      } else if (typeof _key === 'number') {
        return +_numberString;
      }
    };
    format = function(_result) {
      var _decimalDigitsNeeded, _indexDot, _integerNumberDigits, _resultString;

      _resultString = _result.toString();
      _indexDot = _resultString.indexOf('.');
      _integerNumberDigits = +_resultString.slice(0, _indexDot).length;
      _decimalDigitsNeeded = allowDigits - _integerNumberDigits;
      if (_integerNumberDigits >= allowDigits) {
        return _result.toExponential(allowDigits - 5);
      } else {
        _result = +_result;
        return +_result.toFixed(_decimalDigitsNeeded);
      }
    };
    operate = function(_firstOperand, _operator, _secondOperand) {
      switch (_operator) {
        case 'x':
          return _firstOperand * _secondOperand;
        case '/':
          if (_secondOperand === 0) {
            return 'Error';
          }
          return _firstOperand / _secondOperand;
        case '-':
          return _firstOperand - _secondOperand;
        case '+':
          return _firstOperand + _secondOperand;
        default:
          return console.log('operator not found');
      }
    };
    calculate = function(_key) {
      var _number, _operator, _result;

      if (calcArr.length === 0) {
        if (typeof _key === 'number') {
          _number = _key;
          return calcArr.push(_number);
        }
      } else if (calcArr.length === 1) {
        if (typeof _key === 'number') {
          if (hasResult) {
            calcArr[0] = _key;
            return hasResult = false;
          } else {
            if (calcArr[0].toString().length < allowDigits) {
              _number = _key;
              return calcArr[0] = concatNumber(calcArr[0], _number);
            }
          }
        } else if (_key === '.') {
          return calcArr[0] = concatNumber(calcArr[0], _key);
        } else {
          _operator = _key;
          switch (_key) {
            case '/':
            case 'x':
            case '-':
            case '+':
              return calcArr.push(_operator);
          }
        }
      } else if (calcArr.length === 2) {
        if (typeof _key === 'number') {
          _number = _key;
          return calcArr.push(_number);
        }
      } else if (calcArr.length === 3) {
        if (typeof _key === 'number') {
          if (calcArr[2].toString().length < allowDigits) {
            _number = _key;
            return calcArr[2] = concatNumber(calcArr[2], _number);
          }
        } else if (_key === '.') {
          return calcArr[2] = concatNumber(calcArr[2], _key);
        } else {
          _operator = _key;
          switch (_key) {
            case '/':
            case 'x':
            case '-':
            case '+':
            case '=':
              _result = operate(calcArr[0], calcArr[1], calcArr[2]);
              calcArr.push(format(_result));
              calcArr.shift();
              calcArr.shift();
              calcArr.shift();
              return hasResult = true;
          }
        }
      }
    };
    manageMemory = function(_key) {
      var el, _index;

      el = angular.element($('.mr'));
      switch (_key) {
        case 'mc':
          memory = void 0;
          break;
        case 'm+':
          memory = memory === void 0 ? $scope.display : memory + $scope.display;
          break;
        case 'm-':
          memory = memory === void 0 ? $scope.display : memory - $scope.display;
          break;
        case 'mr':
          if (memory != null) {
            calculate(format(memory));
          }
      }
      if (memory != null) {
        if ($scope.keys.indexOf('C') !== -1) {
          _index = $scope.keys.indexOf('C');
          $scope.keys[_index] = 'mc';
        }
        return el.addClass('highlight');
      } else {
        if ($scope.keys.indexOf('mc') !== -1) {
          _index = $scope.keys.indexOf('mc');
          $scope.keys[_index] = 'C';
        }
        return el.removeClass('highlight');
      }
    };
    return $scope.handleNext = function(_key) {
      switch (_key) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case '/':
        case 'x':
        case '-':
        case '+':
        case '=':
        case '.':
          calculate(_key);
          break;
        case 'mc':
        case 'm+':
        case 'm-':
        case 'mr':
        case 'C':
          manageMemory(_key);
          if (_key === 'C') {
            calcArr = [];
          }
      }
      return $scope.display = calcArr[calcArr.length - 1];
    };
  });

}).call(this);
