import '../models/lesson.dart';

/// Marathi translation of [lessons] in lessons_data.dart. Keep the SAME
/// ids, order and isPremium flags as the Hinglish version — screens key
/// off id, so a mismatch here would break progress tracking.
final List<Lesson> lessonsMarathi = [
  Lesson(
    id: 'basics',
    title: 'Excel च्या मूलभूत गोष्टी',
    subtitle: 'Cell, Row, Column आणि Sheet समजून घ्या',
    icon: '📊',
    sections: const [
      LessonSection(
        heading: 'Excel म्हणजे काय?',
        content:
            'Microsoft Excel हे एक स्प्रेडशीट सॉफ्टवेअर आहे ज्यामध्ये डेटा rows आणि columns च्या '
            'ग्रिडमध्ये साठवून त्याची गणना, विश्लेषण आणि सादरीकरण केले जाते. प्रत्येक बॉक्सला "Cell" म्हणतात.',
        funFact: 'Excel 1985 मध्ये लाँच झाला — आजही 38+ वर्षांनंतर हे जगातील #1 स्प्रेडशीट टूल आहे!',
      ),
      LessonSection(
        heading: 'Cell Reference',
        content:
            'प्रत्येक cell चा स्वतःचा पत्ता असतो — Column letter + Row number. जसे पहिला column A, '
            'पहिली row 1, तर त्यांचा cell "A1" म्हणतात.',
        formulaExample: 'A1, B2, C10',
        funFact: 'Excel ला एक शहर समजा — Column letters "रस्ते" आहेत आणि Row numbers "घर क्रमांक"!',
      ),
      LessonSection(
        heading: 'Sheet आणि Workbook',
        content:
            'एका Workbook (file) मध्ये अनेक Sheets असू शकतात (खाली tabs दिसतात). प्रत्येक sheet '
            'स्वतःचा वेगळा डेटा ठेवू शकते.',
        funFact: 'Workbook म्हणजे एक "पुस्तक" आणि Sheets म्हणजे त्याची "पाने" — प्रत्येक महिन्याचा डेटा वेगळ्या sheet मध्ये ठेवता येतो.',
      ),
      LessonSection(
        heading: 'Ribbon आणि Tabs',
        content:
            'सगळ्यात वर Home, Insert, Page Layout, Formulas, Data, Review, View असे tabs असतात — '
            'प्रत्येक tab मध्ये संबंधित tools group करून ठेवलेले असतात.',
        funFact: 'Ribbon Ctrl+F1 ने लपवू/दाखवू शकता — जास्त screen space हवी असल्यास वापरून पहा!',
      ),
      LessonSection(
        heading: 'Rows आणि Columns ची Limit',
        content:
            'एका sheet मध्ये 10 लाखांपेक्षा जास्त rows (1,048,576) आणि 16,384 columns (A ते XFD) असतात.',
        funFact: 'एका सेकंदाला एक row भरली तरी सर्व rows भरायला 12 दिवस लागतील!',
      ),
      LessonSection(
        heading: 'Data Types आपोआप ओळखले जातात',
        content:
            'Text नेहमी left-align होतो, numbers आणि dates right-align होतात — काहीही न करता Excel स्वतः ओळखतो.',
        funFact: 'Number left-align दिसत असेल तर तो प्रत्यक्षात "text" आहे, number नाही — यामुळे formulas मध्ये चुकीचा result येऊ शकतो!',
      ),
      LessonSection(
        heading: 'File Save करणे',
        content:
            'Ctrl+S ने save होतं. Excel file चा format ".xlsx" असतो. नवीन नावाने save करण्यासाठी "Save As" (F12) वापरा.',
        funFact: 'जुन्या .xls format ची फक्त 65,536 rows ची limit होती — 2007 मध्ये .xlsx आल्यावर ही limit 16 पटीने वाढली!',
      ),
      LessonSection(
        heading: 'Status Bar — Quick Calculation',
        content:
            'Cells select करताच खाली Status Bar मध्ये लगेच Sum, Average, Count दिसतं — formula न लिहिता quick check साठी.',
        funFact: 'Status bar वर right-click करून तुम्ही Min, Max किंवा इतर कोणती value दाखवायची ते निवडू शकता.',
      ),
      LessonSection(
        heading: 'Navigation Shortcuts',
        content:
            'Ctrl+Home ने सरळ A1 वर जातो. Ctrl+End ने डेटाच्या शेवटच्या cell पर्यंत पोहोचतो.',
        funFact: 'मोठ्या sheets मध्ये scroll करण्याऐवजी Ctrl+End वापरून पहा — डेटा कुठपर्यंत आहे लगेच कळेल.',
      ),
    ],
  ),
  Lesson(
    id: 'basic_formulas',
    title: 'मूलभूत Formulas',
    subtitle: 'SUM, AVERAGE, MIN, MAX, COUNT आणि अजून',
    icon: '➕',
    sections: const [
      LessonSection(
        heading: 'Formula कसं लिहायचं',
        content:
            'Excel मध्ये प्रत्येक formula "=" (equal to) चिन्हाने सुरू होतो. जसं A1 आणि A2 जोडायचं '
            'असेल तर लिहू =A1+A2',
        formulaExample: '=A1+A2',
        funFact: '"=" विसरलात तर Excel त्याला फक्त text समजेल, calculate करणार नाही — ही सर्वात common चूक आहे!',
      ),
      LessonSection(
        heading: 'SUM — बेरीज करणे',
        content: 'SUM function एका range मधल्या सर्व numbers ची बेरीज करतो.',
        formulaExample: '=SUM(A1:A5)',
        funFact: 'Ribbon मधील "AutoSum" (Σ) बटणाने एका click मध्ये SUM formula तयार होतो — Alt+= shortcut सुद्धा वापरून पहा!',
      ),
      LessonSection(
        heading: 'AVERAGE — सरासरी काढणे',
        content: 'AVERAGE range मधल्या numbers ची सरासरी (mean) काढतो.',
        formulaExample: '=AVERAGE(A1:A5)',
        funFact: 'AVERAGE रिकाम्या cells कडे दुर्लक्ष करतो, पण 0 असलेल्या cells ला count करतो — हा फरक result बदलू शकतो!',
      ),
      LessonSection(
        heading: 'MIN आणि MAX',
        content: 'MIN सगळ्यात लहान number आणि MAX सगळ्यात मोठा number देतो.',
        formulaExample: '=MIN(A1:A5)   =MAX(A1:A5)',
        funFact: 'Sales report मध्ये MAX ने "best month" आणि MIN ने "worst month" एका सेकंदात काढता येतो.',
      ),
      LessonSection(
        heading: 'COUNT',
        content: 'COUNT range मध्ये किती numbers आहेत ते मोजतो.',
        formulaExample: '=COUNT(A1:A5)',
        funFact: 'COUNT फक्त numbers मोजतो — text किंवा रिकाम्या cells साठी COUNTA वापरा.',
      ),
      LessonSection(
        heading: 'ROUND — Decimal Control',
        content: 'ROUND number ला दिलेल्या decimal places पर्यंत round करतो — bill/invoice बनवताना खूप उपयोगी.',
        formulaExample: '=ROUND(A1,2)',
        funFact: '=ROUND(A1,-2) ने 100 पर्यंत सुद्धा round करता येतं — जसं 1234 → 1200!',
      ),
      LessonSection(
        heading: 'TODAY आणि Simple Date Math',
        content: 'TODAY() आजची date देतो — यामुळे वय, deadline days सहज काढता येतात.',
        formulaExample: '=TODAY()   =TODAY()-A1',
        funFact: 'Excel मध्ये dates म्हणजे प्रत्यक्षात numbers असतात — म्हणूनच dates वरही गणित करता येतं!',
      ),
      LessonSection(
        heading: 'Text जोडणे — & Symbol',
        content: 'दोन cells चा text जोडण्यासाठी "&" चिन्ह वापरतात — जसं पहिलं नाव आणि आडनाव जोडणे.',
        formulaExample: '=A1&" "&B1',
        funFact: 'CONCATENATE function सुद्धा तेच काम करतो, पण "&" जास्त popular आहे कारण तो छोटा आणि जलद आहे.',
      ),
    ],
  ),
  Lesson(
    id: 'logical',
    title: 'Logical Functions',
    subtitle: 'IF, AND, OR ने conditions लावा',
    icon: '🧠',
    sections: const [
      LessonSection(
        heading: 'IF Function',
        content:
            'IF एक condition तपासतो — जर TRUE असेल तर एक value, जर FALSE असेल तर दुसरी '
            'value देतो.',
        formulaExample: '=IF(A1>50,"Pass","Fail")',
        funFact: 'IF ला "जर-तर-नाहीतर" सारखं समजा — रोजच्या आयुष्यातल्या निर्णयांसारखंच!',
      ),
      LessonSection(
        heading: 'AND / OR सोबत IF',
        content:
            'एकाच वेळी अनेक conditions तपासण्यासाठी AND (दोन्ही बरोबर असायला हवं) आणि OR '
            '(कोणतंही एक बरोबर असावं) वापरतात.',
        formulaExample: '=IF(AND(A1>40,B1>40),"Pass","Fail")',
        funFact: 'AND एक strict teacher सारखा आहे — सगळं बरोबर हवं. OR एक relaxed teacher सारखा आहे!',
      ),
      LessonSection(
        heading: 'Nested IF',
        content:
            'एका IF च्या आत दुसरा IF लावून grading सारखा multi-level result काढता येतो.',
        formulaExample: '=IF(A1>=90,"A",IF(A1>=75,"B","C"))',
        funFact: 'खूप जास्त Nested IF वापरल्यास formula वाचणं कठीण होतं — professionals IFS function वापरतात.',
      ),
    ],
  ),
  Lesson(
    id: 'lookup',
    title: 'Lookup Functions',
    subtitle: 'VLOOKUP, INDEX-MATCH ने डेटा शोधा',
    icon: '🔍',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'VLOOKUP',
        content:
            'VLOOKUP एखादी value टेबलच्या पहिल्या column मध्ये शोधून त्याच row मधून दुसऱ्या '
            'column चा डेटा आणतो. Reports बनवताना खूप common आहे.',
        formulaExample: '=VLOOKUP(A2,\$D\$2:\$F\$100,3,FALSE)',
        funFact: 'Job interviews मध्ये VLOOKUP सर्वात जास्त विचारला जाणारा Excel topic आहे!',
      ),
      LessonSection(
        heading: 'HLOOKUP',
        content:
            'HLOOKUP तेच काम करतो पण horizontally — पहिल्या row मध्ये शोधून खालच्या row मधून '
            'value आणतो.',
        formulaExample: '=HLOOKUP(A2,D1:H10,3,FALSE)',
        funFact: 'HLOOKUP कमी वापरला जातो कारण बहुतांश डेटा vertically organize केलेला असतो.',
      ),
      LessonSection(
        heading: 'INDEX + MATCH',
        content:
            'INDEX-MATCH VLOOKUP पेक्षा जास्त flexible आहे — डावी-उजवी दोन्ही दिशेने शोधू शकतो '
            'आणि speed मध्येही चांगला असतो.',
        formulaExample: '=INDEX(C:C,MATCH(A2,B:B,0))',
        funFact: 'मोठ्या कंपन्यांमध्ये Excel experts नेहमी INDEX-MATCH ला प्राधान्य देतात.',
      ),
    ],
  ),
  Lesson(
    id: 'text_date',
    title: 'Text आणि Date Functions',
    subtitle: 'नाव, date आणि text manage करा',
    icon: '🔤',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'CONCATENATE / &',
        content: 'दोन किंवा जास्त text values जोडण्यासाठी.',
        formulaExample: '=A1&" "&B1   किंवा   =CONCATENATE(A1," ",B1)',
        funFact: 'नवीन Excel मध्ये TEXTJOIN function अजून चांगला आहे — संपूर्ण range एकत्र जोडू शकतो.',
      ),
      LessonSection(
        heading: 'LEFT, RIGHT, MID',
        content: 'Text मधून specific characters काढण्यासाठी.',
        formulaExample: '=LEFT(A1,3)   =RIGHT(A1,4)   =MID(A1,2,3)',
        funFact: 'Email ID मधून username काढणे, phone number मधून area code वेगळा करणे यासाठी हे खूप वापरले जातात.',
      ),
      LessonSection(
        heading: 'TODAY आणि DATE',
        content: 'आजची date किंवा एखादी specific date काढण्यासाठी.',
        formulaExample: '=TODAY()   =DATE(2026,8,9)',
        funFact: '=TODAY() दर वेळी file उघडल्यावर आपोआप update होतो — reports साठी perfect!',
      ),
    ],
  ),
  Lesson(
    id: 'charts_pivot',
    title: 'Charts आणि Pivot Tables',
    subtitle: 'डेटा visually समजावून सांगा',
    icon: '📈',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Chart कसा बनवायचा',
        content:
            'डेटा select करून Insert tab मध्ये Chart option ने Bar, Line, Pie सारखा chart '
            'एका click मध्ये बनतो.',
        funFact: 'सर्वात जलद मार्ग: डेटा select करा आणि Alt+F1 दाबा — लगेच default chart तयार होईल!',
      ),
      LessonSection(
        heading: 'Pivot Table म्हणजे काय',
        content:
            'Pivot Table मोठ्या डेटाचा summary करून पटकन analyze करण्याचं सगळ्यात powerful '
            'साधन आहे — group by, total, average सगळं drag-drop ने होतं.',
        funFact: 'Data analysts म्हणतात "Pivot Table शिका, Excel चं 80% काम झालं" — इतकं शक्तिशाली टूल आहे!',
      ),
    ],
  ),
  Lesson(
    id: 'shortcuts',
    title: 'Keyboard Shortcuts',
    subtitle: 'जलद काम करण्यासाठी आवश्यक shortcuts',
    icon: '⌨️',
    sections: const [
      LessonSection(
        heading: 'Basic Shortcuts',
        content:
            'Ctrl+C Copy, Ctrl+V Paste, Ctrl+Z Undo, Ctrl+S Save, Ctrl+Arrow ने डेटाच्या '
            'शेवटपर्यंत जाणे, Ctrl+Space ने पूर्ण column select.',
        funFact: 'Professionals mouse खूप कमी वापरतात — shortcuts मुळे काम 2-3 पट जलद होतं.',
      ),
      LessonSection(
        heading: 'Formula Shortcuts',
        content:
            'F2 ने cell edit, F4 ने cell reference lock ( \$A\$1 ), Alt+= ने auto SUM, '
            'Ctrl+` ने formulas show/hide.',
        funFact: 'Ctrl+` ने संपूर्ण sheet मध्ये formulas दिसू लागतात — कोणाची sheet check करण्यासाठी उपयोगी.',
      ),
      LessonSection(
        heading: 'Selection Shortcuts',
        content: 'Ctrl+A ने संपूर्ण sheet select, Shift+Space ने संपूर्ण row select, Ctrl+Shift+End ने डेटाच्या शेवटपर्यंत select.',
        funFact: 'Ctrl+Shift+Arrow एका फटक्यात संपूर्ण डेटा block select करतो — मोठ्या डेटासोबत काम करण्यासाठी must-know shortcut.',
      ),
    ],
  ),
  Lesson(
    id: 'conditional_formatting',
    title: 'Conditional Formatting',
    subtitle: 'डेटा रंगांनी जिवंत करा',
    icon: '🎨',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Conditional Formatting म्हणजे काय?',
        content:
            'एका rule नुसार cells automatically highlight/color होतात — जसं low sales ला '
            'red आणि high sales ला green दाखवणे, काहीही manually न करता.',
        funFact: 'मोठ्या Excel dashboards मध्ये दिसणारे colorful red-yellow-green cells हे सगळे Conditional Formatting ने बनतात!',
      ),
      LessonSection(
        heading: 'Color Scales',
        content:
            'Home tab → Conditional Formatting → Color Scales ने numbers त्यांच्या value नुसार gradient color मिळतो.',
        funFact: 'Heatmap सारखा effect बनवण्यासाठी Color Scales सर्वात popular मार्ग आहे — कोणताही formula न लिहिता!',
      ),
      LessonSection(
        heading: 'Data Bars',
        content:
            'प्रत्येक cell मध्ये एक mini bar chart दिसतो जो value च्या प्रमाणात लहान/मोठा असतो.',
      ),
      LessonSection(
        heading: 'Custom Formula Rule',
        content:
            'स्वतःचा formula लिहून खूप advanced highlighting सुद्धा बनू शकते — जसं Deadline '
            'column, आज पेक्षा आधी असेल तर संपूर्ण row red होणे.',
        formulaExample: '=\$B2<TODAY()',
        funFact: 'Custom formula rule ने तुम्ही संपूर्ण row एकत्र highlight करू शकता, फक्त एक cell नाही!',
      ),
    ],
  ),
  Lesson(
    id: 'data_cleaning',
    title: 'Data Cleaning आणि Validation',
    subtitle: 'गोंधळलेला डेटा स्वच्छ आणि error-free बनवा',
    icon: '🧹',
    isPremium: true,
    sections: const [
      LessonSection(
        heading: 'Data Validation — Dropdown List',
        content:
            'Data tab → Data Validation ने एका cell मध्ये फक्त predefined list मधूनच value '
            'निवडता येते — data entry मधल्या चुका कमी होतात.',
        funFact: '"Yes/No" किंवा "Delhi/Mumbai/Pune" सारख्या dropdown lists Excel मध्ये सहज बनवता येतात!',
      ),
      LessonSection(
        heading: 'Removing Duplicates',
        content:
            'Data tab → Remove Duplicates ने एका click मध्ये repeat होणाऱ्या rows आपोआप निघून जातात.',
        funFact: 'Remove Duplicates वापरण्यापूर्वी डेटाची backup copy ठेवा — risk टाळणे उत्तम!',
      ),
      LessonSection(
        heading: 'IFERROR ने Clean Sheets',
        content:
            'IFERROR formula मध्ये error आल्यावर crash दाखवण्याऐवजी custom message दाखवतो.',
        formulaExample: '=IFERROR(A1/B1,"N/A")',
        funFact: 'Job interview मध्ये sheet मध्ये उघड्या #DIV/0! किंवा #N/A errors "unprofessional" मानले जातात!',
      ),
      LessonSection(
        heading: 'Text to Columns',
        content:
            'एका column च्या text ला comma किंवा space च्या आधारावर अनेक columns मध्ये split '
            'करण्यासाठी Data tab → Text to Columns वापरतात.',
      ),
    ],
  ),
];
