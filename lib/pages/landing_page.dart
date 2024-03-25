import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/landing.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.7,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text("Bringing the World to Your Fingertips:\n     Stay Informed with FlutterNews", style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),),
           const SizedBox(height: 20,),
            Text("Empowering You with Global Insights, Anytime,\n                               Anywhere!", style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500),),
          const SizedBox(height: 50,),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width/1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5,
                child: Container(
                  
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Get Started', style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),)),
                ),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}