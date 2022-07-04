import 'package:app_1/custom_widgets/custom_text_widget_one.dart';
import 'package:app_1/custom_widgets/custom_text_widget_two.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final Map responseMap;

  ResultScreen({required this.responseMap});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Size size;

  late int num;

  @override
  void initState() {
    // TODO: implement initState
    changeBackGroundPicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Map mainMap = widget.responseMap['main'];
    Map windMap = widget.responseMap['wind'];
    List list = widget.responseMap['weather'];
    Map weatherMap = list[0];
    String status = weatherMap['main'];
    double h = mainMap['temp_max'] - 270;
    double l = mainMap['temp_min'] - 270;
    double t = mainMap['temp'] - 270;
    int humidity = mainMap['humidity'];
    int pressure = mainMap['pressure'];
    double windSpeed = windMap['speed'];
    double visibility = widget.responseMap['visibility'] / 1000;
    // h = num.parse(h.toStringAsFixed(0));
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/sky$num.jpg'),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 350,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      widget.responseMap['name'],
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      status,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      ' ${t.toStringAsFixed(0)}°',
                      style: TextStyle(
                          fontSize: 80,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'H: ${h.toStringAsFixed(0)}°',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'L: ${l.toStringAsFixed(0)}°',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget2(text: 'Wind'),
                              CustomTextWidget1(
                                  text:
                                      'wsw ${windSpeed.toStringAsFixed(0)} km/h')
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget2(text: 'Pressure'),
                              CustomTextWidget1(text: '$pressure hPa')
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                      indent: 60,
                      endIndent: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget2(text: 'Humidity'),
                              CustomTextWidget1(text: '$humidity%')
                            ],
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget2(text: 'Visibility'),
                              CustomTextWidget1(
                                  text: '${visibility.toStringAsFixed(0)} km')
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeBackGroundPicture() async {
    List list = widget.responseMap['weather'];
    Map weatherMap = list[0];
    if (weatherMap['main'] == 'Clouds') {
      num = 4;
    } //
    else if (weatherMap['main'] == 'Clear') {
      num = 1;
    } //
    else if (weatherMap['main'] == 'Rain') {
      num = 7;
    } //
    else if (weatherMap['main'] == 'Haze') {
      num = 8;
    }
  }
}
