import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/ui/widgets/common/expanded_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

//TODO данные из bloc
//TODO нажатия на партнеров

class PartnersWidget extends StatelessWidget {
  final List<Partner> partners;
  PartnersWidget(this.partners);

  @override
  Widget build(BuildContext context) {
    return ExpandedWidget(
      image: AssetImage("assets/images/fon2.png"),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _PartnerLogosList(partners[index]),
                childCount: partners.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerLogosList extends StatelessWidget {
  final Partner partner;

  _PartnerLogosList(this.partner);

  @override
  Widget build(BuildContext context) {
    return TransparentWidget(
        color: Colors.white,
        height: 80.0 * ((partner.logos.length + 1) / 2).truncate() + 35.0,
        child: Column(children: <Widget>[
          _PartnerTitleText(partner.title),
          Column(
              children: _separate(partner.logos)
                  .map((list) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: list
                          .map((logo) => Expanded(child: _LogoPanel(logo)))
                          .toList()))
                  .toList())
        ]));
  }

  List<List<Logo>> _separate(List<Logo> logos) {
    List<List<Logo>> ret = List<List<Logo>>();
    for (int i = 0; i < logos.length; i += 2) {
      List<Logo> tmp = List<Logo>();
      tmp.add(logos[i]);
      if (i + 1 != logos.length) {
        tmp.add(logos[i + 1]);
      }
      ret.add(tmp);
    }
    return ret;
  }
}

class _LogoPanel extends StatelessWidget {
  final Logo logo;
  _LogoPanel(this.logo);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        child: Column(
          children: <Widget>[
            _LogoSign(logo.logoUrl),
          ],
        ));
  }
}

class _LogoSign extends StatelessWidget {
  final String logoUrl;

  _LogoSign(this.logoUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.topCenter,
        child: SizedBox(width: 140.0, height: 60.0, child: CachedImage(logoUrl)));
  }
}

class _PartnerTitleText extends StatelessWidget {
  _PartnerTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      alignment: Alignment.center,
      child: Text(text, style: Utils.headerTextStyle(Colors.blue)),
    );
  }
}
