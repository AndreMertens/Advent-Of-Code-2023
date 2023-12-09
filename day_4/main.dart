import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int pointSum = 0;
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);

  for (String line in lines) {
    List<String> cardElements = line.split(':');
    cardElements = cardElements[1].split('|');

    final winningNumberMatches = regExp.allMatches(cardElements[0]).toList();
    final List<String> winningNumbers =
        winningNumberMatches.map((match) => match[0]!).toList();

    final numberMatches = regExp.allMatches(cardElements[1]).toList();
    final List<String> numbers =
        numberMatches.map((match) => match[0]!).toList();

    int points = 0;

    for (String number in numbers) {
      if (winningNumbers.contains(number)) {
        if (points == 0) {
          points = 1;
        } else {
          points *= 2;
        }
      }
    }
    pointSum += points;
  }
  print(pointSum);
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  int cardAmount = 0;
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);
  final cardCopies = List.generate(lines.length, (index) => 0);

  for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    final line = lines[lineIndex];
    List<String> cardElements = line.split(':');
    cardElements = cardElements[1].split('|');

    final winningNumberMatches = regExp.allMatches(cardElements[0]).toList();
    final List<String> winningNumbers =
        winningNumberMatches.map((match) => match[0]!).toList();

    final numberMatches = regExp.allMatches(cardElements[1]).toList();
    final List<String> numbers =
        numberMatches.map((match) => match[0]!).toList();

    int matchingNumbersAmount = 0;

    for (String number in numbers) {
      if (winningNumbers.contains(number)) {
        matchingNumbersAmount += 1;
      }
    }

    for (int counter = 0; counter < matchingNumbersAmount; counter++) {
      if (lineIndex + counter + 1 <= cardCopies.length) {
        cardCopies[lineIndex + counter + 1] += 1 + cardCopies[lineIndex];
      }
    }

    cardAmount += 1 + cardCopies[lineIndex];
  }
  print(cardAmount);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
