typedef T Operation<T>(T object1, T object2);

Map<String, Operation> DefaultOperations = {
  "plus": (obj1, obj2) => obj1 + obj2,
  "minus": (obj1, obj2) => obj1 - obj2,
  "multiply": (obj1, obj2) => obj1 * obj2,
  "divide": (obj1, obj2) => obj1 / obj2
};

class Matrix {
  List<List<num>> _values;

  Matrix(List<List<num>> values) {
    _values = values;
  }

  bool _isValidSize(List<List<num>> values) {
    throw new UnimplementedError();
  }

  bool isEqualSize(Matrix m) {
    return values.length == m.values.length &&
        values[0].length == m.values[0].length;
  }

  void update(Operation action, num value) {
    for (var i = 0; i < values.length; i++) {
      for (var j = 0; j < values[0].length; j++) {
        values[i][j] = action(values[i][j], value);
      }
    }
  }

  Matrix _actionWithMatrices(Operation action, Matrix m) {
    if (!isEqualSize(m)) throw new ArgumentError("Matrices size is not equal");

    int rowCount = values.length;
    int columnCount = m.values[0].length;
    var matrix = newZeroMatrix(rowCount, columnCount);

    for (var i = 0; i < rowCount; i++) {
      for (var j = 0; j < columnCount; j++) {
        matrix.values[i][j] = action(values[i][j], m.values[i][j]);
      }
    }

    return matrix;
  }

  Matrix operator +(Matrix m) {
    return _actionWithMatrices(DefaultOperations["plus"], m);
  }

  Matrix operator -(Matrix m) {
    return _actionWithMatrices(DefaultOperations["minus"], m);
  }

  Matrix operator *(Matrix m) {
    if (values[0].length != m.values.length)
      throw new ArgumentError(
          "Matrices row size and column size doesn't match");

    int rowCount = values.length;
    int columnCount = m.values[0].length;
    var matrix = newZeroMatrix(rowCount, columnCount);

    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        for (int k = 0; k < values[0].length; k++)
          matrix.values[i][j] += values[i][k] * m.values[k][j];
      }
    }

    return matrix;
  }

  Matrix operator /(Matrix m) {
    throw new UnimplementedError();
  }

  List<List<num>> get values => _values;
}

Matrix newFiledMatrix(num fillNumber, int rowCount, int columnCount) {
  var values = new List<List<num>>(rowCount);

  for (var i = 0; i < rowCount; i++) {
    values[i] = new List<num>(columnCount)
      ..fillRange(0, columnCount, fillNumber);
  }

  return new Matrix(values);
}

Matrix newZeroMatrix(int rowCount, int columnCount) {
  return newFiledMatrix(0, rowCount, columnCount);
}
