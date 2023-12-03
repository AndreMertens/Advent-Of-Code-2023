import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int idSum = 0;
  String pattern = '\\d+ (blue|red|green)';
  RegExp regExp = RegExp(pattern);
  final colorMaxAmountMap = {'red': 12, 'green': 13, 'blue': 14};

  for (String line in lines) {
    final List<String> stringElements = line.split(':');
    final String games = stringElements[1];

    final matches = regExp.allMatches(games).toList();

    bool isPossible = true;

    for (RegExpMatch match in matches) {
      List<String> amountAndColor = match[0]!.split(' ');

      int amount = int.parse(amountAndColor[0]);
      String color = amountAndColor[1];

      if (amount > colorMaxAmountMap[color]!) {
        isPossible = false;
        break;
      }
    }
    if (isPossible) {
      final String gameLabel = stringElements[0];
      final int gameId = int.parse(gameLabel.replaceFirst('Game ', ''));
      idSum += gameId;
    }
  }
  print(idSum);
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  int powerSum = 0;
  String pattern = '\\d+ (blue|red|green)';
  RegExp regExp = RegExp(pattern);

  for (String line in lines) {
    final List<String> stringElements = line.split(':');
    final String games = stringElements[1];

    final matches = regExp.allMatches(games).toList();

    final maxAmounts = {'blue': 0, 'red': 0, 'green': 0};

    for (RegExpMatch match in matches) {
      List<String> amountAndColor = match[0]!.split(' ');

      int amount = int.parse(amountAndColor[0]);
      String color = amountAndColor[1];

      if (amount > maxAmounts[color]!) {
        maxAmounts[color] = amount;
      }
    }

    powerSum += maxAmounts['blue']! * maxAmounts['red']! * maxAmounts['green']!;
  }
  print(powerSum);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
