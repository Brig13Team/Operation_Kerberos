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
//#define DEBUG_MODE_FULL
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
    0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391];

private _a0 = 0x67452301;
private _b0 = 0xEFCDAB89;
private _c0 = 0x98BADCFE;
private _d0 = 0x10325476;

// convert the array to bits and split into 512-Bit blocks
_value = (toArray _value);

private _bitArray = [];
private _temparray = [];
while {(count _value)>0} do {
    private _curVal = _value deleteAt 0;
    // convert into bits
    {
        If ((_curVal - _x)>0) then {
            _curVal = _curVal - _x;
            _temparray pushBack 1;
        }else{
            _temparray pushBack 0;
        };
        nil;
    } count [256,128,64,32,16,8,4,2,1]; // only 2^8 for ASCII needed
    // add the block, if it's greater than 512
    If (count _temparray == 512) then {
        _bitArray pushBack _temparray);
        _temparray = [];
    };
};

// add "1" and fill with "0" until it matches 512
_temparray pushBack 1;
while {_temparray < 512} do {
    _temparray pushBack 0;
};
_bitArray pushBack _temparray;


















//
