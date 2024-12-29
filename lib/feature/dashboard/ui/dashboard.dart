import 'package:carcheckinout/constant/string_constant.dart';
import 'package:carcheckinout/feature/checkIn/ui/check_in.dart';
import 'package:carcheckinout/feature/view_car_check_history/ui/car_check_in_history.dart';
import 'package:carcheckinout/widgets/app_button.dart';
import 'package:carcheckinout/widgets/app_dashboard.dart';
import 'package:carcheckinout/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return AppDashboard(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: AppText(
            text: StringConstant.appHeading,
            fontSize: 22,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          text: StringConstant.checkInText,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const CheckIn();
              },
            ));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          text: StringConstant.viewCheckInList,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const CarCheckInHistory();
              },
            ));
          },
        )
      ],
    ));
  }
}
