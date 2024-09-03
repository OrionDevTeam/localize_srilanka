import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ReservationScreen(),
    );
  }
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int selectedDateIndex = 0;
  int selectedTimeSlotIndex = 1;
  String selectedMonth = DateFormat.MMMM().format(DateTime.now());
  int currentYear = DateTime.now().year;
  List<String> dates = [];
  final List<String> timeSlots = [
    "10:00AM - 2:00PM",
    "2:00PM - 6:00PM",
    "10:00AM - 2:00PM"
  ];

  @override
  void initState() {
    super.initState();
    generateDates();
  }

  void generateDates() {
    final monthIndex = DateFormat.MMMM().parse(selectedMonth).month;
    final daysInMonth = DateUtils.getDaysInMonth(currentYear, monthIndex);

    dates = List.generate(daysInMonth, (index) {
      final date = DateTime(currentYear, monthIndex, index + 1);
      return DateFormat.d().format(date);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Reserve",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedMonth,
              items: List.generate(12, (index) {
                return DropdownMenuItem<String>(
                  value: DateFormat.MMMM().format(DateTime(0, index + 1)),
                  child: Text(DateFormat.MMMM().format(DateTime(0, index + 1))),
                );
              }),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                  selectedDateIndex = 0;
                  generateDates();
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final date = DateTime(currentYear,
                      DateFormat.MMMM().parse(selectedMonth).month, index + 1);
                  final day = DateFormat.E().format(date);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selectedDateIndex == index
                            ? Colors.teal
                            : Colors.white,
                        border: Border.all(
                          color: selectedDateIndex == index
                              ? Colors.teal
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedDateIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            dates[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedDateIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: List.generate(timeSlots.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeSlotIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: selectedTimeSlotIndex == index
                          ? Colors.teal
                          : Colors.white,
                      border: Border.all(
                        color: selectedTimeSlotIndex == index
                            ? Colors.teal
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        timeSlots[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedTimeSlotIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      trailing: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedTimeSlotIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                          color: selectedTimeSlotIndex == index
                              ? Colors.teal
                              : Colors.transparent,
                        ),
                        child: selectedTimeSlotIndex == index
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 156, 140),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Continue",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
