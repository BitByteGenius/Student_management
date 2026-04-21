import 'package:flutter/material.dart';
import 'package:student_management/common_widget/appbar.dart';
import 'package:student_management/constant/colors.dart';
import 'package:student_management/constant/sizes.dart';
import 'package:student_management/constant/text.dart';
import 'package:student_management/features/data/db_helper.dart';

class AddStudentScreen extends StatefulWidget {
  final int? id;
  const AddStudentScreen({super.key, this.id});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  List<Map<String, dynamic>> allData = [];
  bool isLoading = true;

   Future<void> addData() async {
  await DbHelper.createData(
    nameController.text,
    courseController.text,
    int.tryParse(ageController.text) ?? 0,
  );
}

Future<void> updateData() async {
  await DbHelper.updateData(
    widget.id!,
    nameController.text,
    int.tryParse(ageController.text) ?? 0,
    courseController.text,
  );
}
   
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        leading: true,
        title: Text(
          TText.tAddStudent,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----Name field----
                Text("Name", style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwItems),
                Text("Age", style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    //labelText: "Age",
                    hintText: "Enter Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwItems),
                Text("Course", style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: courseController,
                  decoration: InputDecoration(
                    //labelText: "Courses",
                    hintText: "Enter Courses",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwSections * 11),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () async {
                    if (widget.id == null) {
                    await addData();
                    } else {
                    await updateData();
                       }

                      nameController.clear();
                      ageController.clear();
                       courseController.clear();

                       Navigator.of(context).pop();

                    },
                    
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: TColors.button,
                    ),
                    child:
                    Padding(padding: EdgeInsetsGeometry.all(18),
                    child: Text(widget.id == null ? "Add Data" : "Update",
                     style: TextStyle(fontSize: 20,
                     fontWeight: FontWeight.w500)
                    
                  ),
                ),
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
