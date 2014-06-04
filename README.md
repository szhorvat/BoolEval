# README #

`BoolEval` is a Mathematica package that helps evaluate conditional expressions on arrays, or filter arrays based on conditions.  Is does this without unpacking packed arrays and offers a significant speedup over `Select` and `Cases` while maintaining convenient notation.  It is particularly useful in conjunction with `Listable` functions.

See the included notebook file for usage examples.

Inspiration: http://mathematica.stackexchange.com/q/2821/12

###Installation

Simply drop `BoolEval.m` in the directory opened by 

    SystemOpen@FileNameJoin[{$UserBaseDirectory, "Applications"}]

then load it as

    << BoolEval`