import 'package:grocery_app/src/common/app_styles/text_styles.dart';
import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:grocery_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:grocery_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:grocery_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/constants.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/parsers/date_parser.dart';
import '../../../get_it_sl.dart';
import '../../bloc/button_bloc/button_bloc.dart';
import '../../widgets/padding_nav_buttons.dart';
import '../../widgets/text_fields/number_text_field.dart';
import 'bloc/sign_in_bloc/sign_in_cubit.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppUtils.phoneMaskFormatter.clear();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ButtonBloc>(
          create: (_) => ButtonBloc(),
        ),
        BlocProvider<SingInCubit>(
          create: (_) => SingInCubit(sl()),
        ),
      ],
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    String number = AppUtils.phoneMaskFormatter.getUnmaskedText();

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).signIn,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.of(context).welcome,
                      style: AppTextStyle.titleMedium
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: S.of(context).abricoz,
                      style: AppTextStyle.titleMedium.copyWith(
                          fontWeight: FontWeight.w700, color: AppColors.main),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 32),
                child: Text(
                  S.of(context).enterNum,
                  style: AppTextStyle.bodyMedium,
                ),
              ),
              NumberTextFieldWidget(
                initialValue: number,
                inputFormatters: [AppUtils.phoneMaskFormatter],
                hintText: S.of(context).phoneNumber,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  final buttonBloc = context.read<ButtonBloc>();
                  bool buttonActive = buttonBloc.state is ButtonActive;
                  if (!buttonActive && (val?.length ?? 0) >= 13) {
                    buttonBloc.add(const ToggleButton(isActive: true));
                  } else if (buttonActive && (val?.length ?? 0) < 13) {
                    buttonBloc.add(const ToggleButton(isActive: false));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: S.of(context).continueAgree,
                        style: AppTextStyle.bodyMedium,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(WebViewRoute(
                                title: S.of(context).privacyPolicy,
                                url: privacyPolicy));
                            //  launchUrlFunc(privacyPolicy);
                          },
                        text: S.of(context).privacyPolicy,
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.blue),
                      ),
                      TextSpan(
                        text: S.of(context).and,
                        style: AppTextStyle.bodyMedium,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(WebViewRoute(
                                title: S.of(context).public_offer,
                                url: publicOffer));
                          },
                        text: S.of(context).public_offer,
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.blue),
                      ),
                      TextSpan(
                        text: ',  ',
                        style: AppTextStyle.bodyMedium,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(WebViewRoute(
                                title: S
                                    .of(context)
                                    .consent_to_personal_data_processing,
                                url: consentData));
                          },
                        text: S.of(context).consent_to_personal_data_processing,
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaddingForNavButtons(
        child: BlocConsumer<SingInCubit, SignInState>(
          listener: (context, state) {
            if (state.status.isSuccessPhone) {
              context.router.push(const CodeEnterRoute());
            } else if (state.status.isError) {
              showErrorSnackBar(context, S.of(context).somethingError);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ButtonBloc, ButtonState>(
              builder: (context, buttonState) {
                return CustomMainButton(
                  isActive: buttonState is ButtonActive,
                  isLoading: state.status.isLoading,
                  text: S.of(context).getSms,
                  onTap: () {
                    context.read<SingInCubit>().signInPhone(
                        AppUtils.phoneMaskFormatter.getUnmaskedText());
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
