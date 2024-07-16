import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neobis_flutter_auth/main.dart';

class SplashScrenn extends StatefulWidget {
  const SplashScrenn({Key? key}) : super(key: key);

  @override
  State<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScrenn> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3));
    context.go(login_page);

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Welcome')),
    );
  }
}
