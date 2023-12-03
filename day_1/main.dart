import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int calibrationValue = 0;
  for (String line in lines) {
    for (int i = 0; i < line.length; i++) {
      final firstDigit = int.tryParse(line[i]);
      if (firstDigit != null) {
        calibrationValue += firstDigit * 10;
        break;
      }
    }

    for (int i = line.length - 1; i >= 0; i--) {
      final lastDigit = int.tryParse(line[i]);
      if (lastDigit != null) {
        calibrationValue += lastDigit;
        break;
      }
    }
  }
  print(calibrationValue);
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  int calibrationValue = 0;
  final wordDigitMap = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9
  };

  String pattern = '';

  for (MapEntry<String, int> entry in wordDigitMap.entries) {
    pattern += '|(${entry.key})|(${entry.value})';
  }

  pattern = pattern.substring(1);
  // (?=()) is necessary to recognize overlapping patterns
  pattern = '(?=($pattern)).';

  RegExp regExp = RegExp(pattern);

  for (String line in lines) {
    final matches = regExp.allMatches(line).toList();

    final String firstMatch = matches[0][1]!;
    int? firstDigit = int.tryParse(firstMatch);

    if (firstDigit == null) {
      firstDigit = wordDigitMap[firstMatch];
    }
    calibrationValue += firstDigit! * 10;

    final String lastMatch = matches[matches.length - 1][1]!;
    int? lastDigit = int.tryParse(lastMatch);

    if (lastDigit == null) {
      lastDigit = wordDigitMap[lastMatch];
    }
    calibrationValue += lastDigit!;
  }

  print(calibrationValue);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
