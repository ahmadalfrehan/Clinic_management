import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

import '../HomeLayout.dart';
import 'Search.dart';

class Edit extends StatelessWidget {
  var index;
  List list = [];

  Edit(this.index, this.list, {Key? key}) : super(key: key);
  var nameEditController = TextEditingController();
  var lasTEditController = TextEditingController();
  var InfoEditController = TextEditingController();
  var PhoneEditController = TextEditingController();
  var acccountEditController = TextEditingController();
  var restEditController = TextEditingController();
  var Far = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicManagement>(
      listener: (context, state) {
        if (state is ClinicManagementUpdateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('updated successfully'),
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
          backgroundColor: const Color(0xFFECF0F3),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFF84a59d),
            title: Text(
              'Edit',
              style: TextStyle(
                color: c.Color2,
                fontWeight: FontWeight.bold,
                //fontSize: 18,
              ),
            ),
            actions: [
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
              )
            ],
          ),
          body: Container(
            child: Form(
              key: Far,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormF("Edit name?", Icons.person, nameEditController, c,
                        list[index]['name']),
                    TextFormF("Edit lastName ?", Icons.person,
                        lasTEditController, c, list[index]['lastN']),
                    TextFormF("Edit Information ?", Icons.info_outline,
                        InfoEditController, c, list[index]['Information']),
                    TextFormF("Edit phoneNumer ?", Icons.phone,
                        PhoneEditController, c, list[index]['phoneN']),
                    TextFormF("Edit account ?", Icons.price_check,
                        acccountEditController, c, list[index]['Account']),
                    TextFormF("Edit rest ?", Icons.price_change,
                        restEditController, c, list[index]['rest']),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: c.Color1,
                          width: 2,
                        ),
                        elevation: 0.0,
                        primary: const Color(0xFFe6bd60),
                        fixedSize: const Size(350, 40),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        if (Far.currentState!.validate()) {
                          c.UpdateInDataBase(
                            id: list[index]['id'],
                            name: nameEditController.text,
                            lastN: lasTEditController.text,
                            phoneN: PhoneEditController.text,
                            information: InfoEditController.text,
                            account: acccountEditController.text,
                            rest: restEditController.text,
                            status: 'new',
                          );
                        }
                        nameEditController = TextEditingController();
                        lasTEditController = TextEditingController();
                        PhoneEditController = TextEditingController();
                        InfoEditController = TextEditingController();
                        acccountEditController = TextEditingController();
                        restEditController = TextEditingController();
                        c.createDataBase();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeLayout()));
                      },
                      child: Text(
                        ' Edit ?',
                        style: TextStyle(
                          color: c.Color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget TextFormF(String lab, IconData Ic, var x, var c, String hint) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: c.Color1, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: c.Color1, width: 2.0),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Ic,
            color: c.Color1,
          ),
          labelText: lab,
          hintText: hint,
        ),
        maxLines: lab == 'Edit Information ?' ? 14 : 1,
        minLines: 1,
        controller: x,
        keyboardType: lab == 'Edit Information ?'
            ? TextInputType.multiline
            : TextInputType.text,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'this field must not be empty';
          }
          return null;
        },
      ),
    );
  }
}
