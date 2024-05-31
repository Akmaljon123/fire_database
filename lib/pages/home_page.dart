import 'package:fire_database/pages/admin_pages/student_detail_page.dart';
import 'package:fire_database/pages/admin_pages/teacher_page.dart';
import 'package:fire_database/pages/admin_pages/uni_page.dart';
import 'package:fire_database/pages/login_page.dart';
import 'package:fire_database/pages/teachers_page.dart';
import 'package:fire_database/pages/unis_page.dart';
import 'package:fire_database/services/authentication_service.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: ()async{
              await AuthenticationService.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const LoginPage()
                  ),
                  (route)=>false
              );
            },
            child: const Text("Home Page")
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 28
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),

          MaterialButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>const StudentDetailsPage()
                  )
              );
            },
            minWidth: 340,
            height: 80,
            shape: const StadiumBorder(),
            color: Colors.purpleAccent,
            child: const Text(
              "Students",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),

          const SizedBox(height: 10),

          MaterialButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>const TeachersPage()
                  )
              );
            },
            minWidth: 340,
            height: 80,
            shape: const StadiumBorder(),
            color: Colors.purpleAccent,
            child: const Text(
              "Faculty members",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),

          const SizedBox(height: 10),

          MaterialButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>const UnisPage()
                  )
              );
            },
            minWidth: 340,
            height: 80,
            shape: const StadiumBorder(),
            color: Colors.purpleAccent,
            child: const Text(
              "Buildings",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),
        ],
      ),
    );
  }
}
