// lib/config/api_config.dart
// ⚠️ ในโปรเจกต์จริงให้ใช้ Environment Variables
// ไฟล์นี้เพิ่มใน .gitignore
import 'package:flutter_dotenv/flutter_dotenv.dart';
class ApiConfig {
  // ดึงค่าผ่าน dotenv.env และดักจับความผิดพลาดด้วย ?? '' เผื่อกรณีหาไฟล์ .env ไม่เจอ
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
}