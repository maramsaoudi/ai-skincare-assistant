class ScanResult {
  final int overallScore;
  final double oiliness;
  final double dryness;
  final double acne;
  final double redness;
  final String insight;

  ScanResult({
    required this.overallScore,
    required this.oiliness,
    required this.dryness,
    required this.acne,
    required this.redness,
    required this.insight,
  });

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      overallScore: json['overallScore'],
      acne: (json['acne'] as num).toDouble() / 100,
      oiliness: (json['oiliness'] as num).toDouble() / 100,
      dryness: (json['dryness'] as num).toDouble() / 100,
      redness: (json['redness'] as num).toDouble() / 100,
      insight: json['insight'] ?? '',
    );
  }
}
