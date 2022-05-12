import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/Screens/Archive.dart';
import 'package:lol/Cubit/states.dart';
import 'package:lol/Screens/Search.dart';
import 'package:lol/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/Home.dart';
import '../Screens/See.dart';

class ClinicCubit extends Cubit<ClinicManagement> {
  ClinicCubit() : super(ClinicManagementInisialState());

  static ClinicCubit get(context) => BlocProvider.of(context);
  Database? database;
  int currrentIndex = 0;
  List<String> titles = ['Home', 'Search', 'Add', 'Archive'];
  List<Widget> list = [See(), SearcH(), Home(), Archive()];

  void ChangeBottomNav(int index) {
    currrentIndex = index;
    emit(ClinicManagementChangeBottomNavSuccessState());
  }

  Delete() {
    //emit(ClinicManagementDeleteSuccessState());
    //database!.delete('clinic');
    //elements.clear();
  }

  Color Color1 = Color(0xFF1A535C);
  Color Color2 = const Color(0xFFFFE66D);
  List<Map> elements = [];
  List<Map> Oldelements = [];

  createDataBase() {
    openDatabase(
      'Ahmad.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        database
            .execute(
                'CREATE TABLE clinic (id INTEGER PRIMARY KEY , name TEXT ,lastN TEXT , phoneN TEXT , Information TEXT , Account TEXT , rest TEXT,status new)')
            .then((value) {
          //     emit(ClinicManagementCreateSuccessState());
          print('table created');
        }).catchError(
          (onError) {
            emit(ClinicManagementCreateErrorState());
            print('the error happen when created database${onError}');
          },
        );
      },
      onOpen: (database) {
        print('database opened');
        GetDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(ClinicManagementCreateSuccessState());
    });
  }

  inserttoDataBase({
    required String name,
    required String lastN,
    required String phoneN,
    required String Inforamtion,
    required String account,
    required String rest,
    required String status,
  }) async {
    await database!.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO clinic (name,lastN,phoneN,Information,Account,rest,status) VALUES("$name","$lastN","$phoneN","$Inforamtion","$account","$rest","$status")')
          .then((value) {
        emit(ClinicManagementAddSuccessState(value.toString()));
        print('$value inserted successfully');
        GetDataFromDatabase(database);
        print(elements);
      }).catchError((onError) {
        print('error when insert to data base ${onError}');
        emit(ClinicManagementAddErrorState());
      }),
    );
  }

  GetDataFromDatabase(database) async {
    emit(ClinicManagementGetLoadingState());
    elements.clear();
    Oldelements.clear();
    await database!.rawQuery('SELECT * FROM clinic').then((value) {
      emit(ClinicManagementGetSuccessState());
      value.forEach((element) {
        if (element['status'] == 'new') {
          elements.add(element);
        } else if (element['status'] == 'old') {
          Oldelements.add(element);
        }
      });
    });
  }

  DeleteFromDataBase({required int id}) async {
    await database!
        .rawDelete('DELETE FROM clinic WHERE id=?', [id]).then((value) {
      emit(ClinicManagementDeleteSuccessState());
      elements.clear();
      GetDataFromDatabase(database);
      main();
    });
  }

  List<Map<dynamic, dynamic>> Search = [];

  void SearchInDelete(String text) async {
    Search.clear();
    database!
        .rawQuery(
            "SELECT * FROM clinic WHERE name LIKE '%${text}%' OR  lastN LIKE '%${text}%' OR  phoneN LIKE '%${text}%' OR  Information LIKE '%${text}%' OR  Account LIKE '%${text}%' OR  rest LIKE '%${text}%'")
        .then((value) {
      value.forEach((element) {
        emit(ClinicManagementSearchSuccessState());
        Search.add(element);
      });
    }).catchError(
      (onError) {
        print('error when insert to data base ${onError}');
        emit(ClinicManagementSearchErrorState());
      },
    );
  }

  bool ty = true;

  UpdateInDataBase({
    required int id,
    required String name,
    required String lastN,
    required String phoneN,
    required String information,
    required String account,
    required String rest,
    required String status,
  }) {
    //emit(ClinicManagementUpdateSuccessState());
    database?.rawUpdate(
      'UPDATE clinic SET name = ?,lastN = ?,phoneN = ?,Information = ?,Account = ?,rest = ?,status = ? WHERE id = ?',
      [name, lastN, phoneN, information, account, rest, status, id],
    ).then((value) {
      emit(ClinicManagementUpdateSuccessState());
      GetDataFromDatabase(database);
    }).catchError((onError) {
      print(onError);
    });
  }

  UpdateStatus({
    required String status,
    required int id,
  }) async {
    await database!.rawUpdate(
      'UPDATE clinic SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      emit(ClinicManagementUpdateStatusSuccessState());
      elements.clear();
      GetDataFromDatabase(database);
    });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    emit(ClinicManagementMakePhoneCallState());
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
    print(launchUri);
  }

  Future<void> launchInBrowser(Uri launchUri) async {
    await launch(launchUri.toString());
    print(launchUri);
  }
}
