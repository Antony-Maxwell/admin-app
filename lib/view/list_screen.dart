import 'package:admin_app/constants/menus.dart';
import 'package:admin_app/dio/api.dart';
import 'package:admin_app/model/category_model.dart';
import 'package:admin_app/view/add_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddedWidgetsListEditUpdateDeleteScreen extends StatefulWidget {
  const AddedWidgetsListEditUpdateDeleteScreen(
      {super.key, required this.menuName});

  final String menuName;

  @override
  State<AddedWidgetsListEditUpdateDeleteScreen> createState() =>
      _AddedWidgetsListEditUpdateDeleteScreenState();
}

class _AddedWidgetsListEditUpdateDeleteScreenState
    extends State<AddedWidgetsListEditUpdateDeleteScreen> {
  List<CategoryModel> dataList = [];
  bool isFetching = false;

  getCategory() async {
    setState(() {
      isFetching = true;
    });

    await FetchApi().fetchCategory().then((response) {
      try {
        if (response['status']) {
          final List<dynamic> data = response['data'];
          dataList = data.map((item) => CategoryModel.fromJson(item)).toList();
          setState(() {
            isFetching = false;
          });
        }
      } catch (e) {
        print("Error while fetching data $e");
      }
    });
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  List<String> widgetMenuNames = [
    AppConstants.productsWidgetMenu,
    AppConstants.categoryWidgetMenu,
    AppConstants.bannerWidgetMenu,
    AppConstants.brandsWidgetMenu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isFetching
          ? const Center(
              child: Text("Fetching data..."),
            )
          : SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        widget.menuName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  Expanded(child: listViewWidgetFromMenu(widget.menuName)),
                ],
              ),
            ),
      bottomNavigationBar: bottomNavButton(context),
    );
  }

  Padding bottomNavButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddDetailsScreen(menuName: widget.menuName),
              ));
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Center(
              child: Text(
            "Add ${widget.menuName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
        ),
      ),
    );
  }

  Widget listViewWidgetFromMenu(String menu) {
    if (menu == widgetMenuNames[0]) {
      return productsGridView();
    } else if (menu == widgetMenuNames[1]) {
      return categoryListViewWidget();
    } else if (menu == widgetMenuNames[2]) {
      return bannerWidgetView();
    } else if (menu == widgetMenuNames[3]) {
      return brandWidgetView();
    } else {
      return const SizedBox();
    }
  }

  Padding brandWidgetView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        itemBuilder: (context, index) => Card(
          elevation: 5,
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ))
              ],
            ),
          ),
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

  Padding bannerWidgetView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: 10),
    );
  }

  Padding productsGridView() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const Expanded(
                      child: Column(
                    children: [Text("Product name"), Text("12314")],
                  ))
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }

  ListView categoryListViewWidget() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(top: 10, left: 10, right: 10)
                : const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: dataList[index].imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(dataList[index].name),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: dataList.length);
  }
}
