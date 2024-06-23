import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const String PLAYER_X = "X";
  static const String PLAYER_Y = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""]; //9 empty places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 144, 249, 219),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
            _restartButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Color.fromARGB(255, 157, 33, 240),
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.black26),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Text(
                          'Player A',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        'x',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.orangeAccent.shade700,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.black26),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Text(
                          'Player B',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Text(
                        'O',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w900),
                      )

                      // Text(
                      //   "$currentPlayer turn",
                      //   style: const TextStyle(
                      //     color: Colors.orange,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 170, top: 10),
              child: Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/4825/4825112.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 280, top: 10),
              child: Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/4825/4825044.png'))),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$currentPlayer turn",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
      ),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        //on click of box
        if (gameEnd || occupied[index].isNotEmpty) {
          //Return if game already ended or box already clicked
          return;
        }

        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        // color: occupied[index].isEmpty
        //     ? Colors.black26
        //     : occupied[index] == PLAYER_X
        //     ? Colors.black26
        //     : Colors.black26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: occupied[index].isEmpty
              ? Colors.black26
              : occupied[index] == PLAYER_X
                  ? Colors.black26
                  : Colors.black26,
        ),
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 85,
                color: occupied[index] == PLAYER_X
                    ? Colors.orangeAccent.shade700
                    : Colors.yellow,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  _restartButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            initializeGame();
          });
        },
        child: const Text("Restart Game"));
  }

  changeTurn() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_Y;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  checkForWinner() {
    //Define winning positions
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          //all equal means player won
          showGameOverMessage("Player $playerPosition0 Won");
          gameEnd = true;
          return;
        }
      }
    }
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        //at least one is empty not all are filled
        draw = false;
      }
    }

    if (draw) {
      showGameOverMessage("Draw");
      gameEnd = true;
    }
  }

  showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Game Over \n $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }
}
