import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: StreamBuilder<List<EventsRecord>>(
          stream: queryEventsRecord(
            queryBuilder: (eventsRecord) =>
                eventsRecord.orderBy('Start', descending: true),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: SpinKitRing(
                    color: FlutterFlowTheme.primaryColor,
                    size: 50,
                  ),
                ),
              );
            }
            List<EventsRecord> columnEventsRecordList = snapshot.data;
            // Customize what your widget looks like with no query results.
            if (snapshot.data.isEmpty) {
              return Material(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Text('No results.'),
                  ),
                ),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children:
                  List.generate(columnEventsRecordList.length, (columnIndex) {
                final columnEventsRecord = columnEventsRecordList[columnIndex];
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      columnEventsRecord.place,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
