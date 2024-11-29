import 'package:admin_app/constants/menus.dart';
import 'package:admin_app/view/add_details_screen.dart';
import 'package:admin_app/view/list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    List<String> apiDataWidgets = [
      'Products',
      'Category',
      'Banners',
      'Brands'
    ];

    List<String> widgetMenuNames = [
      AppConstants.productsWidgetMenu,
      AppConstants.categoryWidgetMenu,
      AppConstants.bannerWidgetMenu,
      AppConstants.brandsWidgetMenu
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        return Padding(
          padding: index == 0 ? const EdgeInsets.only(top: 10, left: 10, right: 10) : const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddedWidgetsListEditUpdateDeleteScreen(menuName: widgetMenuNames[index],),));
              },
              leading: const CircleAvatar(),
              title: Text(apiDataWidgets[index]),
            )
          ),
        );
      }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: apiDataWidgets.length),
    
    );
  }
}
