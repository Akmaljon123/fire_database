import 'package:fire_database/pages/admin_pages/student_detail_page.dart';
import 'package:fire_database/pages/admin_pages/teacher_page.dart';
import 'package:fire_database/pages/admin_pages/uni_page.dart';
import 'package:flutter/material.dart';

import '../../services/authentication_service.dart';
import '../login_page.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: ()async{
              await AuthenticationService.logout();
              if(context.mounted){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>const LoginPage()
                    ),
                        (route)=>false
                );
              }
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),

          MaterialButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>const StudentDetailPage()
                  )
              );
            },
            minWidth: 365,
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
                      builder: (context)=>const TeacherPage()
                  )
              );
            },
            minWidth: 365,
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
                      builder: (context)=>const UniPage()
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
