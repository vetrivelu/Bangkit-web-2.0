import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController secondaryphoneController = TextEditingController();
  final TextEditingController icnumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController primaryAdresssLine1 = TextEditingController();
  final TextEditingController primaryAdressline2 = TextEditingController();
  final TextEditingController secondaryAddressLine1 = TextEditingController();
  final TextEditingController secondaryAdressLIne2 = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController descriptionController2 = TextEditingController();
  final TextEditingController roofcolorController = TextEditingController();
  final TextEditingController doorcolorController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController primaryaddrsseController = TextEditingController();
  final TextEditingController secondaryaddressController = TextEditingController();
  final TextEditingController roofcolor2Controller = TextEditingController();
  final TextEditingController doorcolor2Controller = TextEditingController();
  final TextEditingController landmark2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    colors = [
      "red",
      "pink",
      "purple",
      "deepPurple",
      "indigo",
      "blue",
      "lightBlue",
      "cyan",
      "teal",
      "green",
      "lightGreen",
      "lime",
      "yellow",
      "amber",
      "orange",
      "deepOrange",
      "brown",
      "blueGrey"
    ];

    states = postalCodes.keys.toList();
    primaryCodeList = postalCodes[primaryState]!.map((e) => e["postCode"].toString()).toList();
    secondaryCodeList = postalCodes[secondaryState]!.map((e) => e["postCode"].toString()).toList();

    doorColorPrimary = widget.profile.primaryAddress.doorColor;
    roofColorPrimary = widget.profile.primaryAddress.roofColor;

    primaryState = widget.profile.primaryAddress.state;
    primaryPostCode = widget.profile.primaryAddress.pincode;

    // doorColorSecondary = widget.profile.secondaryAddress.doorColor;
    // roofColorSecondary = widget.profile.secondaryAddress.roofColor;
    // secondaryState = widget.profile.secondaryAddress.state;
    // doorColorSecondary = widget.profile.secondaryAddress.doorColor;

    // secondaryPostCode = widget.profile.secondaryAddress.pincode;

    nameController.text = widget.profile.name;
    phoneController.text = widget.profile.phone;
    secondaryphoneController.text = widget.profile.secondaryPhone;

    emailController.text = authController.auth.currentUser!.email ?? '';
    // icnumberController.text=widget.profile.icNumber??'';
  }

  setPrimaryPostalCodes() {
    primaryCodeList = postalCodes[primaryState]!.map((e) => e["postCode"].toString()).toList();
    primaryPostCode = primaryCodeList.first;
  }

  setSecondaryPostalCodes() {
    secondaryCodeList = postalCodes[secondaryState]!.map((e) => e["postCode"].toString()).toList();
    secondaryPostCode = secondaryCodeList.first;
  }

  getsubmitData() {
    var primaryAddress = Address(
        line1: primaryAdresssLine1.text,
        line2: primaryAdressline2.text,
        description: descriptionController.text,
        roofColor: roofColorPrimary,
        doorColor: doorColorPrimary,
        state: primaryState,
        pincode: primaryPostCode);
    var secondaryAddress = Address(
        line1: secondaryAddressLine1.text,
        line2: secondaryAdressLIne2.text,
        description: descriptionController2.text,
        roofColor: roofColorSecondary,
        doorColor: doorColorSecondary,
        state: secondaryState,
        pincode: primaryPostCode);
    return Profile(
      name: nameController.text,
      phone: phoneController.text,
      secondaryPhone: secondaryaddressController.text,
      email: emailController.text,
      primaryAddress: primaryAddress,
      // secondaryAddress: secondaryAddress,
      icNumber: icnumberController.text,
      documents: widget.profile.documents,
      services: widget.profile.services,
      fcm: widget.profile.fcm,
    );
  }

  late List<String> colors;
  late List<String> states;
  List<String> primaryCodeList = [];
  List<String> secondaryCodeList = [];

  late String doorColorPrimary;
  late String primaryState;
  late String secondaryState;
  late String doorColorSecondary;
  late String roofColorPrimary;
  late String roofColorSecondary;
  late String primaryPostCode;
  late String secondaryPostCode;
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.logout), onPressed: authController.auth.signOut),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black,
        ),
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
              child: Align(
                child: Text('Personal details'),
                alignment: Alignment.centerLeft,
              ),
            ),
            CustomTextFormfieldRed(
              controller: nameController,
              hintText: 'Name',
              labelText: 'Enter your name',
              icon: const Icon(Icons.person),
              keyboardType: TextInputType.name,
            ),
            CustomTextFormfieldRed(
              controller: phoneController,
              hintText: '+60 12-4103212',
              labelText: 'Enter your phone Number',
              icon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            CustomTextFormfieldRed(
              controller: secondaryphoneController,
              hintText: '+60 23456788',
              labelText: 'Enter Secondary Phone Number',
              icon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            CustomTextFormfieldRed(
              controller: icnumberController,
              hintText: 'Ex. F12345678I',
              labelText: 'Enter your Ic Number',
              icon: const Icon(FontAwesomeIcons.passport),
            ),
            CustomTextFormfieldRed(
              controller: emailController,
              hintText: 'name@email.com',
              labelText: 'Enter your Email',
              icon: const Icon(Icons.email),
              enabled: false,
              keyboardType: TextInputType.emailAddress,
            ),
            ExpansionTile(
              leading: const Icon(Icons.home),
              title: const Text('House address'),
              trailing: Icon(
                _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
              ),
              children: <Widget>[
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    child: Text('House Address'),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                CustomTextFormfieldRed(
                  controller: primaryAdresssLine1,
                  hintText: '123 Street',
                  labelText: 'Address line 1',
                  icon: const Icon(Icons.home),
                ),
                CustomTextFormfieldRed(
                  controller: primaryAdressline2,
                  hintText: '123 Street',
                  labelText: 'Address line 2',
                  icon: const Icon(Icons.home),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Choose State',
                    Icon: const Icon(FontAwesomeIcons.hotel),
                    value: primaryState,
                    onChanged: (String? newValue) {
                      setState(() {
                        primaryState = newValue!;
                        setPrimaryPostalCodes();
                      });
                    },
                    item: states.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Choose PinCode',
                    Icon: const Icon(FontAwesomeIcons.hotel),
                    value: primaryPostCode,
                    onChanged: (String? newValue) {
                      setState(() {
                        primaryPostCode = newValue!;
                      });
                    },
                    item: primaryCodeList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                CustomTextFormfieldRed(
                  maxLines: 4,
                  controller: descriptionController,
                  hintText: 'Type Your Text Here',
                  labelText: 'Description',
                  icon: const Icon(Icons.list),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'DoorColor',
                    Icon: const Icon(Icons.door_back_door),
                    value: doorColorPrimary,
                    onChanged: (String? newValue) {
                      setState(() {
                        doorColorPrimary = newValue!;
                      });
                    },
                    item: colors.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value),
                            const SizedBox(width: 15),
                            Container(height: 10, width: 10, color: Colors.primaries.elementAt(colors.indexWhere((element) => element == value))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Roof Color',
                    Icon: const Icon(Icons.roofing),
                    value: roofColorPrimary,
                    onChanged: (String? newValue) {
                      setState(() {
                        roofColorPrimary = newValue!;
                      });
                    },
                    item: colors.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value),
                            const SizedBox(width: 15),
                            Container(height: 10, width: 10, color: Colors.primaries.elementAt(colors.indexWhere((element) => element == value))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _customTileExpanded = expanded);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.home),
              title: const Text('Secondary House address'),
              trailing: Icon(
                _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
              ),
              children: [
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    child: Text('Secondary House Address'),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                CustomTextFormfieldRed(
                  controller: secondaryAddressLine1,
                  hintText: '123 Street',
                  labelText: 'Address line 1',
                  icon: const Icon(FontAwesomeIcons.home),
                ),
                CustomTextFormfieldRed(
                  controller: secondaryAdressLIne2,
                  hintText: '123 Street',
                  labelText: 'Address line 2',
                  icon: const Icon(FontAwesomeIcons.home),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Choose State',
                    Icon: const Icon(FontAwesomeIcons.hotel),
                    value: secondaryState,
                    onChanged: (String? newValue) {
                      setState(() {
                        secondaryState = newValue!;
                        setSecondaryPostalCodes();
                      });
                    },
                    item: states.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Choose PinCode',
                    Icon: const Icon(FontAwesomeIcons.hotel),
                    value: secondaryPostCode,
                    onChanged: (String? newValue) {
                      setState(() {
                        secondaryPostCode = newValue!;
                      });
                    },
                    item: secondaryCodeList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                CustomTextFormfieldRed(
                  maxLines: 4,
                  controller: descriptionController2,
                  hintText: 'Type Your Text Here',
                  labelText: 'Description',
                  icon: const Icon(Icons.list),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'DoorColor',
                    Icon: const Icon(Icons.door_back_door),
                    value: doorColorSecondary,
                    onChanged: (String? newValue) {
                      setState(() {
                        doorColorSecondary = newValue!;
                      });
                    },
                    item: colors.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value),
                            const SizedBox(width: 15),
                            Container(height: 10, width: 10, color: Colors.primaries.elementAt(colors.indexWhere((element) => element == value))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CustomDropDownButtonformField(
                    labelText: 'Roof Color',
                    Icon: const Icon(Icons.roofing),
                    value: roofColorSecondary,
                    onChanged: (String? newValue) {
                      setState(() {
                        roofColorSecondary = newValue!;
                      });
                    },
                    item: colors.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value),
                            const SizedBox(width: 15),
                            Container(height: 10, width: 10, color: Colors.primaries.elementAt(colors.indexWhere((element) => element == value))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    Profile submitProfile = getsubmitData();
                    submitProfile.updateUser();
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shadowColor: const Color(0xFF757575),
                    side: const BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropDownButtonformField extends StatelessWidget {
  const CustomDropDownButtonformField({
    Key? key,
    this.Icon,
    this.Icon2,
    this.labelText,
    this.hintText,
    this.item,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final Widget? Icon;
  final Widget? Icon2;
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuItem<String>>? item;
  final String? value;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: item,
        decoration: InputDecoration(
          suffixIcon: Icon2,
          prefixIcon: Icon,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        ),
      ),
    );
  }
}

class CustomTextFormfieldRed extends StatelessWidget {
  const CustomTextFormfieldRed({
    Key? key,
    required this.controller,
    this.icon,
    this.icon2,
    this.labelText,
    this.hintText,
    this.maxLines,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);
  final TextEditingController controller;

  final Widget? icon;
  final Widget? icon2;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final bool? enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 60),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: TextFormField(
          expands: false,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: icon2,
            prefixIcon: icon,
            labelText: labelText,
            labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          ),
          style: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF2B343A),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
