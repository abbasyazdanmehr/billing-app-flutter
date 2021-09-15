import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/bills_database.dart';
import 'package:billing_app/db/turnovers_database.dart';
import 'package:flutter/material.dart';

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
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                BillsDatabase.instance.dropDB();
              },
              child: Text('Drop bills table'),
            ),
            TextButton(
              onPressed: () async {
                BillsDatabase.instance
                    .createDB(await BillsDatabase.instance.database, 1);
              },
              child: Text('Create bills table'),
            ),
          ],
        ),
      ),
    );
  }
}
