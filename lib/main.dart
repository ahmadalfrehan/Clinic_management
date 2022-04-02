import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/Cubit/cubit.dart';
import 'package:lol/Cubit/states.dart';
import 'package:lol/HomeLayout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClinicCubit()..createDataBase(),
        ),
      ],
      child: BlocConsumer<ClinicCubit, ClinicManagement>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}
