import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/search_view.dart';

import '../widgets/no_wheather_body.dart';
import '../widgets/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchView()));
              },
              icon: const Icon(Icons.search))
        ],
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (BuildContext context, state) {
          if (state is WeatherInitialState) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return  WeatherInfoBody(
              weatherModel: state.weatherModel,
            );
          } else {
            return const Text('there was an error');
          }
        },
      ),
    );
  }
}
