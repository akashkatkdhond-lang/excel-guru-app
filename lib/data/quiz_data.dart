import '../models/quiz_question.dart';

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
];
