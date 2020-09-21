import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_world_time/cubit/world_time_cubit.dart';
import 'package:flutter_world_time/data/network/worldtimeapi.dart';
import 'package:flutter_world_time/pages/choose_location.dart';

import 'package:flutter_world_time/pages/home.dart';
import 'package:flutter_world_time/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/',
    // routes: {
    //   '/': (context) => BlocProvider(
    //         create: (context) => WorldTimeCubit(WorldTimeRepository()),
    //         child: Loading(),
    //       ),
    //   '/home': (context) => BlocProvider(
    //         create: (context) => WorldTimeCubit(WorldTimeRepository()),
    //         child: Home(),
    //       ),
    //   '/location': (context) => ChooseLocation()
    // },
    home: BlocProvider(
      create: (context) => WorldTimeCubit(WorldTimeRepository()),
      child: Home(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
