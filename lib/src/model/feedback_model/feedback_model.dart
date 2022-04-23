// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

class FeedbackModel {
  FeedbackModel({
    required this.success,
    required this.message,
    required this.feedbackData,
  });

  int success;
  String message;
  List<FeedbackDatum> feedbackData;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        success: json["success"] ?? 0,
        message: json["message"] ?? "",
        feedbackData: json["feedback_data"] == null
            ? List<FeedbackDatum>.from(<FeedbackDatum>[])
            : List<FeedbackDatum>.from(
                json["feedback_data"].map((x) => FeedbackDatum.fromJson(x))),
      );
}

class FeedbackDatum {
  FeedbackDatum({
    required this.entryDateF,
    required this.feedbackDetails,
  });

  String entryDateF;
  List<FeedbackDetail> feedbackDetails;

  factory FeedbackDatum.fromJson(Map<String, dynamic> json) => FeedbackDatum(
        entryDateF: json["EntryDateF"] ?? "",
        feedbackDetails: json["feedback_details"] == null
            ? List<FeedbackDetail>.from(<FeedbackDetail>[])
            : List<FeedbackDetail>.from(json["feedback_details"]
                .map((x) => FeedbackDetail.fromJson(x))),
      );
}

class FeedbackDetail {
  FeedbackDetail({
    required this.feedbackId,
    required this.title,
    required this.subject,
    required this.message,
    required this.entryBy,
    required this.entryDate,
  });

  String feedbackId;
  String title;
  String subject;
  String message;
  String entryBy;
  DateTime entryDate;

  factory FeedbackDetail.fromJson(Map<String, dynamic> json) => FeedbackDetail(
        feedbackId: json["FeedbackID"] ?? "",
        title: json["Title"] ?? "",
        subject: json["Subject"] ?? "",
        message: json["Message"] ?? "",
        entryBy: json["EntryBy"] ?? "",
        entryDate: json["EntryDate"] == null
            ? DateTime.parse("2022")
            : DateTime.parse(json["EntryDate"]),
      );
}
