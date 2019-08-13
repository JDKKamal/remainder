import 'package:flutter/material.dart';
import 'package:remainder/src/global_bloc.dart';
import 'package:remainder/src/models/reminer.dart';
import 'package:remainder/src/ui/details/remainder_details.dart';
import 'package:remainder/src/ui/new_entry/new_entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.blue.withOpacity(0.5),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0, 3.5),
          )
        ],
        color: Colors.blue,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "Remainder",
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Colors.blue,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Remainder",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Reminder>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 5 ),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      fontFamily: "Neu",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Reminder>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
              child: Text(
                "Press + to add a Mediminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFC9C9C9),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Color(0xFFF6F8FC),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Reminder reminder;

  MedicineCard(this.reminder);

  Hero makeIcon(double size) {
    if (reminder.remainderType == "Java") {
      return Hero(
        tag: reminder.title + reminder.remainderType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    } else if (reminder.remainderType == "PHP") {
      return Hero(
        tag: reminder.title + reminder.remainderType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    } else if (reminder.remainderType == "Flutter") {
      return Hero(
        tag: reminder.title + reminder.remainderType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    }
    return Hero(
      tag: reminder.title + reminder.remainderType,
      child: Icon(
        Icons.error,
        color: Colors.blue,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: RemainderDetails(reminder),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(50.0),
                Hero(
                  tag: reminder.title,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      reminder.title,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  reminder.interval == 1
                      ? "Every " + reminder.interval.toString() + " hour"
                      : "Every " + reminder.interval.toString() + " hours",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC9C9C9),
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MiddleContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
//     return StreamBuilder<Object>(
//         stream: globalBloc.selectedDay$,
//         builder: (context, snapshot) {
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Saturday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sat",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Saturday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Sunday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sun",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Sunday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Monday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Mon",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Monday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Tuesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Tue",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Tuesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Wednesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Wed",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Wednesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Thursday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Thu",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Thursday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Friday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Fri",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Friday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
