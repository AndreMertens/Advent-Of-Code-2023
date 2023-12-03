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
  String pattern1 = '\\d+';
  RegExp regExp1 = RegExp(pattern1);

  for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    final line = lines[lineIndex];
    final matches = regExp1.allMatches(line).toList();

    for (RegExpMatch match in matches) {
      int? secondNumber;

      for (int numberIndex = match.start - 1;
          numberIndex <= match.end;
          numberIndex++) {
        if (numberIndex < 0) {
          continue;
        }
        if (numberIndex >= line.length) {
          continue;
        }

        if (numberIndex == match.start - 1) {
          final String characterSameLine = line[numberIndex];
          if (characterSameLine == '*') {
            if (lineIndex + 1 < lines.length) {
              final belowFromStar = getLastNumberOfStringIfPossible(
                  lines[lineIndex + 1].substring(0, numberIndex + 1));

              if (belowFromStar != null) {
                secondNumber = int.parse(belowFromStar);
                break;
              }

              final belowLeftFromStar = getLastNumberOfStringIfPossible(
                  lines[lineIndex + 1].substring(0, numberIndex));

              if (belowLeftFromStar != null) {
                secondNumber = int.parse(belowLeftFromStar);
                break;
              }
            }
          }
        }

        if (numberIndex == match.end) {
          if (lineIndex - 1 >= 0) {
            final String characterUpperLine = lines[lineIndex - 1][numberIndex];
            if (characterUpperLine == '*') {
              if (numberIndex + 1 < line.length) {
                final rightLowerFromStar = getFirstNumberOfStringIfPossible(
                    line.substring(numberIndex + 1));
                if (rightLowerFromStar != null) {
                  secondNumber = int.parse(rightLowerFromStar);
                  break;
                }
              }
            }
          }

          final String characterSameLine = line[numberIndex];
          if (characterSameLine == '*') {
            if (numberIndex + 1 < line.length) {
              final rightFromStar = getFirstNumberOfStringIfPossible(
                  line.substring(numberIndex + 1));
              if (rightFromStar != null) {
                secondNumber = int.parse(rightFromStar);
                break;
              }
            }

            if (lineIndex + 1 < lines.length) {
              final belowFromStar = getFirstNumberOfStringIfPossible(
                  lines[lineIndex + 1].substring(numberIndex));

              if (belowFromStar != null) {
                secondNumber = int.parse(belowFromStar);
                break;
              }

              if (numberIndex + 1 < line.length) {
                final belowRightFromStar = getFirstNumberOfStringIfPossible(
                    lines[lineIndex + 1].substring(numberIndex + 1));

                if (belowRightFromStar != null) {
                  secondNumber = int.parse(belowRightFromStar);
                  break;
                }
              }
            }
          }
        }

        if (lineIndex + 1 >= lines.length) {
          continue;
        }

        final String characterLowerLine = lines[lineIndex + 1][numberIndex];

        if (characterLowerLine == '*') {
          if (numberIndex == match.end && numberIndex + 1 < line.length) {
            final upperRightFromStar = getFirstNumberOfStringIfPossible(
                line.substring(numberIndex + 1));
            if (upperRightFromStar != null) {
              secondNumber = int.parse(upperRightFromStar);
              break;
            }
          }

          final leftFromStar = getLastNumberOfStringIfPossible(
              lines[lineIndex + 1].substring(0, numberIndex));
          if (leftFromStar != null) {
            secondNumber = int.parse(leftFromStar);
            break;
          }

          if (numberIndex + 1 < line.length) {
            final rightFromStar = getFirstNumberOfStringIfPossible(
                lines[lineIndex + 1].substring(numberIndex + 1));
            if (rightFromStar != null) {
              secondNumber = int.parse(rightFromStar);
              break;
            }
          }

          if (lineIndex + 2 >= lines.length) {
            continue;
          }

          final belowLeftFromStar = getLastNumberOfStringIfPossible(
                  lines[lineIndex + 2].substring(0, numberIndex)) ??
              '';

          final belowFromStar = getFirstNumberOfStringIfPossible(
                  lines[lineIndex + 2].substring(numberIndex)) ??
              '';

          final combinedString = belowLeftFromStar + belowFromStar;

          if (int.tryParse(combinedString) != null) {
            secondNumber = int.parse(combinedString);
            break;
          }

          if (numberIndex + 1 < line.length) {
            final belowRightFromStar = getFirstNumberOfStringIfPossible(
                lines[lineIndex + 2].substring(numberIndex + 1));
            if (belowRightFromStar != null) {
              secondNumber = int.parse(belowRightFromStar);
              break;
            }
          }
        }
      }

      if (secondNumber != null) {
        final int firstNumber = int.parse(match[0]!);
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
