import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omar_ahmed_maps/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:omar_ahmed_maps/constants/my_colors.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  AuthCubit authCubit = AuthCubit();

  final Uri _facebookUrl = Uri.parse('https://www.facebook.com/yssralx2015');
  final Uri _twitterUrl = Uri.parse('https://twitter.com/home');
  final Uri _youtubeUrl = Uri.parse('https://www.youtube.com/');

  Widget buildDraweHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            "assets/images/yasser.png",
            fit: BoxFit.cover,
            height: 150,
          ),
        ),
        Text("Eng. Yasser",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        Text("01009997566",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget buildDrawerListitem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void _launchURL(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw "Couldn't launch $url";
  }

  Widget buildIcon(IconData icon, Uri url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(FontAwesomeIcons.facebook, _facebookUrl),
          const SizedBox(width: 15),
          buildIcon(FontAwesomeIcons.twitter, _twitterUrl),
          const SizedBox(width: 15),
          buildIcon(FontAwesomeIcons.youtube, _youtubeUrl),
        ],
      ),
    );
  }

  Widget buildLogoutBlocProvider(context) {
    return Container(
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        child: buildDrawerListitem(
          leadingIcon: Icons.logout,
          title: "Logout",
          onTap: () async {
            await authCubit.logOut();
            Navigator.of(context).pushReplacementNamed(loginScreen);
          },
          color: Colors.red,
          trailing: SizedBox(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 300,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDraweHeader(context),
            ),
          ),
          buildDrawerListitem(leadingIcon: Icons.person, title: "My Profile"),
          buildDrawerListItemsDivider(),
          buildDrawerListitem(
              leadingIcon: Icons.history,
              title: "Places History",
              onTap: () {}),
          buildDrawerListItemsDivider(),
          buildDrawerListitem(leadingIcon: Icons.settings, title: "Settings"),
          buildDrawerListItemsDivider(),
          buildDrawerListitem(leadingIcon: Icons.help, title: "Help"),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(
            height: 180,
          ),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(),
        ],
      ),
    );
  }
}
