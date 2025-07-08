import 'package:flutter/material.dart';
import 'constants/sizes.dart';

void main() {
  runApp(const VangtiChaiApp());
}

class VangtiChaiApp extends StatelessWidget {
  const VangtiChaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'VangtiChai',
      home: VangtiChaiHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VangtiChaiHome extends StatefulWidget {
  const VangtiChaiHome({super.key});

  @override
  State<VangtiChaiHome> createState() => _VangtiChaiHomeState();
}

class _VangtiChaiHomeState extends State<VangtiChaiHome> {
  String input = '';
  Map<int, int> noteCounts = {
    500: 0,
    100: 0,
    50: 0,
    20: 0,
    10: 0,
    5: 0,
    2: 0,
    1: 0,
  };

  final List<int> notes = [500, 100, 50, 20, 10, 5, 2, 1];

  void addDigit(String digit) {
    setState(() {
      input += digit;
      calculateNotes();
    });
  }

  void clearInput() {
    setState(() {
      input = '';
      noteCounts = {
        500: 0,
        100: 0,
        50: 0,
        20: 0,
        10: 0,
        5: 0,
        2: 0,
        1: 0,
      };
    });
  }

  void backspace() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        calculateNotes();
      }
    });
  }

  void calculateNotes() {
    int amount = int.tryParse(input) ?? 0;
    Map<int, int> counts = {};
    for (var note in notes) {
      counts[note] = amount ~/ note;
      amount %= note;
    }
    noteCounts = counts;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: const Text('VangtiChai')),
      body: isPortrait ? buildPortraitLayout() : buildLandscapeLayout(),
    );
  }

  Widget buildPortraitLayout() {
    return Row(
      children: [
        Expanded(child: buildNoteTable()),
        Container(
          width: 220,
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            children: [
              Text("Taka: $input", style: const TextStyle(fontSize: AppSizes.textLarge)),
              const SizedBox(height: AppSizes.spacing),
              Expanded(child: buildKeypad(context)),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLandscapeLayout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSmall),
          child: Text("Taka: $input", style: const TextStyle(fontSize: AppSizes.textLarge)),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: buildNoteTable()),
              Container(
                width: 300,
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: buildKeypad(context),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildNoteTable() {
    return ListView(
      children: noteCounts.entries.map((entry) {
        return ListTile(
          title: Text("৳${entry.key}", style: const TextStyle(fontSize: AppSizes.textMedium)),
          trailing: Text("${entry.value}", style: const TextStyle(fontSize: AppSizes.textMedium)),
        );
      }).toList(),
    );
  }

  Widget buildKeypad(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: isPortrait ? 3 : 5,
            mainAxisSpacing: AppSizes.paddingSmall,
            crossAxisSpacing: AppSizes.paddingSmall,
            children: keys.map((key) {
              return ElevatedButton(
                onPressed: () => addDigit(key),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(80, 60),
                  padding: EdgeInsets.zero,
                ),
                child: Center(
                  child: Text(
                    key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.textLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSizes.spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: backspace,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(100, 50),
              ),
              child: const Icon(Icons.backspace, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: clearInput,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(100, 50),
              ),
              child: const Icon(Icons.clear, color: Colors.white)
            ),
          ],
        ),
      ],
    );
  }
}
