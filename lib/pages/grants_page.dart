import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_database/models/student_grant_model.dart';
import 'package:flutter/material.dart';

import '../services/cloud_store_service.dart';

class StudentGrantPages extends StatefulWidget {
  const StudentGrantPages({super.key});

  @override
  State<StudentGrantPages> createState() => _StudentGrantPagesState();
}

class _StudentGrantPagesState extends State<StudentGrantPages> {
  List<QueryDocumentSnapshot<Object?>> fireList = [];
  List<StudentGrantModel> fireListData = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController module = TextEditingController();
  TextEditingController level = TextEditingController();

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
                        ),
                      );
                    }
                )
            ),

            const SizedBox(height: 90)
          ]
      ),
    );
  }
}
