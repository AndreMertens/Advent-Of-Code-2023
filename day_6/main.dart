import 'dart:io';
import 'dart:math';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);

  final timeMatches = regExp.allMatches(lines[0]).toList();
  final distanceMatches = regExp.allMatches(lines[1]).toList();

  int waysToWinProd = 1;

  for (int matchIndex = 0; matchIndex < timeMatches.length; matchIndex++) {
    final time = int.parse(timeMatches[matchIndex][0]!);
    final distance = int.parse(distanceMatches[matchIndex][0]!);

    int first = (time / 2 + sqrt(pow(time / 2, 2) - distance) - 0.001).floor();
    int second = (time / 2 - sqrt(pow(time / 2, 2) - distance) + 0.001).ceil();

    final int waysToWin = first - second + 1;
    waysToWinProd *= waysToWin;
  }

  print(waysToWinProd);
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);

  final timeMatches = regExp.allMatches(lines[0]).toList();
  final distanceMatches = regExp.allMatches(lines[1]).toList();
  String timeString = '';
  String distanceString = '';

  for (int matchIndex = 0; matchIndex < timeMatches.length; matchIndex++) {
    timeString += timeMatches[matchIndex][0]!;
    distanceString += distanceMatches[matchIndex][0]!;
  }

  final time = int.parse(timeString);
  final distance = int.parse(distanceString);
  int first = (time / 2 + sqrt(pow(time / 2, 2) - distance) - 0.001).floor();
  int second = (time / 2 - sqrt(pow(time / 2, 2) - distance) + 0.001).ceil();

  final int waysToWin = first - second + 1;

  print(waysToWin);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
