import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../repository/notes_repository.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
  }

  Future<void> _insertNote() async {
    final note = Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await NotesRepository.insert(note);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('บันทึกสำเร็จ!')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
    );
    await NotesRepository.update(note);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('แก้ไขสำเร็จ!')),
      );
      Navigator.pop(context);
    }
  }

  // ✅ ข้อ 34: ฟังก์ชันลบข้อมูล
  Future<void> _deleteNote() async {
    await NotesRepository.delete(widget.note!);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
        actions: [
          // ✅ ปุ่มลบ แสดงเฉพาะตอนแก้ไข
          if (widget.note != null)
            IconButton(
              onPressed: () {
                // ✅ กดแล้วแสดงกล่องยืนยัน
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("ยืนยันการลบ"),
                    content: const Text("คุณต้องการลบรายการนี้ใช่หรือไม่?"),
                    actions: [
                      // ปุ่มยกเลิก
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                      // ปุ่มยืนยัน → ลบข้อมูล
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _deleteNote();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
            ),

          // ปุ่มบันทึก/แก้ไข
          IconButton(
            onPressed: widget.note == null ? _insertNote : _updateNote,
            icon: const Icon(Icons.done_outline_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: "Start typing here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}