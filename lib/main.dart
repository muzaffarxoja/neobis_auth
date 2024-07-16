import 'package:flutter/material.dart';
import 'package:neobis_flutter_auth/views/register_view.dart';
import 'package:neobis_flutter_auth/views/splash_screeen.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

const String login_page = '/login_page';
const String register_page = '/register_page';
const String home_page = '/home_page';
const String splash_screen = '/splash_screen';

final _router = GoRouter(
  initialLocation: splash_screen,
  routes: [
    GoRoute(
      path: login_page,
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: register_page,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: home_page,
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: splash_screen,
      builder: (context, state) => const SplashScrenn(),
    ),
  ],
);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter MVVM Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Consumer<AuthViewModel>(
      //   builder: (context, authViewModel, child) {
      //     return authViewModel.users.isNotEmpty ? HomeView() : LoginView();
      //   },
      // ),
    );
  }
}
