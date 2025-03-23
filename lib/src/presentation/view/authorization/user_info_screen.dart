import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/presentation/bloc/button_bloc/button_bloc.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../get_it_sl.dart';
import '../../bloc/validate_email_cubit.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/padding_nav_buttons.dart';
import '../../widgets/show_error_snackbar.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'bloc/sign_in_bloc/sign_in_cubit.dart';

@RoutePage()
class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key, this.isSignIn = true});
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ButtonBloc(),
      ),
      BlocProvider<SingInCubit>(
        create: (_) => SingInCubit(sl()),
      ),
      BlocProvider<EmailValidationCubit>(
        create: (_) => EmailValidationCubit(),
      ),
    ], child: UserInfoView(isSignIn: isSignIn));
  }
}

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key, required this.isSignIn});
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    checkActiveButton() {
      final buttonBloc = context.read<ButtonBloc>();
      bool buttonActive = buttonBloc.state is ButtonActive;
      if (!buttonActive &&
          nameController.text.isNotEmpty &&
          surnameController.text.isNotEmpty &&
          emailController.text.isNotEmpty) {
        buttonBloc.add(const ToggleButton(isActive: true));
      } else if (buttonActive &&
          (nameController.text.isEmpty ||
              surnameController.text.isEmpty ||
              emailController.text.isEmpty)) {
        buttonBloc.add(const ToggleButton(isActive: false));
      }
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: isSignIn ? null : 8,
          automaticallyImplyLeading: false,
          title: isSignIn ? Text(S.of(context).signIn) : null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: isSignIn
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
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
                    S.of(context).enter_name_surname_email,
                    style: AppTextStyle.bodyMedium,
                  ),
                ),
                BlocConsumer<SingInCubit, SignInState>(
                  listener: (context, state) {
                    if (state.status.isSuccessName) {
                      if (isSignIn) {
                        context.router.replaceAll([
                          const IndexRoute(children: [HomeNestedRoute()])
                        ]);
                      } else {
                        Navigator.of(context).pop();
                      }
                    } else if (state.status.isError) {
                      showErrorSnackBar(
                        context,
                        S.of(context).somethingError,
                      );
                      SharedPrefs().deleteTokens();
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<EmailValidationCubit, bool>(
                          builder: (context, isValid) {
                            return Column(
                              children: [
                                CustomTextFieldWidget(
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: S.of(context).email,
                                  controller: emailController,
                                  onChanged: (val) {
                                    context.read<EmailValidationCubit>().validateEmail(val ?? '');
                                    checkActiveButton();
                                  },
                                ),
                                if (!isValid)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Text(
                                      S.of(context).email_invalid,
                                      style: AppTextStyle.bodySmall
                                          .copyWith(color: AppColors.errorRedColor),
                                    ),
                                  )
                              ],
                            );
                          },
                        ),
                        12.height,
                        CustomTextFieldWidget(
                          hintText: S.of(context).name,
                          controller: nameController,
                          onChanged: (val) {
                            checkActiveButton();
                          },
                        ),
                        12.height,
                        CustomTextFieldWidget(
                          hintText: S.of(context).surname,
                          controller: surnameController,
                          onChanged: (val) {
                            checkActiveButton();
                          },
                        ),
                        if (state.status.isError)
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 6.0, bottom: 32),
                            child: Text(
                              S.of(context).errorPlsAgain,
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.errorRedColor),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            PaddingForNavButtons(child: BlocBuilder<SingInCubit, SignInState>(
          builder: (context, state) {
            return BlocBuilder<ButtonBloc, ButtonState>(
              builder: (context, buttonState) {
                return CustomMainButton(
                  text: S.of(context).save,
                  isLoading: state.status.isLoading,
                  isActive: buttonState is ButtonActive,
                  onTap: () {
                    context.read<SingInCubit>().setName(
                          nameController.text,
                          surnameController.text,
                          emailController.text,
                        );
                  },
                );
              },
            );
          },
        )),
      ),
    );
  }
}
