(* Mathematica Package *)
(* :Context: BoolEval` *)
(* :Author: szhorvat *)
(* :Date: 2014-05-30 *)

BeginPackage["BoolEval`"]
(* Exported symbols added here with SymbolName::usage *)

BoolEval::usage = "BoolEval[array > value] replaces elements of the numerical array 'array' which are greater than 'value' with 1, and the rest with 0.
BoolEval[condition] takes a condition expressed in terms of >, >=, <, <=, ==, != and logical operators, and evaluates it for each element of the arrays appearing in the condition. The result is returned as a Boolean array of 0s and 1s."
BoolPick::usage = "BoolPick[array, condition] will return the elements of a numerical array for which condition is True."
BoolCount::usage = "BoolCount[condition] counts the number of elements satisfying the array condition."

Begin["`Private`"] (* Begin Private Context *)

greatereq[a_, b_] := UnitStep[a - b]
lesseq[a_, b_] := UnitStep[b - a]
greater[a_, b_] := 1 - lesseq[a, b]
less[a_, b_] := 1 - greatereq[a, b]
unequal[a_, b_] := Unitize[a - b]
equal[a_, b_] := 1 - unequal[a, b]

equal[a_, b_, c__] := equal[a, b] equal[b, c]
less[a_, b_, c__] := less[a, b] less[b, c]
greater[a_, b_, c__] := greater[a, b] greater[b, c]
lesseq[a_, b_, c__] := lesseq[a, b] lesseq[b, c]
greatereq[a_, b_, c__] := greatereq[a, b] greatereq[b, c]

unequal[a__] := Times @@ (unequal @@@ Subsets[{a}, {2}])

rules = Dispatch[
  {arr_ ? ArrayQ :> arr,
    Less -> less, LessEqual -> lesseq,
    Greater -> greater, GreaterEqual -> greatereq,
    Equal -> equal, Unequal -> unequal,
    Or -> (Unitize@Plus[##]&), And -> Times, Not -> (1 - # &),
    True -> 1, False -> 0}
  ];


BoolEval[condition_] := condition /. rules

BoolPick[array_, condition_] :=
    Pick[array,
      BoolEval[condition],
      1
    ]

BoolCount[condition_] := Total@BoolEval[condition]

End[] (* End Private Context *)

EndPackage[]