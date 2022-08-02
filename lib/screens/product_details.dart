import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/models/products_model.dart';

import '../services/api_handler.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";

  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      errorStr = error.toString();

      isError = true;

      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isError
          ? Center(
              child: Text(
              "an error occured $errorStr ",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          : SafeArea(
              child: productsModel == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          const BackButton(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productsModel!.category!.name.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                        productsModel!.title.toString(),
                                        textAlign: TextAlign.start,
                                        style: titleStyle,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: RichText(
                                        text: TextSpan(
                                            text: "\$",
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: productsModel!.price
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: lightTextColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.4,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/placeholder.png",
                                    image: productsModel!.images![index]
                                        .toString(),
                                    // image: "https://placeimg.com/640/480/any",
                                    fit: BoxFit.fill);
                              },
                              autoplay: true,
                              itemCount: 3,
                              pagination: const SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productsModel!.title.toString(),
                                  style: titleStyle,
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  productsModel!.description.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
    );
  }
}
