import 'package:flutter/material.dart';
import 'package:ornek_deneme_calisma/constants/projectcolors.dart';
import 'package:ornek_deneme_calisma/cubit/prices_cubit.dart';
import 'package:ornek_deneme_calisma/cubit/thememanagement_cubit.dart';
import 'package:ornek_deneme_calisma/widgets/drawer.dart';
import 'package:ornek_deneme_calisma/widgets/sections/calculation_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ornek_deneme_calisma/widgets/sections/sarrafiye_section.dart';
import 'dart:async';
import '../widgets/sections/doviz_fiyatlari_section.dart';
import '../widgets/sections/footerr_section.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;

  @override
  void initState() {
    BlocProvider.of<PricesCubit>(context).getPrices();
    timer = Timer.periodic(const Duration(seconds: 5),
        (Timer t) => BlocProvider.of<PricesCubit>(context).getPrices());

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final ScrollController _controller = ScrollController();
  ScrollPhysics? _physics = null;

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      1445,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  @override
  Widget build(BuildContext context) {
    final themeProjectColors = Theme.of(context).extension<ProjectColors>()!;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            elevation: 0,
          actions: [
            Align(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  themeProjectColors.ozakLogoPath as String,

                  // "assets/ozak-light-theme.png",

                  width: 100,
                  height: 40,
                ),
              ),
            ),Spacer(),
            Align(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: themeProjectColors.borderColor as Color)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Image.asset(
                      themeProjectColors.themeChangeButtonImagePath as String,
                      color: themeProjectColors.iconColor,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onTap: () {
                    if (context.read<ThemeManagementCubit>().state.themeMode ==
                        "light") {
                      context.read<ThemeManagementCubit>().setTheme("dark");
                    } else {
                      context.read<ThemeManagementCubit>().setTheme("light");
                    }
                  },
                ),
              ),
            ),SizedBox(width: 8,),
            Builder(
              builder: (context) {
                return Align(
                  child: Ink.image(
                    image: AssetImage(themeProjectColors.menuButtonImagePath as String),
                    width: 48,
                    height: 48,
                    
                    child: InkWell(

                      borderRadius: BorderRadius.circular(100),

                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 16,)
          ],
          backgroundColor: themeProjectColors.appBarColor,
        ),
        endDrawer: CustomDrawer(
          scrollUp: _scrollUp,
          scrollDown: _scrollDown,
        ),
        backgroundColor: themeProjectColors.scaffoldBackgroundColor,
        body: NotificationListener<OverscrollIndicatorNotification>(
          // scroll glow animasyonunu tüm app den silmek için kullanıldı.
          onNotification: (overScroll) {
            overScroll.disallowGlow();

            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              physics: _physics,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 315, child: CalculationSection()),
                  SizedBox(
                    height: 16,
                  ),
                  Container(height: 546, child: DovizFiyatlariSection()),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 546,
                    child: SarrafiyeSection(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 760,
                    child: FooterrSection(

                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
