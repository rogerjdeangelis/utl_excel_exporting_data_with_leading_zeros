Excel exporting data with leading zeros

github
https://github.com/rogerjdeangelis/utl_excel_exporting_data_with_leading_zeros

One of the more difficult formatting is leading zeros. Note
some of methods below can be used with other formats.

First of all do not use 'proc export';
Hopefully SAS will deprecate 'proc import/export' in the future?

Four Methods

  1. num=10; style={ tagattr='format:0#######'}  * adds one or more leading 0s;
  2. num=cats('09'x,ssnWth);
  3. num=cats(' ',ssnWth); * numlock alt-255 hiddon dragon;
  4. num=cats('+',ssnWth);

see
https://tinyurl.com/ycofgbcp
https://communities.sas.com/t5/SAS-Enterprise-Guide/How-to-preserve-the-format-while-exporting-a-Dataset-into-Excel/m-p/468657

see
https://goo.gl/9zV8xe
https://communities.sas.com/t5/ODS-and-Base-Reporting/Exporting-Data-with-Leading-Zeores/m-p/397851

KSharp profile (best solution)
https://communities.sas.com/t5/user/viewprofilepage/user-id/18408


EXAMPLES

1.  Maintain numeric or add leading 0
-------------------------------------

       SAS     EXCEL

       10    => 010
       88    => 088
       11    => 011

data have;
  ssn=10;output;
  ssn=88;output;
  ssn=11;output;
run;quit;

ods excel file="d:/xls/addzero.xlsx" ;
proc print data=have noobs label;
  var _all_ / style={ tagattr='format:0#######'};
run;
ods excel close ;


2.  Maintain leading 0s. kSharp character solution (best?)
-----------------------------------------------------------

       SAS     EXCEL

       010    => 010
       088    => 088
       011    => 011

data have(drop=ssnWth);
  input ssnWth $4.;
  ssn=cats('09'x,ssnWth);
cards4;
010
088
011
;;;;
run;quit;

ods excel file="d:/xls/ksharp.xlsx" ;
proc print data=have noobs label;
  var _all_ / style={ tagattr='format:text'};
run;
ods excel close ;


3. Using the hiddon dragon (numlock alt 255). Does not show the green 'error' triangle.
--------------------------------------------------------------------------------------

       On Dell full keyboard. numlock > hold alt key down >  255 produces the hidden dragon.
       On a Dell laptop without a keypad I think it is something like hold down function and alt
       then hit kii.

       SAS     EXCEL

       010    => 010
       088    => 088
       011    => 011

data have(drop=ssnWth);
  input ssnWth $4.;
  ssn=cats(' ',ssnWth); * numlock alt-255 hiddon dragon;
cards4;
010
088
011
;;;;
run;quit;

ods excel file="d:/xls/dragon.xlsx" ;
proc print data=have noobs label;
  var _all_ / style={ tagattr='format:text'};
run;
ods excel close ;


4. You can also use a '$' or '+' (may not be what you want)
-----------------------------------------------------------

       On Dell full keyboard. numlock > hold alt key down >  255 produces the hidden dragon.
       On a Dell laptop without a keypad hold down function and alt
       then hit kii.

       SAS     EXCEL

       010    => $010
       088    => $088
       011    => $011

       010    => +010   May get an error opening excel but excel fixes it
       088    => +088
       011    => +011

data have(drop=ssnWth);
  input ssnWth $4.;
  ssn=cats('+',ssnWth); * numlock alt-255;
cards4;
010
088
011
;;;;
run;quit;

ods excel file="d:/xls/dollar.xlsx" ;
proc print data=have noobs label;
  var _all_ /*/ style={ tagattr='format:text'}*/;
run;
ods excel close ;

