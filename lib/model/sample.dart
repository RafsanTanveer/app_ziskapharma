import 'dart:convert';

class User {
  final double userOID;
  final double userID;
  final String userUID;
  final String userPws;
  final String userFullName;
  final double userComID;
  final String userComCode;
  final double userBrnID;
  final String userBrnCode;
  final String userBrnName;
  final String userDepartmentCode;
  final String userDepartment;
  final int userStatus;
  final String? userReportMenu;
  final int userType;
  final String userTypeName;
  final bool menuSystem;
  final bool utilities;
  final bool task;
  final bool sysCompany;
  final bool sysBranch;
  final bool sysFacility;
  final String? filterData;
  final bool sysRoomData;
  final bool sysDosagesForm;
  final String? sysProcessDefault;
  final bool sysProcessParameter;
  final bool sysProductionLine;
  final bool sysCreateUser;
  final bool sysBackupSetup;
  final bool sysSetupOption;
  final bool utiProcurementSource;
  final bool utiStdUnit;
  final bool utiProductInfo;
  final bool utiMaterialsInfo;
  final bool utiReorderLevel;
  final bool utiStandardBatch;
  final String? accessoriesInfo;
  final bool utiMachineries;
  final bool utiChartofAcct;
  final bool utiGLH;
  final bool utiCustomerInfo;
  final bool utiSupplierInfo;
  final bool utiLostTimeSet;
  final bool utiManpower;
  final bool utiMachineCapacityPrdwise;
  final bool utiLeadTime;
  final bool utiTollCompany;
  final bool utiTollCharge;
  final String? cuid;
  final String muid;
  final DateTime? cDate;
  final DateTime mDate;
  final bool taskOperation;
  final bool taskProductionPlan;
  final String? taskSalesForeCust;
  final String? taskFactoryStock;
  final String? taskStockAllDepot;
  final String? taskPipeLineBase;
  final String? taskWip;
  final String? taskRequirement;
  final String? taskTentative;
  final bool taskProcurementSchedule;
  final bool taskLCDocument;
  final bool taskQuarantineMaterials;
  final bool taskQCRelease;
  final bool taskMaterialsStore;
  final bool taskProduction;
  final bool taskActionPlan;
  final bool taskBatchIssue;
  final bool taskFOIssue;
  final bool taskDispensing;
  final bool taskLineDelivery;
  final bool taskWIProgress;
  final bool taskProductQuarantine;
  final bool taskProductRelease;
  final bool taskProductIDTM;
  final bool taskProductStore;
  final bool taskQC;
  final bool taskQA;
  final bool taskReject;
  final bool taskReCall;
  final bool taskDestruction;
  final bool taskDelivery;
  final String? taskHRManagement;
  final String? taskAccounts;
  final String? taskEngineering;
  final String userDesignation;
  final String userMobileNo;
  final String userEmail;
  final bool administratorUser;
  final bool normalUser;
  final bool superAdministrator;
  final bool statusActive;
  final bool statusInactive;
  final String userImagePicture;

  User({
    required this.userOID,
    required this.userID,
    required this.userUID,
    required this.userPws,
    required this.userFullName,
    required this.userComID,
    required this.userComCode,
    required this.userBrnID,
    required this.userBrnCode,
    required this.userBrnName,
    required this.userDepartmentCode,
    required this.userDepartment,
    required this.userStatus,
    this.userReportMenu,
    required this.userType,
    required this.userTypeName,
    required this.menuSystem,
    required this.utilities,
    required this.task,
    required this.sysCompany,
    required this.sysBranch,
    required this.sysFacility,
    this.filterData,
    required this.sysRoomData,
    required this.sysDosagesForm,
    this.sysProcessDefault,
    required this.sysProcessParameter,
    required this.sysProductionLine,
    required this.sysCreateUser,
    required this.sysBackupSetup,
    required this.sysSetupOption,
    required this.utiProcurementSource,
    required this.utiStdUnit,
    required this.utiProductInfo,
    required this.utiMaterialsInfo,
    required this.utiReorderLevel,
    required this.utiStandardBatch,
    this.accessoriesInfo,
    required this.utiMachineries,
    required this.utiChartofAcct,
    required this.utiGLH,
    required this.utiCustomerInfo,
    required this.utiSupplierInfo,
    required this.utiLostTimeSet,
    required this.utiManpower,
    required this.utiMachineCapacityPrdwise,
    required this.utiLeadTime,
    required this.utiTollCompany,
    required this.utiTollCharge,
    this.cuid,
    required this.muid,
    this.cDate,
    required this.mDate,
    required this.taskOperation,
    required this.taskProductionPlan,
    this.taskSalesForeCust,
    this.taskFactoryStock,
    this.taskStockAllDepot,
    this.taskPipeLineBase,
    this.taskWip,
    this.taskRequirement,
    this.taskTentative,
    required this.taskProcurementSchedule,
    required this.taskLCDocument,
    required this.taskQuarantineMaterials,
    required this.taskQCRelease,
    required this.taskMaterialsStore,
    required this.taskProduction,
    required this.taskActionPlan,
    required this.taskBatchIssue,
    required this.taskFOIssue,
    required this.taskDispensing,
    required this.taskLineDelivery,
    required this.taskWIProgress,
    required this.taskProductQuarantine,
    required this.taskProductRelease,
    required this.taskProductIDTM,
    required this.taskProductStore,
    required this.taskQC,
    required this.taskQA,
    required this.taskReject,
    required this.taskReCall,
    required this.taskDestruction,
    required this.taskDelivery,
    this.taskHRManagement,
    this.taskAccounts,
    this.taskEngineering,
    required this.userDesignation,
    required this.userMobileNo,
    required this.userEmail,
    required this.administratorUser,
    required this.normalUser,
    required this.superAdministrator,
    required this.statusActive,
    required this.statusInactive,
    required this.userImagePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userOID: json['user_OID'].toDouble(),
      userID: json['user_ID'].toDouble(),
      userUID: json['user_UID'],
      userPws: json['user_Pws'],
      userFullName: json['user_FullName'],
      userComID: json['user_ComID'].toDouble(),
      userComCode: json['user_ComCode'],
      userBrnID: json['user_BrnID'].toDouble(),
      userBrnCode: json['user_BrnCode'],
      userBrnName: json['user_BrnName'],
      userDepartmentCode: json['user_DepartmentCode'],
      userDepartment: json['user_Department'],
      userStatus: json['user_Status'],
      userReportMenu: json['user_ReportMenu'],
      userType: json['user_UserType'],
      userTypeName: json['user_UserTypeName'],
      menuSystem: json['user_MenuSystem'] == 'True',
      utilities: json['user_Utilities'] == 'True',
      task: json['user_Task'] == 'True',
      sysCompany: json['user_SysCompany'] == 'True',
      sysBranch: json['user_SysBranch'] == 'True',
      sysFacility: json['user_SysFacility'] == 'True',
      filterData: json['user_FilterData'],
      sysRoomData: json['user_SysRoomData'] == 'True',
      sysDosagesForm: json['user_SysDosagesForm'] == 'True',
      sysProcessDefault: json['user_SysProcessDefault'],
      sysProcessParameter: json['user_SysProcessParameter'] == 'True',
      sysProductionLine: json['user_SysProductionLine'] == 'True',
      sysCreateUser: json['user_SysCreateUser'] == 'True',
      sysBackupSetup: json['user_SysBackupSetup'] == 'True',
      sysSetupOption: json['user_SysSetupOption'] == 'True',
      utiProcurementSource: json['user_UtiProcurementSource'] == 'True',
      utiStdUnit: json['user_UtiStdUnit'] == 'True',
      utiProductInfo: json['user_UtiProductInfo'] == 'True',
      utiMaterialsInfo: json['user_UtiMaterialsInfo'] == 'True',
      utiReorderLevel: json['user_UtiReorderLevel'] == 'True',
      utiStandardBatch: json['user_UtiStandardBatch'] == 'True',
      accessoriesInfo: json['user_AccessoriesInfo'],
      utiMachineries: json['user_UtiMachineries'] == 'True',
      utiChartofAcct: json['user_UtiChartofAcct'] == 'True',
      utiGLH: json['user_UtiGLH'] == 'True',
      utiCustomerInfo: json['user_UtiCustomerInfo'] == 'True',
      utiSupplierInfo: json['user_UtiSupplierInfo'] == 'True',
      utiLostTimeSet: json['user_UtiLostTimeSet'] == 'True',
      utiManpower: json['user_UtiManpower'] == 'True',
      utiMachineCapacityPrdwise:
          json['user_UtiMachineCapacityPrdwise'] == 'True',
      utiLeadTime: json['user_UtiLeadTime'] == 'True',
      utiTollCompany: json['user_UtiTollCompany'] == 'True',
      utiTollCharge: json['user_UtiTollCharge'] == 'True',
      cuid: json['user_CUID'],
      muid: json['user_MUID'],
      cDate: json['user_CDate'] != null
          ? DateTime.parse(json['user_CDate'])
          : null,
      mDate: DateTime.parse(json['user_MDate']),
      taskOperation: json['user_TaskOperation'] == 'True',
      taskProductionPlan: json['user_TaskProductionPlan'] == 'True',
      taskSalesForeCust: json['user_TaskSalesForeCust'],
      taskFactoryStock: json['user_TaskFactoryStock'],
      taskStockAllDepot: json['user_TaskStockAllDepot'],
      taskPipeLineBase: json['user_TaskPipeLineBase'],
      taskWip: json['user_TaskWip'],
      taskRequirement: json['user_TaskRequirement'],
      taskTentative: json['user_TaskTentative'],
      taskProcurementSchedule: json['user_TaskProcurementSchedule'] == 'True',
      taskLCDocument: json['user_TaskLCDocument'] == 'True',
      taskQuarantineMaterials: json['user_TaskQuarantineMaterials'] == 'True',
      taskQCRelease: json['user_TaskQCRelease'] == 'True',
      taskMaterialsStore: json['user_TaskMaterialsStore'] == 'True',
      taskProduction: json['user_TaskProduction'] == 'True',
      taskActionPlan: json['user_TaskActionPlan'] == 'True',
      taskBatchIssue: json['user_TaskBatchIssue'] == 'True',
      taskFOIssue: json['user_TaskFOIssue'] == 'True',
      taskDispensing: json['user_TaskDispensing'] == 'True',
      taskLineDelivery: json['user_TaskLineDelivery'] == 'True',
      taskWIProgress: json['user_TaskWIProgress'] == 'True',
      taskProductQuarantine: json['user_TaskProductQuarantine'] == 'True',
      taskProductRelease: json['user_TaskProductRelease'] == 'True',
      taskProductIDTM: json['user_TaskProductIDTM'] == 'True',
      taskProductStore: json['user_TaskProductStore'] == 'True',
      taskQC: json['user_TaskQC'] == 'True',
      taskQA: json['user_TaskQA'] == 'True',
      taskReject: json['user_TaskReject'] == 'True',
      taskReCall: json['user_TaskReCall'] == 'True',
      taskDestruction: json['user_TaskDestruction'] == 'True',
      taskDelivery: json['user_TaskDelivery'] == 'True',
      taskHRManagement: json['user_TaskHRManagement'],
      taskAccounts: json['user_TaskAccounts'],
      taskEngineering: json['user_TaskEngineering'],
      userDesignation: json['user_Designation'],
      userMobileNo: json['user_MobileNo'],
      userEmail: json['user_Email'],
      administratorUser: json['user_AdministratorUser'] == 'True',
      normalUser: json['user_NormalUser'] == 'True',
      superAdministrator: json['user_SuperAdministrator'] == 'True',
      statusActive: json['user_StatusActive'] == 'True',
      statusInactive: json['user_StatusInactive'] == 'True',
      userImagePicture: json['user_ImagePicture'],
    );
  }
}

User parseUserFromJson(String jsonString) {
  print('in sample file');
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);


  final Map<String, dynamic> userJson = parsedJson['Table'][0];
  // print(userJson);
  return User.fromJson(userJson);
}
