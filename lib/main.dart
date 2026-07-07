import 'package:flutter/material.dart';
import 'pages/ai_chat_page.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- 1. เพิ่ม import ตัวนี้เข้ามา

// <-- 2. เปลี่ยน main ให้เป็น Future แบบนี้ เพื่อรอโหลดค่าจาก .env ก่อนรันแอป
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 250, 255, 103)),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์ของฉัน'),
        backgroundColor: const Color.fromARGB(255, 255, 191, 0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // รูปโปรไฟล์
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color.fromARGB(255, 255, 225, 0),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              
              const SizedBox(height: 16),
              
              // ชื่อ
              const Text(
                'เทพทัต บัวเทศ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // รหัสนักศึกษา
              const Text(
                'รหัสนักศึกษา: 67030296',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              
              const SizedBox(height: 24),
              
              // Card ข้อมูล
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.school, 'คณะ', 'ครุศาสตร์อุตสาหกรรมและเทคโนโลยี'),
                      const Divider(),
                      _buildInfoRow(Icons.code, 'วิชาที่ชอบ', 'Mobile Development'),
                      const Divider(),
                      _buildInfoRow(Icons.star, 'เป้าหมาย', 'พัฒนาแอปให้ได้ 1 ตัว'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // เรียกใช้งาน WeatherCard
              const WeatherCard(
                city: 'ลาดกระบัง, กรุงเทพฯ',
                temperature: 34.5,
                condition: 'sunny',
                humidity: 60,
              ),

              // -----------------------------------------------------
              // 2. ส่วนที่เพิ่มใหม่: ปุ่มกดเพื่อเปิดหน้า AI Chat ต่อท้ายการ์ดอากาศ
              // -----------------------------------------------------
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AiChatPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.smart_toy),
                label: const Text('ทดลอง AI Chat'),
              ),
              // -----------------------------------------------------

            ],
          ),
        ),
      ),
    );
  }
  
  // Helper Method สร้างแถวข้อมูล
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 255, 184, 5)),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String condition;
  final int humidity;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.cloud;
      case 'rainy':
        return Icons.water_drop;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade400, Colors.blue.shade800],
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                _getWeatherIcon(condition),
                color: Colors.white,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                '${temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                condition.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              const Divider(color: Colors.white24, height: 30, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.opacity, color: Colors.white70, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Humidity: $humidity%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}