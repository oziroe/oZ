;
; example/00-return42.oz
; The very first oz source code. Return 42 to system.
;
; Created by oziroe on July 19, 2017.
; Last modified by oziroe on July 23, 2017.
;

Main(argv: >>Char): Int
    return AbsAdd(-40, 2)

AbsAdd(x: Int, y: Int): Int
    if x * y >= 0
        return x + y
    else
        return -(x + y)
