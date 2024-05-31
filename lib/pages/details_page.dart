import 'package:fire_database/pages/grants_page.dart';
import 'package:fire_database/pages/students_pages.dart';
import 'package:flutter/material.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
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
                      builder: (context)=>const StudentGrantPages()
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
                      builder: (context)=>const StudentsPage()
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
