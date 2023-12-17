import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  int historyValueSum = 0;
  String pattern = '-*\\d+';
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

      history.add(diffSequence);

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
  int historyValueSum = 0;
  String pattern = '-*\\d+';
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

      history.add(diffSequence);

      for (int element in diffSequence) {
        if (element != 0) {
          continue outerLoop;
        }
      }
      allvaluesNotZeros = false;
    }

    int historyValue = 0;

    for (int index = history.length - 1; index >= 0; index--) {
      historyValue = history[index].first - historyValue;
    }
    historyValueSum += historyValue;
  }
  print(historyValueSum);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
