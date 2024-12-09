import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          displayMedium: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          displaySmall: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          headlineLarge: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          headlineMedium: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          headlineSmall: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          titleLarge: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          titleMedium: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          titleSmall: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          bodyLarge: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          bodySmall: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          labelLarge: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          labelMedium: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
          labelSmall: TextStyle(color: Color.fromARGB(255, 3, 46, 96)),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
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
  Map<String, String>? selectedEmotion;
  int? selectedIndex;
  Map selectedIndexForBottomNavBar = {};

  List<String> emojiNames = [
    "Feeling Sad",
    "Feeling Angry",
    "Feeling Bad",
    "Feeling Happy",
    "Feeling Empty"
  ];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog(context);
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Welcome Maxwell",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "How are you feeling today?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 1,
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final isSelected =
                                selectedEmotion?[emojiNames[index]] ==
                                    "assets/images/emoji${index + 1}.png";
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedEmotion = null;
                                  } else {
                                    selectedEmotion = {
                                      emojiNames[index]:
                                          "assets/images/emoji${index + 1}.png"
                                    };
                                    selectedIndex = index + 1;
                                  }
                                });

                                print(selectedEmotion);
                                print(selectedIndex);
                              },
                              child: Card(
                                color: index + 1 == selectedIndex
                                    ? Colors.cyan.shade100
                                    : null,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/emoji${index + 1}.png",
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                      ),
                                      Text(
                                        emojiNames[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> listHeadlines = [
    "Feel Better in 15 Min",
    "Tide Over Together",
    "How are you Feeling"
  ];

  List<String> listContents = [
    '''Stressed, Angry, worried? 15 Minutes Live chat with our Psychologist''',
    '''Counsellor-led Support  Group sessions''',
    '''Get Curated Tips for your Betterment'''
  ];

  List<String> trailingImages = [
    "assets/images/woman in online meetings.png",
    "assets/images/isometric view of young woman and man talking.png",
    "assets/images/girl meditating.png",
  ];

  List<IconData> bottomNavBarIcons = [
                        Icons.phone_in_talk_sharp,
                        Icons.live_tv_outlined,
                        Icons.home,
                        Icons.person,
                        Icons.rss_feed_sharp
  ];

  List<String> bottomNavBarTitles = [
    "Speak Up",
    "Videos",
    "Home",
    "Profile",
    "Feeds"
  ];

  List<String> datesInAWeak = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/HomeScreen2nd.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hello",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Badge.count(
                            count: 5,
                            child: const Icon(
                              Icons.notifications_active_outlined,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Maxwell",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: const Color.fromARGB(255, 232, 243, 253),
                              elevation: 8,
                              child: SizedBox(
                                height: 70,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                            "assets/images/sessions.png"),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Sessions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Card(
                              color: const Color.fromARGB(255, 228, 239, 249),
                              elevation: 8,
                              child: SizedBox(
                                height: 70,
                                child: Stack(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(-15, 0),
                                      child: Image.asset(
                                        "assets/images/streak.png",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    const Positioned(
                                      right: 15,
                                      top: 22,
                                      child: Text(
                                        "7 Streaks",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: const Color.fromARGB(255, 228, 239, 249),
                        elevation: 8,
                        child: SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double paddingHorizontal = 15.0 * 2;
                              double dividerWidth = 1.0;
                              int dividerCount = datesInAWeak.length - 1;
                              double totalDividerWidth =
                                  dividerWidth * dividerCount;

                              double availableWidth = constraints.maxWidth -
                                  paddingHorizontal -
                                  totalDividerWidth;

                              double itemWidth =
                                  availableWidth / datesInAWeak.length;
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: itemWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.calendar_today),
                                        Text(
                                          datesInAWeak[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const VerticalDivider(
                                  endIndent: 20,
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                itemCount: datesInAWeak.length,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: const Color.fromARGB(255, 228, 239, 249),
                        elevation: 8,
                        child: SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/idea.png"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Mindfull Tips",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  '''Consider setting an intention before meditating, maybe its self-kindness, openness or patience''',
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Suggested for you",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemCount: trailingImages.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color.fromARGB(255, 228, 239, 249),
                            elevation: 5,
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            listHeadlines[index],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            listContents[index],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    trailingImages[index]),
                                                fit: BoxFit.contain)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF189ab4).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index; 
                          });
                        },
                        child: selectedIndex == index
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 228, 239, 249),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(bottomNavBarIcons[index]),
                                    const SizedBox(width: 4),
                                    Text(bottomNavBarTitles[index], style: const TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ))
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(bottomNavBarIcons[index], color: Colors.white,),
                                const SizedBox(height: 2,),
                                Container(
                                  height: 3,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).textTheme.bodyLarge!.color
                                  ),
                                )
                              ],
                            ),
                      );
                    }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(Icons.phone_in_talk_sharp),
//                         Icon(Icons.live_tv_outlined),
//                         Icon(Icons.home),
//                         Icon(Icons.person),
//                         Icon(Icons.rss_feed_sharp)
//                       ],
//                     ),
//                   ),

// bottomNavigationBar: Padding(
//           padding: EdgeInsets.all(15),
//           child: Container(
//             height: 60,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: Colors.cyan.shade300,
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
