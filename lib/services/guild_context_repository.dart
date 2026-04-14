import 'dart:convert';
import 'dart:io';

class CharacterRef {
  final String name;
  final String? characterClass;
  final String? realm;
  final bool isMain;

  const CharacterRef({
    required this.name,
    this.characterClass,
    this.realm,
    this.isMain = false,
  });

  factory CharacterRef.fromJson(Map<String, dynamic> json) => CharacterRef(
        name: json['name'] as String,
        characterClass: json['class'] as String?,
        realm: json['realm'] as String?,
        isMain: (json['main'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'name': name};
    if (characterClass != null) map['class'] = characterClass;
    if (realm != null) map['realm'] = realm;
    if (isMain) map['main'] = true;
    return map;
  }
}

class GuildMemberContext {
  final String discordUsername;
  final List<CharacterRef> characters;
  final List<String> wowCharacters;
  final String? main;
  final String? notes;
  final String? language;
  final List<String> topicsOfInterest;
  final String? communicationStyle;
  final List<String> runningJokes;
  final String? profileNote;
  final DateTime? profileUpdatedAt;
  final DateTime? firstSeen;
  final DateTime? lastSeen;
  final int interactionCount;
  final List<String> recentMessages;

  GuildMemberContext({
    required this.discordUsername,
    this.characters = const [],
    this.wowCharacters = const [],
    this.main,
    this.notes,
    this.language,
    this.topicsOfInterest = const [],
    this.communicationStyle,
    this.runningJokes = const [],
    this.profileNote,
    this.profileUpdatedAt,
    this.firstSeen,
    this.lastSeen,
    this.interactionCount = 0,
    this.recentMessages = const [],
  });

  factory GuildMemberContext.fromJson(Map<String, dynamic> json) =>
      GuildMemberContext(
        discordUsername: json['discord_username'] as String,
        characters: (json['characters'] as List<dynamic>? ?? [])
            .map((e) => CharacterRef.fromJson(e as Map<String, dynamic>))
            .toList(),
        wowCharacters: (json['wow_characters'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
        main: json['main'] as String?,
        notes: json['notes'] as String?,
        language: json['language'] as String?,
        topicsOfInterest: (json['topics_of_interest'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
        communicationStyle: json['communication_style'] as String?,
        runningJokes: (json['running_jokes'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
        profileNote: json['profile_note'] as String?,
        profileUpdatedAt: json['profile_updated_at'] != null
            ? DateTime.tryParse(json['profile_updated_at'] as String)
            : null,
        firstSeen: json['first_seen'] != null
            ? DateTime.tryParse(json['first_seen'] as String)
            : null,
        lastSeen: json['last_seen'] != null
            ? DateTime.tryParse(json['last_seen'] as String)
            : null,
        interactionCount: (json['interaction_count'] as int?) ?? 0,
        recentMessages: (json['recent_messages'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'discord_username': discordUsername,
      'interaction_count': interactionCount,
      'first_seen': (firstSeen ?? DateTime.now()).toIso8601String(),
      'last_seen': (lastSeen ?? DateTime.now()).toIso8601String(),
    };
    if (characters.isNotEmpty) map['characters'] = characters.map((c) => c.toJson()).toList();
    if (wowCharacters.isNotEmpty) map['wow_characters'] = wowCharacters;
    if (main != null) map['main'] = main;
    if (notes != null) map['notes'] = notes;
    if (language != null) map['language'] = language;
    if (topicsOfInterest.isNotEmpty) map['topics_of_interest'] = topicsOfInterest;
    if (communicationStyle != null) map['communication_style'] = communicationStyle;
    if (runningJokes.isNotEmpty) map['running_jokes'] = runningJokes;
    if (profileNote != null) map['profile_note'] = profileNote;
    if (profileUpdatedAt != null) map['profile_updated_at'] = profileUpdatedAt!.toIso8601String();
    if (recentMessages.isNotEmpty) map['recent_messages'] = recentMessages;
    return map;
  }

  GuildMemberContext copyWith({
    List<CharacterRef>? characters,
    List<String>? wowCharacters,
    String? main,
    String? notes,
    String? language,
    List<String>? topicsOfInterest,
    String? communicationStyle,
    List<String>? runningJokes,
    String? profileNote,
    DateTime? profileUpdatedAt,
    DateTime? firstSeen,
    DateTime? lastSeen,
    int? interactionCount,
    List<String>? recentMessages,
  }) =>
      GuildMemberContext(
        discordUsername: discordUsername,
        characters: characters ?? this.characters,
        wowCharacters: wowCharacters ?? this.wowCharacters,
        main: main ?? this.main,
        notes: notes ?? this.notes,
        language: language ?? this.language,
        topicsOfInterest: topicsOfInterest ?? this.topicsOfInterest,
        communicationStyle: communicationStyle ?? this.communicationStyle,
        runningJokes: runningJokes ?? this.runningJokes,
        profileNote: profileNote ?? this.profileNote,
        profileUpdatedAt: profileUpdatedAt ?? this.profileUpdatedAt,
        firstSeen: firstSeen ?? this.firstSeen,
        lastSeen: lastSeen ?? this.lastSeen,
        interactionCount: interactionCount ?? this.interactionCount,
        recentMessages: recentMessages ?? this.recentMessages,
      );
}

class GuildContextRepository {
  static const _contextFile = 'guild_context.json';
  static const _maxRecentMessages = 10;
  static const _profileUpdateEvery = 5;

  final List<String> guildNotes;
  final List<GuildMemberContext> _members;

  GuildContextRepository._({
    required this.guildNotes,
    required List<GuildMemberContext> members,
  }) : _members = members;

  List<GuildMemberContext> get members => List.unmodifiable(_members);

  static Future<GuildContextRepository> load() async {
    final file = File(_contextFile);
    if (!await file.exists()) {
      print('[Context] guild_context.json not found — starting fresh.');
      return GuildContextRepository._(guildNotes: [], members: []);
    }

    try {
      final raw = await file.readAsString();
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final notes = (json['guild_notes'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList();
      final memberList = (json['members'] as List<dynamic>? ?? [])
          .map((e) => GuildMemberContext.fromJson(e as Map<String, dynamic>))
          .toList();
      print('[Context] Loaded ${memberList.length} member(s).');
      return GuildContextRepository._(guildNotes: notes, members: memberList);
    } catch (e) {
      print('[Context] Warning: Failed to parse guild_context.json: $e');
      return GuildContextRepository._(guildNotes: [], members: []);
    }
  }

  GuildMemberContext? lookup(String discordUsername) {
    final lower = discordUsername.toLowerCase();
    try {
      return _members.firstWhere(
        (m) => m.discordUsername.toLowerCase() == lower,
      );
    } catch (_) {
      return null;
    }
  }

  /// Records an interaction. Returns true if a profile update should be triggered.
  Future<bool> record(String discordUsername, String message) async {
    final now = DateTime.now();
    final snippet =
        message.length > 120 ? '${message.substring(0, 120)}…' : message;

    final idx = _members.indexWhere(
      (m) => m.discordUsername.toLowerCase() == discordUsername.toLowerCase(),
    );

    final int newCount;
    if (idx == -1) {
      _members.add(GuildMemberContext(
        discordUsername: discordUsername,
        firstSeen: now,
        lastSeen: now,
        interactionCount: 1,
        recentMessages: [snippet],
      ));
      newCount = 1;
    } else {
      final existing = _members[idx];
      newCount = existing.interactionCount + 1;
      final updatedMessages = [...existing.recentMessages, snippet]
          .reversed
          .take(_maxRecentMessages)
          .toList()
          .reversed
          .toList();
      _members[idx] = existing.copyWith(
        lastSeen: now,
        interactionCount: newCount,
        recentMessages: updatedMessages,
      );
    }

    await _save();
    return newCount % _profileUpdateEvery == 0;
  }

  /// Applies a Claude-generated profile update for a user.
  Future<void> applyProfileUpdate(
      String discordUsername, Map<String, dynamic> data) async {
    final idx = _members.indexWhere(
      (m) => m.discordUsername.toLowerCase() == discordUsername.toLowerCase(),
    );
    if (idx == -1) return;

    _members[idx] = _members[idx].copyWith(
      language: data['language'] as String?,
      topicsOfInterest:
          (data['topics_of_interest'] as List<dynamic>?)?.cast<String>(),
      communicationStyle: data['communication_style'] as String?,
      runningJokes: (data['running_jokes'] as List<dynamic>?)?.cast<String>(),
      profileNote: data['profile_note'] as String?,
      profileUpdatedAt: DateTime.now(),
    );

    await _save();
    print('[Context] Profile updated for $discordUsername.');
  }

  Future<void> _save() async {
    try {
      final data = {
        'guild_notes': guildNotes,
        'members': _members.map((m) => m.toJson()).toList(),
      };
      await File(_contextFile)
          .writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    } catch (e) {
      print('[Context] Warning: Failed to save guild_context.json: $e');
    }
  }
}
