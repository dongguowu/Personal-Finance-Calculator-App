import 'package:auto_route/auto_route.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/pages/loan_calculator_page.dart';
import 'package:personal_finance_calculator/features/investment_calculator/presentation/pages/investment_calculator_page.dart';
import 'package:personal_finance_calculator/features/bank_rates/presentation/pages/bank_rates_page.dart';
import 'package:personal_finance_calculator/features/history/presentation/pages/history_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoanCalculatorRoute.page, initial: true),
        AutoRoute(page: InvestmentCalculatorRoute.page),
        AutoRoute(page: BankRatesRoute.page),
        AutoRoute(page: HistoryRoute.page),
      ];
}
