import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreen(
                context,
                () => _viewModel.forgotPassword(),
                _getContent(),
              ) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Padding(
      padding: EdgeInsets.all(ValuesManager.padding16),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: ValuesManager.spacing12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<bool>(
              stream: _viewModel.isEmailValidOutput,
              builder: (context, asyncSnapshot) {
                final bool? isEmailValid = asyncSnapshot.data;
                return TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: StringsManager.email.tr(),
                    hintStyle: StylesManager.hintTextStyle,
                    errorText: (isEmailValid == null || isEmailValid)
                        ? null
                        : StringsManager.emailError.tr(),
                    labelText: StringsManager.email.tr(),
                    fillColor: ColorsManager.white,
                    filled: true,
                  ),
                );
              },
            ),
            StreamBuilder<bool>(
              stream: _viewModel.isEmailValidOutput,
              builder: (context, snapshot) {
                final bool isEmailValid = snapshot.data ?? false;
                return ElevatedButton(
                  onPressed: isEmailValid
                      ? () {
                          _viewModel.forgotPassword();
                        }
                      : null,
                  child: Text(
                    StringsManager.resetPassword.tr(),
                    style: StylesManager.buttonTextStyle,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
