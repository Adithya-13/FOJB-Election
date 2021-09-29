import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GetStorage getStorage = GetStorage();
  late String name;
  late String id;
  late String phoneNumber;
  late String type;

  @override
  void initState() {
    String name = getStorage.read(Keys.name);
    String id = getStorage.read(Keys.id);
    String phoneNumber = getStorage.read(Keys.phoneNumber);
    String type = getStorage.read(Keys.type);
    this.id = id;
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.type = type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        automaticallyImplyLeading: false,
        title: Text('Profile Saya', style: AppTheme.headline3.white),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, PagePath.login, (route) => false);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Column(
                children: [
                  _profileHeader(context),
                  SizedBox(height: Helper.normalPadding),
                  _settings(),
                  SizedBox(height: Helper.normalPadding),
                  _supports(),
                  SizedBox(height: 24),
                  _developerText(),
                  SizedBox(height: 24),
                  CustomButton(
                    text: 'Keluar',
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => _logoutDialog(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            boxShadow: Helper.getShadow(),
          ),
          child: CustomNetworkImage(
            imgUrl: Dummy.profileImg,
            borderRadius: 64,
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        SizedBox(height: Helper.normalPadding),
        Text(name, style: AppTheme.headline3),
        SizedBox(height: 8),
        Text(type, style: AppTheme.text3),
        SizedBox(height: 8),
        Text(id, style: AppTheme.text3.green),
      ],
    );
  }

  Widget _settings() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Pengaturan', style: AppTheme.headline3),
        SizedBox(height: Helper.smallPadding),
        _optionItems('Notifikasi'),
        _optionItems('Ganti Kata Sandi'),
        _optionItems('Bahasa'),
      ],
    );
  }

  Widget _supports() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Dukungan', style: AppTheme.headline3),
        SizedBox(height: Helper.smallPadding),
        _optionItems('Tentang App'),
        _optionItems('Bantuan'),
        _optionItems('Kebijakan Privasi'),
        _optionItems('Syarat & Ketentuan'),
        _optionItems('Masukan & Saran'),
      ],
    );
  }

  Widget _optionItems(String optionTitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(optionTitle, style: AppTheme.text2),
            ),
            SizedBox(width: 8),
            SvgPicture.asset(Resources.next),
          ],
        ),
        SizedBox(height: 16),
        Container(
          color: AppTheme.green,
          height: 0.8,
        ),
      ],
    );
  }

  Widget _developerText() {
    return GestureDetector(
      onTap: () async {
        await canLaunch(Strings.instagram) ? await launch(Strings.instagram) : throw 'Could not launch ${Strings.instagram}';
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Developer:', style: AppTheme.text3),
          Text('Adithya Firmansyah Putra', style: AppTheme.text3),
          Text('@adithya_firmansyahputra', style: AppTheme.text3.green),
        ],
      ),
    );
  }

  Widget _logoutDialog(BuildContext context) {
    return CustomDialog(
      title: 'Keluar dari FOJB Election',
      content: Text('Yakin mau keluar?', style: AppTheme.text3),
      buttons: Row(
        children: [
          Flexible(
            child: CustomButton(
              onTap: () => Navigator.pop(context),
              text: 'Tidak',
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: CustomButton(
              onTap: () => context.read<AuthBloc>().add(Logout()),
              text: 'Keluar',
              isOutline: true,
            ),
          ),
        ],
      ),
    );
  }
}
