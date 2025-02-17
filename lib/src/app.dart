import 'package:app/src/pages/home_view.dart';
import 'package:app/src/pages/settings_view.dart';
import 'package:app/src/pages/splash_view.dart';
import 'package:app/src/pages/login_view.dart';
import 'package:app/src/pages/register_view.dart';
import 'package:app/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class Cumulo extends StatelessWidget {
  const Cumulo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'cumulo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: cumuloTheme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        HomeView.routeName: (context) => const HomeView(),
        SettingsView.routeName: (context) => const SettingsView(),
      },
    );
  }
}
