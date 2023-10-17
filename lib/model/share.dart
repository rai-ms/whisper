class Share {
  final String id;
  final String shareBy;
  final String postedBy;
  final String sharedAt;

  Share({
    required this.id,
    required this.shareBy,
    required this.postedBy,
    required this.sharedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shareBy': shareBy,
      'postedBy': postedBy,
      'sharedAt': sharedAt,
    };
  }

  factory Share.fromMap(Map<String, dynamic> map) {
    return Share(
      id: map['id'],
      shareBy: map['shareBy'],
      postedBy: map['postedBy'],
      sharedAt: map['sharedAt'],
    );
  }
}
