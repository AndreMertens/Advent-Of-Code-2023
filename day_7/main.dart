import 'dart:io';

class CardHand {
  final String cards;
  final int bid;

  CardHand(this.cards, this.bid);

  final cardValues = {
    'A': 14,
    'K': 13,
    'Q': 12,
    'J': 11,
    'T': 10,
    '9': 9,
    '8': 8,
    '7': 7,
    '6': 6,
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2
  };

  int compareTo(CardHand compareHand) {
    for (int cardIndex = 0; cardIndex < cards.length; cardIndex++) {
      if (cardValues[this.cards[cardIndex]]! <
          cardValues[compareHand.cards[cardIndex]]!) {
        return -1;
      } else if (cardValues[this.cards[cardIndex]]! >
          cardValues[compareHand.cards[cardIndex]]!) {
        return 1;
      }
    }
    return 0;
  }
}

class CardHand2 {
  final String cards;
  final int bid;

  CardHand2(this.cards, this.bid);

  final cardValues = {
    'A': 14,
    'K': 13,
    'Q': 12,
    'T': 10,
    '9': 9,
    '8': 8,
    '7': 7,
    '6': 6,
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2,
    'J': 1,
  };

  int compareTo(CardHand2 compareHand) {
    for (int cardIndex = 0; cardIndex < cards.length; cardIndex++) {
      if (cardValues[this.cards[cardIndex]]! <
          cardValues[compareHand.cards[cardIndex]]!) {
        return -1;
      } else if (cardValues[this.cards[cardIndex]]! >
          cardValues[compareHand.cards[cardIndex]]!) {
        return 1;
      }
    }
    return 0;
  }
}

void solveFirstPart(File file) {
  final lines = file.readAsLinesSync();
  String pattern = '\\w+';
  RegExp regExp = RegExp(pattern);
  List<List<CardHand>> ranking = [[], [], [], [], [], [], []];

  for (String line in lines) {
    final matches = regExp.allMatches(line).toList();
    final cardHand = CardHand(matches[0][0]!, int.parse(matches[1][0]!));

    final cardCounter = {};

    for (int cardIndex = 0; cardIndex < cardHand.cards.length; cardIndex++) {
      final card = cardHand.cards[cardIndex];
      if (cardCounter[card] == null) {
        cardCounter[card] = 1;
      } else {
        cardCounter[card] += 1;
      }
    }

    var sortedCardCounter = Map.fromEntries(cardCounter.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    int rankingIndex = 0;

    if (sortedCardCounter.values.toList()[0] == 5) {
      rankingIndex = 6;
    } else if (sortedCardCounter.values.toList()[0] == 4) {
      rankingIndex = 5;
    } else if (sortedCardCounter.values.toList()[0] == 3) {
      if (sortedCardCounter.values.toList()[1] == 2) {
        rankingIndex = 4;
      } else {
        rankingIndex = 3;
      }
    } else if (sortedCardCounter.values.toList()[0] == 2) {
      if (sortedCardCounter.values.toList()[1] == 2) {
        rankingIndex = 2;
      } else {
        rankingIndex = 1;
      }
    }

    bool wasAdded = false;

    for (int groupIndex = 0;
        groupIndex < ranking[rankingIndex].length;
        groupIndex++) {
      final compareCardHand = ranking[rankingIndex][groupIndex];
      if (cardHand.compareTo(compareCardHand) < 0) {
        ranking[rankingIndex].insert(groupIndex, cardHand);
        wasAdded = true;
        break;
      }
    }

    if (!wasAdded) {
      ranking[rankingIndex].add(cardHand);
    }
  }
  final flatRanking = ranking.expand((i) => i).toList();

  int totalWinnings = 0;
  for (int flatRankingIndex = 0;
      flatRankingIndex < flatRanking.length;
      flatRankingIndex++) {
    totalWinnings += (flatRankingIndex + 1) * flatRanking[flatRankingIndex].bid;
  }
  print(totalWinnings);
}

void solveSecondPart(File file) {
  final lines = file.readAsLinesSync();
  String pattern = '\\w+';
  RegExp regExp = RegExp(pattern);
  List<List<CardHand2>> ranking = [[], [], [], [], [], [], []];

  for (String line in lines) {
    final matches = regExp.allMatches(line).toList();
    final cardHand = CardHand2(matches[0][0]!, int.parse(matches[1][0]!));

    final cardCounter = {};

    for (int cardIndex = 0; cardIndex < cardHand.cards.length; cardIndex++) {
      final card = cardHand.cards[cardIndex];
      if (cardCounter[card] == null) {
        cardCounter[card] = 1;
      } else {
        cardCounter[card] += 1;
      }
    }

    var sortedCardCounter = Map.fromEntries(cardCounter.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    int rankingIndex = 0;

    if (sortedCardCounter.values.toList()[0] == 5) {
      rankingIndex = 6;
    } else if (sortedCardCounter.values.toList()[0] == 4) {
      rankingIndex = 5;
    } else if (sortedCardCounter.values.toList()[0] == 3) {
      if (sortedCardCounter.values.toList()[1] == 2) {
        rankingIndex = 4;
      } else {
        rankingIndex = 3;
      }
    } else if (sortedCardCounter.values.toList()[0] == 2) {
      if (sortedCardCounter.values.toList()[1] == 2) {
        rankingIndex = 2;
      } else {
        rankingIndex = 1;
      }
    }

    bool wasAdded = false;

    for (int groupIndex = 0;
        groupIndex < ranking[rankingIndex].length;
        groupIndex++) {
      final compareCardHand = ranking[rankingIndex][groupIndex];
      if (cardHand.compareTo(compareCardHand) < 0) {
        ranking[rankingIndex].insert(groupIndex, cardHand);
        wasAdded = true;
        break;
      }
    }

    if (!wasAdded) {
      ranking[rankingIndex].add(cardHand);
    }
  }
  final flatRanking = ranking.expand((i) => i).toList();

  int totalWinnings = 0;
  for (int flatRankingIndex = 0;
      flatRankingIndex < flatRanking.length;
      flatRankingIndex++) {
    totalWinnings += (flatRankingIndex + 1) * flatRanking[flatRankingIndex].bid;
  }
  print(totalWinnings);
}

void main() {
  File file = File('input.txt');

  solveFirstPart(file);
  //solveSecondPart(file);
}
