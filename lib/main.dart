import 'package:flutter/material.dart';
import 'package:ornek_deneme_calisma/cubit/prices_cubit.dart';
import 'package:ornek_deneme_calisma/cubit/thememanagement_cubit.dart';
import 'package:ornek_deneme_calisma/pages/home_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constants/projectcolors.dart';


Future<void> main() async {

  await dotenv.load(fileName: ".env");

  //uygulama başlamadan veri tabanından tema çekiliyor.
  ThemeManagementCubit model = ThemeManagementCubit();
  await model.getTheme();



  runApp(OzakApp(themeCubitModel:model));
}

class OzakApp extends StatelessWidget {
  OzakApp({required this.themeCubitModel});

  ThemeManagementCubit themeCubitModel;




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => themeCubitModel),
        BlocProvider(create: (context) => PricesCubit()),
      ],
      child: BlocBuilder<ThemeManagementCubit, ThemeManagementState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(fontFamily: "Euclid-Circular-B").copyWith(

              extensions: <ThemeExtension<dynamic>>[
                ProjectColors.light,
              ],
            ),
            darkTheme: ThemeData(fontFamily: "Euclid-Circular-B").copyWith(
              extensions: <ThemeExtension<dynamic>>[
                ProjectColors.dark,
              ],
            ),


            themeMode:
            state.themeMode == "light" ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
