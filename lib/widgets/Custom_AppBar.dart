import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool phonewhat;
  const CustomAppBar({super.key, required this.title, required this.phonewhat});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange.shade50,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: phonewhat ? PhoneWhatsapp() : Container(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
