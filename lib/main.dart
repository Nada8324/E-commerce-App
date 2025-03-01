import 'package:connectx_task_shopapp/controllers/Layout/Layout_screen.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/onBoarding/onBoardingScreen.dart';
import 'package:connectx_task_shopapp/firebase_options.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/network/local/cache_helper.dart';
import 'package:connectx_task_shopapp/shared/network/remote/diohelper.dart';
import 'package:connectx_task_shopapp/view/signup_screen.dart';
import 'package:connectx_task_shopapp/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider plugin
import 'package:firebase_core/firebase_core.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();

  await CacheHelper.init();
  // token=CacheHelper.getData(key: 'token');
   Widget widget;
    token=CacheHelper.getData(key: 'uId');
    print(token);
    if(token!=null){
    widget=LayoutScreen();
    }
    else{
    widget=OnBoardingScreen();
  }
  runApp(MyApp(widget));
 // FlutterNativeSplash.remove();

}

class MyApp extends StatelessWidget {

  final Widget startwidget;
   MyApp(this.startwidget);
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Shopcubit(),)
      ],
      child: ScreenUtilInit(
       
        designSize: const Size(375, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
      
            useMaterial3: true,
      
          ),
          darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black
          ),
          themeMode: ThemeMode.light,
      
          home: StartScreen(startwidget),
        ),
      ),
    );
  }
}
