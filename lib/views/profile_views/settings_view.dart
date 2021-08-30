import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/turnovers_database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                TurnoversDatabase.instance.dropDB();
              },
              child: Text('Drop turnovers table'),
            ),
            TextButton(
              onPressed: () async {
                TurnoversDatabase.instance
                    .createDB(await TurnoversDatabase.instance.database, 1);
              },
              child: Text('Create turnovers table'),
            ),
          ],
        ),
      ),
    );
  }
}
