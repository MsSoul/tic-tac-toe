import 'package:flutter/material.dart';
import 'app_bar.dart';

class PlayerAvatarSelection extends StatefulWidget {
  const PlayerAvatarSelection({super.key});

  @override
  State<PlayerAvatarSelection> createState() => _PlayerAvatarSelectionState();
}

class _PlayerAvatarSelectionState extends State<PlayerAvatarSelection> {
  // Map to hold selected avatars for players
  final Map<int, int> selectedAvatars = {};

  void openAvatarDialog(int player) {
    showDialog(
      context: context,
      builder: (context) => ChoosePlayerDialog(
        player: player,
        onImageSelected: (avatar) {
          setState(() {
            selectedAvatars[player] = avatar;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Player Avatar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int player = 1; player <= 2; player++) // Example: 2 players
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: CustomAppBar.orangeButton(
                    text: 'Player $player',
                    onPressed: () => openAvatarDialog(player),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ChoosePlayerDialog extends StatefulWidget {
  final int player;
  final Function(int) onImageSelected;

  const ChoosePlayerDialog({
    super.key,
    required this.player,
    required this.onImageSelected,
  });

  @override
  State<ChoosePlayerDialog> createState() => _ChoosePlayerDialogState();
}

class _ChoosePlayerDialogState extends State<ChoosePlayerDialog> {
  int? selectedAvatar;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Player ${widget.player}, Choose your tile.',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // First row with the first three avatars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = index + 1;
                    });
                    widget.onImageSelected(index + 1);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedAvatar == index + 1
                            ? Colors.orange
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/${index + 1}.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16), // Space between rows
            // Second row with the last three avatars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = index + 4;
                    });
                    widget.onImageSelected(index + 4);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedAvatar == index + 4
                            ? Colors.orange
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/${index + 4}.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Confirm Button
            SizedBox(
              width: 200.0,
              height: 50.0,
              child: CustomAppBar.orangeButton(
                text: 'Confirm',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
