import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/models/users_model.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UsersModel userModelProvider = Provider.of<UsersModel>(context);
    return ListTile(
      leading: FadeInImage.assetNetwork(
        height: size.height * 0.12,
        width: size.height * 0.12,
        placeholder: "assets/images/placeholder.png",
        image: userModelProvider.avatar.toString(),
        fit: BoxFit.fill,
      ),
      title: Text(userModelProvider.name.toString()),
      subtitle: Text(userModelProvider.email.toString()),
      trailing: Text(
        userModelProvider.role.toString(),
        style: TextStyle(color: lightIconsColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
