
import 'package:fire_database/models/student_grant_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/student_model.dart';
import '../../services/rtdb_service.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<StudentModel> grantList = [];
  bool isLoading = false;
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
  TextEditingController contract = TextEditingController();
  TextEditingController newContract = TextEditingController();


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

  Future<void> createData(StudentModel grant) async {
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.saveDataContracts(grant);
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

                                            const SizedBox(height: 10),
                                            Text(
                                              "Contact of the Student: ${grantList[index].contract}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),

                                            const SizedBox(height: 20),
                                            MaterialButton(
                                              onPressed: () {
                                                name.text = grantList[index].name;
                                                surname.text = grantList[index].surname;
                                                module.text = grantList[index].moduleName;
                                                level.text = grantList[index].level.toString();
                                                contract.text = grantList[index].contract.toString();

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
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: contract,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Contract",
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            StudentModel student = grantList[index].copyWith(
                                                                name: name.text,
                                                                surname: surname.text,
                                                                moduleName: module.text,
                                                                level: int.parse(level.text),
                                                                contract: int.parse(contract.text),
                                                                id: grantList[index].id
                                                            );

                                                            await updateData(student);

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
                          trailing: Text(
                            "${grantList[index].contract}\$",
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
                  ),Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newContract,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Contract",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () async {
                      StudentModel student = StudentModel(
                          name: newName.text,
                          surname: newSurname.text,
                          moduleName: newModule.text,
                          level: int.parse(newLevel.text),
                          contract: int.parse(newContract.text)
                      );

                      await createData(student);

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
