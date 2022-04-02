import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/Screens/Edit.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import 'DB.dart';
import 'Details.dart';

class SearcH extends StatelessWidget {
  const SearcH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ClinicCubit()..createDataBase(),
      child: BlocConsumer<ClinicCubit, ClinicManagement>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = ClinicCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: const Color(0xFFECF0F3),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: c.Color1, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: c.Color1, width: 2.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: c.Color1,
                            ),
                            labelText: " Search "),
                        onChanged: (String text) {
                          text.length == 0 ? c.ty = true : c.ty = false;
                          c.Search.clear();
                          c.SearchInDelete(text);
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 1555,
                        child: (c.Search.isEmpty || c.ty == true)
                            ? const Center(
                                child: Text('No element Found !'),
                              )
                            : ListView.builder(
                                itemCount: c.Search.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Details(c.Search, index),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              backgroundColor:
                                                  Color(0xFF84a59d),
                                              child: Text(
                                                c.Search[index]['id']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Color(0xFFf7ede2)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              c.Search[index]['name'],
                                              style:
                                                  const TextStyle(fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          c.Search[index]['lastN'],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          c.Search[index]['Account'],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Edit(index, c.Search),
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
                                                      id: c.Search[index]
                                                          ['id']);
                                                },
                                                child:
                                                    const Icon(Icons.archive),
                                              ),
                                            ),
                                            Expanded(
                                              child: MaterialButton(
                                                onPressed: () {
                                                  c.DeleteFromDataBase(
                                                      id: c.Search[index]
                                                          ['id']);
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
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
