import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projucti_sample/blocs/auto_complete/application_bloc.dart';
import 'package:projucti_sample/blocs/geolocation/geolocation_bloc.dart';
import 'package:projucti_sample/repositories/geolocation/geolocation_repo.dart';
import 'package:projucti_sample/res/custom_colors.dart';
import 'package:projucti_sample/widgets/app_bar_title.dart';
import 'package:projucti_sample/widgets/google_sign_out_button.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GeolocationRepo>(
            create: (_) => GeolocationRepo(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => GeolocationBloc(
                    geolocationRepo: context.read<GeolocationRepo>())
                  ..add(LoadGeolocation()))
          ],
          child: Scaffold(
            backgroundColor: CustomColor.loginPageBackground,
            appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: CustomColor.loginPageBackground,
                title: AppBarTitle(
                  sectionName: "DASHBOARD",
                ),
                actions: <Widget>[
                  GoogleSignOutButton(),
                ]),
            body: SafeArea(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: CustomColor.label,
                  fontSize: 16.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 20.0, top: 50.0),
                  child: Column(
                    children: [
                      Row(),
                      // display user image
                      _user.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color: CustomColor.loginPageBackground
                                    .withOpacity(0.3),
                                child: Image.network(
                                  _user.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color: CustomColor.loginPageBackground
                                    .withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: CustomColor.loginPageBackground,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 16.0),

                      // display user name
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Welcome " + _user.displayName!),
                      ),

                      // display user current location by latitude and longitude
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Your current location is "),
                      ),
                      BlocBuilder<GeolocationBloc, GeolocationState>(
                          builder: (context, state) {
                        if (state is GeolocationInitial) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GeolocationInitiated) {
                          return Text(state.position.latitude.toString() +
                              ', ' +
                              state.position.longitude.toString());
                        } else {
                          return Text('unable to retrieve your location');
                        }
                      }),
                      //auto_complete
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search City',
                              suffixIcon: Icon(Icons.search)),
                          onChanged: (value) =>
                              ApplicationBloc().searchPlaces(value),
                        ),
                      ),
                      Container(
                        height: 100.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.darken,
                            color: Colors.black.withOpacity(.6)),
                      ),
                      Container(
                        height: 100.0,
                        child: ListView.builder(
                          itemCount: ApplicationBloc().searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  ApplicationBloc()
                                      .searchResults[index]
                                      .description,
                                  style: TextStyle(color: CustomColor.label)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
