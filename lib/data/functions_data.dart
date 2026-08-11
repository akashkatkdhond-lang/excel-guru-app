import '../models/excel_function.dart';

/// Searchable A-Z reference of real Excel functions — a quick lookup
/// dictionary, separate from Lessons/Levels. Free for everyone.
final List<ExcelFunction> excelFunctions = [
  // Math & Trig
  const ExcelFunction(name: 'SUM', category: 'Math', syntax: 'SUM(range)', description: 'Numbers ki range ko jodta hai.'),
  const ExcelFunction(name: 'SUMIF', category: 'Math', syntax: 'SUMIF(range,criteria,sum_range)', description: 'Ek condition follow karne wali values ko jodta hai.'),
  const ExcelFunction(name: 'SUMIFS', category: 'Math', syntax: 'SUMIFS(sum_range,range1,criteria1,...)', description: 'Multiple conditions ke basis par jodta hai.'),
  const ExcelFunction(name: 'SUMPRODUCT', category: 'Math', syntax: 'SUMPRODUCT(array1,array2)', description: 'Do arrays ko multiply karke unka total deta hai.'),
  const ExcelFunction(name: 'ROUND', category: 'Math', syntax: 'ROUND(number,digits)', description: 'Number ko diye gaye decimal places tak round karta hai.'),
  const ExcelFunction(name: 'ROUNDUP', category: 'Math', syntax: 'ROUNDUP(number,digits)', description: 'Number ko hamesha upar ki taraf round karta hai.'),
  const ExcelFunction(name: 'ROUNDDOWN', category: 'Math', syntax: 'ROUNDDOWN(number,digits)', description: 'Number ko hamesha neeche ki taraf round karta hai.'),
  const ExcelFunction(name: 'ABS', category: 'Math', syntax: 'ABS(number)', description: 'Number ki absolute (bina negative sign) value deta hai.'),
  const ExcelFunction(name: 'POWER', category: 'Math', syntax: 'POWER(number,power)', description: 'Number ko power tak raise karta hai.'),
  const ExcelFunction(name: 'SQRT', category: 'Math', syntax: 'SQRT(number)', description: 'Number ka square root nikalta hai.'),
  const ExcelFunction(name: 'MOD', category: 'Math', syntax: 'MOD(number,divisor)', description: 'Division ke baad bacha hua remainder deta hai.'),
  const ExcelFunction(name: 'RAND', category: 'Math', syntax: 'RAND()', description: '0 aur 1 ke beech ek random number generate karta hai.'),
  const ExcelFunction(name: 'RANDBETWEEN', category: 'Math', syntax: 'RANDBETWEEN(bottom,top)', description: 'Do numbers ke beech ek random whole number deta hai.'),

  // Statistical
  const ExcelFunction(name: 'AVERAGE', category: 'Statistical', syntax: 'AVERAGE(range)', description: 'Numbers ki range ka average nikalta hai.'),
  const ExcelFunction(name: 'AVERAGEIF', category: 'Statistical', syntax: 'AVERAGEIF(range,criteria,avg_range)', description: 'Ek condition follow karne wali values ka average nikalta hai.'),
  const ExcelFunction(name: 'AVERAGEIFS', category: 'Statistical', syntax: 'AVERAGEIFS(avg_range,range1,criteria1,...)', description: 'Multiple conditions ke basis par average nikalta hai.'),
  const ExcelFunction(name: 'COUNT', category: 'Statistical', syntax: 'COUNT(range)', description: 'Range me sirf numbers ginta hai.'),
  const ExcelFunction(name: 'COUNTA', category: 'Statistical', syntax: 'COUNTA(range)', description: 'Range me numbers + text dono cells ginta hai.'),
  const ExcelFunction(name: 'COUNTBLANK', category: 'Statistical', syntax: 'COUNTBLANK(range)', description: 'Range me khali (blank) cells ginta hai.'),
  const ExcelFunction(name: 'COUNTIF', category: 'Statistical', syntax: 'COUNTIF(range,criteria)', description: 'Ek condition follow karne wali cells ginta hai.'),
  const ExcelFunction(name: 'COUNTIFS', category: 'Statistical', syntax: 'COUNTIFS(range1,criteria1,...)', description: 'Multiple conditions ke basis par ginta hai.'),
  const ExcelFunction(name: 'MIN', category: 'Statistical', syntax: 'MIN(range)', description: 'Range me sabse chhota number deta hai.'),
  const ExcelFunction(name: 'MAX', category: 'Statistical', syntax: 'MAX(range)', description: 'Range me sabse bada number deta hai.'),
  const ExcelFunction(name: 'MEDIAN', category: 'Statistical', syntax: 'MEDIAN(range)', description: 'Range ki middle value (madhya) nikalta hai.'),
  const ExcelFunction(name: 'MODE', category: 'Statistical', syntax: 'MODE.SNGL(range)', description: 'Range me sabse zyada baar aane wali value deta hai.'),
  const ExcelFunction(name: 'STDEV', category: 'Statistical', syntax: 'STDEV.S(range)', description: 'Data ka standard deviation (spread) nikalta hai.'),
  const ExcelFunction(name: 'LARGE', category: 'Statistical', syntax: 'LARGE(range,k)', description: 'Range ki k-wi sabse badi value deta hai.'),
  const ExcelFunction(name: 'SMALL', category: 'Statistical', syntax: 'SMALL(range,k)', description: 'Range ki k-wi sabse chhoti value deta hai.'),
  const ExcelFunction(name: 'RANK', category: 'Statistical', syntax: 'RANK.EQ(number,range)', description: 'Range me kisi number ki rank (position) deta hai.'),

  // Logical
  const ExcelFunction(name: 'IF', category: 'Logical', syntax: 'IF(condition,true_value,false_value)', description: 'Condition ke sahi/galat hone par alag value deta hai.'),
  const ExcelFunction(name: 'IFS', category: 'Logical', syntax: 'IFS(cond1,val1,cond2,val2,...)', description: 'Multiple conditions ek saath check karta hai — nested IF se simple.'),
  const ExcelFunction(name: 'AND', category: 'Logical', syntax: 'AND(condition1,condition2,...)', description: 'Sabhi conditions sahi hon tabhi TRUE deta hai.'),
  const ExcelFunction(name: 'OR', category: 'Logical', syntax: 'OR(condition1,condition2,...)', description: 'Koi bhi ek condition sahi ho to TRUE deta hai.'),
  const ExcelFunction(name: 'NOT', category: 'Logical', syntax: 'NOT(condition)', description: 'Condition ka ulta result deta hai.'),
  const ExcelFunction(name: 'IFERROR', category: 'Logical', syntax: 'IFERROR(value,value_if_error)', description: 'Formula me error aaye to custom message dikhata hai.'),
  const ExcelFunction(name: 'IFNA', category: 'Logical', syntax: 'IFNA(value,value_if_na)', description: '#N/A error ke liye specifically custom message dikhata hai.'),
  const ExcelFunction(name: 'ISERROR', category: 'Logical', syntax: 'ISERROR(value)', description: 'Value error hai ya nahi, TRUE/FALSE me batata hai.'),
  const ExcelFunction(name: 'ISBLANK', category: 'Logical', syntax: 'ISBLANK(cell)', description: 'Cell khali hai ya nahi check karta hai.'),
  const ExcelFunction(name: 'ISNUMBER', category: 'Logical', syntax: 'ISNUMBER(value)', description: 'Value number hai ya nahi check karta hai.'),

  // Text
  const ExcelFunction(name: 'CONCATENATE', category: 'Text', syntax: 'CONCATENATE(text1,text2,...)', description: 'Multiple text values ko jodta hai.'),
  const ExcelFunction(name: 'TEXTJOIN', category: 'Text', syntax: 'TEXTJOIN(delimiter,ignore_empty,range)', description: 'Ek separator ke saath range ke text values jodta hai.'),
  const ExcelFunction(name: 'LEFT', category: 'Text', syntax: 'LEFT(text,num_chars)', description: 'Text ke shuru se diye gaye characters nikalta hai.'),
  const ExcelFunction(name: 'RIGHT', category: 'Text', syntax: 'RIGHT(text,num_chars)', description: 'Text ke end se diye gaye characters nikalta hai.'),
  const ExcelFunction(name: 'MID', category: 'Text', syntax: 'MID(text,start,num_chars)', description: 'Text ke beech se diye gaye characters nikalta hai.'),
  const ExcelFunction(name: 'LEN', category: 'Text', syntax: 'LEN(text)', description: 'Text me kitne characters hain, ginta hai.'),
  const ExcelFunction(name: 'TRIM', category: 'Text', syntax: 'TRIM(text)', description: 'Text ke extra spaces hata deta hai.'),
  const ExcelFunction(name: 'UPPER', category: 'Text', syntax: 'UPPER(text)', description: 'Text ko CAPITAL letters me badalta hai.'),
  const ExcelFunction(name: 'LOWER', category: 'Text', syntax: 'LOWER(text)', description: 'Text ko small letters me badalta hai.'),
  const ExcelFunction(name: 'PROPER', category: 'Text', syntax: 'PROPER(text)', description: 'Har word ka pehla letter capital karta hai.'),
  const ExcelFunction(name: 'SUBSTITUTE', category: 'Text', syntax: 'SUBSTITUTE(text,old,new)', description: 'Text ke andar ek word/character ko dusre se replace karta hai.'),
  const ExcelFunction(name: 'REPLACE', category: 'Text', syntax: 'REPLACE(old_text,start,num_chars,new_text)', description: 'Position ke basis par text replace karta hai.'),
  const ExcelFunction(name: 'FIND', category: 'Text', syntax: 'FIND(find_text,within_text)', description: 'Ek text ke andar dusre text ki position dhundta hai (case-sensitive).'),
  const ExcelFunction(name: 'TEXT', category: 'Text', syntax: 'TEXT(value,format)', description: 'Number/date ko custom format wale text me badalta hai.'),
  const ExcelFunction(name: 'VALUE', category: 'Text', syntax: 'VALUE(text)', description: 'Number jaisa dikhne wale text ko real number me badalta hai.'),

  // Date & Time
  const ExcelFunction(name: 'TODAY', category: 'Date & Time', syntax: 'TODAY()', description: 'Aaj ki date deta hai.'),
  const ExcelFunction(name: 'NOW', category: 'Date & Time', syntax: 'NOW()', description: 'Aaj ki date aur current time deta hai.'),
  const ExcelFunction(name: 'DATE', category: 'Date & Time', syntax: 'DATE(year,month,day)', description: 'Diye gaye year/month/day se ek date banata hai.'),
  const ExcelFunction(name: 'DATEDIF', category: 'Date & Time', syntax: 'DATEDIF(start,end,unit)', description: 'Do dates ke beech ka gap (din/mahine/saal) nikalta hai.'),
  const ExcelFunction(name: 'EDATE', category: 'Date & Time', syntax: 'EDATE(start_date,months)', description: 'Kisi date se diye gaye months aage/peeche ki date deta hai.'),
  const ExcelFunction(name: 'EOMONTH', category: 'Date & Time', syntax: 'EOMONTH(start_date,months)', description: 'Kisi mahine ka last date deta hai.'),
  const ExcelFunction(name: 'WEEKDAY', category: 'Date & Time', syntax: 'WEEKDAY(date)', description: 'Date kis din (1-7) padti hai, batata hai.'),
  const ExcelFunction(name: 'NETWORKDAYS', category: 'Date & Time', syntax: 'NETWORKDAYS(start,end)', description: 'Do dates ke beech ke working days (weekends chhod kar) ginta hai.'),
  const ExcelFunction(name: 'YEAR', category: 'Date & Time', syntax: 'YEAR(date)', description: 'Date me se sirf saal nikalta hai.'),
  const ExcelFunction(name: 'MONTH', category: 'Date & Time', syntax: 'MONTH(date)', description: 'Date me se sirf mahina nikalta hai.'),
  const ExcelFunction(name: 'DAY', category: 'Date & Time', syntax: 'DAY(date)', description: 'Date me se sirf din nikalta hai.'),

  // Lookup & Reference
  const ExcelFunction(name: 'VLOOKUP', category: 'Lookup', syntax: 'VLOOKUP(value,table,col_index,exact)', description: 'Table ke pehle column me value dhundh kar dusre column ka data laata hai.'),
  const ExcelFunction(name: 'HLOOKUP', category: 'Lookup', syntax: 'HLOOKUP(value,table,row_index,exact)', description: 'VLOOKUP jaisa hi lekin horizontally search karta hai.'),
  const ExcelFunction(name: 'XLOOKUP', category: 'Lookup', syntax: 'XLOOKUP(value,lookup_array,return_array)', description: 'VLOOKUP ka modern, zyada flexible replacement.'),
  const ExcelFunction(name: 'INDEX', category: 'Lookup', syntax: 'INDEX(range,row,column)', description: 'Position number ke basis par range me se value nikalta hai.'),
  const ExcelFunction(name: 'MATCH', category: 'Lookup', syntax: 'MATCH(value,range,match_type)', description: 'Range me kisi value ki position (row number) dhundta hai.'),
  const ExcelFunction(name: 'CHOOSE', category: 'Lookup', syntax: 'CHOOSE(index,value1,value2,...)', description: 'Index number ke basis par list me se ek value choose karta hai.'),
  const ExcelFunction(name: 'OFFSET', category: 'Lookup', syntax: 'OFFSET(reference,rows,cols)', description: 'Kisi cell se diye gaye rows/columns door ka cell reference deta hai.'),
  const ExcelFunction(name: 'INDIRECT', category: 'Lookup', syntax: 'INDIRECT(ref_text)', description: 'Text ke roop me likhe reference ko actual cell reference me badalta hai.'),

  // Financial
  const ExcelFunction(name: 'PMT', category: 'Financial', syntax: 'PMT(rate,nper,pv)', description: 'Loan ki fixed monthly EMI calculate karta hai.'),
  const ExcelFunction(name: 'FV', category: 'Financial', syntax: 'FV(rate,nper,pmt)', description: 'Regular investment ki future value nikalta hai.'),
  const ExcelFunction(name: 'PV', category: 'Financial', syntax: 'PV(rate,nper,pmt)', description: 'Future paisa aaj ke hisaab se kitna value ka hai, batata hai.'),
  const ExcelFunction(name: 'NPER', category: 'Financial', syntax: 'NPER(rate,pmt,pv)', description: 'Loan/investment ko poora hone me kitne periods lagenge, batata hai.'),
  const ExcelFunction(name: 'RATE', category: 'Financial', syntax: 'RATE(nper,pmt,pv)', description: 'Loan/investment ka interest rate nikalta hai.'),

  // Information
  const ExcelFunction(name: 'CELL', category: 'Information', syntax: 'CELL(info_type,reference)', description: 'Cell ke baare me jaankari (format, address, etc.) deta hai.'),
  const ExcelFunction(name: 'ISTEXT', category: 'Information', syntax: 'ISTEXT(value)', description: 'Value text hai ya nahi check karta hai.'),
  const ExcelFunction(name: 'TYPE', category: 'Information', syntax: 'TYPE(value)', description: 'Value ka data-type (number/text/etc.) batata hai.'),
];
