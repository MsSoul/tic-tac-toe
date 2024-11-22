import 'package:flutter/material.dart';
import 'choose_player.dart';
import 'app_bar.dart'; 

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  TicTacToeScreenState createState() => TicTacToeScreenState();
}

class TicTacToeScreenState extends State<TicTacToeScreen> {
  List<int?> board = List.generate(9, (index) => null); // 3x3 grid
  int currentPlayer = 1;
  String? winner;
  int? player1Image;
  int? player2Image;

  // Reset the game and player images
  void resetGame() {
    setState(() {
      board = List.generate(9, (index) => null);
      currentPlayer = 1;
      winner = null;
      player1Image = null;
      player2Image = null;
    });
  }

  void makeMove(int index) {
    if (board[index] == null && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          winner = 'Player $currentPlayer wins!';
          showResultDialog(winner!);
        } else if (!board.contains(null)) {
          winner = 'Draw';
          showResultDialog(winner!);
        } else {
          currentPlayer = currentPlayer == 1 ? 2 : 1;
        }
      });
    }
  }

  bool checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != null &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  void showResultDialog(String resultMessage) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: Text(
            resultMessage,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: CustomAppBar.orangeButton(
            text: 'Play Again',
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              resetGame();
            },
          ),
        );
      },
    );
  }

  void showChoosePlayerDialog(int player) async {
    await showDialog(
      context: context,
      builder: (context) => ChoosePlayerDialog(
        player: player,
        onImageSelected: (selectedImage) {
          setState(() {
            if (player == 1) {
              player1Image = selectedImage;
            } else {
              player2Image = selectedImage;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Use the CustomAppBar here
          const CustomAppBar(
            title: 'TIC TAC TOE',
            titleStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          if (winner == null && (player1Image == null || player2Image == null))
            Column(
              children: [
                if (player1Image == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomAppBar.orangeButton(
                      text: 'Player 1: Choose Your Tile.',
                      onPressed: () => showChoosePlayerDialog(1),
                    ),
                  ),
                if (player2Image == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomAppBar.orangeButton(
                      text: 'Player 2: Choose Your Tile.',
                      onPressed: () => showChoosePlayerDialog(2),
                    ),
                  ),
              ],
            )
          else
            buildGameBoard(),
        ],
      ),
    );
  }

  Widget buildGameBoard() {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0), // Margin outside the grid
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => makeMove(index),
            child: Container(
              margin: const EdgeInsets.all(4.0), // Margin between tiles
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // How far the shadow spreads
                    blurRadius: 2, // Blur effect
                    offset: const Offset(2, 4), // Position of the shadow
                  ),
                ],
              ),
              child: Center(
                child: board[index] != null
                    ? Image.asset(
                        'assets/${board[index] == 1 ? player1Image : player2Image}.png',
                        height: 80,
                        width: 80,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    ),
  );
}

}
