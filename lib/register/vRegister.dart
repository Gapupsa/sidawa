import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:sidawa/data/res_ds.dart';
import 'package:sidawa/models/pekerjaan.dart';
import 'package:sidawa/models/radioGroup.dart';
import 'package:sidawa/widgets/sidawaAppbar.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  BuildContext _ctx;

  RestDatasource api = new RestDatasource();

  List<Pekerjaan> workingList;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final f = new DateFormat('dd-MM-yyyy');
  //EditControl
  TextEditingController txtPicker = new TextEditingController();
  TextEditingController txtNoKK = new TextEditingController();
  TextEditingController txtKTP = new TextEditingController();
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtTempat = new TextEditingController();
  TextEditingController txtDOB = new TextEditingController();
  TextEditingController txtGender = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();
  TextEditingController txtRTRW = new TextEditingController();
  TextEditingController txtKelurahan = new TextEditingController();
  TextEditingController txtKecamatan = new TextEditingController();
  TextEditingController txtReligion = new TextEditingController();
  TextEditingController txtStatus = new TextEditingController();
  TextEditingController txtWork = new TextEditingController();
  TextEditingController txtNasionality = new TextEditingController();
  TextEditingController txtDOE = new TextEditingController();
  TextEditingController txtEmailID = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  int _rgJkel = -1;

  final List<RadioGroup> _jKel = [
    RadioGroup(index: 0, text: 'Laki-Laki'),
    RadioGroup(index: 1, text: 'Perempuan')
  ];

  final List _religions = [
    "ISLAM",
    "KRISTEN",
    "KATOLIK",
    "PROTESTAN",
    "HINDU",
    "BUDHA",
    "ATHEIS"
  ];

  final List _status = [
    "MENIKAH",
    "BELUM KAWIN",
  ];

  List<DropdownMenuItem<String>> _dropDownMenuReligions;
  String _currentReligion;
  List<DropdownMenuItem<String>> _dropDownMenuStatus;
  String _currentStatus;
  List<DropdownMenuItem<String>> _dropDownMenuWorking;
  String _currentWorking;

  @override
  void initState() {
    _dropDownMenuReligions = getDropDownMenuItems(1);
    _currentReligion = _dropDownMenuReligions[0].value;

    _dropDownMenuStatus = getDropDownMenuItems(2);
    _currentStatus = _dropDownMenuStatus[0].value;

    // workingList = new List<Pekerjaan>();
    // api.fetchPekerjaan().then((List<Pekerjaan> pekerjaan) {
    //   workingList = pekerjaan;
    // });
    // _dropDownMenuWorking = getDropDownMenuItemWK();
    // _currentWorking = _dropDownMenuWorking[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(int index) {
    List<DropdownMenuItem<String>> items = new List();
    if (index == 1) {
      for (String religion in _religions) {
        items.add(
            new DropdownMenuItem(value: religion, child: new Text(religion)));
      }
    } else {
      for (String status in _status) {
        items.add(new DropdownMenuItem(value: status, child: new Text(status)));
      }
    }

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemWK() {
    List<DropdownMenuItem<String>> items = new List();
    workingList.forEach((wrk) {
      items.add(new DropdownMenuItem(
          value: wrk.kode, child: new Text(wrk.pekerjaan)));
    });

    return items;
  }

  void changedDropDownItemReligion(String selected) {
    setState(() {
      _currentReligion = selected;
    });
  }

  void changedDropDownItemStatus(String selected) {
    setState(() {
      _currentStatus = selected;
    });
  }

  void changedDropDownItemWork(String selected) {
    setState(() {
      _currentWorking = selected;
    });
  }

  Widget _comboField(String title, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButton(
                  value: index == 0
                      ? _currentReligion
                      : index == 1
                          ? _currentStatus
                          : _currentWorking,
                  items: index == 0
                      ? _dropDownMenuReligions
                      : index == 1
                          ? _dropDownMenuStatus
                          : _dropDownMenuWorking,
                  onChanged: index == 0
                      ? changedDropDownItemReligion
                      : index == 1
                          ? changedDropDownItemStatus
                          : changedDropDownItemWork,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entryField(String title, TextEditingController txt,
      {bool isPassword = false, bool isPicker = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          isPicker
              ? TextField(
                  controller: txtPicker,
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        currentTime: DateTime.now(),
                        locale: LocaleType.id, onConfirm: (date) {
                      txtPicker..text = f.format(date);
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
              : isPassword
                  ? TextField(
                      controller: txt,
                      obscureText: isPassword,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true))
                  : TextField(
                      controller: txt,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true))
        ],
      ),
    );
  }

  Widget _entryRadio(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _jKel
                .map((jkel) => Row(
                      children: [
                        Radio(
                            value: jkel.index,
                            groupValue: _rgJkel,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              setState(() {
                                _rgJkel = value;
                              });
                            }),
                        Text(jkel.text)
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff9c27b0), Color(0xff6a0080)])),
      child: Text(
        'Daftar',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _inputWidget() {
    return Column(
      children: <Widget>[
        _entryField("No.KK", txtNoKK),
        _entryField("NIK", txtKTP),
        _entryField("Nama", txtNama),
        _entryField("Tempat", txtTempat),
        _entryField("Tgl Lahir", txtDOB, isPicker: true),
        _entryRadio('Jenis Kelamin'),
        _entryField("Alamat", txtAddress),
        _entryField("RT/RW", txtRTRW),
        _entryField("Kel/Desa", txtKelurahan),
        _entryField("Kecamatan", txtKecamatan),
        _comboField("Agama", 0),
        _comboField("Status Perkawinan", 1),
        _comboField("Pekerjaan", 2),
        _entryField("Kewarganegaraan", txtNasionality),
        _entryField("Berlaku Hingga", txtDOE),
        _entryField("Email id", txtEmailID),
        _entryField("Password", txtPassword, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: SidawaAppBar(),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height, maxWidth: width),
          child: Container(
            height: height,
            child:
                // Positioned(
                //   top: -MediaQuery.of(context).size.height * .15,
                //   right: -MediaQuery.of(context).size.width * .4,
                //   child: BezierContainer(),
                // ),
                Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: height * .2),
                      //_title(),
                      SizedBox(
                        height: 50,
                      ),
                      _inputWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      //_loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
