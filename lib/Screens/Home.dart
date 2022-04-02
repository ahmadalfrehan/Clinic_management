import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import '../HomeLayout.dart';
import 'Search.dart';
import 'See.dart';
import '../main.dart';

class Home extends StatelessWidget {
  var nameController = TextEditingController();
  var lasTController = TextEditingController();
  var InfoController = TextEditingController();
  var PhoneController = TextEditingController();
  var acccountController = TextEditingController();
  var restController = TextEditingController();
  var idController = TextEditingController();
  var far = GlobalKey<FormState>();
  double heights = 40;
  double widths = 350;
  int? idd;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicManagement>(
      listener: (context, state) {
        if (state is ClinicManagementAddSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('successfully added the ' + state.num.toString()),
            ),
          );
        }
        if (state is ClinicManagementAddErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred try again'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var c = ClinicCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xFFECF0F3),
          body: Form(
            key: far,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormF("name", Icons.person, nameController, c),
                  TextFormF("lastName", Icons.person, lasTController, c),
                  TextFormF(
                      "Information", Icons.info_outline, InfoController, c),
                  TextFormF("phoneNumer", Icons.phone, PhoneController, c),
                  TextFormF(
                      "account", Icons.price_check, acccountController, c),
                  TextFormF("rest", Icons.price_change, restController, c),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        color: c.Color1,
                        width: 2,
                      ),
                      elevation: 0.0,
                      primary: const Color(0xFFe6bd60),
                      fixedSize: Size(widths, heights),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      if (far.currentState!.validate()) {
                        c.inserttoDataBase(
                          name: nameController.text,
                          lastN: lasTController.text,
                          Inforamtion: InfoController.text,
                          phoneN: PhoneController.text,
                          account: acccountController.text,
                          rest: restController.text,
                          status: 'new',
                        );
                      }
                      nameController = TextEditingController();
                      lasTController = TextEditingController();
                      InfoController = TextEditingController();
                      PhoneController = TextEditingController();
                      acccountController = TextEditingController();
                      restController = TextEditingController();
                    },
                    child: Text(
                      ' Save ?',
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
        );
      },
    );
  }

  Widget TextFormF(String lab, IconData Ic, var x, var c) {
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
        ),
        maxLines: lab == 'Information' ? 14 : 1,
        minLines: 1,
        controller: x,
        keyboardType:
            lab == 'Information' ? TextInputType.multiline : TextInputType.text,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'the field must not be empty';
          }
          return null;
        },
      ),
    );
  }
}
