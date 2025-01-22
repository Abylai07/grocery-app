import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/presentation/bloc/button_bloc/button_bloc.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../get_it_sl.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/padding_nav_buttons.dart';
import '../../widgets/show_error_snackbar.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'bloc/sign_in_bloc/sign_in_cubit.dart';

@RoutePage()
class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ButtonBloc(),
      ),
      BlocProvider<SingInCubit>(
        create: (_) => SingInCubit(sl()),
      ),
    ], child: const UserInfoView());
  }
}

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    checkActiveButton(){
      final buttonBloc = context.read<ButtonBloc>();
      bool buttonActive = buttonBloc.state is ButtonActive;
      if (!buttonActive && nameController.text.isNotEmpty && surnameController.text.isNotEmpty) {
        buttonBloc.add(const ToggleButton(isActive: true));
      } else if (buttonActive && (nameController.text.isEmpty || surnameController.text.isEmpty)) {
        buttonBloc.add(const ToggleButton(isActive: false));
      }
    }

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
                  S.of(context).enterName,
                  style: AppTextStyle.bodyMedium,
                ),
              ),
              BlocConsumer<SingInCubit, SignInState>(
                listener: (context, state) {
                  if (state.status.isSuccessName) {
                    context.router.replaceAll([
                      const IndexRoute(children: [HomeNestedRoute()])
                    ]);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldWidget(
                        hintText: S.of(context).name,
                        controller: nameController,
                        onChanged: (val){
                          checkActiveButton();
                        },
                      ),
                      12.height,
                      CustomTextFieldWidget(
                        hintText: S.of(context).surname,
                        controller: surnameController,
                        onChanged: (val){
                          checkActiveButton();
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
                  if(nameController.text.isEmpty || surnameController.text.isEmpty){
                    showErrorSnackBar(context, S.of(context).fillName);
                  } else{
                    context.read<SingInCubit>().setName(
                        nameController.text, surnameController.text);
                  }
                },
              );
            },
          );
        },
      )),
    );
  }
}
