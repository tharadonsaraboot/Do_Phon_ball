import 'package:flutter/material.dart';
import '../service/score_service.dart'; // Import the Score Service
import '../models/score_ball.dart';
import 'package:intl/intl.dart';

class EditScoreScreen extends StatefulWidget {
  final ScoreBall score; // Pass the score object to the screen

  EditScoreScreen({required this.score});

  @override
  _EditScoreScreenState createState() => _EditScoreScreenState();
}

class _EditScoreScreenState extends State<EditScoreScreen> {
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();
  final _score1Controller = TextEditingController();
  final _score2Controller = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _team1Controller.text = widget.score.team1;
    _team2Controller.text = widget.score.team2;
    _score1Controller.text = widget.score.score1.toString();
    _score2Controller.text = widget.score.score2.toString();
    _selectedDate = widget.score.date; // Initialize the date
  }

  Future<void> _updateScore() async {
    try {
      await ScoreService().updateScore(
        id: widget.score.id, // ID of the record
        team1: _team1Controller.text,
        team2: _team2Controller.text,
        score1: int.parse(_score1Controller.text),
        score2: int.parse(_score2Controller.text),
        date: _selectedDate!,
      );
      Navigator.pop(context); // Go back to the previous screen after saving
    } catch (error) {
      print('Failed to update score: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Score')),
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
            SizedBox(height: 16.0),
            Text(
              _selectedDate == null
                  ? 'No Date Chosen!'
                  : 'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
            ),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateScore,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
