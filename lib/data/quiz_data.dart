import '../models/quiz_question.dart';
import '../services/language_service.dart';
import 'quiz_data_mr.dart';

/// Returns the quiz catalog in the requested language. Falls back to
/// the Hinglish (default) list for any language code other than Marathi.
List<QuizSet> quizSetsFor(String languageCode) {
  return languageCode == AppLanguage.marathi ? quizSetsMarathi : quizSets;
}

/// Quiz sets shown in the Quiz tab. Keep IDs stable — progress is saved
/// against them in [ProgressService].
final List<QuizSet> quizSets = [
  QuizSet(
    id: 'basics_quiz',
    title: 'Excel Basics Quiz',
    questions: const [
      QuizQuestion(
        question: 'Excel me har box ko kya kehte hain?',
        options: ['Box', 'Cell', 'Grid', 'Frame'],
        correctIndex: 1,
        explanation: 'Row aur Column ke intersection wale box ko Cell kehte hain.',
      ),
      QuizQuestion(
        question: 'Pehle column A ki pehli row ka cell address kya hoga?',
        options: ['1A', 'A1', 'AA', 'A-1'],
        correctIndex: 1,
        explanation: 'Column letter pehle, phir row number — A1.',
      ),
      QuizQuestion(
        question: 'Ek file (Workbook) me kya ho sakta hai?',
        options: [
          'Sirf ek sheet',
          'Multiple sheets',
          'Sirf charts',
          'Koi sheet nahi'
        ],
        correctIndex: 1,
        explanation: 'Ek workbook me multiple sheets add ki ja sakti hain.',
      ),
      QuizQuestion(
        question: 'Seedha A1 cell par jump karne ke liye kaunsa shortcut hai?',
        options: ['Ctrl+Home', 'Ctrl+End', 'Ctrl+A', 'F2'],
        correctIndex: 0,
        explanation: 'Ctrl+Home hamesha seedha A1 par le jaata hai — kitna bhi neeche/right ho.',
      ),
      QuizQuestion(
        question: 'Excel file ka default modern format kya hai?',
        options: ['.doc', '.xlsx', '.pdf', '.txt'],
        correctIndex: 1,
        explanation: '.xlsx 2007 se Excel ka standard file format hai.',
      ),
    ],
  ),
  QuizSet(
    id: 'formulas_quiz',
    title: 'Basic Formulas Quiz',
    questions: const [
      QuizQuestion(
        question: 'Har formula kis sign se shuru hota hai?',
        options: ['+', '=', '@', '#'],
        correctIndex: 1,
        explanation: 'Excel me formula hamesha = se shuru hota hai.',
      ),
      QuizQuestion(
        question: 'A1 se A5 tak ke numbers jodne ke liye sahi formula?',
        options: [
          '=ADD(A1:A5)',
          '=SUM(A1:A5)',
          '=TOTAL(A1:A5)',
          '=PLUS(A1:A5)'
        ],
        correctIndex: 1,
        explanation: 'SUM function range ke numbers ko add karta hai.',
      ),
      QuizQuestion(
        question: 'Range me sabse bada number nikalne ke liye kaunsa function?',
        options: ['=MIN()', '=MAX()', '=BIG()', '=TOP()'],
        correctIndex: 1,
        explanation: 'MAX function sabse bada number return karta hai.',
      ),
      QuizQuestion(
        question: '=ROUND(4.567,1) ka result kya hoga?',
        options: ['4.5', '4.6', '4.57', '5'],
        correctIndex: 1,
        explanation: '1 decimal place tak round karne par 4.567 → 4.6 ban jaata hai.',
      ),
      QuizQuestion(
        question: '=TODAY() formula kya deta hai?',
        options: ['Kal ki date', 'Aaj ki date', 'File create hone ki date', 'Ek random date'],
        correctIndex: 1,
        explanation: 'TODAY() har baar file kholne par aaj ki current date deta hai.',
      ),
    ],
  ),
  QuizSet(
    id: 'logical_quiz',
    title: 'Logical Functions Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: '=IF(A1>50,"Pass","Fail") — agar A1 = 40 hai to result?',
        options: ['Pass', 'Fail', 'Error', 'Blank'],
        correctIndex: 1,
        explanation: '40, 50 se chhota hai isliye condition FALSE — "Fail" milega.',
      ),
      QuizQuestion(
        question: 'AND function kab TRUE deta hai?',
        options: [
          'Jab koi ek condition sahi ho',
          'Jab sabhi conditions sahi hon',
          'Hamesha TRUE',
          'Hamesha FALSE'
        ],
        correctIndex: 1,
        explanation: 'AND tabhi TRUE deta hai jab sabhi conditions sahi hon.',
      ),
    ],
  ),
  QuizSet(
    id: 'lookup_quiz',
    title: '🔍 Lookup Functions Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'VLOOKUP me "V" ka matlab kya hai?',
        options: ['Value', 'Vertical', 'Variable', 'Verify'],
        correctIndex: 1,
        explanation: 'VLOOKUP = Vertical Lookup — column me neeche ki taraf search karta hai.',
      ),
      QuizQuestion(
        question: 'VLOOKUP me exact match ke liye last argument kya hona chahiye?',
        options: ['TRUE', 'FALSE', '0', 'Dono TRUE aur 0'],
        correctIndex: 3,
        explanation: 'FALSE aur 0 dono se exact match milta hai — TRUE approximate match deta hai.',
      ),
      QuizQuestion(
        question: 'INDEX-MATCH, VLOOKUP se better kyun mana jaata hai?',
        options: [
          'Kyunki likhna chhota hai',
          'Kyunki left-right dono direction me search kar sakta hai',
          'Kyunki sirf text ke liye kaam karta hai',
          'Koi fayda nahi hai',
        ],
        correctIndex: 1,
        explanation: 'VLOOKUP sirf right-side columns dekhta hai, INDEX-MATCH kisi bhi direction me search kar sakta hai.',
      ),
      QuizQuestion(
        question: 'Agar VLOOKUP ko value nahi milti, to kya error deta hai?',
        options: ['#DIV/0!', '#N/A', '#REF!', '#NAME?'],
        correctIndex: 1,
        explanation: '#N/A ka matlab hai "value not available" — table me match nahi mila.',
      ),
    ],
  ),
  QuizSet(
    id: 'shortcuts_quiz',
    title: '⌨️ Shortcuts Quiz',
    questions: const [
      QuizQuestion(
        question: 'Poora column select karne ke liye kaunsa shortcut hai?',
        options: ['Ctrl+Space', 'Shift+Space', 'Ctrl+A', 'Alt+Space'],
        correctIndex: 0,
        explanation: 'Ctrl+Space poora column select karta hai, Shift+Space poori row.',
      ),
      QuizQuestion(
        question: 'Cell ki reference lock karne ( \$A\$1 ) ke liye kaunsi key dabate hain?',
        options: ['F2', 'F4', 'F5', 'F9'],
        correctIndex: 1,
        explanation: 'F4 dabane se \$ signs automatically add ho jaate hain.',
      ),
      QuizQuestion(
        question: 'Cell ko edit mode me kholne ke liye kaunsi key?',
        options: ['F1', 'F2', 'F3', 'F4'],
        correctIndex: 1,
        explanation: 'F2 dabane se selected cell edit mode me khul jaata hai.',
      ),
      QuizQuestion(
        question: 'AutoSum turant lagane ka shortcut kya hai?',
        options: ['Ctrl+=', 'Alt+=', 'Shift+=', 'Ctrl+Shift+='],
        correctIndex: 1,
        explanation: 'Alt+= select ki hui range ka turant SUM formula bana deta hai.',
      ),
    ],
  ),
  QuizSet(
    id: 'conditional_formatting_quiz',
    title: '🎨 Conditional Formatting Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Conditional Formatting kya karta hai?',
        options: [
          'Cells ko condition ke basis par automatic color/highlight karta hai',
          'Sirf font size badalta hai',
          'File ko password protect karta hai',
          'Formula ko chhupata hai',
        ],
        correctIndex: 0,
        explanation: 'Yeh ek rule ke basis par cells ko automatically highlight karta hai.',
      ),
      QuizQuestion(
        question: 'Numbers ko unki value ke hisaab se gradient color dene ke liye kaunsa option use karte hain?',
        options: ['Data Bars', 'Color Scales', 'Icon Sets', 'Cell Styles'],
        correctIndex: 1,
        explanation: 'Color Scales chhote-bade numbers ko halke-gehre color me dikhata hai.',
      ),
      QuizQuestion(
        question: 'Cell ke andar mini bar chart dikhane wala option kya kehlaata hai?',
        options: ['Color Scales', 'Icon Sets', 'Data Bars', 'Sparklines'],
        correctIndex: 2,
        explanation: 'Data Bars har cell ke andar value ke proportion me ek bar dikhate hain.',
      ),
      QuizQuestion(
        question: 'Poori row highlight karne ke liye custom rule me reference kaise likhna chahiye?',
        options: ['\$B2 (column lock)', 'B\$2 (row lock)', 'B2 (dono relative)', '\$B\$2 (dono lock)'],
        correctIndex: 0,
        explanation: 'Column lock (\$B2) karne se row ke sabhi cells ek hi column (B) check karte hain, isliye poori row highlight hoti hai.',
      ),
    ],
  ),
  QuizSet(
    id: 'data_cleaning_quiz',
    title: '🧹 Data Cleaning Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Data Validation se dropdown list banane ka main fayda kya hai?',
        options: [
          'Sheet ko colorful banata hai',
          'Data entry errors kam karta hai',
          'File size chhota karta hai',
          'Print speed badhata hai',
        ],
        correctIndex: 1,
        explanation: 'Jab user sirf list se choose kar sakta hai, to typing errors nahi hote.',
      ),
      QuizQuestion(
        question: 'Remove Duplicates use karne se pehle kya karna chahiye?',
        options: ['Data ka backup rakhna', 'File delete karna', 'Sheet rename karna', 'Kuch nahi'],
        correctIndex: 0,
        explanation: 'Duplicates hatana permanent ho sakta hai, isliye backup rakhna safe practice hai.',
      ),
      QuizQuestion(
        question: '=IFERROR(A1/B1,"N/A") — agar B1 khali (0) ho to kya dikhega?',
        options: ['#DIV/0!', 'N/A', 'Blank', 'Error message crash'],
        correctIndex: 1,
        explanation: 'IFERROR ne #DIV/0! error ko pakad kar "N/A" custom message dikhaya.',
      ),
      QuizQuestion(
        question: 'Ek column ke text ko comma se split karke alag columns banane ke liye kya use karte hain?',
        options: ['Remove Duplicates', 'Data Validation', 'Text to Columns', 'Conditional Formatting'],
        correctIndex: 2,
        explanation: 'Text to Columns ek column ke data ko delimiter (comma/space) ke basis par split karta hai.',
      ),
    ],
  ),
  QuizSet(
    id: 'interview_quiz',
    title: '💼 Excel Interview Questions',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Interview me pucha jata hai: VLOOKUP aur INDEX-MATCH me kya difference hai?',
        options: [
          'Koi difference nahi',
          'INDEX-MATCH left side ke column bhi search kar sakta hai, VLOOKUP nahi',
          'VLOOKUP zyada fast hai',
          'INDEX-MATCH sirf text ke liye hai',
        ],
        correctIndex: 1,
        explanation:
            'VLOOKUP sirf right-side columns me search karta hai. INDEX-MATCH kisi bhi direction '
            'me search kar sakta hai aur performance me bhi better hota hai.',
      ),
      QuizQuestion(
        question: 'Pivot Table kis kaam ke liye use hoti hai?',
        options: [
          'Sirf chart banane ke liye',
          'Bade data ko quickly summarize aur analyze karne ke liye',
          'Sirf print karne ke liye',
          'Formula likhne ke liye',
        ],
        correctIndex: 1,
        explanation: 'Pivot Table bade dataset ko group-by, total, average se summarize karta hai — data analysis ka core skill.',
      ),
      QuizQuestion(
        question: '\$A\$1 aur A1 me kya farak hai?',
        options: [
          'Koi farak nahi',
          '\$A\$1 absolute reference hai — copy karne par fixed rehta hai',
          'A1 sirf numbers ke liye hai',
          '\$A\$1 sirf headers ke liye use hota hai',
        ],
        correctIndex: 1,
        explanation: '\$ sign lagane se reference "lock" ho jata hai — formula copy karne par bhi wahi cell refer karta hai.',
      ),
      QuizQuestion(
        question: 'Conditional Formatting kis liye use hoti hai?',
        options: [
          'Cells ko condition ke basis par automatically highlight/color karne ke liye',
          'Sirf bold text ke liye',
          'Formula chhupane ke liye',
          'File save karne ke liye',
        ],
        correctIndex: 0,
        explanation: 'Jaise "agar sales 10000 se kam hai to red color" — visually data patterns turant dikhte hain.',
      ),
      QuizQuestion(
        question: 'Data Validation ka main use kya hai?',
        options: [
          'Data ko sort karna',
          'Cell me sirf specific type ka valid data enter hone dena (jaise dropdown list)',
          'Data ko delete karna',
          'Chart banana',
        ],
        correctIndex: 1,
        explanation: 'Data entry errors kam karne ke liye — jaise sirf dropdown se hi value choose ho sake.',
      ),
    ],
  ),
];
