
import 'package:fire_database/models/student_grant_model.dart';
import 'package:firebase_database/firebase_database.dart';
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
    DatabaseReference ref = FirebaseDatabase.instance.ref("/students/contract_students");

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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<StudentModel> studentGrantData = [
            StudentModel(
              name: "John",
              surname: "Doe",
              moduleName: "BIS",
              level: 3,
              contract: 3500,
            ),
            StudentModel(
              name: "Jane",
              surname: "Smith",
              moduleName: "BABM",
              level: 4,
              contract: 3200,
            ),
            StudentModel(
              name: "Alice",
              surname: "Johnson",
              moduleName: "LAW",
              level: 5,
              contract: 4000,
            ),
            StudentModel(
              name: "Bob",
              surname: "Brown",
              moduleName: "ECOFin",
              level: 6,
              contract: 3100,
            ),
            StudentModel(
              name: "Charlie",
              surname: "Davis",
              moduleName: "BIS",
              level: 3,
              contract: 3000,
            ),
            StudentModel(
              name: "David",
              surname: "Miller",
              moduleName: "BABM",
              level: 4,
              contract: 3300,
            ),
            StudentModel(
              name: "Ella",
              surname: "Wilson",
              moduleName: "LAW",
              level: 5,
              contract: 3900,
            ),
            StudentModel(
              name: "Frank",
              surname: "Moore",
              moduleName: "ECOFin",
              level: 6,
              contract: 3400,
            ),
            StudentModel(
              name: "Grace",
              surname: "Taylor",
              moduleName: "BIS",
              level: 3,
              contract: 3200,
            ),
            StudentModel(
              name: "Hank",
              surname: "Anderson",
              moduleName: "BABM",
              level: 4,
              contract: 3600,
            ),
            StudentModel(
              name: "Ivy",
              surname: "Clark",
              moduleName: "LAW",
              level: 5,
              contract: 3700,
            ),
            StudentModel(
              name: "Jack",
              surname: "White",
              moduleName: "ECOFin",
              level: 6,
              contract: 3800,
            ),
            StudentModel(
              name: "Kate",
              surname: "Harris",
              moduleName: "BIS",
              level: 3,
              contract: 3100,
            ),
            StudentModel(
              name: "Leo",
              surname: "Allen",
              moduleName: "BABM",
              level: 4,
              contract: 3500,
            ),
            StudentModel(
              name: "Mia",
              surname: "King",
              moduleName: "LAW",
              level: 5,
              contract: 3400,
            ),
            StudentModel(
              name: "Noah",
              surname: "Baker",
              moduleName: "ECOFin",
              level: 6,
              contract: 3900,
            ),
            StudentModel(
              name: "Olivia",
              surname: "Evans",
              moduleName: "BIS",
              level: 3,
              contract: 3200,
            ),
            StudentModel(
              name: "Peter",
              surname: "Gonzalez",
              moduleName: "BABM",
              level: 4,
              contract: 3100,
            ),
            StudentModel(
              name: "Quinn",
              surname: "Nelson",
              moduleName: "LAW",
              level: 5,
              contract: 3000,
            ),
            StudentModel(
              name: "Rachel",
              surname: "Young",
              moduleName: "ECOFin",
              level: 6,
              contract: 4000,
            ),
          ];


          await storeTeachers(studentGrantData);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
