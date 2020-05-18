import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/auth_screen.dart';

class AuthGuard extends StatelessWidget {
  final Widget displayPage;

  AuthGuard(this.displayPage);

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    if (!authProv.isAuth)
      return AuthScreen();
    return displayPage;
  }
}
