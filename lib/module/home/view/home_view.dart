import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/source/user_repository.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_event.dart';
import 'package:flutter_babycare/module/sample/view/sample_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  final UserRepository _userRepository;
  int selectedIndex = 0;

  HomeView(UserRepository userRepository, {Key key, this.selectedIndex = 0})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _bottomNavigationKey = GlobalKey();
  List<Widget> screens;
  var _icons = {
    'home': 'assets/icon/home.svg',
    'notify': 'assets/icon/notify.svg',
    'chat': 'assets/icon/chat.svg',
    'user': 'assets/icon/user.svg',
  };

  @override
  void initState() {
    super.initState();
    screens = [
      HomeBodyView(widget._userRepository),
      SampleView(),
      SampleView(),
      SampleView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            AppConstants.paddingAppH + AppConstants.paddingSuperLargeH),
        child: AppBar(
          title: Container(
            height: 32.h,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: AppConstants.paddingAppW),
            child: Text(
              'Baby Care',
              style: GoogleFonts.dosis(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
            )
          ],
        ),
      ),
      body: screens[widget.selectedIndex],
      bottomNavigationBar: _buildBottomTabBar(),
    );
  }

  Widget _buildBottomTabBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: AppColors.background,
      items: [
        Tab(
          icon: SvgPicture.asset(
            _icons['home'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['notify'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['chat'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['user'],
            color: AppColors.text,
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },
    );
  }
}

class HomeBodyView extends StatelessWidget {
  final UserRepository _userRepository;
  const HomeBodyView(UserRepository userRepository, {Key key})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      color: AppColors.background,
      child: ListView(
        children: [
          _buildTipView(context),
          SizedBox(height: AppConstants.paddingLargeH),
          _buildWelcomeUser(context, _userRepository.getUser().toString()),
          SizedBox(height: AppConstants.paddingLargeH),
        ],
      ),
    );
  }

  Widget _buildTipView(BuildContext context) {
    return Container(
      height: 80.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
        vertical: AppConstants.paddingNormalH,
      ),
      child: Text(
        'Tips: Coming soon...',
        style: Theme.of(context).textTheme.headline1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeUser(BuildContext context, String username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi ' + username + '!',
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Hope your angels are well',
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}