import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class LocaleBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Locale locale) builder;

  const LocaleBuilder({super.key, required this.builder});

  static State<LocaleBuilder> of(BuildContext context) {
    final state = context.findAncestorStateOfType<_LocaleBuilderState>();
    if (state == null) {
      throw Exception('No LocaleBuilder ancestor found');
    }
    return state;
  }

  @override
  State<LocaleBuilder> createState() => _LocaleBuilderState();
}

class _LocaleBuilderState extends State<LocaleBuilder> {
  Locale _locale = Locale(SharedPrefs().getLocaleLang()); // задаем язык локализации по умолчанию

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