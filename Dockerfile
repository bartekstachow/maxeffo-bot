# syntax=docker/dockerfile:1

# ── Build stage ───────────────────────────────────────────────────────────────
FROM dart:stable AS builder

WORKDIR /build

# Cache pub dependencies separately from source code
COPY pubspec.yaml pubspec.lock ./
RUN dart pub get

# Copy source and regenerate freezed/chopper code
COPY . .
RUN dart run build_runner build --delete-conflicting-outputs

# Compile to a self-contained native binary (no Dart SDK needed at runtime)
RUN dart compile exe bin/main.dart -o /build/maxeffo_bot

# ── Runtime stage ─────────────────────────────────────────────────────────────
FROM debian:bookworm-slim

# ca-certificates required for outbound TLS (Discord, Battle.net, Raider.io…)
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/maxeffo_bot /usr/local/bin/maxeffo_bot

# /data is the persistent volume mount point.
# The bot writes guild_context.json and logs/ relative to its working dir,
# so files land here and survive container restarts.
WORKDIR /data

CMD ["maxeffo_bot"]