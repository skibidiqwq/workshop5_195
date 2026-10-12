import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/note.dart';
import '../../add-note/add_note_screen.dart';

class ItemNote extends StatelessWidget {
  final Note note;

  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // ✅ ห่อส่วนด้วย GestureDetector เพื่อรับการกด
    return GestureDetector(
      onTap: () {
        // ✅ กดแล้วเปิดหน้าแก้ไข ส่งข้อมูล note ไปด้วย
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteScreen(note: note),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  DateFormat('dd', 'th_TH').format(note.createdAt),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('MMM', 'th_TH').format(note.createdAt),
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  DateFormat('y', 'th_TH').format(note.createdAt),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.Hm().format(note.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}