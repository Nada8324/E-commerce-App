import 'package:connectx_task_shopapp/view/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/component/component.dart';

class board {
  final String image;
  final String title;
  board(this.image, this.title);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();
  void initState() {
    super.initState();
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool alreadyRun = prefs.getBool('alreadyRun') ?? false;
    if (!alreadyRun) {

       Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));

      await prefs.setBool('alreadyRun', true);
    }
  }
  List<board> PageViewItemsList = [
    board("assets/images/onboarding1.png", "Easy Shopping"),
    board("assets/images/onboarding2.jpg", "Secure Payment"),
    board("assets/images/onboarding3.jpg", "Quick Delivery")
  ];
  bool islast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen(),),
                      (route) => false);
            }, child: Text(
              "Skip",
              style: GoogleFonts.inter(
                color: HexColor("#1D1E20"),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              /* child: PageView(

               children: [
                BuildPageViewItem("assets/images/onboarding1.png","Easy Shopping"),
                BuildPageViewItem("assets/images/onboarding2.jpg","Secure Payment"),
                BuildPageViewItem("assets/images/onboarding3.jpeg","Quick Delivery"),
              ],
            physics:BouncingScrollPhysics(),
            controller:boardcontroller
              ),*/
              child: PageView.builder(
                  controller: boardcontroller,
                  onPageChanged: (value) {
                    if(value==PageViewItemsList.length-1)
                      {

                        setState(() {
                          islast=true;
                        });
                      }
                    else{
                      setState(() {
                        islast=false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: PageViewItemsList.length,
                  itemBuilder: (context, index) =>
                      BuildPageViewItem(PageViewItemsList[index])),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.h,
                    dotWidth: 10.w,
                    spacing: 5,
                      activeDotColor:  HexColor("#1D1E20")

                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: () {
                  if(islast){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen(),),
                            (route) => false);

                  }
                    boardcontroller.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn);

                },
                  shape: CircleBorder(),
                  backgroundColor: HexColor("#F5F6FA"),
                  child: Icon(Iconsax.arrow_right_3,color: HexColor("#1D1E20")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget BuildPageViewItem(board model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Image(image: AssetImage("${model.image}"),width:double.infinity,height: 300.h,),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "${model.title}",
          style: GoogleFonts.inter(
            color: HexColor("#1D1E20"),
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
