import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int partNumberSum = 0;
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);

  for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    final line = lines[lineIndex];
    final matches = regExp.allMatches(line).toList();

    for (RegExpMatch match in matches) {
      bool isPartNumber = false;

      outerLoop:
      for (int numberIndex = match.start - 1;
          numberIndex <= match.end;
          numberIndex++) {
        if (numberIndex < 0) {
          continue;
        }
        if (numberIndex >= line.length) {
          continue;
        }

        for (int i = -1; i <= 1; i++) {
          if (lineIndex + i < 0) {
            continue;
          }
          if (lineIndex + i >= lines.length) {
            continue;
          }
          if (i == 0 &&
              numberIndex != match.start - 1 &&
              numberIndex != match.end) {
            continue;
          }

          final String character = lines[lineIndex + i][numberIndex];
          if (character != '.') {
            isPartNumber = true;
            break outerLoop;
          }
        }
      }

      if (isPartNumber) {
        final int number = int.parse(match[0]!);
        partNumberSum += number;
      }
    }
  }
  print(partNumberSum);
}

String? getFirstNumberOfStringIfPossible(String string) {
  String pattern = '^\\d+';
  RegExp regExp = RegExp(pattern);
  RegExpMatch? match = regExp.firstMatch(string);
  if (match != null) {
    return match[0];
  }
  return null;
}

String? getLastNumberOfStringIfPossible(String string) {
  String pattern = '\\d+\$';
  RegExp regExp = RegExp(pattern);
  RegExpMatch? match = regExp.firstMatch(string);
  if (match != null) {
    return match[0];
  }
  return null;
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  int gearRatioSum = 0;
  String pattern = '\\*';
  RegExp regExp1 = RegExp(pattern);

  for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    final line = lines[lineIndex];
    final matches = regExp1.allMatches(line).toList();

    for (RegExpMatch match in matches) {
      int? firstNumber;
      int? secondNumber;

      for (int i = -1; i <= 1; i++) {
        if (lineIndex + i < 0) {
          continue;
        }
        if (lineIndex + i >= lines.length) {
          continue;
        }

        if (i == 0) {
          final String? leftOfStar = getLastNumberOfStringIfPossible(
              lines[lineIndex + i].substring(0, match.start));
          if (leftOfStar != null && firstNumber == null) {
            firstNumber = int.parse(leftOfStar);
          } else if (leftOfStar != null && secondNumber == null) {
            secondNumber = int.parse(leftOfStar);
            break;
          }

          final String? rightOfStar = getFirstNumberOfStringIfPossible(
              lines[lineIndex + i].substring(match.end));

          if (rightOfStar != null && firstNumber == null) {
            firstNumber = int.parse(rightOfStar);
          } else if (rightOfStar != null && secondNumber == null) {
            secondNumber = int.parse(rightOfStar);
            break;
          }
        } else {
          final String aboveOrBelowLeftOfStar = getLastNumberOfStringIfPossible(
                  lines[lineIndex + i].substring(0, match.start)) ??
              '';

          final String aboveOrBelowStar = getFirstNumberOfStringIfPossible(
                  lines[lineIndex + i].substring(match.start)) ??
              '';

          final combinedString = aboveOrBelowLeftOfStar + aboveOrBelowStar;

          if (int.tryParse(combinedString) != null) {
            int combinedNumber = int.parse(combinedString);

            if (firstNumber == null) {
              firstNumber = combinedNumber;
            } else if (secondNumber == null) {
              secondNumber = combinedNumber;
              break;
            }
          }

          if (aboveOrBelowStar == '') {
            final String? upperOrBelowRightFromStar =
                getFirstNumberOfStringIfPossible(
                    lines[lineIndex + i].substring(match.end));

            if (upperOrBelowRightFromStar != null && firstNumber == null) {
              firstNumber = int.parse(upperOrBelowRightFromStar);
            } else if (upperOrBelowRightFromStar != null &&
                secondNumber == null) {
              secondNumber = int.parse(upperOrBelowRightFromStar);
              break;
            }
          }
        }
      }
      if (firstNumber != null && secondNumber != null) {
        gearRatioSum += firstNumber * secondNumber;
      }
    }
  }

  print(gearRatioSum);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
