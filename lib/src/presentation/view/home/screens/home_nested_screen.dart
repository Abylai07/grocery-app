import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeNestedScreen extends StatelessWidget {
  const HomeNestedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
