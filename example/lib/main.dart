import 'package:flutter/material.dart';
import 'package:responsive_sidebar/responsive_sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      darkTheme:
          ThemeData(primarySwatch: Colors.cyan, brightness: Brightness.light),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(
        title: const Text("Example Sidebar Scaffold"),
        actions: const <Widget>[],
        elevation: 0,
        // Some logic to show the implicit menu button on AppBar when
        // there is no rail or menu.

        // !isDesktop && isMenuClosed && menuDoneClosing,
      ),
      menuTitle: const Text("Example Sidebar Scaffold"),
      // Make Rail width larger when using it on tablet or desktop.
      railWidth: 66,
      breakpointShowFullMenu: 900,
      extendBodyBehindAppBar: false,
      extendBody: true,
      menuItems: [
        MenuItemInfo(icon: Icons.dashboard, label: "Dashboard"),
        MenuItemInfo(icon: Icons.people, label: "Pacientes"),
        MenuItemInfo(icon: Icons.medical_services, label: "Estudios"),
        MenuItemInfo(icon: Icons.access_alarm, label: "Alarmas"),
        MenuItemInfo(icon: Icons.accessibility_new_rounded, label: "Accesos"),
        MenuItemInfo(icon: Icons.face, label: "Faces"),
      ],
      menuHeader: const _UserProfile(railWidth: 52),
      menuFooter: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Version 1.0"),
      ),
      onSelect: (index) {},
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// A user profile widget that we use as leading widget in the menu.
///
/// Mock UI for the demo app, it does not do anything.
class _UserProfile extends StatefulWidget {
  const _UserProfile({
    Key? key,
    required this.railWidth,
  }) : super(key: key);
  final double railWidth;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<_UserProfile> {
  bool _collapsed = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextTheme primaryTextTheme = theme.primaryTextTheme;
    const double hPadding = 5;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints.maxWidth);
        return Material(
          // As an effect for theme demos, we put themed surface color on
          // Material used as background for the user profile widget. This gives
          // a it a slightly different tone for the background with themes that use
          // a blend mode where the blend strength is different for background
          // and surface, since this widget is placed on Material with background
          // color it will show up in such theme modes.
          color: theme.colorScheme.surface,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      radius: widget.railWidth / 2 - hPadding,
                      child: Text(
                        'MR',
                        style: primaryTextTheme.subtitle1!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  if (constraints.maxWidth > widget.railWidth * 2) ...[
                    Expanded(
                      child: Text(
                        'Marcos Rodriguez',
                        maxLines: 1,
                        style: textTheme.subtitle1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    ExpandIcon(
                      isExpanded: !_collapsed,
                      size: 24,
                      padding: EdgeInsets.zero,
                      onPressed: (_) {
                        setState(() {
                          _collapsed = !_collapsed;
                        });
                      },
                    ),
                  ]
                ],
              ),
              // Add some expand actions for access to mock functionality.
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  );
                },
                child: _collapsed
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  const Icon(Icons.person),
                                  Text('Profile', style: textTheme.overline),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  const Icon(Icons.logout),
                                  Text('Sign out', style: textTheme.overline),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
