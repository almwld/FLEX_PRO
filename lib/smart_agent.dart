import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SmartAgent {
  static final SmartAgent _instance = SmartAgent._internal();
  factory SmartAgent() => _instance;
  SmartAgent._internal();

  Database? _db;
  List<Map<String, dynamic>> _history = [];

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await openDatabase(
      '${dir.path}/agent_memory.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE messages (id INTEGER PRIMARY KEY, role TEXT, content TEXT, timestamp INTEGER)');
      },
    );
  }

  Future<String> respond(String userInput) async {
    await _saveMessage('user', userInput);
    String response = _generateResponse(userInput);
    await _saveMessage('agent', response);
    return response;
  }

  Future<void> _saveMessage(String role, String content) async {
    await _db?.insert('messages', {'role': role, 'content': content, 'timestamp': DateTime.now().millisecondsSinceEpoch});
  }

  String _generateResponse(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('مرحبا')) return 'مرحباً! كيف أخدمك؟';
    if (lower.contains('+')) return _calculate(input);
    if (lower.contains('تذكير')) return '✅ تم حفظ التذكير';
    return 'سؤال جيد! أنا أعمل محلياً.';
  }

  String _calculate(String input) {
    try {
      final numbers = RegExp(r'\d+').allMatches(input).map((m) => int.parse(m.group(0)!)).toList();
      if (numbers.length < 2) return 'اكتب عملية صحيحة';
      if (input.contains('+')) return '${numbers[0]} + ${numbers[1]} = ${numbers[0] + numbers[1]}';
    } catch (e) {}
    return 'خطأ في الحساب';
  }
}
