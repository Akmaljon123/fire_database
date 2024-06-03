import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/uni_model.dart';
import '../services/cloud_store_service.dart';

class UnisPage extends StatefulWidget {
  const UnisPage({super.key});

  @override
  State<UnisPage> createState() => _UnisPageState();
}

class _UnisPageState extends State<UnisPage> {
  List<QueryDocumentSnapshot<Object?>> uniList = [];
  List<UniModel> uniListData = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController year = TextEditingController();

  Future<void> createDataFire(UniModel uniModel) async {
    isLoading = true;
    setState(() {});

    await CFSService.createData(isBuilding: true, data: uniModel.toJson());
    await loadDataFire();
  }

  Future<void> loadDataFire() async {
    uniListData = [];
    isLoading = true;
    setState(() {});
    uniList = await CFSService.readData(isBuilding: true);
    for (var e in uniList) {
      uniListData.add(UniModel.fromJson(e.data() as Map<String, dynamic>));
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> updateDataFire({
    required UniModel uniModel,
  })async{
    isLoading = true;
    setState(() {});

    await CFSService.updateData(data: uniModel.toJson(), isBuilding: true);
    await loadDataFire();
  }

  Future<void> deleteDataFire({
    required String id,
    required UniModel uniModel
  })async{
    isLoading = true;
    setState(() {});

    await CFSService.deleteData(isBuilding: false, data: uniModel.toJson());
    await loadDataFire();
  }

  @override
  void didChangeDependencies() async {
    await loadDataFire();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Buildings"),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 28
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
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
                    itemCount: uniListData.length,
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
                                          // Container(
                                          //   height: 300,
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(15),
                                          //   ),
                                          //   child: ClipRRect(
                                          //     borderRadius: BorderRadius.circular(15),
                                          //     child: Image.asset(
                                          //       uniList[index].url!,
                                          //       fit: BoxFit.cover,
                                          //       width: double.infinity,
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Name of the building: ${uniListData[index].name}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Built in: ${uniListData[index].year}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            uniListData[index].desc!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );


                          },
                          title: Text(
                            uniListData[index].name!,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          // leading: Image.asset(uniList[index].url!),
                          subtitle: Text(
                            uniListData[index].year!,
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
