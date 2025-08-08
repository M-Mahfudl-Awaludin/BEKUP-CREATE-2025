dynamic studentInfo() {
  // TODO 1

  var name = 'M Mahfudl Awaludin';
  var favNumber = 2;
  var isDicodingStudent = true;

  // End of TODO 1
  return [name, favNumber, isDicodingStudent];
}

dynamic circleArea(num r) {
  if (r < 0) {
    return 0.0;
  } else {
    const double pi = 3.1415926535897932; //π sama dengan library dart.math;

    // TODO 2

    return pi * r * r;

    // End of TODO 2
  }
}

int? parseAndAddOne(String? input) {
  // TODO 3

  if (input == null) {
    return null;
  }

  try {
    final intValue = int.parse(input);
    return intValue + 1;
  } catch (e) {
    throw Exception('Input harus berupa angka');
  }

  // End of TODO 3
}
