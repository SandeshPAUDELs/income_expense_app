import 'package:finance_app/view/add_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: Column(
        children: [
          Expanded(
            child: ListView(
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
                          'Rs 32000',
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
                                "1600",
                              ),
                              cardExpense(
                                "1200",
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
                          spots: [
                            FlSpot(2, 1000),
                            FlSpot(3, 1200),
                            FlSpot(4, 3000),
                            FlSpot(5, 2000),
                            FlSpot(8, 1400),
                            FlSpot(10, 1320),
                            FlSpot(12, 900),
                            FlSpot(17, 1900),
                          ],
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
                creditTile(
                  12000,
                ),
                expenseTile(
                  2000,
                ),
                expenseTile(
                  4000,
                ),
                expenseTile(
                  2200,
                ),
                
                SizedBox(
                  height: hh * 0.004,
                ),
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}


Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          // color: Theme.of(context).colorScheme.background,
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
              // color: Colors.white70,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              // color: Colors.white,
              color: Colors.black,
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
              // color: Colors.white70,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              // color: Colors.white,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget expenseTile(int value) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_up_outlined,
              size: 28.0,
              color: Colors.red[700],
            ),
            Text(
              "\tExpense",
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
  );
}

Widget creditTile(int value) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(
          8.0,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_down_outlined,
              size: 28.0,
              color: Colors.green[700],
            ),
            Text(
              "\tCredit",
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
  );
}
