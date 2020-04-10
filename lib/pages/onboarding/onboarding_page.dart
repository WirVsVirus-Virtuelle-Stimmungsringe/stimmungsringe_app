import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _groupCodeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<OnboardingBloc>(context).add(CheckUser());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is CheckingUser) {
            return buildLoadingPage();
          }

          if (state is FindGroupInitial) {
            return Column(
              children: <Widget>[
                CupertinoTextField(
                  placeholder: "Gib den Gruppen-Code ein (Tip: 1111)",
                  controller: _groupCodeController,
                  onSubmitted: _submitGroupCode,
                ),
                CupertinoButton(
                  onPressed: () => _submitGroupCode(_groupCodeController.text),
                  child: const Text('beitreten'),
                ),
              ],
            );
          }

          if (state is FindGroupSearching) {
            return LoadingSpinnerWidget();
          }

          if (state is FindGroupSuccess) {
            // return buildSuccessArea(context);
          }

          // return _errorPage(context, state);

          print("Did not render state $state");
          return Container();
        },
        listener: (context, state) {
          if (state is GotoDashboard) {
            print("navigate from onboarding to dasboard");
            Navigator.of(context).pushReplacementNamed('/home');
          }

          if (state is FindGroupSuccess) {
            print("show alert: Group found");

            Future.delayed(const Duration(milliseconds: 800), () {
              Fluttertoast.showToast(
                  msg: "Erfolgreich beigetreten",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });

            Navigator.of(context).pushReplacementNamed('/home');
          }

          if (state is FindGroupNotFound) {
            print("show alert: Group not found!");
            _groupCodeController.clear();

            Future.delayed(const Duration(milliseconds: 800), () {
              Fluttertoast.showToast(
                  msg: "Gruppe nicht gefunden",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          }
        },
      ),
    ));
  }

  void _submitGroupCode(String code) {
    BlocProvider.of<OnboardingBloc>(context).add(SearchGroup(code));
  }

  Widget buildLoadingPage() {
    return LoadingSpinnerWidget();
  }

  Widget _errorPage(BuildContext context, OnboardingState state) {
    print("Did not render state $state");
    return LoadingSpinnerWidget();
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Error'),
              CupertinoButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  "/",
                  arguments: null,
                ),
                child: const Text('zur Hauptseite'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuccessArea(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Gruppe gefunden'),
        CupertinoButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            "/",
            arguments: null,
          ),
          child: const Text('Los legen!'),
        )
      ],
    );
  }
}
