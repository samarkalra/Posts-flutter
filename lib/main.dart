import 'package:flutter/material.dart';
import 'package:posts/add_edit_post_screen.dart';
import 'package:posts/services/post_services.dart';
import 'package:posts/state/post_provider.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PostProvider(service: PostService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddEditPostScreen.routeName: (context) => const AddEditPostScreen(),
        },
      ),
    );
  }
}
