import 'package:carcheckinout/constant/string_constant.dart';
import 'package:carcheckinout/feature/view_car_check_history/model/car_model.dart';
import 'package:carcheckinout/utils/app_database_helper.dart';
import 'package:carcheckinout/utils/app_toast.dart';
import 'package:carcheckinout/utils/format_time.dart';
import 'package:carcheckinout/widgets/app_dashboard.dart';
import 'package:carcheckinout/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CarCheckInHistory extends StatefulWidget {
  const CarCheckInHistory({super.key});

  @override
  State<CarCheckInHistory> createState() => _CarCheckInHistoryState();
}

class _CarCheckInHistoryState extends State<CarCheckInHistory> {
  List<Car> carData = [];
  @override
  void initState() {
    super.initState();
    _getCarData();
  }

  void _getCarData() async {
    var data = await AppDatabaseHelper.instance.getAllCars();
    setState(() {
      carData.addAll(data.map((map) => Car.fromMap(map)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDashboard(
        isAppBarRequired: true,
        appBarHeading: StringConstant.viewCheckInList,
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(border: Border.all()),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      textAlign: TextAlign.center,
                      text: 'Car Number',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppText(
                      textAlign: TextAlign.center,
                      text: 'Check-In Time',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppText(
                      textAlign: TextAlign.center,
                      text: 'Check-Out Time',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: carData.isNotEmpty,
              replacement: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppText(
                    text: 'No Data Avaliable at the moment!',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: ListView.builder(
                itemCount: carData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(border: Border.all()),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            textAlign: TextAlign.center,
                            text: carData[index].carNumber,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AppText(
                            textAlign: TextAlign.center,
                            text: carData[index].checkInTime != null
                                ? formatTime(
                                    carData[index].checkInTime.toString())
                                : '--',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Visibility(
                            visible: carData[index].checkOutTime != null,
                            replacement: InkWell(
                              onTap: () async {
                                await AppDatabaseHelper.instance
                                    .updateCarCheckOut(carData[index].carNumber,
                                        DateTime.now().toIso8601String());
                                AppToast.showToast(
                                    StringConstant.checkOutSucess);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                              child: AppText(
                                text: StringConstant.checkOutText,
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: AppText(
                              textAlign: TextAlign.center,
                              text: carData[index].checkOutTime != null
                                  ? formatTime(
                                      carData[index].checkOutTime.toString())
                                  : '--',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
