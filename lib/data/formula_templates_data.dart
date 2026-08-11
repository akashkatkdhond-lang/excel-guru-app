import '../models/formula_template.dart';

/// Guided formula templates for the Formula Builder Wizard — for
/// beginners who find typing raw formulas intimidating. Free feature.
final List<FormulaTemplate> formulaTemplates = [
  const FormulaTemplate(
    functionName: 'SUM',
    description: 'Numbers ki range ko jodta hai',
    template: '=SUM({0})',
    params: [FormulaParam(label: 'Range', hint: 'jaise A1:A10')],
  ),
  const FormulaTemplate(
    functionName: 'AVERAGE',
    description: 'Range ka average nikalta hai',
    template: '=AVERAGE({0})',
    params: [FormulaParam(label: 'Range', hint: 'jaise A1:A10')],
  ),
  const FormulaTemplate(
    functionName: 'IF',
    description: 'Condition check karke alag value deta hai',
    template: '=IF({0},"{1}","{2}")',
    params: [
      FormulaParam(label: 'Condition', hint: 'jaise A1>50'),
      FormulaParam(label: 'Agar TRUE ho', hint: 'jaise Pass'),
      FormulaParam(label: 'Agar FALSE ho', hint: 'jaise Fail'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'VLOOKUP',
    description: 'Table me value dhundh kar related data laata hai',
    template: '=VLOOKUP({0},{1},{2},FALSE)',
    params: [
      FormulaParam(label: 'Dhundhni wali value', hint: 'jaise A2'),
      FormulaParam(label: 'Table Range', hint: 'jaise D2:F100'),
      FormulaParam(label: 'Column Number', hint: 'jaise 3'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'COUNTIF',
    description: 'Condition follow karne wali cells ginta hai',
    template: '=COUNTIF({0},"{1}")',
    params: [
      FormulaParam(label: 'Range', hint: 'jaise A1:A10'),
      FormulaParam(label: 'Condition', hint: 'jaise >50 ya Delhi'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'SUMIF',
    description: 'Condition ke hisaab se total nikalta hai',
    template: '=SUMIF({0},"{1}",{2})',
    params: [
      FormulaParam(label: 'Condition Range', hint: 'jaise A1:A10'),
      FormulaParam(label: 'Condition', hint: 'jaise Delhi'),
      FormulaParam(label: 'Sum Range', hint: 'jaise B1:B10'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'CONCATENATE',
    description: 'Do text values ko jodta hai',
    template: '={0}&" "&{1}',
    params: [
      FormulaParam(label: 'Pehla Cell', hint: 'jaise A1'),
      FormulaParam(label: 'Dusra Cell', hint: 'jaise B1'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'ROUND',
    description: 'Number ko decimal places tak round karta hai',
    template: '=ROUND({0},{1})',
    params: [
      FormulaParam(label: 'Number/Cell', hint: 'jaise A1'),
      FormulaParam(label: 'Decimal Places', hint: 'jaise 2'),
    ],
  ),
  const FormulaTemplate(
    functionName: 'MIN / MAX',
    description: 'Range ka sabse chhota/bada number',
    template: '=MIN({0})   =MAX({0})',
    params: [FormulaParam(label: 'Range', hint: 'jaise A1:A10')],
  ),
  const FormulaTemplate(
    functionName: 'IFERROR',
    description: 'Error aane par custom message dikhata hai',
    template: '=IFERROR({0},"{1}")',
    params: [
      FormulaParam(label: 'Original Formula', hint: 'jaise A1/B1'),
      FormulaParam(label: 'Error Message', hint: 'jaise Error'),
    ],
  ),
];
