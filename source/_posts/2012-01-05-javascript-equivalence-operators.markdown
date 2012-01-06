---
layout: post
title: "JavaScript Equivalence Operators"
date: 2012-01-05 22:06
comments: true
categories: javascript
---

JavaScript has two sets of equivalence operators. One set is type converting
while the other set is strict.

Here's a quick example that demonstrates these two types of operators:

``` javascript Equivalence operators in JavaScript
> var a = 4;
4
> var b = 4;
4
> var c = "4";
"4"
> a == b
true
> a === b
true
> a == c
true
// fails due to type mismatch
> a === c
false
```

The key point is noting that while `a == c` is true, `a === c` is false.

Why? When using the `==` operator the string `"4"` is type cast into a `4` 
which is compared to `4`. As `4` is equivalent to `4`, this evaluates to true.

However, when using the `===` operator the string `"4"` is directly compared to the
number `4`. This fails because a `String` is not equivalent to a `Number`.

Here are the specific rules that the JavaScript interpreter follows:

> If either operand is a number or a boolean, the operands are converted to
numbers if possible; else if either operand is a string, the other operand is
converted to a string if possible. If both operands are objects, then
JavaScript compares internal references which are equal when operands refer
to the same object in memory.
[Mozilla Developer Network][1]

So, if you're ever trying to figure out why a comparison is evaluating to
true when it should be evaluating to false, double check that you're not
accidentally type casting one of the operands.

Want to dive deeper? Check out these articles for even more information:

* [W3CSchools - JavaScript Comparison and Logical Operators][2]
* [MDN - Comparison operators][1]

[1]: https://developer.mozilla.org/en/JavaScript/Reference/Operators/Comparison_Operators
[2]: http://www.w3schools.com/Js/js_comparisons.asp
