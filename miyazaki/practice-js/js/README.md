# javascript
This directory is for practice ``javascript``.

## memorandum

### global function

#### ``parseInt``

convert str into int.
```
parseInt(str)
parseInt(str, int)   // the second argument is a cardinal number.

parseInt("10")       // -> 10
parseInt("2019year") // -> 2019
parseInt("-77point") // -> -77
parseInt("Book170")  // -> Nan (Initial char is not number.)
parseInt("11", 2)    // -> 3
parseInt("11", 8)    // -> 9
parseInt("11", 10)   // -> 11
```

#### ``parseFlot``

convert str into number.
```
parseFlot(str)

parseFloat("10")       // -> 10
parseFloat("2019year") // -> 2019
parseFloat("-77point") // -> -77
parseFloat("18.26B")   // -> 18.26
parseFloat("2.4e-3")   // -> 0.0024
parseFloat("book170")  // -> NAN
```

### Number class

#### The property of Number constructor function

```
Number.NaN               // 非数
Number.POSITIVE_INFINITY // 正の無限大
Number.NEGATIVE_INFINITY // 負の無限大
Number.MAX_VALUE         // 表現可能な最大の値
Number.MIN_VALU          // 表現可能な最小の値
```

#### ``toFixed``
convert the object of Number Class into number, specifing a number of decimal places.

```
toFixed(int)

var num_obj = new Number(15.784);

var str1    = num_obj.toFixed(0); // 16
var str2    = num_obj.toFixed(2); // 15.78
var str3    = num_obj.toFixed(4); // 15.7840
```

#### toPrecision
convert the object of Number Class into number, specifing a significant figure.

```
var num_obj = new Number(176.54);

var str1    = num_obj.toExponential(1); // 2e+2
var str2    = num_obj.toExponential(4); // 176.5
var str3    = num_obj.toExponential(7); // 176.5400
```

### dialog

#### prompt
get the text input by user.

```
rsl = propmt('showed text', 'init text');
```

### DOM (Document Object Model)
DOM is the API for taking in HTML or XML.

#### getElementByTagName
Returns a NodeList of all the Elements with a given tag name in the
order in which they would be encountered in a preorder traversal of
the Document tree.
