import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ✅ เพิ่ม
import 'package:intl/date_symbol_data_local.dart'; // ✅ เพิ่ม
import 'screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ เพิ่มบรรทัดนี้ เพื่อโหลดข้อมูลภาษาไทย
  await initializeDateFormatting('th_TH', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}