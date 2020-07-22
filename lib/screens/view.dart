import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/dependencies.dart';
import 'viewmodel.dart';

class View<T extends Viewmodel> extends StatelessWidget {
  final Widget Function(BuildContext context, T viewmodel, Widget child)
      builder;

  final void Function(T viewmodel) initViewmodel;

  View({this.builder, this.initViewmodel});

  T _setupViewmodel() {
    final viewmodel = dependency<T>();
    if (initViewmodel != null) {
      initViewmodel(viewmodel);
    }
    return viewmodel;
  }

  Widget _builder(BuildContext context, T viewmodel, Widget child) {
    if (viewmodel.busy) {
      return Center(
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return builder(context, viewmodel, child);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _setupViewmodel(),
        child: Consumer<T>(builder: _builder),
      );
}
