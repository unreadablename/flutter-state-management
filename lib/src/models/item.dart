class Item {
  Item({
    this.id,
    this.title,
    this.description = '',
    this.isResolved = false,
//    this.type,
//    this.contentLevels,
//    this.tagNames,
//    this.startTimestamp,
//    this.endTimestamp,
//    this.isFeatured: false,
//    this.room,
//    this.speakers,
//    this.relatedSessions,
  });

  final String id;
  final String title;
  final String description;
  final bool isResolved;
////  final List<String> contentLevels;
////  final List<String> tagNames;
//  final List<dynamic> contentLevels;
//  final List<dynamic> tagNames;
//  final int startTimestamp;
//  final int endTimestamp;
//  final bool isFeatured;
////  final Room room;
//  final String room;
////  final List<String> speakers;
//  final List<dynamic> speakers;
////  final List<String> relatedSessions;
//  final List<dynamic> relatedSessions;

//  Item({
//    this.id,
//    this.title,
//    this.description,
//    this.isResolved,
////    this.type,
////    this.contentLevels,
////    this.tagNames,
////    this.startTimestamp,
////    this.endTimestamp,
////    this.isFeatured: false,
////    this.room,
////    this.speakers,
////    this.relatedSessions,
//  });


//  factory Item.fromJson(Map<String, dynamic> json) {
//    if (json == null)
//      return null;
//
//    return Item(
//      id: json['id'],
//      title: json['title'] ?? '[null]',
//      description: json['description'] ?? '',
//      type: json['type'] ?? '',
//      contentLevels: json['contentLevels'] ?? [],
//      tagNames: json['tagNames'] ?? [],
//      startTimestamp: json['startTimestamp'] ?? 0,
//      endTimestamp: json['endTimestamp'] ?? 0,
//      isFeatured: json['isFeatured'] ?? false,
//      room: json['room'] ?? '',
//      speakers: json['speakers'] ?? [],
//      relatedSessions: json['relatedSessions'] ?? [],
//    );
//  }
}