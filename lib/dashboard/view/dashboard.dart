import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/dashboard/view_model/dashboard_view_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: DrawerButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Events: ${dashboardViewModel.getEventsTotal().toString()}'),
            Text('Tasks: ${dashboardViewModel.getTaskTotal().toString()}'),
            Text('Owners: ${dashboardViewModel.getOwnersTotal().toString()}'),
          ],
        ),
      ),
    );
  }
}
