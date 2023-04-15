import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/cubit/update_cubit.dart';
import 'modules/dashboard/controller/dashboard_cubit.dart';
import 'modules/dashboard/repository/dashboard_repository.dart';
import 'modules/order/controller/cubit/cubit/running_order_cubit.dart';
import 'modules/order/controller/cubit/order_request_cubit.dart';
import 'modules/order/controller/repository/order_repository.dart';
import 'modules/profile/controller/cubit/profile_cubit.dart';
import 'modules/profile/controller/repository/profile_repository.dart';
import 'modules/withdraw/controller/method_cubit/method_cubit.dart';
import 'core/data/datasources/local_data_source.dart';
import 'core/data/datasources/remote_data_source.dart';
import 'modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'modules/animated_splash_screen/controller/repository/app_setting_repository.dart';
import 'modules/authentication/controller/forgot_password/forgot_password_cubit.dart';
import 'modules/authentication/controller/login/login_bloc.dart';
import 'modules/authentication/controller/sign_up/sign_up_bloc.dart';
import 'modules/authentication/repository/auth_repository.dart';
import 'modules/order/controller/cubit/cubit/complete_order_cubit.dart';
import 'modules/order/controller/cubit/cubit/order_details_cubit.dart';
import 'modules/profile/controller/cubit/cubit/profile_edit_cubit.dart';
import 'modules/withdraw/controller/account_info/account_info_cubit.dart';
import 'modules/withdraw/controller/create_withdraw/create_withdraw_cubit.dart';
import 'modules/withdraw/controller/single_account_info/single_account_info_cubit.dart';
import 'modules/withdraw/repository/withdraw_repository.dart';

class StateInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    // Stripe.publishableKey = RemoteUrls.publishableKey;
  }

  static final repositoryProviders = <RepositoryProvider>[
    ///network client
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),

    ///data source repository
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(
        client: context.read(),
      ),
    ),

    RepositoryProvider<LocalDataSource>(
      create: (context) => LocalDataSourceImpl(
        sharedPreferences: context.read(),
      ),
    ),

    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImp(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<AppSettingRepository>(
      create: (context) => AppSettingRepositoryImp(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<DashboardRepository>(
      create: (context) => DashboardRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<ProfileRepository>(
      create: (context) => ProfileRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<WithdrawRepository>(
      create: (context) => WithdrawRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),

    RepositoryProvider<OrderRepository>(
      create: (context) => OrderRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),

    ///repository
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(
        // profileRepository: context.read(),
        authRepository: context.read(),
      ),
    ),
    BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(
        context.read(),
      ),
    ),
    BlocProvider<ForgotPasswordCubit>(
      create: (BuildContext context) => ForgotPasswordCubit(
        context.read(),
      ),
    ),
    BlocProvider<AppSettingCubit>(
      create: (BuildContext context) => AppSettingCubit(
        context.read(),
      ),
    ),
    BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(
        dashboardRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(
        profileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ProfileEditCubit>(
      create: (BuildContext context) => ProfileEditCubit(
        profileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CreateWithdrawCubit>(
      create: (BuildContext context) => CreateWithdrawCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AccountInfoCubit>(
      create: (BuildContext context) => AccountInfoCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<OrderRequestCubit>(
      create: (BuildContext context) => OrderRequestCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<OrderDetailsCubit>(
      create: (BuildContext context) => OrderDetailsCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<RunningOrderCubit>(
      create: (BuildContext context) => RunningOrderCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<RunningOrderCubit>(
      create: (BuildContext context) => RunningOrderCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CompleteOrderCubit>(
      create: (BuildContext context) => CompleteOrderCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<MethodCubit>(
      create: (BuildContext context) => MethodCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CreateWithdrawCubit>(
      create: (BuildContext context) => CreateWithdrawCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SingleAccountInfoCubit>(
      create: (BuildContext context) => SingleAccountInfoCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),BlocProvider<UpdateCubit>(
      create: (BuildContext context) => UpdateCubit(
        orderRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
  ];
}
