import 'dart:io';

class Instruction {
  final String left;
  final String right;

  const Instruction(this.left, this.right);
}

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int step = 0;
  String pattern = '\\w+';
  RegExp regExp = RegExp(pattern);
  Map<String, Instruction> instructionMap = {};

  for (String line in lines) {
    final matches = regExp.allMatches(line).toList();
    if (matches.length == 3) {
      instructionMap[matches[0][0]!] =
          Instruction(matches[1][0]!, matches[2][0]!);
    }
  }

  String currentField = 'AAA';

  final String sequence = lines[0];

  while (currentField != 'ZZZ') {
    if (sequence[step % sequence.length] == 'L') {
      currentField = instructionMap[currentField]!.left;
    } else {
      currentField = instructionMap[currentField]!.right;
    }
    step += 1;
  }

  print(step);
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
