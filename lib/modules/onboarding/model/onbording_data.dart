import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

import '../../../utils/k_images.dart';
import 'onbording_model.dart';

final onBoardingList = [
  OnBordingModel(
    image: Kimages.onboarding_1,
    title: Language.onBoardingTitle01.capitalizeByWord(),
    paragraph: Language.onBoardingSubtitle01,
  ),
  OnBordingModel(
    image: Kimages.onboarding_2,
    title: Language.onBoardingTitle02.capitalizeByWord(),
    paragraph: Language.onBoardingSubtitle02,
  ),
  OnBordingModel(
    image: Kimages.onboarding_3,
    title: Language.onBoardingTitle03.capitalizeByWord(),
    paragraph: Language.onBoardingSubtitle03,
  ),
];
