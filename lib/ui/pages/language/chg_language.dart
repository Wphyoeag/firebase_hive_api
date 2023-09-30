import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/localization_notifier_provider.dart';

class ChgLanguage extends ConsumerWidget {
  const ChgLanguage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                unselectedWidgetColor: Colors.white,
              ),
              child: ExpansionTile(
                // onTap: () {

                // },
                title: Text(AppLocalizations.of(context).language),
                // onTap: () {

                // },
                children: [
                  RadioListTile<Locale>(
                      value: const Locale('en'),
                      title: const Text('English'),
                      groupValue:
                          ref.read(localizationChangeNotifierProvider).currnet,
                      onChanged: (v) {
                        ref
                            .read(localizationChangeNotifierProvider)
                            .changeLocale(const Locale('en'));
                      }),
                  RadioListTile<Locale>(
                      value: const Locale('vi'),
                      title: const Text('Vietnamese'),
                      groupValue:
                          ref.read(localizationChangeNotifierProvider).currnet,
                      onChanged: (v) {
                        ref
                            .read(localizationChangeNotifierProvider)
                            .changeLocale(const Locale('vi'));
                      })
                ],
              ),
            ),
          );
  }
}