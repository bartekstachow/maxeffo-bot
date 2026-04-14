import 'package:dotenv/dotenv.dart';

class Config {
  final String discordToken;
  final String bnetClientId;
  final String bnetClientSecret;
  final String region;
  final String realmSlug;
  final String guildSlug;
  final String? announcementsChannelId;
  final String? anthropicApiKey;
  final String? tavilyApiKey;

  Config({
    required this.discordToken,
    required this.bnetClientId,
    required this.bnetClientSecret,
    required this.region,
    required this.realmSlug,
    required this.guildSlug,
    this.announcementsChannelId,
    this.anthropicApiKey,
    this.tavilyApiKey,
  });

  factory Config.load() {
    final env = DotEnv(includePlatformEnvironment: true)..load();

    String require(String key) {
      final value = env[key];
      if (value == null || value.isEmpty || value.startsWith('your_')) {
        throw Exception('$key is not configured in .env');
      }
      return value;
    }

    // Returns null for unset or placeholder values
    String? optional(String? value) =>
        (value == null || value.isEmpty || value.startsWith('your_'))
            ? null
            : value;

    return Config(
      discordToken: require('DISCORD_TOKEN'),
      bnetClientId: require('BNET_CLIENT_ID'),
      bnetClientSecret: require('BNET_CLIENT_SECRET'),
      realmSlug: require('REALM_SLUG'),
      guildSlug: env['GUILD_SLUG'] ?? 'maximumeffort',
      region: env['REGION'] ?? 'eu',
      announcementsChannelId: optional(env['ANNOUNCEMENTS_CHANNEL_ID']),
      anthropicApiKey: optional(env['ANTHROPIC_API_KEY']),
      tavilyApiKey: optional(env['TAVILY_API_KEY']),
    );
  }
}
