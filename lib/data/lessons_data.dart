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
      ),
      LessonSection(
        heading: 'Cell Reference',
        content:
            'Har cell ka apna address hota hai — Column letter + Row number. '
            'Jaise pehla column A, pehli row 1, to unka cell "A1" kehlata hai.',
        formulaExample: 'A1, B2, C10',
      ),
      LessonSection(
        heading: 'Sheet aur Workbook',
        content:
            'Ek Workbook (file) me multiple Sheets ho sakti hain (tabs neeche '
            'dikhte hain). Har sheet apna alag data rakh sakti hai.',
      ),
    ],
  ),
  Lesson(
    id: 'basic_formulas',
    title: 'Basic Formulas',
    subtitle: 'SUM, AVERAGE, MIN, MAX, COUNT',
    icon: '➕',
    sections: const [
      LessonSection(
        heading: 'Formula kaise likhein',
        content:
            'Excel me har formula "=" (equal to) sign se shuru hota hai. '
            'Jaise agar A1 aur A2 ko jodna hai to likhenge =A1+A2',
        formulaExample: '=A1+A2',
      ),
      LessonSection(
        heading: 'SUM — jodna',
        content: 'SUM function ek range ke sabhi numbers ko add karta hai.',
        formulaExample: '=SUM(A1:A5)',
      ),
      LessonSection(
        heading: 'AVERAGE — average nikalna',
        content: 'AVERAGE range ke numbers ka average (mean) nikalta hai.',
        formulaExample: '=AVERAGE(A1:A5)',
      ),
      LessonSection(
        heading: 'MIN aur MAX',
        content: 'MIN sabse chhota number aur MAX sabse bada number deta hai.',
        formulaExample: '=MIN(A1:A5)   =MAX(A1:A5)',
      ),
      LessonSection(
        heading: 'COUNT',
        content: 'COUNT range me kitne numbers hain, wo ginta hai.',
        formulaExample: '=COUNT(A1:A5)',
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
      ),
      LessonSection(
        heading: 'AND / OR ke saath IF',
        content:
            'Multiple conditions ek saath check karne ke liye AND (dono '
            'sahi hone chahiye) aur OR (koi ek sahi ho) use karte hain.',
        formulaExample: '=IF(AND(A1>40,B1>40),"Pass","Fail")',
      ),
      LessonSection(
        heading: 'Nested IF',
        content:
            'Ek IF ke andar dusra IF laga kar grading jaisa multi-level '
            'result nikala ja sakta hai.',
        formulaExample: '=IF(A1>=90,"A",IF(A1>=75,"B","C"))',
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
      ),
      LessonSection(
        heading: 'HLOOKUP',
        content:
            'HLOOKUP wahi kaam karta hai lekin horizontally — pehli row me '
            'dhundh kar neeche wali row se value laata hai.',
        formulaExample: '=HLOOKUP(A2,D1:H10,3,FALSE)',
      ),
      LessonSection(
        heading: 'INDEX + MATCH',
        content:
            'INDEX-MATCH VLOOKUP se zyada flexible hai — left-right dono '
            'direction me search kar sakta hai aur fast bhi hota hai.',
        formulaExample: '=INDEX(C:C,MATCH(A2,B:B,0))',
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
      ),
      LessonSection(
        heading: 'LEFT, RIGHT, MID',
        content: 'Text me se specific characters nikalne ke liye.',
        formulaExample: '=LEFT(A1,3)   =RIGHT(A1,4)   =MID(A1,2,3)',
      ),
      LessonSection(
        heading: 'TODAY aur DATE',
        content: 'Aaj ki date ya koi specific date nikalne ke liye.',
        formulaExample: '=TODAY()   =DATE(2026,8,9)',
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
      ),
      LessonSection(
        heading: 'Pivot Table kya hai',
        content:
            'Pivot Table bade data ko summarize karke quickly analyze karne '
            'ka sabse powerful tool hai — group by, total, average sab '
            'drag-drop se ho jata hai.',
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
      ),
      LessonSection(
        heading: 'Formula Shortcuts',
        content:
            'F2 se cell edit, F4 se cell reference lock ( \$A\$1 ), '
            'Alt+= se auto SUM, Ctrl+` se formulas show/hide.',
      ),
    ],
  ),
];
