import 'package:app/src/models/firebase_user.dart';
import 'package:app/src/pages/settings_view.dart';
import 'package:app/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  BoxConstraints get constraints => widget.constraints;

  @override
  void initState() {
    super.initState();
    // Fetch user details when the widget is initialized
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SizedBox(
      height: constraints.maxHeight * 0.2,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Text("Let's soar",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 16)),
                  SizedBox(height: constraints.maxHeight * 0.012),
                  Text(
                    userProvider.user?.firstName.toUpperCase() ?? "USER",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 24),
                  ),
                ],
              ),
              Spacer(flex: 1),
              IconButton(
                icon: Icon(Icons.account_circle_rounded,
                    size: constraints.maxHeight * 0.05),
                onPressed: () =>
                    Navigator.pushNamed(context, SettingsView.routeName),
              )
            ],
          ),
        ),
      ),
    );
  }
}
