import 'package:flutter/foundation.dart';

class Note {
  int? id;
  String title;
  String description;
  DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // ✅ ข้อ 26: แปลงข้อมูลเป็น Map เพื่อบันทึกลงฐานข้อมูล
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(), // แปลงวันที่เป็นข้อความ
    };
  }

  // ✅ แปลงจาก Map กลับมาเป็นวัตถุ Note
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']), // แปลงข้อความกลับเป็นวันที่
    );
  }
}