import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/user/user_entity.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/parsers/date_parser.dart';
import '../../../get_it_sl.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/padding_nav_buttons.dart';
import '../profile/bloc/user_session_bloc.dart';
import 'bloc/sign_in_bloc/sign_in_cubit.dart';
import 'bloc/timer_bloc.dart';

@RoutePage()
class CodeEnterScreen extends StatelessWidget {
  const CodeEnterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TimerBloc>(
        create: (_) => TimerBloc()..add(StartTimer()),
      ),
      BlocProvider<SingInCubit>(
        create: (_) => SingInCubit(sl()),
      ),
    ], child: const CodeEnterView());
  }
}

class CodeEnterView extends StatelessWidget {
  const CodeEnterView({super.key});

  @override
  Widget build(BuildContext context) {
    String number = AppUtils.phoneMaskFormatter.getUnmaskedText();
    FocusNode focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {
          context.router.maybePop();
          context.read<TimerBloc>().add(ResetTimer());
        },
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
                  S.of(context).enterCode,
                  style: AppTextStyle.bodyMedium,
                ),
              ),
              BlocConsumer<SingInCubit, SignInState>(
                listener: (context, state) {
                  if (state.status.isSuccessCode || state.status.isNeedName) {
                    context.read<TimerBloc>().add(ResetTimer());
                    context.read<UserSessionBloc>().add(LoadUserSession());
                    if (state.status.isNeedName) {
                      context.router.replace(UserInfoRoute());
                    } else {
                      UserEntity user = state.entity;
                      context.router.replaceAll([
                        user.isBanned
                            ? const BannedUserRoute()
                            : const IndexRoute(children: [HomeNestedRoute()])
                      ]);
                    }
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PinCodeTextField(
                        autoFocus: true,
                        focusNode: focusNode,
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 56,
                          fieldWidth: 52,
                          activeColor: state.status.isError
                              ? AppColors.errorRedColor
                              : AppColors.main,
                          selectedColor: AppColors.lightGrey,
                          inactiveColor: AppColors.lightGrey,
                        ),
                        textStyle: AppTextStyle.titleMedium,
                        cursorColor: AppColors.main,
                        animationDuration: const Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                        inputFormatters: [AppUtils.codeMaskFormatter],
                        onChanged: (value) {
                          if (value.length == 6) {
                            context
                                .read<SingInCubit>()
                                .signInCode(number, value);
                          }
                        },
                      ),
                      if (state.status.isError)
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, bottom: 32),
                          child: Text(
                            S.of(context).pinError,
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.errorRedColor),
                          ),
                        )
                      else if (state.status.isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                    ],
                  );
                },
              ),
              Text(
                S.of(context).sentTo(
                    '+7 ${AppUtils.phoneMaskFormatter.getMaskedText()}'),
                style: AppTextStyle.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          PaddingForNavButtons(child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is TimerRunInProgress)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: S.of(context).getSmsTime,
                        style: AppTextStyle.bodyMedium,
                      ),
                      TextSpan(
                        text: ' ${state.duration}',
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.main),
                      ),
                    ],
                  ),
                ),
              8.height,
              CustomMainButton(
                text: S.of(context).getNewSms,
                isActive: state is TimerRunComplete,
                onTap: () {
                  context.read<SingInCubit>().signInPhone(number);
                  context.read<TimerBloc>().add(StartTimer());
                },
              ),
            ],
          );
        },
      )),
    );
  }
}
