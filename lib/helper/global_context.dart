import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext globalContext = navigatorKey.currentState!.overlay!.context;
