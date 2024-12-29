import 'package:carcheckinout/constant/string_constant.dart';
import 'package:carcheckinout/utils/app_database_helper.dart';
import 'package:carcheckinout/utils/app_toast.dart';
import 'package:carcheckinout/utils/format_time.dart';
import 'package:carcheckinout/widgets/app_button.dart';
import 'package:carcheckinout/widgets/app_dashboard.dart';
import 'package:carcheckinout/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  final TextEditingController _carNumbeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppDashboard(
      appBarHeading: StringConstant.checkInText,
      isAppBarRequired: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: AppTextfield(
                  controller: _carNumbeController,
                  hintText: StringConstant.carNumberText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppButton(
                onPressed: () async {
                  if (_validateCarNumber()) {
                    final carData = {
                      'carNumber': _carNumbeController.text,
                      'checkInTime': DateTime.now().toIso8601String(),
                      'checkOutTime': null,
                    };

                    try {
                      final existingCar = await AppDatabaseHelper.instance
                          .getCarByNumber(_carNumbeController.text);
                      if (existingCar != null) {
                        if (existingCar.checkOutTime != null) {
                          await AppDatabaseHelper.instance.updateCarCheckIn(
                              _carNumbeController.text,
                              DateTime.now().toIso8601String());
                          await AppDatabaseHelper.instance.updateCarCheckOut(
                              _carNumbeController.text, null);
                          AppToast.showToast(StringConstant.checkInSucess);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } else {
                          AppToast.showToast(
                              StringConstant.carNumberAlreadyCheck,
                              isError: true);
                        }
                      } else {
                        await AppDatabaseHelper.instance.insertCar(carData);
                        AppToast.showToast(StringConstant.checkInSucess);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (e is DatabaseException &&
                          e.isUniqueConstraintError()) {
                        AppToast.showToast(StringConstant.carNumberExist,
                            isError: true);
                      } else {
                        AppToast.showToast('An unexpected error occurred',
                            isError: true);
                      }
                    }
                  }
                },
                text: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateCarNumber() {
    if (_carNumbeController.text.isEmpty) {
      AppToast.showToast(StringConstant.carEmptyErrorMsg, isError: true);
      return false;
    }
    if (!validateCarNumber(_carNumbeController.text)) {
      AppToast.showToast(StringConstant.carInvalidDataMsg, isError: true);
      return false;
    }
    return true;
  }

  bool validateCarNumber(String carNumber) {
    final RegExp carNumberRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z]{1,2}\d{4}$');
    return carNumberRegex.hasMatch(carNumber);
  }
}
