import 'package:flutter/material.dart';
import 'package:uidemo/api/repository.dart';
import 'package:uidemo/models/data_model.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key, required this.userId}) : super(key: key);
  final int userId;
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  int get _userID => widget.userId;
  final Repository _repository = Repository();
  @override
  void initState() {
    _repository.getSingleUser(_userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
          padding: const EdgeInsets.all(120),
          alignment: Alignment.center,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
          child: FutureBuilder<SingleUserModel?>(
            future: Repository().getSingleUser(_userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.error != null) {
                return Text('${snapshot.error}');
              } else {
                return _buildUserDetails(snapshot.data!);
              }
            },
          )),
    ));
  }

  Widget _buildUserDetails(SingleUserModel userModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(userModel.avatarLink!),
        ),
        CustomTextField(
          initialValue: userModel.firstName,
          labelText: "First Name",
        ),
        CustomTextField(initialValue: userModel.lastName, labelText: "Last Name"),
        CustomTextField(
          labelText: "Email",
          initialValue: userModel.email,
        )
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.initialValue,
    required this.labelText,
  }) : super(key: key);
  final String? initialValue;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          label: Text(
            labelText,
            style: const TextStyle(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
        initialValue: initialValue,
        readOnly: true);
  }
}
