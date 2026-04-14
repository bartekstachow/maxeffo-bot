import 'dart:convert';
import 'dart:io';

import 'package:maxeffo_bot/models/guild_member.dart';

class CacheService {
  static const String _cacheDir = 'cache';
  static const String _cacheFile = 'cache/mounts.json';

  Future<Map<String, GuildMember>> load() async {
    final file = File(_cacheFile);
    if (!await file.exists()) return {};

    try {
      final content = await file.readAsString();
      if (content.trim().isEmpty) return {};

      final data = json.decode(content) as Map<String, dynamic>;
      return data.map(
        (key, value) => MapEntry(
          key,
          GuildMember.fromJson(value as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      print('[Cache] Warning: Could not load cache: $e');
      return {};
    }
  }

  Future<void> save(Map<String, GuildMember> members) async {
    final dir = Directory(_cacheDir);
    if (!await dir.exists()) await dir.create(recursive: true);

    final data =
        members.map((key, value) => MapEntry(key, value.toJson()));
    await File(_cacheFile).writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }
}
