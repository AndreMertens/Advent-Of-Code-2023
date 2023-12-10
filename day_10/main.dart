import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();

  int x = 110;
  int y = 41;
  int prevX = 111;
  int prevY = 41;
  int step = 1;

  // int x = 0;
  // int y = 3;
  // int prevX = 0;
  // int prevY = 2;
  // int step = 1;

  while (lines[y][x] != 'S') {
    if (lines[y][x] == '|') {
      if (y > prevY) {
        prevX = x;
        prevY = y;
        y += 1;
      } else {
        prevX = x;
        prevY = y;
        y -= 1;
      }
    } else if (lines[y][x] == '-') {
      if (x > prevX) {
        prevX = x;
        prevY = y;
        x += 1;
      } else {
        prevX = x;
        prevY = y;
        x -= 1;
      }
    } else if (lines[y][x] == 'L') {
      if (y > prevY) {
        prevX = x;
        prevY = y;
        x += 1;
      } else {
        prevX = x;
        prevY = y;
        y -= 1;
      }
    } else if (lines[y][x] == 'J') {
      if (x > prevX) {
        prevX = x;
        prevY = y;
        y -= 1;
      } else {
        prevX = x;
        prevY = y;
        x -= 1;
      }
    } else if (lines[y][x] == '7') {
      if (x > prevX) {
        prevX = x;
        prevY = y;
        y += 1;
      } else {
        prevX = x;
        prevY = y;
        x -= 1;
      }
    } else if (lines[y][x] == 'F') {
      if (x < prevX) {
        prevX = x;
        prevY = y;
        y += 1;
      } else {
        prevX = x;
        prevY = y;
        x += 1;
      }
    }
    step += 1;
  }
  print(step ~/ 2);
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
