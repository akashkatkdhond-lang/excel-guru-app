/// One tip shown on the Home screen as "Formula of the Day" — rotates
/// automatically based on the day of the year, so it's the same for
/// everyone on a given day without needing a server.
class FormulaTip {
  final String formula;
  final String tip;

  const FormulaTip({required this.formula, required this.tip});
}

final List<FormulaTip> formulaTips = [
  const FormulaTip(
    formula: '=TRIM(A1)',
    tip: 'Text ke aage-peeche ke extra spaces hata deta hai — messy data clean karne ke liye best.',
  ),
  const FormulaTip(
    formula: '=UNIQUE(A1:A10)',
    tip: 'Ek list me se sirf unique (bina repeat wale) values nikal deta hai.',
  ),
  const FormulaTip(
    formula: 'Ctrl + T',
    tip: 'Kisi bhi data range ko turant ek proper "Table" bana deta hai — filters, formatting auto ho jate hain.',
  ),
  const FormulaTip(
    formula: '=IFERROR(A1/B1,"Error")',
    tip: 'Agar formula me error aaye (jaise divide by zero), to custom message dikhata hai, #DIV/0! nahi.',
  ),
  const FormulaTip(
    formula: '=TEXT(A1,"dd-mm-yyyy")',
    tip: 'Kisi date ko apne pasand ke format me text ki tarah dikhata hai.',
  ),
  const FormulaTip(
    formula: 'F4',
    tip: 'Cell reference me \$ sign turant add/remove karne ke liye — Absolute reference banane ka fastest tarika.',
  ),
  const FormulaTip(
    formula: '=COUNTIF(A1:A10,">50")',
    tip: 'Range me kitni values ek condition follow karti hain, wo ginta hai.',
  ),
  const FormulaTip(
    formula: 'Alt + Enter',
    tip: 'Ek hi cell ke andar naya line/paragraph shuru karne ke liye.',
  ),
  const FormulaTip(
    formula: '=SUMIF(A1:A10,"Delhi",B1:B10)',
    tip: 'Condition ke hisaab se sirf matching rows ka total nikalta hai — jaise sirf "Delhi" wali sales jodna.',
  ),
  const FormulaTip(
    formula: 'Ctrl + Shift + L',
    tip: 'Selected data par turant Filter arrows laga/hata deta hai.',
  ),
];

/// Picks today's tip deterministically from the day-of-year.
FormulaTip todaysFormulaTip() {
  final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  return formulaTips[dayOfYear % formulaTips.length];
}
