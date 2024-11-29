import 'package:admin_app/dio/api.dart';
import 'package:admin_app/model/category_model.dart';
import 'package:admin_app/view/add_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddedWidgetsListEditUpdateDeleteScreen extends StatefulWidget {
  const AddedWidgetsListEditUpdateDeleteScreen({super.key, required this.menuName});

  final String menuName;

  @override
  State<AddedWidgetsListEditUpdateDeleteScreen> createState() => _AddedWidgetsListEditUpdateDeleteScreenState();
}

class _AddedWidgetsListEditUpdateDeleteScreenState extends State<AddedWidgetsListEditUpdateDeleteScreen> {

     List<CategoryModel>  categoryList = [];


  getCategory()async{
    Dio dio = Dio();

    try{
      final response = await dio.get(Api.getCategoryApi);
      if(response.data != null){
        final List<dynamic> data = response.data['data'];
        categoryList = data.map((item) => CategoryModel.fromJson(item)).toList();
        print(categoryList);
      }
    }catch (e){
      print("error while fetching category api $e");
    }
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(itemBuilder: (context, index) {
        return Padding(
          padding: index == 0 ? const EdgeInsets.only(top: 10, left: 10, right: 10) : const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: categoryList[index].imageUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(categoryList[index].name),
            )
          ),
        );
      }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: categoryList.length),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetailsScreen(menuName: widget.menuName),));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Center(child: Text("Add ${widget.menuName}", style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18
            ),)),
          ),
        ),
      ),
    );
  }
}