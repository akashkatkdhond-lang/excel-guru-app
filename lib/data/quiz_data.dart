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
