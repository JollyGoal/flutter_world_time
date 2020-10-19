import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_world_time/cubit/world_time_cubit.dart';
import 'package:flutter_world_time/data/network/worldtimeapi.dart';
import 'package:flutter_world_time/pages/home.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => WorldTimeCubit(WorldTimeRepository()),
      child: Home(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
