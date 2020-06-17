import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Native Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/start_music');
  // Get Service Status.
  String _serviceStatus = 'Unknown Service Status.';

  Future<void> _getServiceStatus(String serviceMethodName) async {
    String serviceStatus;
    try {
      final int result = await platform.invokeMethod('$serviceMethodName');
      serviceStatus = '$result';
    } on PlatformException catch (e) {
      serviceStatus = "Failed to get Service Status: '${e.message}'.";
    }
    setState(() {
      _serviceStatus = serviceStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: w*0.9,
          height: h * 0.3,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
              color: Color(0xffeeeeee),
              border: Border.all(color: Color(0xffcccccc), width: 0.5)),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "$_serviceStatus",
                  style:TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0
                  ) ,
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0.0,
                        heroTag: 'btnStartServiceTag',
                        onPressed:() => _getServiceStatus('startMyService'),
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.notifications_active,
                          color: Colors.blue,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0.0,
                        heroTag: 'btnEndServiceTag',
                        onPressed:() => _getServiceStatus('stopMyService'),
                        backgroundColor: Colors.white,
                        child: Icon(Icons.notifications_off, color: Colors.blue),
                      )),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
