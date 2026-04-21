import 'package:flutter/material.dart';
import 'package:student_management/common_widget/appbar.dart';
import 'package:student_management/constant/colors.dart';
import 'package:student_management/constant/sizes.dart';
import 'package:student_management/constant/text.dart';
import 'package:student_management/features/data/db_helper.dart';
import 'package:student_management/features/screen/add_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> allData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() async {
    final data = await DbHelper.getAllData();
    setState(() {
      allData = data;
      isLoading = false;
    });
  }

  //----- Add data------

  Future<void> addData() async {
    await DbHelper.createData(
      _nameController.text,
      _courseController.text,
      int.tryParse(_ageController.text) ?? 0,
    );
    refreshData();
  }

  //-----Update Data------

  Future<void> updateData(int id) async {
    await DbHelper.updateData(
      id,
      _nameController.text,
      int.tryParse(_ageController.text) ?? 0,
      _courseController.text,
    );
    refreshData();
  }

  //-------Delete Data-----

  void deleteData(int id) async {
    await DbHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Data Deleted"),
      ),
    );
    refreshData();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void addStudentScreen(int? id) async {
    // Jab Id Null rahega tb update hoga
    if (id != null) {
      final existingData = 
      allData.firstWhere((element) => element['id'] == id);
      _nameController.text = existingData['name'];
      _ageController.text = existingData['age'].toString();
      _courseController.text = existingData['course'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // final list = HomeScreenModel.list;
    return Scaffold(
      appBar: TAppBar(
        leading: false,
        title: Text(
          TText.tAppName,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      allData[index]['name'],
                      style: TextStyle(
                        fontSize: TSizes.fontSizeLg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(allData[index]['age'].toString()),
                      Text(allData[index]['course']),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: ()  async {
                        await Navigator.push(
                         context,
                           MaterialPageRoute(
                             builder: (_) => AddStudentScreen(id: allData[index]['id']),
                            ),
                          );
                           refreshData(); // refresh after editing
                          },
                        icon: Icon(Icons.edit, color: TColors.button),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteData(allData[index]['id']);
                        },
                        icon: Icon(Icons.delete, color: TColors.danger),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddStudentScreen()),
          );
          refreshData(); // refresh after coming back
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
