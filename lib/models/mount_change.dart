/// Represents a mount count change for a single character after a polling cycle.
class MountChange {
  final String characterName;
  final int gained;
  final int newTotal;
  final int previousRank;
  final int newRank;

  const MountChange({
    required this.characterName,
    required this.gained,
    required this.newTotal,
    required this.previousRank,
    required this.newRank,
  });

  /// Positive = moved up the ranking, negative = moved down, 0 = same.
  int get rankDelta => previousRank - newRank;
}
