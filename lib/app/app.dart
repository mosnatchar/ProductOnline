import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/counter/bloc/counter_bloc.dart';
import '../features/counter/view/counter_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Starter',
        theme: ThemeData(useMaterial3: true),
        home: const CounterPage(),
      ),
    );
  }
}
