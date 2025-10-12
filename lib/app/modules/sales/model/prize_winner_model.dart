class PrizeGroup {
  final String id;
  final String name;
  final int month;
  final int year;
  final List<PrizeEntry> entries;
  final List<TopUser> topUsers;

  PrizeGroup({
    required this.id,
    required this.name,
    required this.month,
    required this.year,
    required this.entries,
    required this.topUsers,
  });
}

class PrizeEntry {
  final String id;
  final int rank;
  final String name;
  final String icon;

  PrizeEntry({
    required this.id,
    required this.rank,
    required this.name,
    required this.icon,
  });
}

class TopUser {
  final String id;
  final String name;
  final String profilePicture;
  final List<Closer> closer;

  TopUser({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.closer,
  });
}

class Closer {
  final double amount;

  Closer({required this.amount});
}
