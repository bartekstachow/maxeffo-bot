import 'package:nyxx/nyxx.dart';

/// WoW class utilities shared across commands.
abstract final class WowClass {
  static const String _cdnBase =
      'https://wow.zamimg.com/images/wow/icons/large';

  static String? iconUrl(String? className) {
    print('className: $className');
    final slug = _slug(className);
    print('slug: $slug');
    if (slug == null) return null;
    return '$_cdnBase/classicon_$slug.jpg';
  }

  static String emoji(String? className) => switch (className?.toLowerCase()) {
        'death knight' || 'rycerz śmierci' => '☠️',
        'demon hunter' || 'łowca demonów' => '🧿',
        'druid' => '🌿',
        'evoker' => '🐉',
        'hunter' || 'łowca' => '🏹',
        'mage' || 'mag' => '🔮',
        'monk' => '🥋',
        'paladin' || 'paladyn' => '🛡️',
        'priest' || 'kapłan' => '✨',
        'rogue' || 'łotrzyk' => '🗡️',
        'shaman' || 'szaman' => '⚡',
        'warlock' || 'czarnoksiężnik' => '💜',
        'warrior' || 'wojownik' => '⚔️',
        _ => '❓',
      };

  static DiscordColor color(String? className) =>
      switch (className?.toLowerCase()) {
        'death knight' || 'rycerz śmierci' => DiscordColor(0xC41E3A),
        'demon hunter' || 'łowca demonów' => DiscordColor(0xA330C9),
        'druid' => DiscordColor(0xFF7C0A),
        'evoker' => DiscordColor(0x33937F),
        'hunter' || 'łowca' => DiscordColor(0xAAD372),
        'mage' || 'mag' => DiscordColor(0x3FC7EB),
        'monk' => DiscordColor(0x00FF98),
        'paladin' || 'paladyn' => DiscordColor(0xF48CBA),
        'priest' || 'kapłan' => DiscordColor(0xFFFFFF),
        'rogue' || 'łotrzyk' => DiscordColor(0xFFF468),
        'shaman' || 'szaman' => DiscordColor(0x0070DD),
        'warlock' || 'czarnoksiężnik' => DiscordColor(0x8788EE),
        'warrior' || 'wojownik' => DiscordColor(0xC69B3A),
        _ => DiscordColor(0x9B59B6),
      };

  static String? _slug(String? className) => switch (className?.toLowerCase()) {
        'death knight' || 'rycerz śmierci' => 'deathknight',
        'demon hunter' || 'łowca demonów' => 'demonhunter',
        'druid' => 'druid',
        'evoker' => 'evoker',
        'hunter' || 'łowca' => 'hunter',
        'mage' || 'mag' => 'mage',
        'monk' => 'monk',
        'paladin' || 'paladyn' => 'paladin',
        'priest' || 'kapłan' => 'priest',
        'rogue' || 'łotrzyk' => 'rogue',
        'shaman' || 'szaman' => 'shaman',
        'warlock' || 'czarnoksiężnik' => 'warlock',
        'warrior' || 'wojownik' => 'warrior',
        _ => null,
      };
}
