import 'package:fire_database/pages/admin_pages/contract_page.dart';
import 'package:fire_database/pages/admin_pages/grant_page.dart';
import 'package:flutter/material.dart';

class StudentDetailPage extends StatefulWidget {
  const StudentDetailPage({super.key});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Detail Page"),
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
                    builder: (context)=>const StudentGrantPage()
                  )
              );
            },
            minWidth: 340,
            height: 80,
            shape: const StadiumBorder(),
            color: Colors.purpleAccent,
            child: const Text(
              "Grant Students",
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
                      builder: (context)=>const StudentPage()
                  )
              );
            },
            minWidth: 340,
            height: 80,
            shape: const StadiumBorder(),
            color: Colors.purpleAccent,
            child: const Text(
              "Contract Students",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          )
        ],
      ),
    );
  }
}
