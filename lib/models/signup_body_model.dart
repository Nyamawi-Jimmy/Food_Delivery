class SignUpBody{
    String first;
    String middle;
    String last;
   String email;
   String phonepassword;
   String phone;

   SignUpBody({
     required this.email,
     required this.phonepassword,
     required this.first,
     required this.phone,
     required this.last,
     required this.middle

});

   Map<String,dynamic>toJson(){
     final Map<String,dynamic>data=new Map<String,dynamic>();
     data["email"]=this.email;
     data["phonepassword"]=this.phonepassword;
     data["first"]=this.first;
     data["last"]=this.last;
     data["middle"]=this.middle;
     data["phone"]=this.phone;
     return data;
}
}
