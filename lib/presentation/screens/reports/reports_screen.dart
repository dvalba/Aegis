import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/reports/reports_provider.dart';
import '../../widgets/shared/app_bar/custom_app_bar.dart';
import 'search_text_field_widget.dart';
import 'report_item_widget.dart';
import '../../widgets/shared/bottom_bar/custom_bottom_navigation_bar.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  final int selectedIndex; // Índice seleccionado

  const ReportsScreen({super.key, required this.selectedIndex});

  @override
  ReportsScreenState createState() => ReportsScreenState();
}

class ReportsScreenState extends ConsumerState<ReportsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Inicializamos el ScrollController
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

      WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reportProvider.notifier).reset();
      ref.read(reportProvider.notifier).loadReports();
    });
  }

  @override
  void dispose() {
    // Liberamos el controller cuando el widget se destruya
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Función para escuchar cuando el usuario llega al final de la lista
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Llamar a la función loadMoreReports cuando se llega al final
      ref.read(reportProvider.notifier).loadReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        child: SearchTextFieldWidget(),
      ),
      body: ListView.builder(
        controller: _scrollController, // Asignamos el controlador aquí
        padding: const EdgeInsets.all(16.0),
        itemCount: reports.patients.length,
        itemBuilder: (BuildContext context, int index) {
          return ReportItem(index: index);
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: widget.selectedIndex, // Usar el índice proporcionado
      ),
    );
  }
}
