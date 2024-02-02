import 'package:finance_app/view/add_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_app/view/settings.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
     late Box box;
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    box = Hive.box('money');
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
  //

  List<FlSpot> getPlotPoints(Map entireData) {
    List<FlSpot> dataSet = [];
    entireData.forEach((key, value) {
      print(
        (value['date'] as DateTime).day.toDouble(),
      );
      print((value['amount'] as int).toDouble());
      if (value['type'] == "Expense") {
        dataSet.add(
          FlSpot(
            (value['date'] as DateTime).day.toDouble(),
            (value['amount'] as int).toDouble(),
          ),
        );
      }
    });
    print(dataSet);
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      // print(key);
      // print(value['type']);
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double hh = media.height;
    double ww = media.width;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransaction()));
      }, child: Icon(Icons.add),),
        body: FutureBuilder<Map>(
        future: fetch(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Oopssss !!! There is some error !",
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "You haven't added Any Data !",
                ),
              );
            }
            //
            getTotalBalance(snapshot.data!);
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            32.0,
                          ),
                          // color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: CircleAvatar(
                          maxRadius: 28.0,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.verified_user_rounded),
                        ),
                      ),
                      Text(
                        "Sandesh paudel",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          // color: Static.PrimaryMaterialColor[800],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.settings,
                    size: 32.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
            //
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(
                12.0,
              ),
              child: Container(
                // constraints: const BoxConstraints(
                //   minWidth: 88.0,
                //   minHeight: 36.0,
                // ), // min sizes for Material buttons
                alignment: Alignment.center,
                
                child: Column(
                  children: [
                    Text(
                      'Total Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: hh * 0.028,
                        // color: Colors.white,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      height: hh * 0.008,
                    ),
                    Text(
                      // 'Rs 32000',
                      'Rs $totalBalance',

                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: hh * 0.036,
                        fontWeight: FontWeight.w700,
                        // color: Colors.white,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    SizedBox(
                      height: hh * 0.012,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardIncome(
                            // "1600",
                          totalIncome.toString(),

                          ),
                          cardExpense(
                            // "1200",
                            totalIncome.toString(),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Text(
                "Feb 2024",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            //
            Container(
              height: hh * 0.4,
              padding: EdgeInsets.symmetric(
                vertical: hh * 0.012,
                horizontal: ww * 0.012,
              ),
              margin: EdgeInsets.all(
                12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      // spots: [
                      //   FlSpot(2, 1000),
                      //   FlSpot(3, 1200),
                      //   FlSpot(4, 3000),
                      //   FlSpot(5, 2000),
                      //   FlSpot(8, 1400),
                      //   FlSpot(10, 1320),
                      //   FlSpot(12, 900),
                      //   FlSpot(17, 1900),
                      // ],
                      spots: getPlotPoints(snapshot.data!),
                
                      isCurved: false,
                      barWidth: 2.5,
                      
                      showingIndicators: [200, 200, 90, 10],
                      dotData: FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Recent Expenses",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            //
            ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map dataAtIndex = snapshot.data![index];
                    if (dataAtIndex['type'] == "Income") {
                      return incomeTile(
                          dataAtIndex['amount'], dataAtIndex['note']);
                    } else {
                      return expenseTile(
                          dataAtIndex['amount'], dataAtIndex['note']);
                    }
                  },
            ),
            // creditTile(
            //   12000,
            // ),
            // expenseTile(
            //   2000,
            // ),
            // expenseTile(
            //   4000,
            // ),
            // expenseTile(
            //   2200,
            // ),
            
            SizedBox(
              height: hh * 0.004,
            ),
          ],
        );
    } else {
            return Text(
              "Loading...",
            );
          }
        },
    ),);
  
  }
}


// Widget cardIncome(String value) {
//   return Row(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white60,
//           // color: Theme.of(context).colorScheme.background,
//           borderRadius: BorderRadius.circular(
//             20.0,
//           ),
//         ),
//         padding: EdgeInsets.all(
//           6.0,
//         ),
//         child: Icon(
//           Icons.arrow_downward,
//           size: 28.0,
//           color: Colors.green[700],
//         ),
//         margin: EdgeInsets.only(
//           right: 8.0,
//         ),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Income",
//             style: TextStyle(
//               fontSize: 14.0,
//               // color: Colors.white70,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.w700,
//               // color: Colors.white,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget cardExpense(String value) {
//   return Row(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white60,
//           borderRadius: BorderRadius.circular(
//             20.0,
//           ),
//         ),
//         padding: EdgeInsets.all(
//           6.0,
//         ),
//         child: Icon(
//           Icons.arrow_upward,
//           size: 28.0,
//           color: Colors.red[700],
//         ),
//         margin: EdgeInsets.only(
//           right: 8.0,
//         ),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Expense",
//             style: TextStyle(
//               fontSize: 14.0,
//               // color: Colors.white70,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.w700,
//               // color: Colors.white,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget expenseTile(int value) {
//   return Container(
//     padding: const EdgeInsets.all(18.0),
//     margin: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//         color: Color(0xffced4eb),
//         borderRadius: BorderRadius.circular(
//           8.0,
//         )),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Icon(
//               Icons.arrow_circle_up_outlined,
//               size: 28.0,
//               color: Colors.red[700],
//             ),
//             Text(
//               "\tExpense",
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           "- $value",
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget creditTile(int value) {
//   return Container(
//     padding: const EdgeInsets.all(18.0),
//     margin: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//         color: Color(0xffced4eb),
//         borderRadius: BorderRadius.circular(
//           8.0,
//         )),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Icon(
//               Icons.arrow_circle_down_outlined,
//               size: 28.0,
//               color: Colors.green[700],
//             ),
//             Text(
//               "\tCredit",
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           "+ $value",
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget incomeTile(int value, String note) {
//   return Container(
//     padding: const EdgeInsets.all(18.0),
//     margin: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//         color: Color(0xffced4eb),
//         borderRadius: BorderRadius.circular(
//           8.0,
//         )),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.arrow_circle_down_outlined,
//                   size: 28.0,
//                   color: Colors.green[700],
//                 ),
//                 SizedBox(
//                   width: 4.0,
//                 ),
//                 Text(
//                   "Credit",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               "+ $value",
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//         //
//         Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Text(
//             note,
//             style: TextStyle(
//               color: Colors.grey[800],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_downward,
          size: 28.0,
          color: Colors.green[700],
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Income",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.amber,
              // color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              // color: Colors.white,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_upward,
          size: 28.0,
          color: Colors.red[700],
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.amber,
              // color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              // color: Colors.white,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget expenseTile(int value, String note) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_up_outlined,
                  size: 28.0,
                  color: Colors.red[700],
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Text(
              "- $value",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        //
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            note,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget incomeTile(int value, String note) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 28.0,
                  color: Colors.green[700],
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Credit",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Text(
              "+ $value",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        //
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            note,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    ),
  );
}