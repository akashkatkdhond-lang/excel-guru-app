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
      QuizQuestion(
        question: 'सरळ A1 cell वर जाण्यासाठी कोणता shortcut आहे?',
        options: ['Ctrl+Home', 'Ctrl+End', 'Ctrl+A', 'F2'],
        correctIndex: 0,
        explanation: 'Ctrl+Home नेहमी सरळ A1 वर घेऊन जातो.',
      ),
      QuizQuestion(
        question: 'Excel file चा default modern format काय आहे?',
        options: ['.doc', '.xlsx', '.pdf', '.txt'],
        correctIndex: 1,
        explanation: '.xlsx 2007 पासून Excel चा standard file format आहे.',
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
      QuizQuestion(
        question: '=ROUND(4.567,1) चा result काय असेल?',
        options: ['4.5', '4.6', '4.57', '5'],
        correctIndex: 1,
        explanation: '1 decimal place पर्यंत round केल्यावर 4.567 → 4.6 होतो.',
      ),
      QuizQuestion(
        question: '=TODAY() formula काय देतो?',
        options: ['कालची date', 'आजची date', 'File create झाल्याची date', 'एक random date'],
        correctIndex: 1,
        explanation: 'TODAY() दर वेळी file उघडल्यावर आजची current date देतो.',
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
    id: 'lookup_quiz',
    title: '🔍 Lookup Functions Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'VLOOKUP मधील "V" चा अर्थ काय आहे?',
        options: ['Value', 'Vertical', 'Variable', 'Verify'],
        correctIndex: 1,
        explanation: 'VLOOKUP = Vertical Lookup — column मध्ये खालच्या दिशेने search करतो.',
      ),
      QuizQuestion(
        question: 'VLOOKUP मध्ये exact match साठी शेवटचा argument काय असावा?',
        options: ['TRUE', 'FALSE', '0', 'दोन्ही TRUE आणि 0'],
        correctIndex: 3,
        explanation: 'FALSE आणि 0 दोन्हीने exact match मिळतो — TRUE approximate match देतो.',
      ),
      QuizQuestion(
        question: 'INDEX-MATCH, VLOOKUP पेक्षा चांगला का मानला जातो?',
        options: [
          'कारण लिहायला छोटा आहे',
          'कारण डावी-उजवी दोन्ही दिशेने शोधू शकतो',
          'कारण फक्त text साठी काम करतो',
          'काहीच फायदा नाही',
        ],
        correctIndex: 1,
        explanation: 'VLOOKUP फक्त उजव्या बाजूचे columns बघतो, INDEX-MATCH कोणत्याही दिशेने शोधू शकतो.',
      ),
      QuizQuestion(
        question: 'VLOOKUP ला value सापडली नाही तर कोणता error देतो?',
        options: ['#DIV/0!', '#N/A', '#REF!', '#NAME?'],
        correctIndex: 1,
        explanation: '#N/A म्हणजे "value not available" — table मध्ये match सापडला नाही.',
      ),
    ],
  ),
  QuizSet(
    id: 'shortcuts_quiz',
    title: '⌨️ Shortcuts Quiz',
    questions: const [
      QuizQuestion(
        question: 'संपूर्ण column select करण्यासाठी कोणता shortcut आहे?',
        options: ['Ctrl+Space', 'Shift+Space', 'Ctrl+A', 'Alt+Space'],
        correctIndex: 0,
        explanation: 'Ctrl+Space संपूर्ण column select करतो, Shift+Space संपूर्ण row.',
      ),
      QuizQuestion(
        question: 'Cell reference lock ( \$A\$1 ) करण्यासाठी कोणती key दाबतात?',
        options: ['F2', 'F4', 'F5', 'F9'],
        correctIndex: 1,
        explanation: 'F4 दाबल्याने \$ signs आपोआप add होतात.',
      ),
      QuizQuestion(
        question: 'Cell ला edit mode मध्ये उघडण्यासाठी कोणती key?',
        options: ['F1', 'F2', 'F3', 'F4'],
        correctIndex: 1,
        explanation: 'F2 दाबल्याने selected cell edit mode मध्ये उघडतो.',
      ),
      QuizQuestion(
        question: 'AutoSum लगेच लावण्याचा shortcut काय आहे?',
        options: ['Ctrl+=', 'Alt+=', 'Shift+=', 'Ctrl+Shift+='],
        correctIndex: 1,
        explanation: 'Alt+= select केलेल्या range चा लगेच SUM formula बनवतो.',
      ),
    ],
  ),
  QuizSet(
    id: 'conditional_formatting_quiz',
    title: '🎨 Conditional Formatting Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Conditional Formatting काय करतो?',
        options: [
          'Cells ला condition नुसार automatic color/highlight करतो',
          'फक्त font size बदलतो',
          'File ला password protect करतो',
          'Formula लपवतो',
        ],
        correctIndex: 0,
        explanation: 'हा एका rule नुसार cells ला आपोआप highlight करतो.',
      ),
      QuizQuestion(
        question: 'Numbers ला त्यांच्या value नुसार gradient color देण्यासाठी कोणता option वापरतात?',
        options: ['Data Bars', 'Color Scales', 'Icon Sets', 'Cell Styles'],
        correctIndex: 1,
        explanation: 'Color Scales लहान-मोठ्या numbers ला फिकट-गडद रंगात दाखवतो.',
      ),
      QuizQuestion(
        question: 'Cell च्या आत mini bar chart दाखवणारा option काय म्हणतात?',
        options: ['Color Scales', 'Icon Sets', 'Data Bars', 'Sparklines'],
        correctIndex: 2,
        explanation: 'Data Bars प्रत्येक cell मध्ये value च्या प्रमाणात एक bar दाखवतात.',
      ),
      QuizQuestion(
        question: 'संपूर्ण row highlight करण्यासाठी custom rule मध्ये reference कसं लिहावं?',
        options: ['\$B2 (column lock)', 'B\$2 (row lock)', 'B2 (दोन्ही relative)', '\$B\$2 (दोन्ही lock)'],
        correctIndex: 0,
        explanation: 'Column lock (\$B2) केल्याने row मधले सर्व cells एकाच column (B) ला check करतात, म्हणून संपूर्ण row highlight होते.',
      ),
    ],
  ),
  QuizSet(
    id: 'data_cleaning_quiz',
    title: '🧹 Data Cleaning Quiz',
    isPremium: true,
    questions: const [
      QuizQuestion(
        question: 'Data Validation ने dropdown list बनवण्याचा मुख्य फायदा काय?',
        options: [
          'Sheet colorful बनवते',
          'Data entry errors कमी करते',
          'File size छोटी करते',
          'Print speed वाढवते',
        ],
        correctIndex: 1,
        explanation: 'जेव्हा user फक्त list मधून निवडू शकतो, तेव्हा typing errors होत नाहीत.',
      ),
      QuizQuestion(
        question: 'Remove Duplicates वापरण्यापूर्वी काय करावं?',
        options: ['डेटाची backup ठेवावी', 'File delete करावी', 'Sheet rename करावी', 'काहीच नाही'],
        correctIndex: 0,
        explanation: 'Duplicates काढणे permanent असू शकतं, म्हणून backup ठेवणं सुरक्षित आहे.',
      ),
      QuizQuestion(
        question: '=IFERROR(A1/B1,"N/A") — जर B1 रिकामा (0) असेल तर काय दिसेल?',
        options: ['#DIV/0!', 'N/A', 'Blank', 'Error message crash'],
        correctIndex: 1,
        explanation: 'IFERROR ने #DIV/0! error पकडून "N/A" custom message दाखवला.',
      ),
      QuizQuestion(
        question: 'एका column च्या text ला comma ने split करून वेगळे columns बनवण्यासाठी काय वापरतात?',
        options: ['Remove Duplicates', 'Data Validation', 'Text to Columns', 'Conditional Formatting'],
        correctIndex: 2,
        explanation: 'Text to Columns एका column च्या डेटाला delimiter (comma/space) नुसार split करतो.',
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
