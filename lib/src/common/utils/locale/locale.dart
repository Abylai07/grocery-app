import 'package:grocery_app/src/common/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class LocaleBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Locale locale) builder;

  const LocaleBuilder({super.key, required this.builder});

  static void setLocale(BuildContext context, Locale locale) {
    context.findAncestorStateOfType<_LocaleBuilderState>()?.setLocale(locale);
  }

  @override
  State<LocaleBuilder> createState() => _LocaleBuilderState();
}

class _LocaleBuilderState extends State<LocaleBuilder> {
  Locale _locale = Locale(SharedPrefs().getLocaleLang());

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _locale);
  }
}
