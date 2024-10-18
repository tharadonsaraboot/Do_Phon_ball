import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/score_service.dart'; // Service for fetching and deleting score_ball data
import '../models/score_ball.dart';
import 'package:intl/intl.dart';
import 'add_score_screen.dart';
import 'edit_score_screen.dart'; // Import the add score screen

class GuestDashboardScreen extends StatefulWidget {
  @override
  _GuestDashboardScreenState createState() => _GuestDashboardScreenState();
}

class _GuestDashboardScreenState extends State<GuestDashboardScreen> {
  List<ScoreBall> scores = [];

  @override
  void initState() {
    super.initState();
    fetchScores();
  }

  Future<void> fetchScores() async {
    scores = await ScoreService().getAllScores();
    setState(() {});
  }

  // Add this function to delete a score
  Future<void> deleteScore(String id) async {
    try {
      await ScoreService().deleteScore(id);
      fetchScores(); // Refresh the list after deletion
    } catch (e) {
      print('Error deleting score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score List'),
        leading: IconButton(
          icon: Icon(Icons.logout), // Logout button icon
          onPressed: () {
            AuthService().logoutUser(context); // Call the logout function
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Add button in the AppBar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddScoreScreen()), // Navigate to add score screen
              );
            },
          ),
        ],
      ),
      body: scores.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, index) {
                final score = scores[index];
                return ListTile(
                  title: Text('${score.team1} vs ${score.team2}'),
                  subtitle: Text(
                    'Score: ${score.score1} - ${score.score2}\n'
                    'Date: ${DateFormat('dd/MM/yyyy').format(score.date)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScoreScreen(score: score),
                            ),
                          );
                        },
                      ),
                      // Delete button
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete this score?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteScore(score.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
