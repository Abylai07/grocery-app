/*
 * Copyright (c) 2021-2024 Larry Aasen. All rights reserved.
 */
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

import '../../common/utils/shared_preference.dart';
import '../bloc/base_state.dart';
import '../bloc/remote_config_cubit.dart';

class UpgradeWidget extends StatefulWidget {
  UpgradeWidget({
    super.key,
    Upgrader? upgrader,
    this.barrierDismissible = false,
    this.dialogStyle = UpgradeDialogStyle.material,
    this.onIgnore,
    this.onLater,
    this.onUpdate,
    this.shouldPopScope,
    this.showIgnore = true,
    this.showLater = true,
    this.showReleaseNotes = true,
    this.cupertinoButtonTextStyle,
    this.dialogKey,
    this.navigatorKey,
    this.child,
  }) : upgrader = upgrader ?? Upgrader.sharedInstance;

  final Upgrader upgrader;

  final bool barrierDismissible;

  final UpgradeDialogStyle dialogStyle;

  final BoolCallback? onIgnore;

  final BoolCallback? onLater;

  final BoolCallback? onUpdate;

  final BoolCallback? shouldPopScope;

  final bool showIgnore;

  final bool showLater;

  final bool showReleaseNotes;

  final TextStyle? cupertinoButtonTextStyle;

  final GlobalKey? dialogKey;

  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? child;

  @override
  UpgradeWidgetState createState() => UpgradeWidgetState();
}

/// The [UpgradeWidget] widget state.
class UpgradeWidgetState extends State<UpgradeWidget> {
  /// Is the alert dialog being displayed right now?
  bool displayed = false;
  String? storeVersion;

  @override
  void initState() {
    getAppVersionWithBuild();
    super.initState();
  }

  Future<String> getAppVersionWithBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    SharedPrefs().setAppVersion(packageInfo.version);
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: build UpgradeAlert');
    }
    if (storeVersion == null) {
      widget.upgrader.initialize();
    }
    return StreamBuilder(
      initialData: widget.upgrader.state,
      stream: widget.upgrader.stateStream,
      builder: (BuildContext context, AsyncSnapshot<UpgraderState> snapshot) {
        if ((snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) &&
            snapshot.data != null) {
          storeVersion = snapshot.data?.versionInfo?.appStoreVersion.toString();
          if (widget.upgrader.state.debugLogging) {
            print('upgrader: build UpgradeAlert');
          }

          if (storeVersion != null) {
            if (widget.upgrader.state.debugLogging) {
              print("upgrader: need to evaluate version");
            }

            if (!displayed) {
              widget.upgrader.minAppVersion = storeVersion ?? '1.0.8';
              final checkContext = widget.navigatorKey != null &&
                  widget.navigatorKey!.currentContext != null
                  ? widget.navigatorKey!.currentContext!
                  : context;
              checkVersion(context: checkContext);
            }
          }
        }
        return widget.child ?? const SizedBox.shrink();
      },
    );
  }

  bool isVersionGreater(String version1, String version2) {
    List<int> parts1 = version1.split('.').map(int.parse).toList();
    List<int> parts2 = version2.split('.').map(int.parse).toList();

    for (int i = 0; i < parts1.length; i++) {
      if (parts1[i] > parts2[i]) return true;
      if (parts1[i] < parts2[i]) return false;
    }

    return false; // Если версии равны
  }

  /// Will show the alert dialog when it should be dispalyed.
  void checkVersion({required BuildContext context}) {
    final shouldDisplay = widget.upgrader.shouldDisplayUpgrade();
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: shouldDisplayReleaseNotes: $shouldDisplayReleaseNotes');
    }
    if (shouldDisplay) {
      displayed = true;
      final appMessages = widget.upgrader.determineMessages(context);

      Future.delayed(const Duration(milliseconds: 0), () {
        showTheDialog(
          key: widget.dialogKey ?? const Key('upgrader_alert_dialog'),
          context: context,
          title: appMessages.message(UpgraderMessage.title),
          message: widget.upgrader.body(appMessages),
          releaseNotes:
              shouldDisplayReleaseNotes ? widget.upgrader.releaseNotes : null,
          barrierDismissible: widget.barrierDismissible,
          messages: appMessages,
        );
      });
    }
  }

  void onUserIgnored(BuildContext context, bool shouldPop) {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: button tapped: ignore');
    }

    // If this callback has been provided, call it.
    final doProcess = widget.onIgnore?.call() ?? true;

    if (doProcess) {
      widget.upgrader.saveIgnored();
    }

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void onUserLater(BuildContext context, bool shouldPop) {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: button tapped: later');
    }

    // If this callback has been provided, call it.
    widget.onLater?.call();

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void onUserUpdated(BuildContext context, bool shouldPop) {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: button tapped: update now');
    }

    // If this callback has been provided, call it.
    final doProcess = widget.onUpdate?.call() ?? true;

    if (doProcess) {
      widget.upgrader.sendUserToAppStore();
    }

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void popNavigator(BuildContext context) {
    Navigator.of(context).pop();
    displayed = false;
  }

  bool get shouldDisplayReleaseNotes =>
      widget.showReleaseNotes &&
      (widget.upgrader.releaseNotes?.isNotEmpty ?? false);

  /// Show the alert dialog.
  void showTheDialog({
    Key? key,
    required BuildContext context,
    required String? title,
    required String message,
    required String? releaseNotes,
    required bool barrierDismissible,
    required UpgraderMessages messages,
  }) {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: showTheDialog title: $title');
      print('upgrader: showTheDialog message: $message');
      print('upgrader: showTheDialog releaseNotes: $releaseNotes');
    }

    // Save the date/time as the last time alerted.
    widget.upgrader.saveLastAlerted();

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: onCanPop(),
          onPopInvoked: (didPop) {
            if (widget.upgrader.state.debugLogging) {
              print('upgrader: showTheDialog onPopInvoked: $didPop');
            }
          },
          child: alertDialog(
            key,
            title ?? '',
            message,
            releaseNotes,
            context,
            widget.dialogStyle == UpgradeDialogStyle.cupertino,
            messages,
          ),
        );
      },
    );
  }

  /// Determines if the dialog blocks the current route from being popped.
  /// Will return the result from [shouldPopScope] if it is not null, otherwise it will return false.
  bool onCanPop() {
    if (widget.upgrader.state.debugLogging) {
      print('upgrader: onCanPop called');
    }
    if (widget.shouldPopScope != null) {
      final should = widget.shouldPopScope!();
      if (widget.upgrader.state.debugLogging) {
        print('upgrader: shouldPopScope=$should');
      }
      return should;
    }

    return false;
  }

  Widget alertDialog(
      Key? key,
      String title,
      String message,
      String? releaseNotes,
      BuildContext context,
      bool cupertino,
      UpgraderMessages messages) {
    // If installed version is below minimum app version, or is a critical update,
    // disable ignore and later buttons.
    final isBlocked = widget.upgrader.blocked();
    final showIgnore = isBlocked ? false : widget.showIgnore;
    final showLater = isBlocked ? false : widget.showLater;

    Widget? notes;
    if (releaseNotes != null) {
      notes = Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: cupertino
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: <Widget>[
              Text(messages.message(UpgraderMessage.releaseNotes) ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(releaseNotes),
            ],
          ));
    }
    final textTitle = Text(title, key: const Key('upgrader.dialog.title'));
    final content = Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment:
              cupertino ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(messages.message(UpgraderMessage.prompt) ?? '')),
            if (notes != null) notes,
          ],
        )));
    final actions = <Widget>[
      if (showIgnore)
        button(cupertino, messages.message(UpgraderMessage.buttonTitleIgnore),
            context, () => onUserIgnored(context, true)),
      if (showLater)
        button(cupertino, messages.message(UpgraderMessage.buttonTitleLater),
            context, () => onUserLater(context, true)),
      button(cupertino, messages.message(UpgraderMessage.buttonTitleUpdate),
          context, () => onUserUpdated(context, !widget.upgrader.blocked())),
    ];

    return cupertino
        ? CupertinoAlertDialog(
            key: key, title: textTitle, content: content, actions: actions)
        : AlertDialog(
            key: key, title: textTitle, content: content, actions: actions);
  }

  Widget button(bool cupertino, String? text, BuildContext context,
      VoidCallback? onPressed) {
    return cupertino
        ? CupertinoDialogAction(
            textStyle: widget.cupertinoButtonTextStyle,
            onPressed: onPressed,
            child: Text(text ?? ''))
        : TextButton(onPressed: onPressed, child: Text(text ?? ''));
  }
}
