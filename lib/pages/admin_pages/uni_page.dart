import 'package:flutter/material.dart';
import '../../models/uni_model.dart';
import '../../services/rtdb_service.dart';

class UniPage extends StatefulWidget {
  const UniPage({super.key});

  @override
  State<UniPage> createState() => _UniPageState();
}

class _UniPageState extends State<UniPage> {
  List<UniModel> uniList = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController newName = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController newDesc = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController newYear = TextEditingController();
  TextEditingController newLocation = TextEditingController();


  Future<void> loadData() async {
    isLoading = true;
    setState(() {});
    uniList = await RealTimeDatabase.getDataUni("uni_buildings");
    isLoading = false;
    setState(() {});
  }

  Future<void> createData(UniModel uni) async {
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.saveDataUni(uni, "uni_buildings");
    await loadData();
  }

  Future<void> updateData(UniModel uni)async{
    isLoading = true;
    setState(() {});

    await RealTimeDatabase.updateDataUni(uni, "uni_buildings");
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
                    itemCount: uniList.length,
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
                                          Container(
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image.asset(
                                                uniList[index].url!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Name of the building: ${uniList[index].name}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Built in: ${uniList[index].year}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            uniList[index].desc!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          const SizedBox(height: 20),

                                          MaterialButton(
                                            onPressed: (){
                                              name.text = uniList[index].name!;
                                              desc.text = uniList[index].desc!;
                                              year.text = uniList[index].year!;

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
                                                            UniModel uni = uniList[index].copyWith(
                                                              name: name.text,
                                                              desc: desc.text,
                                                              year: year.text
                                                            );

                                                            await updateData(uni);

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
                          title: Text(
                            uniList[index].name!,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          leading: Image.asset(uniList[index].url!),
                          subtitle: Text(
                            uniList[index].year!,
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
