import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_test/bloc/user_bloc.dart';
import 'package:practical_test/model/user-model.dart';
import 'package:practical_test/widgets/widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    _userBloc.add(GetUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildProfilePage(),
    );
  }

  Widget _buildProfilePage() {
    return BlocProvider(
      create: (_) => _userBloc,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return _buildLoading();
            } else if (state is UserLoading) {
              return _buildLoading();
            } else if (state is UserLoaded) {
              if(state.userModel.results != null){
                return _buildCard(context, state.userModel);
              }else{
                return const EmptyView();
              }

            } else if (state is UserError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, User model) {
    var img = model.results?.first.picture?.large;
    var username = model.results?.first.login?.username;
    var age = model.results?.first.dob?.age;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

     return Stack(
      children: <Widget>[
        Container(
        color: Color(0xFF26CBE6),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: _height / 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage(img!),
                        radius: _height / 10,
                      ),
                      SizedBox(
                        height: _height / 30,
                      ),
                      Text(
                      "${model.results?.first.name?.title}. ${model.results?.first.name?.first} ${model.results?.first.name?.last}".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _height / 2.2),
                child: Container(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _height / 2.6,
                    left: _width / 20,
                    right: _width / 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 2.0))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(_width / 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              headerChild('Username',username!),
                              headerChild('Age', age.toString()!),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: _height / 15),
                      child: Column(
                        children: <Widget>[
                          infoChild(
                              _width, Icons.email, model.results?.first.email),
                          Gap(g: 20.0),
                          infoChild(_width, Icons.call, model.results?.first.phone),
                          Gap(g: 20.0),
                          infoChild(
                              _width, Icons.location_on, "${model.results?.first.location?.street?.number} ${model.results?.first.location?.street?.name}, ${model.results?.first.location?.city}, ${model.results?.first.location?.country}"),
                          Gap(g: 20.0),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget headerChild(String header, String value) => Expanded(
      child: Column(
        children: <Widget>[
          Text(header,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.0,color: Color(0xFF26CBE6)),),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: const TextStyle(
                fontSize: 14.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: InkWell(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: width / 10,
          ),
          Icon(
            icon,
            color: const Color(0xFF26CBE6),
            size: 36.0,
          ),
          SizedBox(
            width: width / 20,
          ),
          Expanded(child: Text(data,style: const TextStyle(color: Colors.blueGrey,fontSize: 16.0),overflow: TextOverflow.ellipsis,))
        ],
      ),
      onTap: () {
        print('Info Object selected');
      },
    ),
  );

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
