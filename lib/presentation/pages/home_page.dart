import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/presentation/routes/page_path.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/custom_button.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetStorage getStorage = GetStorage();
  late String name;

  @override
  void initState() {
    String fullName = getStorage.read(Keys.name);
    name = fullName.split(' ').first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerHome(context),
              _candidate(context),
              _voteNow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerHome(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Helper.normalPadding),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(64)),
        color: AppTheme.green,
        boxShadow: Helper.getShadow(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Halo, $name', style: AppTheme.headline1.white),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await getStorage.erase();
                      Navigator.pushNamedAndRemoveUntil(context, PagePath.login, (route) => false);
                    },
                    child: SvgPicture.asset(Resources.vote),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                'Ayo pilih Calon Ketua Umum Forum Osis Jawa Barat pilihanmu!',
                style: AppTheme.headline3.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _candidate(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Text(
              'Calon Ketua Umum',
              style: AppTheme.headline3,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            height: MediaQuery.of(context).size.height * 0.36,
            alignment: Alignment.topRight,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, PagePath.detail),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: Helper.getShadow(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(Helper.smallPadding),
                  margin: index == 0
                      ? EdgeInsets.only(
                          left: Helper.normalPadding, right: 8, bottom: 8)
                      : index == 5
                          ? EdgeInsets.only(
                              left: 8, right: Helper.normalPadding, bottom: 8)
                          : EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: AspectRatio(
                    aspectRatio: 6.4 / 10,
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              Resources.imgDummy,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Farah Fauziah Danopa',
                          style: AppTheme.text1.bold,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Kab. Majalengka',
                          style: AppTheme.subText1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Lihat Visi Misi',
                          style: AppTheme.subText1.blue,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Helper.normalPadding),
        ],
      ),
    );
  }

  Widget _voteNow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Text(
            'Vote Sekarang!',
            style: AppTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            'Setelah kamu lihat-lihat visi dan misi Calon Ketua Umum Forum Osis Jawa Barat, yuk Vote sekarang, ingat! Pilih lah sesuai kata hati, bukan kata orang!',
            style: AppTheme.text2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Helper.normalPadding),
          CustomButton(
              onTap: () => showDialog(
                    context: context,
                    builder: (context) => _announcementDialog(context),
                  ),
              text: 'Vote'),
          SizedBox(height: Helper.normalPadding),
        ],
      ),
    );
  }

  Widget _announcementDialog(BuildContext context) {
    return CustomDialog(
      title: 'Perhatian',
      content: Text(
        'Pastikan apa yang kamu pilih adalah pilihanmu sendiri, tidak ada campur tangan orang lain dan sesuai dengan kata hati',
        style: AppTheme.text3,
      ),
      buttons: CustomButton(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, PagePath.vote);
        },
        text: 'Oke, mengerti',
      ),
    );
  }

  Widget _cantVoteDialog(BuildContext context) {
    return CustomDialog(
      title: 'Perhatian',
      content: Text(
        'Kamu telah vote, kamu tidak bisa vote lagi, maaf ya!',
        style: AppTheme.text3,
      ),
      buttons: CustomButton(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, PagePath.vote);
        },
        text: 'Oke, mengerti',
      ),
    );
  }
}
