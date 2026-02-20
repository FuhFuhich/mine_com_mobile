import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mine_com_mobile/l10n/app_localizations.dart';
import '../../provider/language_provider.dart';

class LanguagePickerFragment extends ConsumerWidget {
  const LanguagePickerFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: supportedLocales.map((locale) {
          final isSelected = locale.languageCode == currentLocale.languageCode;
          final name = localeNames[locale.languageCode] ?? locale.languageCode;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF00E676)
                    : theme.dividerColor,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  locale.languageCode == 'ru' ? '🇷🇺' : '🇬🇧',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              title: Text(name, style: theme.textTheme.titleSmall),
              trailing: isSelected
                  ? const Icon(Icons.check_circle,
                      color: Color(0xFF00E676), size: 20)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(locale);
                Navigator.pop(context);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
