import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import 'Details.dart';
import 'Edit.dart';

class See extends StatelessWidget {
  int t = 1;
  double o = 1;
  int r = 1;
  int b = 1;
  int g = 1;
  double a = 60;
  double a1 = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicManagement>(
      listener: (context, state) {
        if (state is ClinicManagementGetLoadingState) {
          const Center(child: CircularProgressIndicator());
        }
        if (state is ClinicManagementUpdateSuccessState) {
          ClinicCubit.get(context).createDataBase();
        }
      },
      builder: (context, state) {
        var c = ClinicCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: const Color(0xFFECF0F3),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: c.elements.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(c.elements, index),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(4, 7),
                              blurRadius: 10,
                            ),
                          ],
                          color: Color(0xFFf7ede2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF84a59d),
                                  child: Text(
                                    c.elements[index]['id'].toString(),
                                    style: const TextStyle(
                                        fontSize: 22, color: Color(0xFFf7ede2)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  c.elements[index]['name'],
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              c.elements[index]['lastN'],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              c.elements[index]['Account'],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Edit(index, c.elements),
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      c.UpdateStatus(
                                          status: 'old',
                                          id: c.elements[index]['id']);
                                    },
                                    child: const Icon(Icons.archive),
                                  ),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      c.DeleteFromDataBase(
                                          id: c.elements[index]['id']);
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
