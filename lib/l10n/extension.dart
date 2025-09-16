import 'package:flutter/widgets.dart';
import 'l10n.dart';

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
