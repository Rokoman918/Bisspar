import 'package:flutter/material.dart';

import 'package:formvalidation/src/pages/manage_time/ui/screens/header.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/description_project.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/historical_record_list.dart';

// ignore: must_be_immutable
class HomeManageTimes extends StatelessWidget {
  String Projectdescription = "";
  String ProjectName = "";
  int IdProject = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            // DescriptionProject(ProjectName, Projectdescription, IdProject),
            // HistoricalRecordList()
          ],
        ),
        HeaderAppbar()
      ],
    );
  }
}
