// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BankRatesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BankRatesPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    InvestmentCalculatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InvestmentCalculatorPage(),
      );
    },
    LoanCalculatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoanCalculatorPage(),
      );
    },
  };
}

/// generated route for
/// [BankRatesPage]
class BankRatesRoute extends PageRouteInfo<void> {
  const BankRatesRoute({List<PageRouteInfo>? children})
      : super(
          BankRatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'BankRatesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InvestmentCalculatorPage]
class InvestmentCalculatorRoute extends PageRouteInfo<void> {
  const InvestmentCalculatorRoute({List<PageRouteInfo>? children})
      : super(
          InvestmentCalculatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvestmentCalculatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoanCalculatorPage]
class LoanCalculatorRoute extends PageRouteInfo<void> {
  const LoanCalculatorRoute({List<PageRouteInfo>? children})
      : super(
          LoanCalculatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoanCalculatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
