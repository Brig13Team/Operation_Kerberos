/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a checksum from a value
 *
 *  Parameter(s):
 *      ANY - any input
 *
 *  Returns:
 *      SCALAR - Checksum
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _value = If (IS_STRING(_this)) then {
    _this
} else {
    str _this
};

private _switches = [ 7, 12, 17, 22,  7, 12, 17, 22,  7, 12,
    17, 22,  7, 12, 17, 22,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
    5,  9, 14, 20,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11,
    16, 23,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21];

private _k = [ 0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
    0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501, 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
    0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821, 0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
    0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8, 0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
    0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a, 0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
    0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70, 0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
    0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665, 0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
    0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1, 0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
    0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391] apply {abs _x};

private _a0 = abs 0x67452301;
private _b0 = abs 0xEFCDAB89;
private _c0 = abs 0x98BADCFE;
private _d0 = abs 0x10325476;

// convert the array to bits and split into 512-Bit blocks
_value = (toArray _value);

private _bitArray = [];
private _temparray = [];
while {!(_value isEqualTo [])} do {
    // convert the text-value into bin
    private _curVal = [_value deleteAt 0,8] call FUNC(numberToBin);
    TRACEV_4(count _temparray,_temparray,_value,_curVal);
    _temparray append _curVal;
    // add the block, if it's greater than 512
    If (count _temparray >= 512) then {
        _bitArray pushBack (_temparray select [0,511]);
        _temparray = _temparray select [511,(count _temparray) -1];
    };
};

private _lenght = (count _bitArray) * 512 + count _temparray;

// add "1" and fill with "0" until it matches (512-64)
If (count _temparray < 447) then {
    _temparray pushBack true;
    while {count _temparray < 448} do {
        _temparray pushBack false;
    };
    // add the lenght
    _temparray append ([_lenght,64] call FUNC(numberToBin));
    _bitArray pushBack _temparray;
}else{
    _temparray pushBack true;
    while {count _temparray < 512} do {
        _temparray pushBack false;
    };
    _bitArray pushBack _temparray;
    _temparray = [];
    while {count _temparray < 448} do {
        _temparray pushBack false;
    };
    // add the lenght
    _temparray append ([_lenght,64] call FUNC(numberToBin));
    _bitArray pushBack _temparray;
};
TRACEV_2(_value,_bitArray);
{
    private _curBitArray = _x;

        private _words = [
            _curBitArray select [0,31],
            _curBitArray select [32,63],
            _curBitArray select [64,95],
            _curBitArray select [96,127],
            _curBitArray select [128,159],
            _curBitArray select [160,191],
            _curBitArray select [192,223],
            _curBitArray select [224,255],
            _curBitArray select [256,287],
            _curBitArray select [256,319],
            _curBitArray select [320,351],
            _curBitArray select [352,383],
            _curBitArray select [384,415],
            _curBitArray select [416,447],
            _curBitArray select [448,479],
            _curBitArray select [480,511]
        ];
        TRACEV_2(_curBitArray,_words);
        // init the value for this block
        private _A = _a0;
        private _B = _b0;
        private _C = _c0;
        private _D = _d0;
        // main loop
        for "_i" from 0 to 63 do {
            private _F = false;
            private _g = 0;
            switch (true) do {
                case (_forEachIndex < 16) : {
                    _F = [
                            ([_B,_C] call FUNC(BitAND)),
                            ([([_B,32] call FUNC(BitNOT)),_D] call FUNC(BitAND))
                        ] call FUNC(BitOR);

                    _g = _forEachIndex;
                };
                case (_forEachIndex < 32) : {
                    _F = [
                            ([_B,_D] call FUNC(BitAND)),
                            ([_C,([_D,32] call FUNC(BitNOT))] call FUNC(BitAND))
                        ] call FUNC(BitOR);
                    _g = (5*_forEachIndex+1)mod 16;
                };
                case (_forEachIndex < 48) : {
                    _F = [_B,([_C,_D] call FUNC(BitXOR))] call FUNC(BitXOR);
                    _g = (3*_forEachIndex+1)mod 16;
                };
                default {
                    _F = [_C,([_B,([_D,32] call FUNC(BitNOT))] call FUNC(BitOR))] call FUNC(BitXOR);
                    _g = (7*_forEachIndex)mod 16;
                };
            };
            TRACEV_6(_A,_B,_C,_D,_F,_i);
            if (_i == 0) then {test4 = _F};
            private _temp = _D;
            _D = _C;
            _C = _B;
            _value = _A + _F + (_k select _i) + ([(_words select _g)] call FUNC(BinToNumber));
            _value = [([abs _value,32] call FUNC(NumberToBin)),_switches select _i] call FUNC(arrayRotate);
            _B = _B + ([_value] call FUNC(BinToNumber));
            _A = _temp;
        };
        _a0 = _a0 + _A;
        _b0 = _b0 + _B;
        _c0 = _c0 + _C;
        _d0 = _d0 + _C;
} forEach _bitArray;

TRACEV_4(_a0,_b0,_c0,_d0);
TRACEV_4(_a0 toFixed 0,_b0 toFixed 0,_c0 toFixed 0,_d0 toFixed 0);

private _return = ([_a0,_b0,_c0,_d0] apply {[_x] call FUNC(NumberToHex)}) joinString "";
test3 = _return;
_return







//
