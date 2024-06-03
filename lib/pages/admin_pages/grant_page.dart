import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_database/models/student_grant_model.dart';
import 'package:flutter/material.dart';

import '../../services/cloud_store_service.dart';
import '../../services/rtdb_service.dart';

class StudentGrantPage extends StatefulWidget {
  const StudentGrantPage({super.key});

  @override
  State<StudentGrantPage> createState() => _StudentGrantPageState();
}

class _StudentGrantPageState extends State<StudentGrantPage> {
  List<StudentGrantModel> grantList = [];
  bool isLoading = false;
  List<QueryDocumentSnapshot<Object?>> fireList = [];
  List<StudentGrantModel> fireListData = [];
  TextEditingController name = TextEditingController();
  TextEditingController newName = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController newSurname = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController newSalary = TextEditingController();
  TextEditingController module = TextEditingController();
  TextEditingController newModule = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController newLevel = TextEditingController();

  Future<void> createDataFire(StudentGrantModel studentModel) async {
    isLoading = true;
    setState(() {});

    await CFSService.createDataStudents(data: studentModel.toJson(), isContract: false);
    await loadDataFire();
  }

  Future<void> loadDataFire() async {
    fireListData = [];
    isLoading = true;
    setState(() {});
    fireList = await CFSService.readDataStudents(isContract: false);
    for (var e in fireList) {
      fireListData.add(StudentGrantModel.fromJson(e.data() as Map<String, dynamic>));
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> updateDataFire({
    required StudentGrantModel studentModel,
  })async{
    isLoading = true;
    setState(() {});

    await CFSService.updateDataStudents(data: studentModel.toJson(), isContract: false);
    await loadDataFire();
  }

  Future<void> deleteDataFire({
    required String id,
    required StudentGrantModel model
  })async{
    isLoading = true;
    setState(() {});

    await CFSService.deleteDataStudents(isContract: false, data: model.toJson());
    await loadDataFire();
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

  Future<void> deleteData(StudentGrantModel grant)async{
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.deleteDataGrants(grant);
    await loadData();
  }
  

  @override
  void didChangeDependencies()async{
    await loadDataFire();
    super.didChangeDependencies();
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
                    itemCount: fireListData.length,
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
                                              "Name of the Student: ${fireListData[index].name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Surname of the Student: ${fireListData[index].surname}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Module of the Student: ${fireListData[index].moduleName}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Level of the Student: ${fireListData[index].level}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            MaterialButton(
                                              onPressed: () {
                                                name.text = fireListData[index].name;
                                                surname.text = fireListData[index].surname;
                                                module.text = fireListData[index].moduleName;
                                                level.text = fireListData[index].level.toString();

                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.black,
                                                      title: const Text(
                                                        "Edit",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      actions: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: name,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Name",
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: surname,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Surname",
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: module,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Module name",
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: level,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Level",
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            StudentGrantModel student = fireListData[index].copyWith(
                                                              name: name.text,
                                                              surname: surname.text,
                                                              moduleName: module.text,
                                                              level: int.parse(level.text),
                                                              id: fireListData[index].id
                                                            );

                                                            await updateDataFire(studentModel: student);

                                                            if (context.mounted) {
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          minWidth: 340,
                                                          height: 50,
                                                          color: Colors.purpleAccent,
                                                          shape: const StadiumBorder(),
                                                          child: const Text(
                                                            "Save",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              minWidth: 340,
                                              height: 50,
                                              shape: const StadiumBorder(),
                                              color: Colors.purpleAccent,
                                              child: const Text(
                                                "Edit",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );



                          },
                          onLongPress: ()async{
                            await deleteDataFire(model: fireListData[index], id: fireListData[index].id!);
                          },
                          title: Text(
                            fireListData[index].name,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            fireListData[index].surname,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          trailing: Text(
                            fireListData[index].moduleName,
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                  "Add a Student",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newName,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Name",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newSurname,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Surname",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newModule,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Module name",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newLevel,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Level",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () async {
                      StudentGrantModel student = StudentGrantModel(
                          name: newName.text,
                          surname: newSurname.text,
                          moduleName: newModule.text,
                          level: int.parse(newLevel.text)
                      );

                      await createDataFire(student);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    minWidth: 340,
                    height: 50,
                    color: Colors.purpleAccent,
                    shape: const StadiumBorder(),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
