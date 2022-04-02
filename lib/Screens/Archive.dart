import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import 'Details.dart';

import 'package:flutter/material.dart';

import 'Edit.dart';

class Archive extends StatelessWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicManagement>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ClinicManagementGetLoadingState) {
          return const CircularProgressIndicator();
        }
        var c = ClinicCubit.get(context);
        return Scaffold(
          body: Container(
            color: const Color(0xFFECF0F3),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              },
              itemCount: c.Oldelements.length,
              itemBuilder: (context, index) {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(c.Oldelements, index),
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
                                backgroundColor:  const Color(0xFF84a59d),
                                child: Text(
                                  c.Oldelements[index]['id'].toString(),
                                  style: const TextStyle(fontSize: 22,color: Color(0xFFf7ede2)),
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
                                c.Oldelements[index]['name'],
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            c.Oldelements[index]['lastN'],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            c.Oldelements[index]['Account'],
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
                                        builder: (context) => Edit(index,c.Oldelements),
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
                                        status: 'new',
                                        id: c.Oldelements[index]['id']);
                                  },
                                  child: const Icon(Icons.unarchive),
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    c.DeleteFromDataBase(
                                        id: c.Oldelements[index]['id']);
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
        );
      },
    );
  }
}
