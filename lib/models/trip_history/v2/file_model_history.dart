class FileModelHistory {
  final String? id;
  final String? sourceId;
  final String? originalName;
  final String? mimeType;
  final String? url;

  FileModelHistory({
    this.id,
    this.sourceId,
    this.originalName,
    this.mimeType,
    this.url,
  });

  factory FileModelHistory.fromJson(Map<String, dynamic> json) {
    return FileModelHistory(
      id: json['id'],
      sourceId: json['source_id'],
      originalName: json['original_name'],
      mimeType: json['mime_type'],
      url: json['url'],
    );
  }
}
