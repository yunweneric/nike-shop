import 'package:flutter/material.dart';
import 'package:flutter_3d_nike_shop/pages/data.dart';
import 'package:flutter_3d_nike_shop/utils/asset_helper.dart';
import 'package:flutter_3d_nike_shop/utils/colors.dart';
import 'package:flutter_3d_nike_shop/utils/sizing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  PageController controller = PageController();
  PageController controller_2 = PageController();
  int activeIndex = 0;

  final duration = const Duration(milliseconds: 1200);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        clipBehavior: Clip.none,
        width: Sizing.width(context),
        height: Sizing.height(context),
        decoration: BoxDecoration(
          color: items[activeIndex].main,
          image: const DecorationImage(image: AssetImage(AssetHelper.lines), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: duration,
              clipBehavior: Clip.none,
              margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
              width: Sizing.width(context),
              height: Sizing.height(context),
              decoration: BoxDecoration(
                color: items[activeIndex].light,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.white.withOpacity(0.3), width: 3),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...items.map((e) {
                            return indicator(e.index == activeIndex, e.index);
                          }),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Sizing.width(context) * 0.3,
                          height: 300,
                          child: PageView.builder(
                            controller: controller_2,
                            itemCount: items.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (c, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[i].title,
                                    style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.white),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    items[i].desc,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: AnimatedContainer(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                duration: duration,
                                decoration: BoxDecoration(
                                  color: items[activeIndex].main,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Add to bag",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: Text(
                                items[activeIndex].price,
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white, fontSize: 28),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(Sizing.width(context) / 5, 0),
              child: Container(
                height: Sizing.height(context),
                alignment: Alignment.centerRight,
                width: Sizing.width(context),
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (c, i) {
                    return AnimatedOpacity(
                      duration: duration,
                      opacity: i == activeIndex ? 1 : 0,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.01)
                          ..scale(1.0),
                        child: Image.asset("assets/images/shoe_${i}.png"),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animateChange(int index) async {
    setState(() {
      activeIndex = index;
    });
    await controller.animateToPage(index, duration: Duration(milliseconds: 1500), curve: Curves.easeInOutBack);
    controller_2.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  Widget indicator(bool isActive, int index) {
    return InkWell(
      onTap: () => animateChange(index),
      child: Row(
        children: [
          AnimatedContainer(
            duration: duration,
            height: activeIndex == index ? 120 : 80,
            width: 4,
            color: isActive ? AppColors.white : AppColors.white.withOpacity(0.5),
            margin: const EdgeInsets.only(right: 25),
          ),
          Text(
            "0${index + 1}",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
