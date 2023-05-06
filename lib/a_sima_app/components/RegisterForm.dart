import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/components/InputFields.dart';

class FormContainer2 extends StatelessWidget {
  final formKey;
  final  phoneNumberValue;
  final  addressValue;
  final  referenceValue;
  final  postalCodeValue;
  final  provinceValue;
  final  cityValue;
  final pass1;

  FormContainer2({ this.formKey, this.addressValue , this.phoneNumberValue , this.cityValue , this.postalCodeValue , this.provinceValue , this.referenceValue, this.pass1 });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Form(
            key : formKey,
            child: Column(
              children: <Widget>[
                InputFieldArea(
                  hint: "شماره همراه",
                  obscure: false,
                  icon : Icons.phone_android,
                  validator: (String value) {

                    if( value.length!=11 ) {
                      return 'شماره همراه را بصورت صحیح وارد نمایید';
                    }
                  },
                  onSaved : phoneNumberValue
                ),InputFieldArea(
                  hint: "آدرس",
                  obscure: false,
                  icon : Icons.location_on,
                  validator: (String value) {

                    if( value.length < 10) {
                      return 'آدرس باید حداقل 10 کاراکتر باشد';
                    }
                  },
                  onSaved : addressValue
                ),InputFieldArea(
                  hint: "نام معرف",
                  obscure: false,
                  icon : Icons.person_outline,
                  onSaved : referenceValue
                ),
                InputFieldArea(
                  hint: "کد پستی",
                  obscure: false,
                  icon: Icons.home,
                  onSaved : postalCodeValue
                ),
                InputFieldArea(
                    hint: "استان",
                    obscure: false,
                    icon: Icons.account_balance_wallet,
                    onSaved : provinceValue
                ), InputFieldArea(
                    hint: "شهر",
                    obscure: false,
                    icon: Icons.location_city,
                    onSaved : provinceValue
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}