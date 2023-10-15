class Event {
  final String? nameEvent;
  final String? startDate;
  final String? endDate;
  final String? location;
  final String? description;
  final String? image;

  Event({
    this.nameEvent,
    this.startDate,
    this.endDate,
    this.location,
    this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameEvent': nameEvent,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
      'image': image,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      nameEvent: map['nameEvent'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      location: map['location'],
      description: map['description'],
      image: map['image'],
    );
  }
}
