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
      ),
      LessonSection(
        heading: 'Cell Reference',
        content:
            'प्रत्येक cell चा स्वतःचा पत्ता असतो — Column letter + Row number. जसे पहिला column A, '
            'पहिली row 1, तर त्यांचा cell "A1" म्हणतात.',
        formulaExample: 'A1, B2, C10',
      ),
      LessonSection(
        heading: 'Sheet आणि Workbook',
        content:
            'एका Workbook (file) मध्ये अनेक Sheets असू शकतात (खाली tabs दिसतात). प्रत्येक sheet '
            'स्वतःचा वेगळा डेटा ठेवू शकते.',
      ),
    ],
  ),
  Lesson(
    id: 'basic_formulas',
    title: 'मूलभूत Formulas',
    subtitle: 'SUM, AVERAGE, MIN, MAX, COUNT',
    icon: '➕',
    sections: const [
      LessonSection(
        heading: 'Formula कसं लिहायचं',
        content:
            'Excel मध्ये प्रत्येक formula "=" (equal to) चिन्हाने सुरू होतो. जसं A1 आणि A2 जोडायचं '
            'असेल तर लिहू =A1+A2',
        formulaExample: '=A1+A2',
      ),
      LessonSection(
        heading: 'SUM — बेरीज करणे',
        content: 'SUM function एका range मधल्या सर्व numbers ची बेरीज करतो.',
        formulaExample: '=SUM(A1:A5)',
      ),
      LessonSection(
        heading: 'AVERAGE — सरासरी काढणे',
        content: 'AVERAGE range मधल्या numbers ची सरासरी (mean) काढतो.',
        formulaExample: '=AVERAGE(A1:A5)',
      ),
      LessonSection(
        heading: 'MIN आणि MAX',
        content: 'MIN सगळ्यात लहान number आणि MAX सगळ्यात मोठा number देतो.',
        formulaExample: '=MIN(A1:A5)   =MAX(A1:A5)',
      ),
      LessonSection(
        heading: 'COUNT',
        content: 'COUNT range मध्ये किती numbers आहेत ते मोजतो.',
        formulaExample: '=COUNT(A1:A5)',
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
      ),
      LessonSection(
        heading: 'AND / OR सोबत IF',
        content:
            'एकाच वेळी अनेक conditions तपासण्यासाठी AND (दोन्ही बरोबर असायला हवं) आणि OR '
            '(कोणतंही एक बरोबर असावं) वापरतात.',
        formulaExample: '=IF(AND(A1>40,B1>40),"Pass","Fail")',
      ),
      LessonSection(
        heading: 'Nested IF',
        content:
            'एका IF च्या आत दुसरा IF लावून grading सारखा multi-level result काढता येतो.',
        formulaExample: '=IF(A1>=90,"A",IF(A1>=75,"B","C"))',
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
      ),
      LessonSection(
        heading: 'HLOOKUP',
        content:
            'HLOOKUP तेच काम करतो पण horizontally — पहिल्या row मध्ये शोधून खालच्या row मधून '
            'value आणतो.',
        formulaExample: '=HLOOKUP(A2,D1:H10,3,FALSE)',
      ),
      LessonSection(
        heading: 'INDEX + MATCH',
        content:
            'INDEX-MATCH VLOOKUP पेक्षा जास्त flexible आहे — डावी-उजवी दोन्ही दिशेने शोधू शकतो '
            'आणि speed मध्ये सुद्धा चांगला असतो.',
        formulaExample: '=INDEX(C:C,MATCH(A2,B:B,0))',
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
      ),
      LessonSection(
        heading: 'LEFT, RIGHT, MID',
        content: 'Text मधून specific characters काढण्यासाठी.',
        formulaExample: '=LEFT(A1,3)   =RIGHT(A1,4)   =MID(A1,2,3)',
      ),
      LessonSection(
        heading: 'TODAY आणि DATE',
        content: 'आजची date किंवा एखादी specific date काढण्यासाठी.',
        formulaExample: '=TODAY()   =DATE(2026,8,9)',
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
      ),
      LessonSection(
        heading: 'Pivot Table म्हणजे काय',
        content:
            'Pivot Table मोठ्या डेटाचा summary करून पटकन analyze करण्याचं सगळ्यात powerful '
            'साधन आहे — group by, total, average सगळं drag-drop ने होतं.',
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
      ),
      LessonSection(
        heading: 'Formula Shortcuts',
        content:
            'F2 ने cell edit, F4 ने cell reference lock ( \$A\$1 ), Alt+= ने auto SUM, '
            'Ctrl+` ने formulas show/hide.',
      ),
    ],
  ),
];
