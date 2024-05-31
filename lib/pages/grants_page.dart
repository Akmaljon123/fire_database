import 'package:fire_database/models/student_grant_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../services/rtdb_service.dart';

class StudentGrantPages extends StatefulWidget {
  const StudentGrantPages({super.key});

  @override
  State<StudentGrantPages> createState() => _StudentGrantPagesState();
}

class _StudentGrantPagesState extends State<StudentGrantPages> {
  List<StudentGrantModel> grantList = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController module = TextEditingController();
  TextEditingController level = TextEditingController();

  Future<void> storeTeachers(List<StudentGrantModel> teachers) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("/students/grants_students");

    for (var teacher in teachers) {
      await RealTimeDatabase.saveDataGrants(teacher);
    }
  }

  Future<void> loadData() async {
    isLoading = true;
    setState(() {});
    grantList = await RealTimeDatabase.getDataGrants();
    isLoading = false;
    setState(() {});
  }

  Future<void> createData(StudentGrantModel grant) async {
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.saveDataGrants(grant);
    await loadData();
  }

  Future<void> updateData(StudentGrantModel grant)async{
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.updateDataGrants(grant);
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
        title: const Text("Grant Students"),
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
          List<StudentGrantModel> studentGrantData = [
            StudentGrantModel(
              name: "John",
              surname: "Doe",
              moduleName: "BIS",
              level: 3,
            ),
            StudentGrantModel(
              name: "Jane",
              surname: "Smith",
              moduleName: "BABM",
              level: 4,
            ),
            StudentGrantModel(
              name: "Alice",
              surname: "Johnson",
              moduleName: "LAW",
              level: 5,
            ),
            StudentGrantModel(
              name: "Bob",
              surname: "Brown",
              moduleName: "ECOFin",
              level: 6,
            ),
            StudentGrantModel(
              name: "Charlie",
              surname: "Davis",
              moduleName: "BIS",
              level: 3,
            ),
            StudentGrantModel(
              name: "David",
              surname: "Miller",
              moduleName: "BABM",
              level: 4,
            ),
            StudentGrantModel(
              name: "Ella",
              surname: "Wilson",
              moduleName: "LAW",
              level: 5,
            ),
            StudentGrantModel(
              name: "Frank",
              surname: "Moore",
              moduleName: "ECOFin",
              level: 6,
            ),
            StudentGrantModel(
              name: "Grace",
              surname: "Taylor",
              moduleName: "BIS",
              level: 3,
            ),
            StudentGrantModel(
              name: "Hank",
              surname: "Anderson",
              moduleName: "BABM",
              level: 4,
            ),
            StudentGrantModel(
              name: "Ivy",
              surname: "Clark",
              moduleName: "LAW",
              level: 5,
            ),
            StudentGrantModel(
              name: "Jack",
              surname: "White",
              moduleName: "ECOFin",
              level: 6,
            ),
            StudentGrantModel(
              name: "Kate",
              surname: "Harris",
              moduleName: "BIS",
              level: 3,
            ),
            StudentGrantModel(
              name: "Leo",
              surname: "Allen",
              moduleName: "BABM",
              level: 4,
            ),
            StudentGrantModel(
              name: "Mia",
              surname: "King",
              moduleName: "LAW",
              level: 5,
            ),
            StudentGrantModel(
              name: "Noah",
              surname: "Baker",
              moduleName: "ECOFin",
              level: 6,
            ),
            StudentGrantModel(
              name: "Olivia",
              surname: "Evans",
              moduleName: "BIS",
              level: 3,
            ),
            StudentGrantModel(
              name: "Peter",
              surname: "Gonzalez",
              moduleName: "BABM",
              level: 4,
            ),
            StudentGrantModel(
              name: "Quinn",
              surname: "Nelson",
              moduleName: "LAW",
              level: 5,
            ),
            StudentGrantModel(
              name: "Rachel",
              surname: "Young",
              moduleName: "ECOFin",
              level: 6,
            ),
          ];


          await storeTeachers(studentGrantData);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
