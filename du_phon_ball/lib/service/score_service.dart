import 'package:pocketbase/pocketbase.dart';
import '../models/score_ball.dart';

class ScoreService {
  final PocketBase pb = PocketBase('http://127.0.0.1:8090'); // Adjust based on your server

  Future<List<ScoreBall>> getAllScores() async {
    final response = await pb.collection('score_ball').getFullList();
    return response.map((e) {
      if (e is RecordModel) {
        return ScoreBall.fromJson(e.toJson());
      }
      throw Exception('Invalid data format');
    }).toList();
  }

  Future<void> addScore({
    required String team1,
    required String team2,
    required int score1,
    required int score2,
    required DateTime date,
  }) async {
    await pb.collection('score_ball').create(body: {
      'team1': team1,
      'team2': team2,
      'score1': score1,
      'score2': score2,
      'date': date.toIso8601String(),
    });
  }

  Future<void> updateScore({
    required String id,
    required String team1,
    required String team2,
    required int score1,
    required int score2,
    required DateTime date,
  }) async {
    await pb.collection('score_ball').update(id, body: {
      'team1': team1,
      'team2': team2,
      'score1': score1,
      'score2': score2,
      'date': date.toUtc().toIso8601String(),
    });
  }

    // Add this method to delete a score record
  Future<void> deleteScore(String id) async {
    try {
      await pb.collection('score_ball').delete(id);
    } catch (e) {
      throw Exception('Failed to delete score: $e');
    }
  }
}