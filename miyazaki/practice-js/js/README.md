# js
This directory is for practice ``javascript``.

## memorandum

### global function

#### parseInt

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

#### parseFlot

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

