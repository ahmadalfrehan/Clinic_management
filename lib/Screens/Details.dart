import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import '../HomeLayout.dart';
import 'Edit.dart';
import 'Search.dart';
import '../main.dart';

class Details extends StatelessWidget {
  List list = [];
  var index;

  Details(this.list, this.index, {Key? key}) : super(key: key);

  var Scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicManagement>(
      listener: (context, state) {
        if (state is ClinicManagementUpdateStatusSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('successfully added it archive'),
            ),
          );
          Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
            ),
          );
        }
        if (state is ClinicManagementDeleteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('successfully deleted the item'),
            ),
          );
          Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var c = ClinicCubit.get(context);
        return Scaffold(
          key: Scaffoldkey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFF84a59d),
            centerTitle: false,
            title: const Text(
              'Details',
              style: TextStyle(
                color: Color(0xFFf7ede2),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Edit(index, list),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () async {
                  print(list[index]['id']);
                  await c.UpdateStatus(
                    status: 'old',
                    id: list[index]['id'],
                  );
                },
                icon: const Icon(
                  Icons.archive,
                ),
              ),
              IconButton(
                onPressed: () {
                  c.DeleteFromDataBase(id: list[index]['id']);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearcH(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
            toolbarHeight: MediaQuery.of(context).size.height / 12,
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFECF0F3),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      list[index]['name'],
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            30,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      list[index]['lastN'],
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            30,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print('phone');
                                  await c.makePhoneCall(list[index]['phoneN']);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.call),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      list[index]['phoneN'],
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.price_check),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    list[index]['Account'],
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.price_change),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    list[index]['rest'],
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, -10),
                            blurRadius: 10,
                          ),
                        ],
                        color: Color(0xFFf7ede2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55),
                          topLeft: Radius.circular(55),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 0),
                            const SizedBox(height: 40),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(55),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Text(
                                            list[index]['Information'],
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
