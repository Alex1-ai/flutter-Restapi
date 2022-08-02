import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/categories_model.dart';

import '../consts/global_colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoriesModel categoriesModelProvider =
        Provider.of<CategoriesModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage.assetNetwork(
              height: size.height * 0.45,
              width: size.height * 0.45,
              placeholder: "assets/images/placeholder.png",
              image: categoriesModelProvider.image.toString(),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              categoriesModelProvider.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  backgroundColor: lightCardColor.withOpacity(0.5),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
