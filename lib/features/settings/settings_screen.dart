import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/theme_provider.dart';
import '../../core/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Text(
              l10n.settingsTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.settingsSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _SectionLabel(label: l10n.accountSection),
            _SettingsTile(
              icon: Icons.person,
              title: l10n.profileTile,
              subtitle: l10n.profileTileSubtitle,
              onTap: () => context.push('/settings/profile'),
            ),
            _SettingsTile(
              icon: Icons.notifications_active_outlined,
              title: l10n.notificationsTile,
              subtitle: l10n.notificationsTileSubtitle,
              trailing: Switch(value: true, onChanged: (_) {}),
            ),
            const SizedBox(height: 24),
            _SectionLabel(label: l10n.experienceSection),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    title: Text(l10n.themeTile),
                    subtitle: Text(l10n.themeTileSubtitle(themeMode.name)),
                    trailing: DropdownButton<ThemeMode>(
                      value: themeMode,
                      onChanged: (mode) {
                        if (mode != null) {
                          ref
                              .read(themeModeProvider.notifier)
                              .setThemeMode(mode);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(l10n.themeSystemLabel),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(l10n.themeLightLabel),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(l10n.themeDarkLabel),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.translate),
                    title: Text(l10n.languageTile),
                    subtitle: Text(
                      locale?.languageCode == 'ar' ? 'العربية' : 'English',
                    ),
                    trailing: DropdownButton<Locale?>(
                      value: locale,
                      onChanged: (value) {
                        ref.read(localeProvider.notifier).setLocale(value);
                      },
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.languageSystemLabel),
                        ),
                        const DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                        const DropdownMenuItem(
                          value: Locale('ar'),
                          child: Text('العربية'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SectionLabel(label: l10n.integrationsSection),
            _SettingsTile(
              icon: Icons.health_and_safety_outlined,
              title: l10n.healthSyncTile,
              subtitle: l10n.healthSyncSubtitle,
              trailing: const Icon(Icons.chevron_right),
            ),
            _SettingsTile(
              icon: Icons.chat_bubble_outline,
              title: l10n.supportTile,
              subtitle: l10n.supportSubtitle,
              trailing: const Icon(Icons.chevron_right),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: Text(l10n.logoutButton),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          letterSpacing: 0.8,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    );
  }
}
