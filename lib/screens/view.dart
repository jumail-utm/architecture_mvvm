import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/dependencies.dart';
import 'viewmodel.dart';

class View<T extends Viewmodel> extends StatelessWidget {
  final Widget Function(BuildContext context, Viewmodel viewmodel, Widget child)
      builder;

  View({this.builder});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: dependency<T>(),
        child: Consumer<T>(builder: builder),
      );
}
