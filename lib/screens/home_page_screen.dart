import 'package:app_1/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size size;
  late TextEditingController textFieldC;
  late bool validate = false;
  String errorText = '';

  @override
  void initState() {
    super.initState();
    textFieldC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textFieldC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        elevation: 20,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/sky2.jpg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Type city that you want to see it\'s weather',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: textFieldC,
                        decoration: InputDecoration(
                          errorText: validate ? errorText : null,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Type your city',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onChoosePressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text('choose'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> getData() async {
    String city = textFieldC.text;
    http.Response response = await http.post(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=bad4ad67fe76157b5bc1ef846793019d'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    // print(response.body);
    Map responseMap = convert.json.decode(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResultScreen(responseMap: responseMap);
          },
        ),
      );
    } //
    else {
      validate = true;
      setState(() {
        errorText = 'Please type city name correctly';
      });
    }
    return response;
  }

  onChoosePressed() {
    setState(() {
      textFieldC.text.isEmpty ? validate = true : validate = false;
      if (textFieldC.text.isEmpty) {
        errorText = 'Please type your city';
        return;
      }
      getData();
    });
  }
}
