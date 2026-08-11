import '../models/mistake_challenge.dart';

/// Curated "Spot the Mistake" rounds. Free mini-game, quick 30-second
/// engagement break between lessons.
final List<MistakeChallenge> mistakeChallenges = [
  const MistakeChallenge(
    scenario: 'B1 se B10 tak numbers hain. User total nikalna chahta hai.',
    shownFormula: '=SUM(B1:B10',
    options: ['Range galat hai', 'Closing bracket ")" missing hai', 'SUM ki jagah AVERAGE hona chahiye', 'Koi mistake nahi'],
    correctIndex: 1,
    explanation: 'Formula ke end me ")" nahi hai — Excel #NAME? ya error dikhayega. Har opening bracket ka closing bracket zaroori hai.',
  ),
  const MistakeChallenge(
    scenario: 'A1 me "10" text ke roop me type kiya gaya hai (left-aligned dikh raha hai), B1 me =A1+5 likha hai.',
    shownFormula: '=A1+5',
    options: ['Formula sahi hai', 'A1 me number text ki tarah stored hai, result galat aa sakta hai', 'B1 khali hona chahiye', '+5 galat hai'],
    correctIndex: 1,
    explanation: 'Agar number text format me hai (left-aligned), to kabhi-kabhi calculations me dikkat aati hai. Cell ko "Number" format me convert karna better hai.',
  ),
  const MistakeChallenge(
    scenario: 'User IF formula se Pass/Fail check kar raha hai: agar marks 40 se zyada hon to Pass.',
    shownFormula: '=IF(A1>40,Pass,Fail)',
    options: ['Formula sahi hai', '"Pass" aur "Fail" ke around quotes missing hain', '>40 galat hai', 'IF ki jagah AND chahiye'],
    correctIndex: 1,
    explanation: 'Text values ko formula me hamesha double quotes me likhna padta hai: "Pass" aur "Fail". Bina quotes ke Excel unhe cell names samajh kar #NAME? error dega.',
  ),
  const MistakeChallenge(
    scenario: 'User A1:A10 me se sirf "Delhi" wali sales jodna chahta hai.',
    shownFormula: '=SUMIF(A1:A10,Delhi,B1:B10)',
    options: ['SUMIF ki jagah SUM likhna tha', '"Delhi" ko quotes me likhna zaroori tha', 'Range B1:B10 galat hai', 'Formula bilkul sahi hai'],
    correctIndex: 1,
    explanation: 'Criteria "Delhi" ek text value hai, isliye quotes me likhna zaroori hai: SUMIF(A1:A10,"Delhi",B1:B10).',
  ),
  const MistakeChallenge(
    scenario: 'User ek formula ko B1 se B10 tak copy karta hai. Har row me A1 ki value use honi chahiye (fixed rehna chahiye), lekin copy karne par reference badal jaata hai.',
    shownFormula: '=A1*B1',
    options: ['Formula me \$ sign missing hai — \$A\$1 hona chahiye', 'B1 ki jagah B2 hona chahiye', 'Multiplication galat hai', 'Koi mistake nahi'],
    correctIndex: 0,
    explanation: 'Jab kisi cell ko fixed rakhna ho (copy karne par bhi na badle), to Absolute Reference (\$A\$1) use karte hain — F4 dabakar turant lagta hai.',
  ),
  const MistakeChallenge(
    scenario: 'User VLOOKUP se ek naam dhundh raha hai, lekin result hamesha #N/A aata hai — jabki naam table me maujood hai.',
    shownFormula: '=VLOOKUP(A2,B:D,2,TRUE)',
    options: ['Range galat hai', 'Last argument TRUE ki jagah FALSE hona chahiye (exact match)', 'Column index galat hai', 'VLOOKUP hi galat function hai'],
    correctIndex: 1,
    explanation: 'TRUE ka matlab hai "approximate match" jo sorted data expect karta hai. Exact naam dhundhne ke liye FALSE use karna chahiye.',
  ),
  const MistakeChallenge(
    scenario: 'User do numbers divide kar raha hai, lekin dusra number kabhi-kabhi 0 hota hai aur error aa jaata hai.',
    shownFormula: '=A1/B1',
    options: ['Formula galat hai', 'IFERROR use karke error ko handle karna chahiye', 'A1/B1 ki jagah B1/A1 hona chahiye', 'Division sign galat hai'],
    correctIndex: 1,
    explanation: '=IFERROR(A1/B1,"Error") likhne se agar B1 0 ho to #DIV/0! ki jagah custom message dikhega, crash jaisa nahi lagega.',
  ),
  const MistakeChallenge(
    scenario: 'User COUNTIF se 50 se zyada wali cells ginna chahta hai.',
    shownFormula: '=COUNTIF(A1:A10,>50)',
    options: ['Range galat hai', 'Criteria ">50" ko quotes me likhna zaroori tha', 'COUNTIF ki jagah COUNT chahiye', 'Formula sahi hai'],
    correctIndex: 1,
    explanation: 'Comparison operators wale criteria ko bhi quotes me likhna padta hai: COUNTIF(A1:A10,">50").',
  ),
];
