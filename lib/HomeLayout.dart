import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/cubit.dart';
import 'Cubit/states.dart';
import 'Screens/Search.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // ClinicCubit.get(context).createDataBase();
        return BlocConsumer<ClinicCubit, ClinicManagement>(
          listener: (context, state) {},
          builder: (context, state) {
            var c = ClinicCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color(0xFF84a59d),
                centerTitle: false,
                title: Text(
                  c.titles[c.currrentIndex],
                  style: const TextStyle(
                    color: Color(0xFFe6bd60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Container(
                  color: const Color(0xFFECF0F3),
                  child: c.list[c.currrentIndex]),
              bottomNavigationBar: CurvedNavigationBar(
                index: c.currrentIndex,
                items: const <Widget>[
                  Icon(Icons.home, size: 30),
                  Icon(Icons.search, size: 30),
                  Icon(Icons.person_add, size: 30),
                  Icon(Icons.archive, size: 30),
                ],
                color: Colors.white,
                buttonBackgroundColor: Colors.white,
                backgroundColor: const Color(0xFFECF0F3),
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  c.ChangeBottomNav(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
