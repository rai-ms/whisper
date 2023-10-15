class Share {
  final String shareBy;
  final String postedBy;
  final String sharedAt;

  Share({
    required this.shareBy,
    required this.postedBy,
    required this.sharedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'shareBy': shareBy,
      'postedBy': postedBy,
      'sharedAt': sharedAt,
    };
  }

  factory Share.fromMap(Map<String, dynamic> map) {
    return Share(
      shareBy: map['shareBy'],
      postedBy: map['postedBy'],
      sharedAt: map['sharedAt'],
    );
  }
}
