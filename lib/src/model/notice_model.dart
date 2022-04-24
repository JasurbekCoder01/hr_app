import 'dart:convert';

NoticeModel noticeModelFromJson(String str) =>
    NoticeModel.fromJson(json.decode(str));

class NoticeModel {
  NoticeModel({
    required this.success,
    required this.message,
    required this.noticeData,
  });

  int success;
  String message;
  List<NoticeDatum> noticeData;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        success: json["success"] ?? 0,
        message: json["message"] ?? "",
        noticeData: json["notice_data"] == null
            ? List<NoticeDatum>.from(<NoticeDatum>[])
            : List<NoticeDatum>.from(
                json["notice_data"].map((x) => NoticeDatum.fromJson(x))),
      );
}

class NoticeDatum {
  NoticeDatum({
    required this.noticeId,
    required this.title,
    required this.subject,
    required this.message,
    required this.noticePublishDate,
    required this.entryBy,
    required this.entryDate,
    required this.active,
  });

  String noticeId;
  String title;
  String subject;
  String message;
  DateTime noticePublishDate;
  String entryBy;
  DateTime entryDate;
  String active;

  factory NoticeDatum.fromJson(Map<String, dynamic> json) => NoticeDatum(
        noticeId: json["NoticeID"] ?? "",
        title: json["Title"] ?? "",
        subject: json["Subject"] ?? "",
        message: json["Message"] ?? "",
        noticePublishDate: json["NoticePublishDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["NoticePublishDate"]),
        entryBy: json["EntryBy"] ?? "",
        entryDate: json["EntryDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["EntryDate"]),
        active: json["Active"] ?? "",
      );
}
