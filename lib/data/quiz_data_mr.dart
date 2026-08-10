import '../models/quiz_question.dart';

/// Marathi translation of [quizSets] in quiz_data.dart. Keep the SAME
/// ids and isPremium flags — ProgressService saves scores keyed by id.
final List<QuizSet> quizSetsMarathi = [
  QuizSet(
    id: 'basics_quiz',
    title: 'Excel मूलभूत Quiz',
    questions: const [
      QuizQuestion(
        question: 'Excel मध्ये प्रत्येक बॉक्सला काय म्हणतात?',
        options: ['Box', 'Cell', 'Grid', 'Frame'],
        correctIndex: 1,
        explanation: 'Row आणि Column च्या intersection ला Cell म्हणतात.',
      ),
      QuizQuestion(
        question: 'पहिल्या column A च्या पहिल्या row चा cell address काय असेल?',
        options: ['1A', 'A1', 'AA', 'A-1'],
        correctIndex: 1,
        explanation: 'Column letter आधी, मग row number — A1.',
      ),
      QuizQuestion(
        question: 'एका file (Workbook) मध्ये काय असू शकतं?',
        options: ['फक्त एक sheet', 'अनेक sheets', 'फक्त charts', 'कोणतीच sheet नाही'],
        correctIndex: 1,
        explanation: 'एका workbook मध्ये अनेक sheets add करता येतात.',
      ),
    ],
  ),
  QuizSet(
    id: 'formulas_quiz',
    title: 'मूलभूत Formulas Quiz',
    questions: const [
      QuizQuestion(
        question: 'प्रत्येक formula कोणत्या चिन्हाने सुरू होतो?',
        options: ['+', '=', '@', '#'],
        correctIndex: 1,
        explanation: 'Excel मध्ये formula नेहमी = ने सुरू होतो.',
      ),
      QuizQuestion(
        question: 'A1 ते A5 पर्यंतचे numbers जोडण्यासाठी योग्य formula कोणता?',
        options: ['=ADD(A1:A5)', '=SUM(A1:A5)', '=TOTAL(A1:A5)', '=PLUS(A1:A5)'],
        correctIndex: 1,
        explanation: 'SUM function range मधल्या numbers ची बेरीज करतो.',
      ),
      QuizQuestion(
        question: 'Range मध्ये सगळ्यात मोठा number काढण्यासाठी कोणता function?',
        options: ['=MIN()', '=MAX()', '=BIG()', '=TOP()'],
        correctIndex: 1,
        explanation: 'MAX function सगळ्यात मोठा number देतो.',
      ),
    ],
  ),
  QuizSet(
    id: 'logical_quiz',
    title: 'Logical Functions Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: '=IF(A1>50,"Pass","Fail") — जर A1 = 40 असेल तर result?',
        options: ['Pass', 'Fail', 'Error', 'Blank'],
        correctIndex: 1,
        explanation: '40, 50 पेक्षा लहान आहे म्हणून condition FALSE — "Fail" मिळेल.',
      ),
      QuizQuestion(
        question: 'AND function कधी TRUE देतो?',
        options: [
          'जेव्हा कोणतीही एक condition बरोबर असेल',
          'जेव्हा सर्व conditions बरोबर असतील',
          'नेहमी TRUE',
          'नेहमी FALSE',
        ],
        correctIndex: 1,
        explanation: 'AND तेव्हाच TRUE देतो जेव्हा सर्व conditions बरोबर असतात.',
      ),
    ],
  ),
  QuizSet(
    id: 'interview_quiz',
    title: '💼 Excel Interview प्रश्न',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Interview मध्ये विचारतात: VLOOKUP आणि INDEX-MATCH मध्ये काय फरक आहे?',
        options: [
          'काहीच फरक नाही',
          'INDEX-MATCH डाव्या बाजूच्या column मध्येही शोधू शकतो, VLOOKUP नाही',
          'VLOOKUP जास्त वेगवान आहे',
          'INDEX-MATCH फक्त text साठी आहे',
        ],
        correctIndex: 1,
        explanation:
            'VLOOKUP फक्त उजव्या बाजूच्या columns मध्ये शोधतो. INDEX-MATCH कोणत्याही दिशेने शोधू '
            'शकतो आणि performance मध्येही चांगला असतो.',
      ),
      QuizQuestion(
        question: 'Pivot Table कशासाठी वापरतात?',
        options: [
          'फक्त chart बनवण्यासाठी',
          'मोठ्या डेटाचा summary करून पटकन analyze करण्यासाठी',
          'फक्त print करण्यासाठी',
          'Formula लिहिण्यासाठी',
        ],
        correctIndex: 1,
        explanation: 'Pivot Table मोठ्या dataset ला group-by, total, average ने summarize करतो.',
      ),
      QuizQuestion(
        question: '\$A\$1 आणि A1 मध्ये काय फरक आहे?',
        options: [
          'काहीच फरक नाही',
          '\$A\$1 absolute reference आहे — copy केल्यावर fixed राहतो',
          'A1 फक्त numbers साठी आहे',
          '\$A\$1 फक्त headers साठी वापरतात',
        ],
        correctIndex: 1,
        explanation: '\$ चिन्ह लावल्याने reference "lock" होतो — formula copy केल्यावरही तोच cell refer करतो.',
      ),
      QuizQuestion(
        question: 'Conditional Formatting कशासाठी वापरतात?',
        options: [
          'Condition नुसार cells automatically highlight/color करण्यासाठी',
          'फक्त bold text साठी',
          'Formula लपवण्यासाठी',
          'File save करण्यासाठी',
        ],
        correctIndex: 0,
        explanation: 'जसं "sales 10000 पेक्षा कमी असेल तर लाल रंग" — डेटाचे patterns लगेच दिसतात.',
      ),
      QuizQuestion(
        question: 'Data Validation चा मुख्य उपयोग काय?',
        options: [
          'डेटा sort करणे',
          'Cell मध्ये फक्त specific प्रकारचा valid डेटा टाकू देणे (जसं dropdown list)',
          'डेटा delete करणे',
          'Chart बनवणे',
        ],
        correctIndex: 1,
        explanation: 'Data entry errors कमी करण्यासाठी — जसं फक्त dropdown मधूनच value निवडता यावी.',
      ),
    ],
  ),
];
