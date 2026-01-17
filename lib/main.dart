import 'package:flutter/material.dart';
import 'features/products/view/products_page.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // ← พื้นหลังหน้าทุกหน้า
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          surface: Colors.white, // ← กันไม่ให้ surface อมสี
          // กำหนดอื่นๆได้ตามต้องการ
        ),
      ),
      home: const ProductsPage(),
    );
  }
}
