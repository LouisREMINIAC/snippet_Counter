import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_alternative/dashboard_page/flutterfire/flutterfire.dart';
import 'package:project_alternative/dashboard_page/flutterfire/ignoringButton.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../flutter_flow/flutter_flow_ad_banner.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DashboardPageWidget extends StatefulWidget {
  const DashboardPageWidget({Key? key}) : super(key: key);

  @override
  _DashboardPageWidgetState createState() => _DashboardPageWidgetState();
}

class _DashboardPageWidgetState extends State<DashboardPageWidget>
    with TickerProviderStateMixin {
  
  // COUNTER 
  
  CountdownController _countdownController = CountdownController();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'dashboard_page'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    _countdownController.start();

    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    // FORMAT COUNTER 
    
    var f = NumberFormat("00", "en_US");
    
    // FIREBASE WHERE THE TIMESTAMP IS SAVED 

    var refCoin = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('collection_1');

    var refAsset = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('collection_2');
    
  Container(
     height: 20,
     width: MediaQuery.of(context).size.width /5,
     child: StreamBuilder(
            stream: refCoin.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
                  if (!snapshot.hasData) {
                    
           return Center(
               child:
               CircularProgressIndicator(),);}
              
           return ListView(
               children: snapshot.data!.docs.map((document) {
                  return Countdown(
                    
                    controller:_countdownController,
                    
                     seconds: ((newDate(formattedDate(document['timestamp'])).difference(DateTime.now())).inSeconds),
                    
                     build:(BuildContext context, double time) => Text("${f.format(time ~/ 3600)}:${f.format((time % 3600) ~/ 60)}:${f.format(time.toInt() % 60)}",
                        
                     style: FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily:'Poppins',
                                  color: Color(0xFFFAFAFA)),),
                                  interval: Duration(seconds: 1),
                                  onFinished: () {setState(() {((newDate(formattedDate(document['timestamp'])).difference(DateTime.now())).inSeconds) == 0.0;
                                                          });
                                                        });
                                                  }).toList(),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
