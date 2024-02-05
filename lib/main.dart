import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/blocs/line_tracking_team_rounds/line_tracking_team_rounds_bloc.dart';
import 'package:robocup/blocs/line_tracking_teams/line_tracking_teams_bloc.dart';
import 'package:robocup/dialogs/choose-map.dart';
import 'package:robocup/dialogs/dialog.dart';
import 'package:robocup/pages/line_tracking_choose_category.dart';
import 'package:robocup/pages/line_tracking_dashboard.dart';
import 'package:robocup/pages/line_tracking_team_round_details.dart';
import 'package:robocup/pages/line_tracking_team_round_scoring.dart';
import 'package:robocup/pages/line_tracking_team_rounds.dart';
import 'package:robocup/pages/line_tracking_teams.dart';
import 'package:robocup/repositories/line_tracking_repository.dart';

import 'amplifyconfiguration.dart';
import 'blocs/line_tracking_team_scoring/line_tracking_team_scoring_bloc.dart';
import 'models/ModelProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _configured = false;

  final router = GoRouter(
    initialLocation: '/line-tracking',
    routes: [
      GoRoute(
        path: '/line-tracking',
        builder: (context, state) => const LineTrackingChooseCategory(),
        routes: [
          GoRoute(
            path: ':category',
            builder: (context, state) => LineTrackingDashBoard(category: state.pathParameters['category']!),
              routes: [
                GoRoute(
                    path: 'teams',
                    builder: (context, state) => LineTrackingTeamsPage(category: state.pathParameters['category']!),
                    routes: [
                      GoRoute(
                          path: 'rounds/:teamID',
                          builder: (context, state) => LineTrackingTeamRoundsPage(teamID: state.pathParameters['teamID']!, category: state.pathParameters['category']!),
                          routes: [
                            GoRoute(
                              path: 'choose-map',
                              pageBuilder: (context, state) => DialogPage(child: ChooseMapDialog(teamID: state.pathParameters['teamID']!, category: state.pathParameters['category']!)),
                            ),
                            GoRoute(
                              path: 'round-details/:roundID',
                              builder: (context, state) => LineTrackingTeamRoundDetails(teamID: state.pathParameters['teamID']!, roundID: state.pathParameters['roundID']!, category: state.pathParameters['category']!),
                            ),
                            GoRoute(
                              // confirmation dialog on exit
                              onExit: (context) async{
                                // show a dialog to confirm exit
                                final result = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Are you sure you want to exit?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('No'),
                                      ),
                                    ],
                                  ),
                                );
                                return result ?? false;
                              },
                              path: 'round-scoring/:mapID',
                              builder: (context, state) => LineTrackingTeamRoundScoring(teamID: state.pathParameters['teamID']!, mapID: state.pathParameters['mapID']!, category: state.pathParameters['category']!),
                            ),
                          ]
                      )
                    ]
                ),
              ]
          )
        ]
      )
    ]
  );

  @override
  void initState() {
    super.initState();
    if (!_configured) {
      _configureAmplify();
    }
  }

  void _configureAmplify() async {
    try {
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);

      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.addPlugin(api);
      await Amplify.configure(amplifyconfig);

      setState(() {
        _configured = true;
      });
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => LineTrackingRepository()),
        ],
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => LineTrackingTeamsBloc(lineTrackingRepository: context.read<LineTrackingRepository>())),
                BlocProvider(create: (_) => LineTrackingTeamScoringBloc(lineTrackingRepository: context.read<LineTrackingRepository>())),
                BlocProvider(create: (_) => LineTrackingTeamRoundsBloc(lineTrackingRepository: context.read<LineTrackingRepository>()))
              ],
              child: MaterialApp.router(
                builder: Authenticator.builder(),
                title: 'Flutter Demo',
                // theme colors will be: dark blue (primary) yellow (secondary) and white (background) with their shades,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                  useMaterial3: true,
                ),
                routerConfig: router,
              ),
            );
          }
        ),
      ),
    );
  }
}