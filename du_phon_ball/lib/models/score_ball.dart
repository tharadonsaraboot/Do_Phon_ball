class ScoreBall {
  final String id;
  final String team1;
  final String team2;
  final int score1;
  final int score2;
  final DateTime date;

  ScoreBall({
    required this.id,
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.date,
  });

  factory ScoreBall.fromJson(Map<String, dynamic> json) {
    return ScoreBall(
      id: json['id'] ?? '',
      team1: json['team1'] ?? '',
      team2: json['team2'] ?? '',
      score1: json['score1'] ?? 0,
      score2: json['score2'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
}
