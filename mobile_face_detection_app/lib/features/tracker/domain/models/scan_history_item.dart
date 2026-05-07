class ScanHistoryItem {
  final String id;
  final double skinScore;
  final DateTime createdAt;

  ScanHistoryItem({
    required this.id,
    required this.skinScore,
    required this.createdAt,
  });

  factory ScanHistoryItem.fromJson(Map<String, dynamic> json) {
    return ScanHistoryItem(
      id: json['id'],
      skinScore: (json['skinScore'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
