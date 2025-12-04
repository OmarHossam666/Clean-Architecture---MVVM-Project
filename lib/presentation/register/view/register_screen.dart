import 'dart:io';
import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/register/view_model/register_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = ImagePicker();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  void _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => _viewModel.setPassword(_passwordController.text),
    );
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _phoneController.addListener(
      () => _viewModel.setPhoneNumber(_phoneController.text),
    );
    _viewModel.isRegisteredOutput.listen((isRegisterd) async {
      if (isRegisterd && mounted) {
        await _appPreferences.setRegistered(true);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
        });
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _viewModel.setProfilePicture(pickedImage);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreen(
              context,
              () => _viewModel.resetToContentState(),
              _getContent(),
            ) ??
            _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ValuesManager.padding24,
          vertical: ValuesManager.padding32,
        ),
        color: ColorsManager.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsManager.splashLogo),
                const SizedBox(height: ValuesManager.padding24),
                StreamBuilder<String?>(
                  stream: _viewModel.nameErrorOutput,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: StringsManager.userName.tr(),
                        labelText: StringsManager.userName.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding24),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StreamBuilder<String?>(
                        stream: _viewModel.countryCodeErrorOutput,
                        builder: (context, snapshot) {
                          return CountryCodePicker(
                            onInit: (countryCode) => _viewModel.setCountryCode(
                              countryCode?.dialCode ??
                                  StringsManager.plus20.tr(),
                            ),
                            onChanged: (countryCode) =>
                                _viewModel.setCountryCode(
                                  countryCode.dialCode ??
                                      StringsManager.plus20.tr(),
                                ),
                            initialSelection: StringsManager.plus20.tr(),
                            showFlag: true,
                            showCountryOnly: true,
                            showFlagDialog: true,
                            hideMainText: true,
                            alignLeft: false,
                            padding: EdgeInsets.zero,
                            dialogTextStyle: StylesManager.titleTextStyle,
                            headerTextStyle:
                                StylesManager.sectionHeaderTextStyle,
                            dialogBackgroundColor: ColorsManager.primary,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: StreamBuilder<String?>(
                        stream: _viewModel.phoneNumberErrorOutput,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: StringsManager.phoneNumber.tr(),
                              labelText: StringsManager.phoneNumber.tr(),
                              errorText: snapshot.data,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ValuesManager.padding24),
                StreamBuilder<String?>(
                  stream: _viewModel.emailErrorOutput,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: StringsManager.email.tr(),
                        labelText: StringsManager.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding24),
                StreamBuilder<String?>(
                  stream: _viewModel.passwordErrorOutput,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: StringsManager.password.tr(),
                        labelText: StringsManager.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding24),
                Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<File>(
                    stream: _viewModel.outputProfilePicture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.path.isNotEmpty) {
                        return GestureDetector(
                          onTap: () => _pickImage(),
                          child: SizedBox(
                            height: ValuesManager.iconSize64,
                            width: ValuesManager.iconSize64,
                            child: Image.file(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return IconButton(
                        onPressed: () => _pickImage(),
                        icon: const Icon(Icons.add_photo_alternate),
                        color: ColorsManager.grey,
                        iconSize: ValuesManager.iconSize64,
                      );
                    },
                  ),
                ),
                const SizedBox(height: ValuesManager.padding32),
                StreamBuilder<bool>(
                  stream: _viewModel.isRegisterValidOutput,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.register();
                            }
                          : null,
                      child: Text(StringsManager.register.tr()),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.loginRoute,
                        ),
                        child: Text(StringsManager.loginText.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
