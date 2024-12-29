import 'package:carcheckinout/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppDashboard extends StatefulWidget {
  Widget body;
  bool? isAppBarRequired = false;
  String? appBarHeading;
  AppDashboard(
      {super.key,
      required this.body,
      this.isAppBarRequired,
      this.appBarHeading});

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Visibility(
                visible: widget.isAppBarRequired ?? false,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          size: 40,
                          color: Colors.black,
                        )),
                    AppText(
                      text: widget.appBarHeading ?? '',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              widget.body,
            ],
          ),
        ),
      ),
    );
  }
}
