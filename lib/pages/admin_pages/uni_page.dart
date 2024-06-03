import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/uni_model.dart';
import '../../services/cloud_store_service.dart';

class UniPage extends StatefulWidget {
  const UniPage({super.key});

  @override
  State<UniPage> createState() => _UniPageState();
}

class _UniPageState extends State<UniPage> {
  List<QueryDocumentSnapshot<Object?>> uniList = [];
  List<UniModel> uniListData = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController newName = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController newDesc = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController newYear = TextEditingController();
  TextEditingController newLocation = TextEditingController();


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
                                          //       // uniList[index].url!,
                                          //       // fit: BoxFit.cover,
                                          //       // width: double.infinity,
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

                                          MaterialButton(
                                            onPressed: (){
                                              name.text = uniListData[index].name!;
                                              desc.text = uniListData[index].desc!;
                                              year.text = uniListData[index].year!;

                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return AlertDialog(
                                                      backgroundColor: Colors.black,
                                                      title: const Text(
                                                          "Edit",
                                                        style: TextStyle(
                                                          color: Colors.white
                                                        ),
                                                      ),

                                                      actions: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: name,
                                                            style: const TextStyle(
                                                              color: Colors.white
                                                            ),
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15)
                                                              ),

                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15)
                                                              ),

                                                              labelText: "Name"
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(height: 10),

                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: desc,
                                                            style: const TextStyle(
                                                                color: Colors.white
                                                            ),
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(15)
                                                                ),

                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(15)
                                                                ),

                                                                labelText: "Description"
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(height: 10),


                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          child: TextField(
                                                            controller: year,
                                                            style: const TextStyle(
                                                                color: Colors.white
                                                            ),
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(15)
                                                                ),

                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(15)
                                                                ),

                                                                labelText: "Year"
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(height: 10),

                                                        MaterialButton(
                                                          onPressed: ()async{
                                                            UniModel uni = uniListData[index].copyWith(
                                                              name: name.text,
                                                              desc: desc.text,
                                                              year: year.text,
                                                              id: uniListData[index].id
                                                            );

                                                            await updateDataFire(uniModel: uni);

                                                            if(context.mounted){
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          minWidth: 340,
                                                          height: 50,
                                                          color: Colors.purpleAccent,
                                                          shape: const StadiumBorder(),
                                                          child: const Text(
                                                            "Save",
                                                            style: TextStyle(
                                                              color: Colors.white
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            minWidth: 340,
                                            height: 50,
                                            shape: const StadiumBorder(),
                                            color: Colors.purpleAccent,
                                            child: const Text(
                                                "Edit",
                                              style: TextStyle(
                                                color: Colors.white
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );


                          },
                          onLongPress: ()async{
                            await deleteDataFire(id: uniListData[index].id!, uniModel: uniListData[index]);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                  "Add a Building",
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
                      controller: newYear,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Year",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newDesc,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Description",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: newLocation,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Location",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),


                  MaterialButton(
                    onPressed: () async {
                      UniModel student = UniModel(
                          name: newName.text,
                          year: newYear.text,
                          desc: newDesc.text,
                          location: newLocation.text
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
