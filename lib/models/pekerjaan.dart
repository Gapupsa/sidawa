class Pekerjaan {
  String _kode;
  String _pekerjaan;

  Pekerjaan(this._kode, this._pekerjaan);

  Pekerjaan.map(dynamic obj) {
    this._kode = obj["kode"];
    this._pekerjaan = obj["pekerjaan"];
  }

  String get kode => _kode;
  String get pekerjaan => _pekerjaan;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["kode"] = _kode;
    map["pekerjaan"] = _pekerjaan;

    return map;
  }
}
