import 'package:flutter/material.dart';
import '../../models/uni_model.dart';
import '../../services/rtdb_service.dart';

class UnisPage extends StatefulWidget {
  const UnisPage({super.key});

  @override
  State<UnisPage> createState() => _UnisPageState();
}

class _UnisPageState extends State<UnisPage> {
  List<UniModel> uniList = [];
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController year = TextEditingController();


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
    );
  }
}
