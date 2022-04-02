abstract class ClinicManagement {}

class ClinicManagementInisialState extends ClinicManagement {}

class ClinicManagementCreateLoadingState extends ClinicManagement {}

class ClinicManagementCreateSuccessState extends ClinicManagement {}

class ClinicManagementCreateErrorState extends ClinicManagement {}

class ClinicManagementGetLoadingState extends ClinicManagement {}

class ClinicManagementGetSuccessState extends ClinicManagement {}

class ClinicManagementGetErrorState extends ClinicManagement {}

class ClinicManagementAddLoadingState extends ClinicManagement {}

class ClinicManagementAddSuccessState extends ClinicManagement {
  String num;

  ClinicManagementAddSuccessState(this.num);
}

class ClinicManagementAddErrorState extends ClinicManagement {}

class ClinicManagementUpdateLoadingState extends ClinicManagement {}

class ClinicManagementUpdateSuccessState extends ClinicManagement {}

class ClinicManagementUpdateErrorState extends ClinicManagement {}

class ClinicManagementUpdateStatusLoadingState extends ClinicManagement {}

class ClinicManagementUpdateStatusSuccessState extends ClinicManagement {}

class ClinicManagementUpdateStatusErrorState extends ClinicManagement {}

class ClinicManagementSearchSuccessState extends ClinicManagement {}

class ClinicManagementSearchErrorState extends ClinicManagement {}

class ClinicManagementChangeBottomNavSuccessState extends ClinicManagement {}

class ClinicManagementDeleteLoadingState extends ClinicManagement {}

class ClinicManagementDeleteSuccessState extends ClinicManagement {}

class ClinicManagementDeleteErrorState extends ClinicManagement {}

class ClinicManagementMakePhoneCallState extends ClinicManagement {}
