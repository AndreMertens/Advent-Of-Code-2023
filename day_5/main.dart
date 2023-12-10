import 'dart:io';

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  String pattern = '\\d+';
  RegExp regExp = RegExp(pattern);
  List<RegExpMatch> matches = regExp.allMatches(lines[0]).toList();

  final List<int> start = [for (final match in matches) int.parse(match[0]!)];
  final List<int> end = List.generate(matches.length, (index) => -1);

  for (int lineIndex = 1; lineIndex < lines.length; lineIndex++) {
    String line = lines[lineIndex];
    if (line == '') {
      continue;
    }

    final match = regExp.allMatches(line).toList();
    if (match.length != 3) {
      for (int endIndex = 0; endIndex < start.length; endIndex++) {
        int element = end[endIndex];
        if (element != -1) {
          start[endIndex] = element;
          end[endIndex] = -1;
        }
      }
    } else {
      int from = int.parse(match[1][0]!);
      int to = int.parse(match[0][0]!);
      int counter = int.parse(match[2][0]!);

      for (int startIndex = 0; startIndex < start.length; startIndex++) {
        int element = start[startIndex];
        if (element >= from && element < from + counter) {
          end[startIndex] = to + element - from;
          start[startIndex] = -1;
        }
      }
    }
  }

  for (int startIndex = 0; startIndex < start.length; startIndex++) {
    int element = start[startIndex];
    if (element != -1) {
      end[startIndex] = element;
      start[startIndex] = -1;
    }
  }

  end.sort();
  print(end[0]);
}

void solveSecondPart(File file) {
  // final lines = file.readAsLinesSync();
  // String pattern = '\\d+';
  // RegExp regExp = RegExp(pattern);
  // List<RegExpMatch> matches = regExp.allMatches(lines[0]).toList();
  // final List<int> seedDeclaration = [
  //   for (final match in matches) int.parse(match[0]!)
  // ];
  // final List<int> start = [];

  // for (int seedDeclarationIndex = 0;
  //     seedDeclarationIndex < seedDeclaration.length;
  //     seedDeclarationIndex += 2) {
  //   start.addAll(List.generate(seedDeclaration[seedDeclarationIndex + 1],
  //       (index) => seedDeclaration[seedDeclarationIndex] + index));
  // }

  // final List<int> end = [];

  // for (int lineIndex = 1; lineIndex < lines.length; lineIndex++) {
  //   String line = lines[lineIndex];
  //   if (line == '') {
  //     continue;
  //   }

  //   final match = regExp.allMatches(line).toList();
  //   if (match.length != 3) {
  //     start.removeWhere((element) => element == -1);
  //     start.addAll(end);
  //     end.clear();
  //   } else {
  //     int from = int.parse(match[1][0]!);
  //     int to = int.parse(match[0][0]!);
  //     int counter = int.parse(match[2][0]!);

  //     for (int startIndex = 0; startIndex < start.length; startIndex += 2) {
  //       int element = start[startIndex];
  //       int elementCounter = start[startIndex + 1];
  //       if (element >= from && element < from + counter) {
  //         end.add(to + element - from);
  //         final diff = from + counter - element;
  //         start[startIndex] = -1;
  //         start[startIndex + 1] = -1;
  //         star
  //       }
  //     }
  //   }
  // }

  // end.addAll(start);
  // start.clear();

  // print(end);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  solveSecondPart(file);
}
