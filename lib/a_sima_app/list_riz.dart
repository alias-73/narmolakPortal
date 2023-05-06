//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'components/Styles.dart';
import 'components/helper.dart' as helper;
import 'models/rizModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row , Stack;

import 'models/rizModelll.dart';



class list_riz_page extends StatefulWidget {
  List<AgentModel> _dataa = [];
   list_riz_page(this._dataa,{Key? key}) : super(key: key);

  //list_riz_page();
  @override
  State<StatefulWidget> createState() => list_riz_pageState();
}

class list_riz_pageState extends State<list_riz_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  String _key1 = "";
  final _key2 = GlobalKey<FormFieldState>();
  String _datetime = 'انتخاب کنید';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  int currentPageIndex = 0;
  List<RizModel> _data = [];
  List<RizModel2> _exData = [];
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource ;
  int i = 0;
  bool isFree = false;
  late Map response;
  late Map response2;
  bool loading = false;
  String srch = "-";
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
   TextEditingController _controller1 = TextEditingController(text: "");

  Future<List<RizModel>>getRizList() async {

    i++;
    if (i < 2 && _key1.length > 1 )
    {
      response = await OnlineServices.getRizList({"terminal": _key2.currentState!.value.toString(), "agentcode": widget._dataa.last.agentCode, "tarikh": _key1.toString().replaceAll("-", "/")} );
      response2 = await OnlineServices.getRizList2({"terminal": _key2.currentState!.value.toString(), "agentcode": widget._dataa.last.agentCode, "tarikh": _key1.toString().replaceAll("-", "/")} );
      if (response["data"] != "free") {
        _data.clear();
        _exData.clear();
        _exData.addAll(response2['data']);

        String cardTemp = "";
        for(int i = 0; i < _exData.length ; i++)
          {
            _exData[i].vaziyat == "کارت نامعتبر" ? _exData[i].vaziyat = "0" :
            _exData[i].vaziyat == "حساب تعریف نشده" ? _exData[i].vaziyat = "1" :
            _exData[i].vaziyat == "از انجام اصلاحیه صرفنظر گردید" ? _exData[i].vaziyat = "2" :
            _exData[i].vaziyat == "موفق" ? _exData[i].vaziyat = "3" :
            _exData[i].vaziyat == "از انجام تراکنش صرف نظر شد" ? _exData[i].vaziyat = "4" :
            _exData[i].vaziyat == "احتمال تقلبی بودن تراکنش است" ? _exData[i].vaziyat = "5" :
            _exData[i].vaziyat == "تعداد دفعات انجام تراکنش از حد مجاز بیشتر است" ? _exData[i].vaziyat = "6" :
            _exData[i].vaziyat == "پذیرنده فروشگاهی نامعتبر است" ? _exData[i].vaziyat = "7" :
            _exData[i].vaziyat == "شماره کارت صحیح نمی باشد" ? _exData[i].vaziyat = "8" :
            _exData[i].vaziyat == "موجودی حساب کافی نمی باشد" ? _exData[i].vaziyat = "9" :
            _exData[i].vaziyat == "قوانین سامانه رعایت نشده است" ? _exData[i].vaziyat = "10" :
            _exData[i].vaziyat == "اشکال در پردازش تراکنش" ? _exData[i].vaziyat = "11" :
            _exData[i].vaziyat == "تراکنش غیر مجاز کارت" ? _exData[i].vaziyat =  "12" :
            _exData[i].vaziyat == "مبلغ تراکنش بیش از حد مجاز می باشد" ? _exData[i].vaziyat =  "13" :
            _exData[i].vaziyat == "تاریخ استفاده از کارت به پایان رسیده است" ? _exData[i].vaziyat =  "14" :
            _exData[i].vaziyat == "رمز نامعتبر" ? _exData[i].vaziyat =  "15" :
            _exData[i].vaziyat == "عدم دریافت پاسخ" ? _exData[i].vaziyat =  "16" :
            _exData[i].vaziyat == "درحال پردازش پایان روز" ? _exData[i].vaziyat =  "17" :
            _exData[i].vaziyat == "تعداد دفعات ورود رمز غلط، بیش از حد مجاز است" ? _exData[i].vaziyat =  "18" :
            _exData[i].vaziyat == "تراکنش تکراری می باشد" ? _exData[i].vaziyat =  "19" :
            _exData[i].vaziyat == "کارت فعال نیست" ? _exData[i].vaziyat =  "20" :
            _exData[i].vaziyat == "تراکنش نامعتبر است" ? _exData[i].vaziyat =  "21" :
            _exData[i].vaziyat == "سوییچ صادر کننده غیرفعال" ? _exData[i].vaziyat =  "22" :
            _exData[i].vaziyat == "کارت محدود شده است" ? _exData[i].vaziyat =  "23" :
            _exData[i].vaziyat == "تمهیدات امنیتی نقض گردیده است" ? _exData[i].vaziyat =  "24" :
            _exData[i].vaziyat == "روز مالی تراکنش نامعتبر است" ? _exData[i].vaziyat =  "25" :
            _exData[i].vaziyat == "تراکنش کامل نشده" ? _exData[i].vaziyat =  "26" :
            _exData[i].vaziyat == "شناسه قبض/پرداخت نادرست" ? _exData[i].vaziyat =  "27" : _exData[i].vaziyat = "0";

            _exData[i].noe == "پاسخ خرید شارژ گروهی" ? _exData[i].noe = "A" :
            _exData[i].noe == "پاسخ خرید TOPUP" ? _exData[i].noe = "B" :
            _exData[i].noe == "پاسخ مانده حساب" ? _exData[i].noe = "C" :
            _exData[i].noe == "پاسخ خرید شارژ" ? _exData[i].noe = "D" :
            _exData[i].noe == "پاسخ اصلاحیه" ? _exData[i].noe = "E" :
            _exData[i].noe == "پاسخ قبض" ? _exData[i].noe = "F" :
            _exData[i].noe == "پاسخ خرید" ? _exData[i].noe = "G" : _exData[i].noe = "X";


          }
        _data.addAll(response['data']);

        loading = false;
        _employees = _getEmployeeData();
        _employeeDataSource = EmployeeDataSource(employeeData: _employees);
        setState(() {});
      }
      else
      {
        isFree = true;
        loading = false;
        _data.clear();
        _exData.clear();
        Comp.showSnack(context,Icons.warning_amber_rounded,"اطلاعاتی برای نمایش وجود ندارد");

    setState(() {});
      }
    }
    return _data;
  }

  List<Employee> _getEmployeeData() {
    List<Employee> a = [];
    for (int i = 0 ; i < _exData.length ; i++)
    {
      a.add(Employee(_exData[i].cart ,_exData[i].peygiri ,_exData[i].saat ,_exData[i].noe,_exData[i].mablaq,_exData[i].vaziyat ));
    }

    return a;
  }


  Future<void> _exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await helper.saveAndLaunchFile(bytes, 'PasargadReport.xlsx');
  }

  Future<void> _exportDataGridToPdf() async {
    final PdfDocument document = _key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await helper.saveAndLaunchFile(bytes, 'PasargadReport.pdf');
    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      floatingActionButton: Visibility(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(right: 27),child: FloatingActionButton(onPressed: _exportDataGridToPdf,
            child: Image.asset("assets/images/pdf.png",height: 25),
            backgroundColor: Colors.teal,
          ),),
          FloatingActionButton(onPressed: _exportDataGridToExcel,
            child: Image.asset("assets/images/xlsx.png",height: 25),
            backgroundColor: Colors.teal,
          ),
        ],
      ),visible: _data.isNotEmpty,),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ریزتراکنش","", Icons.edit, (){})),
      body:  Stack(
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                CircleAvatar(backgroundColor: Color(0xfffac80a),maxRadius: 25,child: IconButton(icon: Icon(Icons.search,color:Colors.black,size: 29,), onPressed: (){
                //  i=0;
                 // getRizList();
                  if(_key1.toString().length > 2 && _key2.currentState!.value.toString().length > 2)
                  {
                    loading = true;
                    setState(() {});
                    i=0;
                    getRizList();
                  }
                  else Comp.showSnack(context,Icons.warning_amber_rounded,"لطفا داده های ورودی را کنترل نمایید");

                }),),

                Column(
                  children: [
                    Container(
                      width: size.width * .7,
                      margin: EdgeInsets.only(left: 30, top: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        cursorColor: cl,
                        textAlign: TextAlign.center,
                        key: _key2,
                        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: Icon(
                            Icons.title,
                            color: cl,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: cl,
                              width: 1.0,
                            ),
                          ),
                          fillColor: cl,
                          focusColor: cl,
                          hoverColor: cl,
                          contentPadding: EdgeInsets.zero,

                          //errorText: _errorText1,
                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl)),

                          labelText: "ترمینال",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl)),
                          // errorText: 'Error message',
                          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: _showDatePicker,
                        child:  Stack(
                          alignment: Alignment.center,
                          children: <Widget>[

                            Container(
                              width: size.width * .7,

                              margin: EdgeInsets.only(left: 30, top: 10),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _controller1,
                                enabled: false,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.date_range_sharp,
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.zero,

                                  labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: cl,width: 1.0)),
                                  labelText: "تاریخ",
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: cl,width: 1.0)),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],),
              _exData.isEmpty ? Center() :
              SizedBox(
                height: 1,
                width: 1,
                child: SfDataGrid(
                  key: _key,
                  source: _employeeDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'cart',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'cart',
                            ))),
                    GridColumn(
                        columnName: 'peygiri',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('peygiri'))),
                    GridColumn(
                        columnName: 'saat',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'saat',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'noe',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('noe'))),
                    GridColumn(
                        columnName: 'mablaq',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'mablaq',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'vaziyat',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('vaziyat'))),
                  ],
                ),
              ),

              Expanded(child:
              FutureBuilder<List<RizModel>>(future: getRizList(),
                builder: (context, AsyncSnapshot<List<RizModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                        });

                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)      )
            ],),
          loading == true ?
          Comp.showLoading(size.height , size.width) : Center()
        ],
      ),


    );
  }

  void _showDatePicker() async {
    String m = "";
    String d = "";
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1401,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
          if (!showTitleActions) {
          }
        }, onConfirm: (year, month, day) {
          month! < 10 ? m = ("0$month") : m = ("$month");
          day! < 10 ? d = ("0$day") : d = ("$day");

          _datetime = '$year-$m-$d';
          if (!_datetime.contains("انتخاب"))
          {    _key1 = _datetime;
          _controller1= TextEditingController(text: _datetime.replaceAll("-", "/"));
          }          setState(() {});

        });
  }


  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;

    return Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text( "ساعت:  " +  _data[index].saat,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text( "کارت: " +  _data[index].cart,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(child: Text( "وضعیت: " +  _data[index].vaziyat,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3))),

                    ],
                  ),
                ],

              ),
            ),
            SizedBox(
              width: size.width * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.title,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(child: Text( "نوع:  " +  _data[index].noe,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3))),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("مبلغ:  " +  _data[index].mablaq ,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.apps,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("پیگیری:  " +  _data[index].peygiri ,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],

              ),
            )

          ],
        ),
    )  ;
  }

}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.cart, this.peygiri, this.saat, this.noe, this.mablaq, this.vaziyat);
  final String cart;
  final String peygiri;
  final String saat;
  final String noe;
  final String mablaq;
  final String vaziyat;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData.map<DataGridRow>((Employee e) => DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'cart', value: e.cart),
      DataGridCell<String>(columnName: 'peygiri', value: e.peygiri),
      DataGridCell<String>(columnName: 'saat', value: e.saat),
      DataGridCell<String>(columnName: 'noe', value: e.noe),
      DataGridCell<String>(columnName: 'mablaq', value: e.mablaq),
      DataGridCell<String>(columnName: 'vaziyat', value: e.vaziyat),
    ])).toList();
  }

  List<DataGridRow> _employeeData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(cell.value.toString()),
          );
        }).toList());
  }
}