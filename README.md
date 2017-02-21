# README #

`BoolEval` is a Mathematica package that helps evaluate conditional expressions on numerical arrays, or filter numerical arrays based on conditions.  Is does this without unpacking packed arrays and offers a significant speedup over `Select` and `Cases` while maintaining convenient notation.  It is particularly useful in conjunction with `Listable` functions.

See the included notebook file for usage examples.

Inspiration: http://mathematica.stackexchange.com/q/2821/12

### Installation

Simply drop [BoolEval.m](https://bitbucket.org/szhorvat/booleval/raw/32f0c87fc507d99980d5ed36c8d8cc2fd1dce4fa/BoolEval.m) in the directory opened by

    SystemOpen@FileNameJoin[{$UserBaseDirectory, "Applications"}]

then load it as

    << BoolEval`

### Possible issues

Within `BoolEval`, the meaning of relational operators (`>`, `>=`, `==`, etc.) and logical operators (`&&`, `||`, `!`) is overloaded.  Avoid using program code within `BoolEval` itself.

Thus the following will fail (without errors):

    BoolEval[
     Select[Range[100], OddQ[#] || # == 2 &] < 10
    ]

Instead compute the array first:

    array = Select[Range[100], OddQ[#] || # == 2 &];

And use it in `BoolEval` afterwards:

    BoolEval[array < 10]

This slight inconvenience is necessitated by the tendency of `Greater`, `Less`, etc. to trigger unpacking.

### Feedback

Feedback is welcome at `szhorvat at gmail.com`.
