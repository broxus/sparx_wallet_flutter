class SseMessage implements Comparable<SseMessage> {
  SseMessage({this.id, this.event, this.data});

  String? id;
  String? event;
  String? data;

  bool get isEmpty => id == null && event == null && data == null;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) json['id'] = id;
    if (event != null) json['event'] = event;
    if (data != null) json['data'] = data;
    return json;
  }

  @override
  int compareTo(SseMessage other) => id!.compareTo(other.id!);
}
