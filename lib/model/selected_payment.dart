class SelectedPayment{
  int id;
  String title;
  String subscribe;

  SelectedPayment({this.id, this.title, this.subscribe});

  static List<SelectedPayment> getSelectedPayment(){
    return <SelectedPayment>[
      SelectedPayment(id: 1, title: "Gopay", subscribe: "Bayar pake gopay"),
      SelectedPayment(id: 2, title: "OVO", subscribe: "Bayar pake OVO"),
      SelectedPayment(id: 3, title: "Bank", subscribe: "Bayar pake Bank"),
    ];
  }
}