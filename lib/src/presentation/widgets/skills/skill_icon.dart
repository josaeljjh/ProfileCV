import 'package:flutter/material.dart';

/// Resolves a skill name to a representative technology icon (Android's
/// robot for Android skills, Flutter's dash for Flutter skills, Apple's
/// logo for Swift, etc.) instead of a generic checkmark - built entirely
/// from Flutter's own Material icon set, no extra asset/package needed.
/// Exact matches first (covers every skill the CV currently lists, in
/// both locales), falling back to keyword matching so a new skill added
/// later still gets a sensible icon instead of silently falling through.
IconData skillIconFor(String skill) {
  switch (skill) {
    case 'Senior Flutter Engineer':
    case 'Flutter Bloc/Cubit':
    case 'Unit Test in Flutter with Mockito':
      return Icons.flutter_dash;
    case 'Dart':
      return Icons.code_rounded;
    case 'Senior Android Engineer':
    case 'Kotlin':
      return Icons.android;
    case 'Jetpack Compose':
      return Icons.widgets_rounded;
    case 'Coroutines/Flow':
      return Icons.sync_rounded;
    case 'Kotlin Multiplatform':
      return Icons.devices_rounded;
    case 'Clean Architecture':
      return Icons.architecture_rounded;
    case 'Realm and Room':
      return Icons.storage_rounded;
    case 'IA con Claude Code':
    case 'AI with Claude Code':
      return Icons.smart_toy_rounded;
    case 'Dependency Injection':
      return Icons.account_tree_rounded;
    case 'Swift / SwiftUI':
      return Icons.apple;
  }

  final lower = skill.toLowerCase();
  if (lower.contains('flutter')) return Icons.flutter_dash;
  if (lower.contains('android') || lower.contains('kotlin')) return Icons.android;
  if (lower.contains('swift') || lower.contains('ios')) return Icons.apple;
  if (lower.contains('test') || lower.contains('mock')) return Icons.bug_report_rounded;
  if (lower.contains('architecture')) return Icons.architecture_rounded;
  if (lower.contains('database') || lower.contains('room') || lower.contains('realm')) {
    return Icons.storage_rounded;
  }
  if (lower.contains('ai') || lower.contains('claude')) return Icons.smart_toy_rounded;
  return Icons.code_rounded;
}
