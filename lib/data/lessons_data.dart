import '../models/lesson.dart';
import '../services/language_service.dart';
import 'lessons_data_mr.dart';

/// Returns the lesson catalog in the requested language. Falls back to
/// the Hinglish (default) list for any language code other than Marathi.
List<Lesson> lessonsFor(String languageCode) {
  return languageCode == AppLanguage.marathi ? lessonsMarathi : lessons;
}

/// All lesson content lives here. Add more Lesson entries to grow the course
/// catalog — no other file needs to change.
final List<Lesson> lessons = [
  Lesson(
    id: 'basics',
    title: 'Excel Basics',
    subtitle: 'Cell, Row, Column aur Sheet samjhein',
    icon: '📊',
    sections: const [
      LessonSection(
        heading: 'Excel kya hai?',
        content:
            'Microsoft Excel ek spreadsheet software hai jisme data ko rows '
            'aur columns ke grid me store karke calculate, analyze aur '
            'present kiya jata hai. Har box ko "Cell" kehte hain.',
        funFact: 'Excel 1985 me launch hua tha — aaj 38+ saal baad bhi yeh duniya ka #1 spreadsheet tool hai, kisi bhi office job me iske bina kaam nahi chalta!',
      ),
      LessonSection(
        heading: 'Cell Reference',
        content:
            'Har cell ka apna address hota hai — Column letter + Row number. '
            'Jaise pehla column A, pehli row 1, to unka cell "A1" kehlata hai.',
        formulaExample: 'A1, B2, C10',
        funFact: 'Socho Excel ek city hai — Column letters "streets" hain aur Row numbers "house numbers". A1 matlab "A Street ka Ghar No. 1"! 🏠',
      ),
      LessonSection(
        heading: 'Sheet aur Workbook',
        content:
            'Ek Workbook (file) me multiple Sheets ho sakti hain (tabs neeche '
            'dikhte hain). Har sheet apna alag data rakh sakti hai.',
        funFact: 'Ek Workbook ko ek "kitaab" samjho aur Sheets uske "pages" — Jan-Feb-Mar ke alag pages jaise, alag sheets me mahine ka data rakh sakte ho.',
      ),
      LessonSection(
        heading: 'Ribbon aur Tabs',
        content:
            'Sabse upar Home, Insert, Page Layout, Formulas, Data, Review, '
            'View jaise tabs hote hain — har tab me related tools group '
            'karke rakhe gaye hain. Home tab me formatting, Insert me '
            'charts/tables, Formulas me function options milte hain.',
        funFact: 'Ribbon ko Ctrl+F1 se chhupa/dikha sakte ho — extra screen space chahiye ho to try karo!',
      ),
      LessonSection(
        heading: 'Rows aur Columns ki Limit',
        content:
            'Ek sheet me 10 lakh se zyada rows (1,048,576) aur 16,384 '
            'columns hote hain (A se lekar XFD tak). Itna bada data ek hi '
            'sheet me store ho sakta hai.',
        funFact: 'Agar aap ek second me ek row fill karo, to sabhi 10+ lakh rows bharne me poore 12 din lag jayenge — kabhi khatam nahi hoga!',
      ),
      LessonSection(
        heading: 'Data Types Automatically Pehchane Jaate Hain',
        content:
            'Text hamesha left-align hota hai, numbers aur dates right-align '
            'hote hain — bina kuch kiye Excel khud pehchan leta hai ki aapne '
            'kya type kiya hai.',
        funFact: 'Agar number left-align dikhe, matlab wo asal me "text" hai, number nahi — isse formulas me galat result aa sakta hai!',
      ),
      LessonSection(
        heading: 'File Save Karna',
        content:
            'Ctrl+S se save hota hai. Excel file ka format ".xlsx" hota hai. '
            'Naye naam se ya alag jagah save karne ke liye "Save As" (F12) '
            'use karein.',
        funFact: 'Purane Excel (.xls) format ki 65,536 rows limit thi — 2007 me .xlsx aaya to yeh limit 16x badh gayi!',
      ),
      LessonSection(
        heading: 'Status Bar — Quick Calculation',
        content:
            'Kuch bhi cells select karte hi neeche Status Bar me turant '
            'Sum, Average, aur Count dikh jaata hai — bina koi formula '
            'likhe quick check karne ke liye.',
        funFact: 'Status bar par right-click karke aap yeh bhi choose kar sakte ho ki Min, Max, ya Sum me se kya dikhna chahiye.',
      ),
      LessonSection(
        heading: 'Navigation Shortcuts',
        content:
            'Ctrl+Home se seedha A1 par jump hota hai. Arrow keys se ek-ek '
            'cell move karte hain. Ctrl+End se data ke aakhri cell tak '
            'pahunch jaate hain.',
        funFact: 'Bade sheets me scroll karne ke bajaye Ctrl+End try karo — turant pata chal jayega data kahan tak hai.',
      ),
    ],
  ),
  Lesson(
    id: 'basic_formulas',
    title: 'Basic Formulas',
    subtitle: 'SUM, AVERAGE, MIN, MAX, COUNT aur aur bhi',
    icon: '➕',
    sections: const [
      LessonSection(
        heading: 'Formula kaise likhein',
        content:
            'Excel me har formula "=" (equal to) sign se shuru hota hai. '
            'Jaise agar A1 aur A2 ko jodna hai to likhenge =A1+A2',
        formulaExample: '=A1+A2',
        funFact: 'Agar "=" bhool gaye to Excel usse sirf text samjhega, calculate nahi karega — yeh sabse common beginner mistake hai!',
      ),
      LessonSection(
        heading: 'SUM — jodna',
        content: 'SUM function ek range ke sabhi numbers ko add karta hai.',
        formulaExample: '=SUM(A1:A5)',
        funFact: 'Ribbon me "AutoSum" (Σ symbol) button se ek click me SUM formula ban jaata hai — Alt+= shortcut bhi try karo!',
        animationKey: 'sum',
      ),
      LessonSection(
        heading: 'AVERAGE — average nikalna',
        content: 'AVERAGE range ke numbers ka average (mean) nikalta hai.',
        formulaExample: '=AVERAGE(A1:A5)',
        funFact: 'AVERAGE khali cells ko ignore karta hai, lekin 0 wale cells ko count karta hai — yeh farak result badal sakta hai!',
      ),
      LessonSection(
        heading: 'MIN aur MAX',
        content: 'MIN sabse chhota number aur MAX sabse bada number deta hai.',
        formulaExample: '=MIN(A1:A5)   =MAX(A1:A5)',
        funFact: 'Sales report me MAX se "best month" aur MIN se "worst month" ek second me nikal sakte ho.',
      ),
      LessonSection(
        heading: 'COUNT',
        content: 'COUNT range me kitne numbers hain, wo ginta hai.',
        formulaExample: '=COUNT(A1:A5)',
        funFact: 'COUNT sirf numbers ginta hai, text ya khali cells ko chhod deta hai — COUNTA use karo agar text bhi ginna ho.',
      ),
      LessonSection(
        heading: 'ROUND — Decimal Control',
        content: 'ROUND number ko diye gaye decimal places tak round kar deta hai — bill/invoice banate waqt bahut kaam aata hai.',
        formulaExample: '=ROUND(A1,2)',
        funFact: '=ROUND(A1,0) se poora decimal hata sakte ho, aur =ROUND(A1,-2) se 100s tak bhi round kar sakte ho — jaise 1234 → 1200!',
      ),
      LessonSection(
        heading: 'TODAY aur Simple Date Math',
        content: 'TODAY() aaj ki date deta hai — isse age, deadline days, ya kitne din bache hain, aasani se nikal sakte hain.',
        formulaExample: '=TODAY()   =TODAY()-A1',
        funFact: 'Excel me dates asal me numbers hote hain (1 Jan 1900 se ginti shuru hoti hai) — isi liye dates par bhi maths (jodna/ghatana) chal jaata hai!',
      ),
      LessonSection(
        heading: 'Text Jodna — & Symbol',
        content: 'Do cells ke text ko jodne ke liye "&" symbol use karte hain — jaise Pehla Naam aur Last Naam ko jodna.',
        formulaExample: '=A1&" "&B1',
        funFact: 'CONCATENATE function bhi wahi kaam karta hai jo "&" karta hai — lekin naye Excel me "&" zyada popular hai kyunki chhota aur fast hai.',
      ),
    ],
  ),
  Lesson(
    id: 'logical',
    title: 'Logical Functions',
    subtitle: 'IF, AND, OR se conditions lagayein',
    icon: '🧠',
    sections: const [
      LessonSection(
        heading: 'IF Function',
        content:
            'IF ek condition check karta hai — agar TRUE hai to ek value, '
            'agar FALSE hai to dusri value deta hai.',
        formulaExample: '=IF(A1>50,"Pass","Fail")',
        funFact: 'IF ko "agar-to-warna" ki tarah socho — bilkul waise hi jaise hum roz decisions lete hain: "Agar barish ho rahi hai to chhata lo, warna nahi".',
        animationKey: 'if',
      ),
      LessonSection(
        heading: 'AND / OR ke saath IF',
        content:
            'Multiple conditions ek saath check karne ke liye AND (dono '
            'sahi hone chahiye) aur OR (koi ek sahi ho) use karte hain.',
        formulaExample: '=IF(AND(A1>40,B1>40),"Pass","Fail")',
        funFact: 'AND ek strict teacher jaisa hai — sab kuch sahi chahiye. OR ek relaxed teacher jaisa hai — koi ek bhi sahi ho to chalega!',
      ),
      LessonSection(
        heading: 'Nested IF',
        content:
            'Ek IF ke andar dusra IF laga kar grading jaisa multi-level '
            'result nikala ja sakta hai.',
        formulaExample: '=IF(A1>=90,"A",IF(A1>=75,"B","C"))',
        funFact: 'Bahut zyada Nested IF (5+) formula ko padhna mushkil bana deta hai — professionals aksar IFS function use karte hain jo saaf aur simple hota hai.',
      ),
    ],
  ),
  Lesson(
    id: 'lookup',
    title: 'Lookup Functions',
    subtitle: 'VLOOKUP, INDEX-MATCH se data dhundhna',
    icon: '🔍',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'VLOOKUP',
        content:
            'VLOOKUP kisi value ko ek table ke pehle column me dhundh kar '
            'usi row se dusra column ka data laata hai. Bahut common hai '
            'reports banate waqt.',
        formulaExample: '=VLOOKUP(A2,\$D\$2:\$F\$100,3,FALSE)',
        funFact: 'VLOOKUP job interviews me sabse zyada pucha jaane wala Excel topic hai — ismein expert banna resume ko strong bana sakta hai!',
        animationKey: 'vlookup',
      ),
      LessonSection(
        heading: 'HLOOKUP',
        content:
            'HLOOKUP wahi kaam karta hai lekin horizontally — pehli row me '
            'dhundh kar neeche wali row se value laata hai.',
        formulaExample: '=HLOOKUP(A2,D1:H10,3,FALSE)',
        funFact: 'HLOOKUP kam use hota hai kyunki zyadatar data vertically (columns me) organize hota hai, horizontally nahi.',
      ),
      LessonSection(
        heading: 'INDEX + MATCH',
        content:
            'INDEX-MATCH VLOOKUP se zyada flexible hai — left-right dono '
            'direction me search kar sakta hai aur fast bhi hota hai.',
        formulaExample: '=INDEX(C:C,MATCH(A2,B:B,0))',
        funFact: 'Bade companies me Excel experts VLOOKUP ki jagah hamesha INDEX-MATCH prefer karte hain — bade data me yeh kaafi fast chalta hai.',
      ),
    ],
  ),
  Lesson(
    id: 'text_date',
    title: 'Text & Date Functions',
    subtitle: 'Naam, date aur text ko manage karein',
    icon: '🔤',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'CONCATENATE / &',
        content: 'Do ya zyada text values ko jodne ke liye.',
        formulaExample: '=A1&" "&B1   ya   =CONCATENATE(A1," ",B1)',
        funFact: 'Naye Excel versions me TEXTJOIN function aur bhi behtar hai — ek saath poori range jod sakta hai, ek-ek karke likhna nahi padta.',
      ),
      LessonSection(
        heading: 'LEFT, RIGHT, MID',
        content: 'Text me se specific characters nikalne ke liye.',
        formulaExample: '=LEFT(A1,3)   =RIGHT(A1,4)   =MID(A1,2,3)',
        funFact: 'Yeh functions email ID se username nikalne, phone number se area code alag karne jaise real kaam me bahut use hote hain.',
      ),
      LessonSection(
        heading: 'TODAY aur DATE',
        content: 'Aaj ki date ya koi specific date nikalne ke liye.',
        formulaExample: '=TODAY()   =DATE(2026,8,9)',
        funFact: '=TODAY() har baar file kholne par khud-ba-khud update ho jaata hai — isliye reports me hamesha "current date" dikhane ke liye perfect hai.',
      ),
    ],
  ),
  Lesson(
    id: 'charts_pivot',
    title: 'Charts & Pivot Tables',
    subtitle: 'Data ko visually samjhayein',
    icon: '📈',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Chart kaise banayein',
        content:
            'Data select karke Insert tab me Chart option se Bar, Line, Pie '
            'jaisa chart ek click me ban jata hai.',
        funFact: 'Sabse fast tarika: data select karo aur bas Alt+F1 dabao — turant default chart ban jaayega!',
      ),
      LessonSection(
        heading: 'Pivot Table kya hai',
        content:
            'Pivot Table bade data ko summarize karke quickly analyze karne '
            'ka sabse powerful tool hai — group by, total, average sab '
            'drag-drop se ho jata hai.',
        funFact: 'Data analysts kehte hain "Pivot Table seekh lo, Excel ka 80% kaam ho gaya" — yeh itna powerful tool hai!',
        animationKey: 'pivot',
      ),
    ],
  ),
  Lesson(
    id: 'shortcuts',
    title: 'Keyboard Shortcuts',
    subtitle: 'Fast kaam karne ke liye zaroori shortcuts',
    icon: '⌨️',
    sections: const [
      LessonSection(
        heading: 'Basic Shortcuts',
        content:
            'Ctrl+C Copy, Ctrl+V Paste, Ctrl+Z Undo, Ctrl+S Save, '
            'Ctrl+Arrow se data ke end tak jump, Ctrl+Space se poora column '
            'select.',
        funFact: 'Professionals mouse ka use bahut kam karte hain — shortcuts se kaam 2-3x fast ho jaata hai.',
      ),
      LessonSection(
        heading: 'Formula Shortcuts',
        content:
            'F2 se cell edit, F4 se cell reference lock ( \$A\$1 ), '
            'Alt+= se auto SUM, Ctrl+` se formulas show/hide.',
        funFact: 'Ctrl+` (backtick, number 1 ke bagal wali key) se poori sheet me formulas dikhne lagte hain — kisi ki sheet check karne ke liye bahut useful.',
      ),
      LessonSection(
        heading: 'Selection Shortcuts',
        content: 'Ctrl+A se poori sheet select, Shift+Space se poori row select, Ctrl+Shift+End se data ke last cell tak select.',
        funFact: 'Ctrl+Shift+Arrow ek hi jhatke me poora data block select kar deta hai — bade data ke saath kaam karne ke liye must-know shortcut.',
      ),
    ],
  ),
  Lesson(
    id: 'conditional_formatting',
    title: 'Conditional Formatting',
    subtitle: 'Data ko rangon se zinda karein',
    icon: '🎨',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Conditional Formatting kya hai?',
        content:
            'Ek rule ke basis par cells automatically highlight/color ho '
            'jaati hain — jaise low sales ko red aur high sales ko green '
            'dikhana, bina manually kuch kiye.',
        funFact: 'Bade Excel dashboards me jo colorful red-yellow-green cells dikhte hain, wo sab Conditional Formatting se banate hain!',
      ),
      LessonSection(
        heading: 'Color Scales',
        content:
            'Home tab → Conditional Formatting → Color Scales se numbers '
            'ko unki value ke hisaab se gradient color mil jaata hai — '
            'chhote number halka, bade number gehra rang.',
        funFact: 'Heatmap jaisa effect banane ke liye Color Scales sabse popular tarika hai — bina koi formula likhe!',
      ),
      LessonSection(
        heading: 'Data Bars',
        content:
            'Har cell ke andar ek mini bar chart dikh jaata hai jo value ke '
            'proportion me lamba/chhota hota hai — numbers ko visually '
            'compare karna aasan ho jaata hai.',
      ),
      LessonSection(
        heading: 'Custom Formula Rule',
        content:
            'Apna khud ka formula likh kar bahut advanced highlighting bhi '
            'ban sakti hai — jaise agar Deadline column, Today se pehle ho '
            'to poori row red ho jaaye.',
        formulaExample: '=\$B2<TODAY()',
        funFact: 'Custom formula rule se aap poori row ko ek saath highlight kar sakte ho, sirf ek cell ko nahi — bahut powerful trick hai!',
      ),
    ],
  ),
  Lesson(
    id: 'data_cleaning',
    title: 'Data Cleaning & Validation',
    subtitle: 'Messy data ko saaf aur error-free banayein',
    icon: '🧹',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Data Validation — Dropdown List',
        content:
            'Data tab → Data Validation se ek cell me sirf ek predefined '
            'list se hi value choose ho sakti hai — data entry me galtiyan '
            'kam ho jaati hain.',
        funFact: 'Google Forms jaise dropdown, Excel me bhi bilkul waise hi ban sakte hain — "Yes/No" ya "Delhi/Mumbai/Pune" jaisi lists banao!',
      ),
      LessonSection(
        heading: 'Removing Duplicates',
        content:
            'Data tab → Remove Duplicates se ek click me repeat hone wali '
            'rows automatically hat jaati hain — bade customer lists clean '
            'karne ke liye zaroori hai.',
        funFact: 'Kabhi bhi Remove Duplicates use karne se pehle data ka ek backup copy rakh lo — yeh action undo ho sakta hai lekin risk lena avoid karo!',
      ),
      LessonSection(
        heading: 'IFERROR se Clean Sheets',
        content:
            'IFERROR formula me error aane par crash dikhane ke bajaye '
            'custom message dikhata hai — professional dashboards me '
            'errors kabhi khule me nahi dikhte.',
        formulaExample: '=IFERROR(A1/B1,"N/A")',
        funFact: 'Job interview me agar aapki sheet me #DIV/0! ya #N/A errors khule dikhein, to yeh "unprofessional" maana jaata hai — IFERROR isse bachata hai.',
      ),
      LessonSection(
        heading: 'Text to Columns',
        content:
            'Ek column ke text ko comma ya space ke basis par multiple '
            'columns me split karne ke liye Data tab → Text to Columns '
            'use karte hain — jaise "Naam, Shehar" ko alag-alag karna.',
      ),
    ],
  ),
];
