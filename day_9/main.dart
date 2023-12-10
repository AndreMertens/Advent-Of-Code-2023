import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int historyValueSum = 0;
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);

  for (String line in lines) {
    final sequence = regExp.allMatches(line).toList();
    final List<int> intSequence =
        sequence.map((e) => int.parse(e[0]!)).toList();
    bool allvaluesNotZeros = true;

    List<List<int>> history = [];
    history.add(intSequence);

    outerLoop:
    while (allvaluesNotZeros) {
      final List<int> diffSequence = [];
      for (int index = 1; index < history.last.length; index++) {
        diffSequence.add(history.last[index] - history.last[index - 1]);
      }
      if (diffSequence.isEmpty) {
        history.add([0]);
      } else {
        history.add(diffSequence);
      }

      for (int element in diffSequence) {
        if (element != 0) {
          continue outerLoop;
        }
      }
      allvaluesNotZeros = false;
    }

    int historyValue = 0;

    for (int index = history.length - 1; index >= 0; index--) {
      historyValue += history[index].last;
    }
    historyValueSum += historyValue;
  }
  print(historyValueSum);
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
  //solveSecondPart(file);
}
