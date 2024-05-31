
import 'package:fire_database/models/student_grant_model.dart';
import 'package:flutter/material.dart';

import '../../models/student_model.dart';
import '../../services/rtdb_service.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<StudentModel> grantList = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController module = TextEditingController();
  TextEditingController level = TextEditingController();

  Future<void> storeTeachers(List<StudentModel> teachers) async {
    for (var teacher in teachers) {
      await RealTimeDatabase.saveDataContracts(teacher);
    }
  }

  Future<void> loadData() async {
    isLoading = true;
    setState(() {});
    grantList = await RealTimeDatabase.getDataContracts();
    isLoading = false;
    setState(() {});
  }

  Future<void> createData(StudentGrantModel grant) async {
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.saveDataGrants(grant);
    await loadData();
  }

  Future<void> updateData(StudentModel grant)async{
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.updateDataStudents(grant);
    await loadData();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contract Students"),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 28
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: isLoading ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator())
          ]
      ) : Column (
          children: [
            const SizedBox(height: 20),

            Expanded(
                child: ListView.builder(
                    itemCount: grantList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade900,
                        child: ListTile(
                          onTap: (){
                            showModalBottomSheet(
                              backgroundColor: Colors.black,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (context, scrollController) {
                                    return SingleChildScrollView(
                                      controller: scrollController,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            Container(
                                              height: 5,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Name of the Student: ${grantList[index].name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Surname of the Student: ${grantList[index].surname}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Module of the Student: ${grantList[index].moduleName}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Level of the Student: ${grantList[index].level}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );



                          },
                          title: Text(
                            grantList[index].name,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            grantList[index].surname,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      );
                    }
                )
            ),

            const SizedBox(height: 90)
          ]
      )
    );
  }
}
