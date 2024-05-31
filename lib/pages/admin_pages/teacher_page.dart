import 'package:flutter/material.dart';

import '../../models/teacher_model.dart';
import '../../services/rtdb_service.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<TeacherModel> teacherList = [];
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


  Future<void> loadData() async {
    isLoading = true;
    setState(() {});
    teacherList = await RealTimeDatabase.getDataTeachers("teachers");
    isLoading = false;
    setState(() {});
  }

  Future<void> createData(TeacherModel teacher) async {
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.saveDataTeachers(teacher, "teachers");
    await loadData();
  }

  Future<void> updateData(TeacherModel teacher)async{
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.updateDataTeachers(teacher, "teachers");
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
        title: const Text("Teachers"),
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
                    itemCount: teacherList.length,
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
                                              "Name of the Teacher: ${teacherList[index].name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Surname of the Teacher: ${teacherList[index].surname}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Salary of the Teacher: ${teacherList[index].salary}\$",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Module of the Teacher: ${teacherList[index].moduleName}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Level of the Teacher: ${teacherList[index].level}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            MaterialButton(
                                              onPressed: () {
                                                name.text = teacherList[index].name;
                                                surname.text = teacherList[index].surname;
                                                salary.text = teacherList[index].salary.toString();
                                                module.text = teacherList[index].moduleName;
                                                level.text = teacherList[index].level;

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
                                                            controller: salary,
                                                            style: const TextStyle(color: Colors.white),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: "Salary",
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
                                                            TeacherModel teacher = teacherList[index].copyWith(
                                                              name: name.text,
                                                              surname: surname.text,
                                                              salary: int.parse(salary.text),
                                                              moduleName: module.text,
                                                              level: level.text,
                                                            );

                                                            await updateData(teacher);

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
                            teacherList[index].name,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            teacherList[index].surname,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          trailing: Text(
                            "Salary: ${teacherList[index].salary}\$",
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
                  "Add a Teacher",
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
                      TeacherModel student = TeacherModel(
                          name: newName.text,
                          surname: newSurname.text,
                          moduleName: newModule.text,
                          level: newLevel.text,
                          salary: int.parse(newSalary.text)
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
