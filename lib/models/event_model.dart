class Event {
  final String? name;

  Event({this.name});

  static Event toEvent(Map<String, dynamic>? inMap) => Event(name: inMap?['name']);
  static Map<String, dynamic> toMap(Event inEvent) =>
      <String, dynamic>{'name': inEvent.name};
}
