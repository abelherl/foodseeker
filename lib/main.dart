import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_bloc.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_event.dart';
import 'package:foodseeker/core/injection/injection.dart';
import 'package:foodseeker/core/navigation/navigation.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await windowManager.ensureInitialized();
  //
  // WindowOptions windowOptions = const WindowOptions(
  //   size: Size(500, 1000),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.hidden,
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  //   await windowManager.focus();
  // });

  await setUpInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeBloc>()
        ..add(const GetAllRecipeEvent(isOnline: true)),
      child: MaterialApp.router(
        title: 'foodseeker.app',
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.pink,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        ),
        routerConfig: Navigation.router,
      ),
    );
  }
}
