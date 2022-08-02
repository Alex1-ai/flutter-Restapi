import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/models/products_model.dart';
import 'package:store_api_flutter_course/screens/categories_screen.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/screens/users_screen.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';
import 'package:store_api_flutter_course/widgets/appbar_icons.dart';
import 'package:store_api_flutter_course/widgets/feeds_grid.dart';
import 'package:store_api_flutter_course/widgets/feeds_widget.dart';
import 'package:store_api_flutter_course/widgets/sale-widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  // List<ProductsModel> productsList = [];

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // elevation: 4,
          title: Text("Home"),
          leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const CategoriesScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
              icon: IconlyBold.category),
          actions: [
            AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const UsersScreen(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                icon: IconlyBold.user3),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).cardColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconsColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            return const SaleWidget();
                          },
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                                activeColor: Colors.red, color: Colors.white),
                          ),
                          autoplay: true,
                          //control: const SwiperControl(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: FeedsScreen(),
                                      type: PageTransitionType.fade,
                                    ),
                                  );
                                },
                                icon: IconlyBold.arrowRight2),
                          ],
                        ),
                      ),

                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProducts(limit: "4"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null) {
                              Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            return FeedsGridWidget(
                                productsList: snapshot.data!);
                          })
                      // ? CircularProgressIndicator()
                      // : FeedsGridWidget(productsList: productsList),
                      // GridView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: 3,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2,
                      //             crossAxisSpacing: 0.0,
                      //             mainAxisSpacing: 0.0,
                      //             childAspectRatio: 0.7),
                      //     itemBuilder: (ctx, index) {
                      //       return FeedsWidget();
                      //     })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
