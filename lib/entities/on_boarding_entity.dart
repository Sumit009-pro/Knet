
import 'package:knet/utils/StringUtils.dart';

class OnBoardingEntity {
  final String image;
  final String image1;
  final String image2;
  final String image3;
  final String heading;
  final String description;

  OnBoardingEntity( {this.image, this.heading, this.description,this.image1, this.image2, this.image3});

  static List<OnBoardingEntity> onBoardingData = [
    OnBoardingEntity(
        image: StringUtils.board1,
        image1:StringUtils.board2,
        image2:StringUtils.board3,
        image3:StringUtils.board1,
        description:
            "K Net is an app that will connect people within a particular sales network.",
        heading: "Welcome"),
    OnBoardingEntity(
        image: StringUtils.board1,
        image1:StringUtils.ob1,
        image2:StringUtils.ob1,
        image3:StringUtils.ob1,
        description: "I’m an early bird and I’m a night owl so I’m wise have worms.",
        heading: "Complete Your Shopping"),
    OnBoardingEntity(
        image: StringUtils.board1,
        image1:StringUtils.ob2,
        image2:StringUtils.board1,
        image3:StringUtils.board1,
        description: "I’m an early bird and I’m a night owl so I’m wise have worms.",
        heading: "Get Product At Your Door"),

  ];
}
