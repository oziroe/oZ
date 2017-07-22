;
; example/00-return42.oz
; The very first oz source code. Return 42 to system.
;
; Created by oziroe on July 19, 2017.
; Last modified by oziroe on July 22, 2017.
;

Main(argv: >>Char): Int =
    return Add(40, 2)

Add(x: Int, y: Int): Int =
    return x + y
