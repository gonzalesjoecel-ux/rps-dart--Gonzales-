import 'dart:io';

/// Displays the title banner
void displayBanner() {
  print("=" * 38);
  print("   ROCK, PAPER, SCISSORS");
  print("=" * 38);
  print("");
}

/// Asks for a player's name with a default fallback if empty.
/// Returns a non-null String.
String getPlayerName(String defaultName) {
  String? input = stdin.readLineSync();
  if (input == null || input.trim().isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }
  return input.trim();
}

/// Validates a move string.
/// Returns the move in lowercase if valid, or null if invalid.
String? validateMove(String? input) {
  List<String> validMoves = ['rock', 'paper', 'scissors'];
  if (input == null) return null;
  String move = input.trim().toLowerCase();
  if (validMoves.contains(move)) {
    return move;
  }
  return null;
}

/// Keeps asking the player until a valid move is entered.
String getMove(String playerName) {
  while (true) {
    stdout.write("$playerName, enter your move (rock/paper/scissors): ");
    String? input = stdin.readLineSync();
    String? move = validateMove(input);
    if (move != null) {
      return move;
    }
    print("Invalid move. Please type rock, paper, or scissors.");
  }
}

/// Decides the winner of the round.
/// Returns the winner's name, or null if it's a draw.
String? decideWinner(String moveOne, String moveTwo, String nameOne, String nameTwo) {
  if (moveOne == moveTwo) {
    return null;
  }
  if ((moveOne == 'rock' && moveTwo == 'scissors') ||
      (moveOne == 'scissors' && moveTwo == 'paper') ||
      (moveOne == 'paper' && moveTwo == 'rock')) {
    return nameOne;
  }
  return nameTwo;
}

void main() {
  displayBanner();

  ///Enter users choices
  stdout.write("Enter Player 1 name: ");
  String playerOne = getPlayerName("Player 1");

  stdout.write("Enter Player 2 name: ");
  String playerTwo = getPlayerName("Player 2");

  ///Static Scores
  int playerOneScore = 0;
  int playerTwoScore = 0;
  int round = 0;
  String? playAgain;

  do {
    round++;
    print("");
    print("--- Round $round ---");

    String moveOne = getMove(playerOne);

    //Print blank lines to hide Player 1's choice
    for (int i = 0; i < 30; i++) {
      print("");
    }

    String moveTwo = getMove(playerTwo);

    print("");
    print("$playerOne chose $moveOne. $playerTwo chose $moveTwo.");

    String? winner = decideWinner(moveOne, moveTwo, playerOne, playerTwo);

    if (winner == playerOne) {
      playerOneScore++;
    } else if (winner == playerTwo) {
      playerTwoScore++;
    }

    String resultMsg = winner ?? "It's a draw!";
    if (winner != null) {
      resultMsg = "$winner wins the round!";
    }
    print("Result: $resultMsg");

    print("Score -> $playerOne: $playerOneScore | $playerTwo: $playerTwoScore");

    stdout.write("Play again? (y/n): ");
    playAgain = stdin.readLineSync()?.trim().toLowerCase();
  } while (playAgain == 'y');

  /// Display Final Score
  print("");
  print("===== FINAL SCORE =====");
  print("$playerOne: $playerOneScore | $playerTwo: $playerTwoScore");

  if (playerOneScore > playerTwoScore) {
    print("Overall winner: $playerOne");
  } else if (playerTwoScore > playerOneScore) {
    print("Overall winner: $playerTwo");
  } else {
    print("Overall winner: Nobody — it's a tie!");
  }
}
