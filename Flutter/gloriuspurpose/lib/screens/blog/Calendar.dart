import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<Event> events = [
    Event('Teach for India - Workshop', DateTime(2024, 10, 1, 10, 0), DateTime(2024, 10, 1, 11, 0)),
    Event('Goonj - Fundraiser', DateTime(2024, 10, 3, 12, 0), DateTime(2024, 10, 3, 13, 0)),
    Event('Akshay Patra - Meal Distribution', DateTime(2024, 10, 5, 14, 0), DateTime(2024, 10, 5, 15, 0)),
    Event('CRY - Awareness Campaign', DateTime(2024, 10, 20, 9, 0), DateTime(2024, 10, 20, 10, 0)),
    Event('PRATHAM - Education Seminar', DateTime(2024, 10, 24, 16, 0), DateTime(2024, 10, 24, 17, 0)),
  ];

  List<Event> selectedDayEvents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Column(
        children: [
          Expanded(
            child: SfCalendar(
              headerHeight: 50,
              view: CalendarView.month,
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
              ),
              cellBorderColor: Colors.transparent,
              todayHighlightColor: Colors.green,
              firstDayOfWeek: 7,
              dataSource: MeetingDataSource(getAppointments()),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  DateTime tappedDate = details.date!;
                  setState(() {
                    selectedDayEvents = events.where((event) =>
                    event.startTime.year == tappedDate.year &&
                        event.startTime.month == tappedDate.month &&
                        event.startTime.day == tappedDate.day).toList();
                  });
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEventDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  List<Appointment> getAppointments() {
    List<Appointment> meetings = [];
    for (var event in events) {
      meetings.add(Appointment(
        startTime: event.startTime,
        endTime: event.endTime,
        subject: event.title,
        color: Colors.green,
      ));
    }
    return meetings;
  }
// Method to show dialog for adding events
  void _showEventDialog() {
    final titleController = TextEditingController();
    DateTime? startTime;
    DateTime? endTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Event",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event Title Input Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Event Title",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 20),

              // Start Time Picker
              GestureDetector(
                onTap: () => _selectDateTime(context, true).then((value) {
                  if (value != null) {
                    setState(() {
                      startTime = value;
                    });
                  }
                }),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.green),
                    SizedBox(width: 10),
                    Text(
                      startTime == null
                          ? 'Select Start Time'
                          : 'Start Time: ${startTime!.toLocal()}',
                      style: TextStyle(
                        fontSize: 16,
                        color: startTime == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // End Time Picker
              GestureDetector(
                onTap: () => _selectDateTime(context, false).then((value) {
                  if (value != null) {
                    setState(() {
                      endTime = value;
                    });
                  }
                }),
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined, color: Colors.green),
                    SizedBox(width: 10),
                    Text(
                      endTime == null
                          ? 'Select End Time'
                          : 'End Time: ${endTime!.toLocal()}',
                      style: TextStyle(
                        fontSize: 16,
                        color: endTime == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            // Add Event Button
            ElevatedButton.icon(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null) {
                  setState(() {
                    events.add(Event(
                      titleController.text,
                      startTime!,
                      endTime!,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.add),
              label: Text("Add Event"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                elevation: 5, // Button shadow
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to select DateTime
  Future<DateTime?> _selectDateTime(BuildContext context, bool isStartTime) async {
    DateTime now = DateTime.now();
    DateTime initialDate = isStartTime ? now : now.add(Duration(hours: 1));
    DateTime? selectedTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (selectedTime != null) {
      TimeOfDay? selectedHour = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (selectedHour != null) {
        return DateTime(selectedTime.year, selectedTime.month, selectedTime.day,
            selectedHour.hour, selectedHour.minute);
      }
    }
    return null;
  }
}

// Event class to hold event data
class Event {
  String title;
  DateTime startTime;
  DateTime endTime;

  Event(this.title, this.startTime, this.endTime);
}

// Custom data source for the calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}