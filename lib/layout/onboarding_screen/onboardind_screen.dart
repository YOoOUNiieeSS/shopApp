import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(title: 'title 1', image: 'assets/images/b1.jpg', body: 'body 1'),
    BoardingModel(title: 'title 2', image: 'assets/images/b1.jpg', body: 'body 2'),
    BoardingModel(title: 'title 3', image: 'assets/images/b1.jpg', body: 'body 3'),
  ];
  bool isLast=false;
  var pageController=PageController();
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigateAndFinish(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit, child: Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(boarding.length-1==index) setState(() => isLast=true);
                  else setState(() => isLast=false);
                },
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
Widget buildBoardingItem(BoardingModel boarding)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(boarding.image),
      ),
    ),
    SizedBox(height: 30,),
    Text(
      boarding.title,
      style: TextStyle(fontSize: 24,),
    ),
    SizedBox(height: 15,),
    Text(
      boarding.body,
      style: TextStyle(fontSize: 14,),
    ),
    SizedBox(height: 30,),
  ],
);

class BoardingModel{
  final String body;
  final String image;
  final String title;
  BoardingModel({required this.title,required this.image,required this.body});
}
