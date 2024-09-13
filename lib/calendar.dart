import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'booking.dart';

class CalendarPage extends StatefulWidget {
  final String packageName;
  final String imageURL;

  CalendarPage({
    required this.packageName,
    required this.imageURL,
  });

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:8.0,right:8.0),
        child: Column(
          children: [
            TableCalendar(
              locale: 'en-US',
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Color(0xFF2A966C),
                  size: 15,
                ),
                rightChevronIcon: Icon(
                  CupertinoIcons.right_chevron,
                  color: Color(0xFF2A966C),
                  size: 15,
                ),
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF2A966C), // Background color for the selected day
                  shape: BoxShape.circle, // Shape of the selected day indicator
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white, // Text color for the selected day
                ),
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              availableGestures: AvailableGestures.all,
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => _isSameDay(day),
            ),
            SizedBox(height: 16.0),
            if (_selectedDate != null)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                  itemCount: 13,
                  itemBuilder: (context, index) {
                    final hour = 8 + index;
                    final time = TimeOfDay(hour: hour, minute: 0);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey
                                  .withOpacity(0.8),
                              width: 0.5),
                          borderRadius:
                              BorderRadius.circular(12.0),
                          color: _selectedTime == time
                              ? Color(0xFF2A966C)
                              : Colors.grey[300],
                          
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time.format(context),
                          style: TextStyle(
                            color: _selectedTime == time
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_selectedTime != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                alignment: Alignment.bottomRight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity, // Make the button take the whole width
                    child: ElevatedButton(
                    
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFF2A966C), // Change text color
                        padding: const EdgeInsets.symmetric(vertical: 16.0), // Increase button height
                        textStyle: const TextStyle(fontSize: 18), // Increase text size
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              date: _selectedDate,
                              time: _selectedTime!,
                              packageName: widget.packageName, // Pass the package name
                              imageURL: widget.imageURL,
                              isPaymentButton: true, // Show payment button
                            ),
                          ),
                        );
                      },
                      child: const Text('Book'),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _selectedTime = null; // Reset time selection when date changes
    });
  }

  bool _isSameDay(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }
}