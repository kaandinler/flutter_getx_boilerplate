// Simple version bump and CHANGELOG updater for Flutter pubspec.yaml
// Usage:
//   dart run tool/version_bump.dart [major|minor|patch|build] -m "Change description"
// Defaults to patch.

import 'dart:convert';
import 'dart:io';

final versionLineRegex = RegExp(r'^version:\s*(\d+)\.(\d+)\.(\d+)\+(\d+)\s*$', multiLine: true);

void main(List<String> args) async {
  final bump = _parseBump(args);
  final message = _parseMessage(args) ?? 'Version bump';

  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    stderr.writeln('pubspec.yaml not found at project root');
    exit(1);
  }

  final content = pubspec.readAsStringSync();
  final match = versionLineRegex.firstMatch(content);
  if (match == null) {
    stderr.writeln('Could not find version in pubspec.yaml');
    exit(1);
  }

  var major = int.parse(match.group(1)!);
  var minor = int.parse(match.group(2)!);
  var patch = int.parse(match.group(3)!);
  var build = int.parse(match.group(4)!);

  switch (bump) {
    case _Bump.major:
      major += 1;
      minor = 0;
      patch = 0;
      build += 1;
      break;
    case _Bump.minor:
      minor += 1;
      patch = 0;
      build += 1;
      break;
    case _Bump.patch:
      patch += 1;
      build += 1;
      break;
    case _Bump.build:
      build += 1;
      break;
  }

  final newVersionLine = 'version: $major.$minor.$patch+$build';
  final updated = content.replaceFirst(versionLineRegex, newVersionLine);
  pubspec.writeAsStringSync(updated);

  _updateChangelog('$major.$minor.$patch', message);

  stdout.writeln('Updated version to $major.$minor.$patch+$build');
}

enum _Bump { major, minor, patch, build }

_Bump _parseBump(List<String> args) {
  if (args.isEmpty) return _Bump.patch;
  final first = args.first.toLowerCase();
  switch (first) {
    case 'major':
      return _Bump.major;
    case 'minor':
      return _Bump.minor;
    case 'patch':
      return _Bump.patch;
    case 'build':
      return _Bump.build;
    default:
      return _Bump.patch;
  }
}

String? _parseMessage(List<String> args) {
  final idx = args.indexWhere((a) => a == '-m' || a == '--message');
  if (idx != -1 && idx + 1 < args.length) {
    return args[idx + 1];
  }
  return null;
}

void _updateChangelog(String version, String message) {
  final f = File('CHANGELOG.md');
  final today = DateTime.now();
  final date = '${today.year}-${_two(today.month)}-${_two(today.day)}';
  final entry = '## [$version] - $date\n- $message\n\n';

  if (!f.existsSync()) {
    f.createSync(recursive: true);
    f.writeAsStringSync('# Changelog\n\n$entry');
    return;
  }

  final current = f.readAsStringSync();
  // Insert after first heading if present
  final lines = LineSplitter.split(current).toList();
  int insertAt = 0;
  if (lines.isNotEmpty && lines.first.startsWith('# ')) {
    insertAt = 2; // leave a blank line
  }
  final newContent = StringBuffer();
  if (insertAt == 2 && lines.length >= 2) {
    newContent.writeln(lines[0]);
    newContent.writeln('');
    newContent.write(entry);
    for (var i = 2; i < lines.length; i++) {
      newContent.writeln(lines[i]);
    }
  } else {
    newContent.write(entry);
    newContent.write(current);
  }
  f.writeAsStringSync(newContent.toString());
}

String _two(int n) => n < 10 ? '0$n' : '$n';

