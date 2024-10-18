import 'package:flutter/material.dart';
import '../service/score_service.dart'; // Import the score service

class AddScoreScreen extends StatefulWidget {
  @override
  _AddScoreScreenState createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();
  final _score1Controller = TextEditingController();
  final _score2Controller = TextEditingController();
  DateTime? _selectedDate;

  // Function to handle adding the new score
  Future<void> _addScore() async {
    if (_team1Controller.text.isEmpty ||
        _team2Controller.text.isEmpty ||
        _score1Controller.text.isEmpty ||
        _score2Controller.text.isEmpty ||
        _selectedDate == null) {
      // Show an error if any field is incomplete
      return;
    }

    try {
      await ScoreService().addScore(
        team1: _team1Controller.text,
        team2: _team2Controller.text,
        score1: int.parse(_score1Controller.text),
        score2: int.parse(_score2Controller.text),
        date: _selectedDate!,
      );
      Navigator.pop(context); // Go back after saving
    } catch (error) {
      print('Failed to add score: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Score')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _team1Controller,
              decoration: InputDecoration(labelText: 'Team 1'),
            ),
            TextField(
              controller: _team2Controller,
              decoration: InputDecoration(labelText: 'Team 2'),
            ),
            TextField(
              controller: _score1Controller,
              decoration: InputDecoration(labelText: 'Score 1'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _score2Controller,
              decoration: InputDecoration(labelText: 'Score 2'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: Text(_selectedDate == null ? 'Select Date' : _selectedDate.toString()),
            ),
            ElevatedButton(
              onPressed: _addScore,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
