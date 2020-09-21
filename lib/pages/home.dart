import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_world_time/cubit/world_time_cubit.dart';
import 'package:flutter_world_time/data/models/world_time.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Map data = {};
//
//   @override
//   Widget build(BuildContext context) {
//     data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
//     // print(data);
//
//     String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
//     Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];
//
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: SafeArea(
//           child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
//           child: Column(children: [
//             FlatButton.icon(
//                 onPressed: () async {
//                   dynamic result =
//                       await Navigator.pushNamed(context, '/location');
//                   setState(() {
//                     data = {
//                       'time': result['time'],
//                       'location': result['location'],
//                       'isDayTime': result['isDayTime'],
//                       'flag': result['flag'],
//                     };
//                   });
//                 },
//                 icon: Icon(
//                   Icons.edit_location,
//                   color: Colors.grey[300],
//                 ),
//                 label: Text(
//                   "Edit Location",
//                   style: TextStyle(
//                     color: Colors.grey[300],
//                   ),
//                 )),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   data['location'],
//                   style: TextStyle(
//                       fontSize: 28.0, letterSpacing: 2.0, color: Colors.white),
//                 )
//               ],
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               data['time'],
//               style: TextStyle(fontSize: 65.0, color: Colors.white),
//             )
//           ]),
//         ),
//       )),
//     );
//   }
// }

class Home extends StatelessWidget {
  final List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorldTimeCubit, WorldTimeState>(
      listener: (context, state) {
        if (state is WorldTimeError) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is WorldTimeInitial) {
          return buildInitialChooseLocation(context);
        } else if (state is WorldTimeLoading) {
          return buildLoading();
        } else if (state is WorldTimeLoaded) {
          return buildColumnWithData(context, state.instance);
        } else {
          return buildInitialChooseLocation(context);
        }
      },
    );
  }

  Scaffold buildLoading() {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
        ));
  }

  Scaffold buildInitialChooseLocation(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Choose Location"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  getTimeData(context, locations[index]);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/flags/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Scaffold buildColumnWithData(BuildContext context, WorldTime worldTime) {
    String bgImage = worldTime.isDayTime ? 'day.png' : 'night.png';
    Color bgColor = worldTime.isDayTime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(children: [
              FlatButton.icon(
                  onPressed: () {
                    setInitialState(context);
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    "Edit Location",
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  )),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    worldTime.location,
                    style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                worldTime.time,
                style: TextStyle(fontSize: 65.0, color: Colors.white),
              )
            ])),
      )),
    );
  }

  void getTimeData(BuildContext context, WorldTime worldTime) {
    final worldTimeCubit = context.bloc<WorldTimeCubit>();
    worldTimeCubit.getTimeData(worldTime);
  }

  void setInitialState(BuildContext context) {
    final worldTimeCubit = context.bloc<WorldTimeCubit>();
    worldTimeCubit.setInitialState();
  }
}
