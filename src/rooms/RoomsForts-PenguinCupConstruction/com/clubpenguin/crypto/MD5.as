class com.clubpenguin.crypto.MD5
{
    function MD5()
    {
    } // End of the function
    static function hash(str)
    {
        return (com.clubpenguin.crypto.MD5.hex_md5(str));
    } // End of the function
    static function utf8Encode(string)
    {
        var _loc6 = "";
        var _loc5;
        var _loc4;
        var _loc8 = 0;
        _loc4 = 0;
        _loc5 = 0;
        _loc8 = string.length;
        for (var _loc3 = 0; _loc3 < _loc8; ++_loc3)
        {
            var _loc1 = string.charCodeAt(_loc3);
            var _loc2 = null;
            if (_loc1 < 128)
            {
                ++_loc4;
            }
            else if (_loc1 > 127 && _loc1 < 2048)
            {
                _loc2 = String.fromCharCode(_loc1 >> 6 | 192) + String.fromCharCode(_loc1 & 63 | 128);
            }
            else
            {
                _loc2 = String.fromCharCode(_loc1 >> 12 | 224) + String.fromCharCode(_loc1 >> 6 & 63 | 128) + String.fromCharCode(_loc1 & 63 | 128);
            } // end else if
            if (_loc2 != null)
            {
                if (_loc4 > _loc5)
                {
                    _loc6 = _loc6 + string.substring(_loc5, _loc4);
                } // end if
                _loc6 = _loc6 + _loc2;
                _loc4 = _loc3 + 1;
                _loc5 = _loc3 + 1;
            } // end if
        } // end of for
        if (_loc4 > _loc5)
        {
            _loc6 = _loc6 + string.substring(_loc5, string.length);
        } // end if
        return (_loc6);
    } // End of the function
    static function hex_md5(s)
    {
        s = com.clubpenguin.crypto.MD5.utf8Encode(s);
        return (com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz)));
    } // End of the function
    static function b64_md5(s)
    {
        return (com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz)));
    } // End of the function
    static function str_md5(s)
    {
        return (com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz)));
    } // End of the function
    static function hex_hmac_md5(key, data)
    {
        return (com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data)));
    } // End of the function
    static function b64_hmac_md5(key, data)
    {
        return (com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data)));
    } // End of the function
    static function str_hmac_md5(key, data)
    {
        return (com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data)));
    } // End of the function
    static function core_md5(x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << len % 32;
        x[(len + 64 >>> 9 << 4) + 14] = len;
        var _loc4 = 1732584193;
        var _loc3 = -271733879;
        var _loc2 = -1732584194;
        var _loc1 = 271733878;
        for (var _loc5 = 0; _loc5 < x.length; _loc5 = _loc5 + 16)
        {
            var _loc10 = _loc4;
            var _loc9 = _loc3;
            var _loc8 = _loc2;
            var _loc7 = _loc1;
            _loc4 = com.clubpenguin.crypto.MD5.md5_ff(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 0], 7, -680876936);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ff(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 1], 12, -389564586);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ff(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 2], 17, 606105819);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ff(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 3], 22, -1044525330);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ff(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 4], 7, -176418897);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ff(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 5], 12, 1200080426);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ff(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 6], 17, -1473231341);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ff(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 7], 22, -45705983);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ff(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 8], 7, 1770035416);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ff(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 9], 12, -1958414417);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ff(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 10], 17, -42063);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ff(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 11], 22, -1990404162);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ff(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 12], 7, 1804603682);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ff(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 13], 12, -40341101);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ff(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 14], 17, -1502002290);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ff(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 15], 22, 1236535329);
            _loc4 = com.clubpenguin.crypto.MD5.md5_gg(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 1], 5, -165796510);
            _loc1 = com.clubpenguin.crypto.MD5.md5_gg(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 6], 9, -1069501632);
            _loc2 = com.clubpenguin.crypto.MD5.md5_gg(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 11], 14, 643717713);
            _loc3 = com.clubpenguin.crypto.MD5.md5_gg(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 0], 20, -373897302);
            _loc4 = com.clubpenguin.crypto.MD5.md5_gg(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 5], 5, -701558691);
            _loc1 = com.clubpenguin.crypto.MD5.md5_gg(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 10], 9, 38016083);
            _loc2 = com.clubpenguin.crypto.MD5.md5_gg(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 15], 14, -660478335);
            _loc3 = com.clubpenguin.crypto.MD5.md5_gg(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 4], 20, -405537848);
            _loc4 = com.clubpenguin.crypto.MD5.md5_gg(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 9], 5, 568446438);
            _loc1 = com.clubpenguin.crypto.MD5.md5_gg(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 14], 9, -1019803690);
            _loc2 = com.clubpenguin.crypto.MD5.md5_gg(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 3], 14, -187363961);
            _loc3 = com.clubpenguin.crypto.MD5.md5_gg(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 8], 20, 1163531501);
            _loc4 = com.clubpenguin.crypto.MD5.md5_gg(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 13], 5, -1444681467);
            _loc1 = com.clubpenguin.crypto.MD5.md5_gg(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 2], 9, -51403784);
            _loc2 = com.clubpenguin.crypto.MD5.md5_gg(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 7], 14, 1735328473);
            _loc3 = com.clubpenguin.crypto.MD5.md5_gg(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 12], 20, -1926607734);
            _loc4 = com.clubpenguin.crypto.MD5.md5_hh(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 5], 4, -378558);
            _loc1 = com.clubpenguin.crypto.MD5.md5_hh(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 8], 11, -2022574463);
            _loc2 = com.clubpenguin.crypto.MD5.md5_hh(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 11], 16, 1839030562);
            _loc3 = com.clubpenguin.crypto.MD5.md5_hh(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 14], 23, -35309556);
            _loc4 = com.clubpenguin.crypto.MD5.md5_hh(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 1], 4, -1530992060);
            _loc1 = com.clubpenguin.crypto.MD5.md5_hh(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 4], 11, 1272893353);
            _loc2 = com.clubpenguin.crypto.MD5.md5_hh(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 7], 16, -155497632);
            _loc3 = com.clubpenguin.crypto.MD5.md5_hh(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 10], 23, -1094730640);
            _loc4 = com.clubpenguin.crypto.MD5.md5_hh(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 13], 4, 681279174);
            _loc1 = com.clubpenguin.crypto.MD5.md5_hh(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 0], 11, -358537222);
            _loc2 = com.clubpenguin.crypto.MD5.md5_hh(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 3], 16, -722521979);
            _loc3 = com.clubpenguin.crypto.MD5.md5_hh(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 6], 23, 76029189);
            _loc4 = com.clubpenguin.crypto.MD5.md5_hh(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 9], 4, -640364487);
            _loc1 = com.clubpenguin.crypto.MD5.md5_hh(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 12], 11, -421815835);
            _loc2 = com.clubpenguin.crypto.MD5.md5_hh(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 15], 16, 530742520);
            _loc3 = com.clubpenguin.crypto.MD5.md5_hh(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 2], 23, -995338651);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ii(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 0], 6, -198630844);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ii(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 7], 10, 1126891415);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ii(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 14], 15, -1416354905);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ii(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 5], 21, -57434055);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ii(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 12], 6, 1700485571);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ii(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 3], 10, -1894986606);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ii(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 10], 15, -1051523);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ii(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 1], 21, -2054922799);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ii(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 8], 6, 1873313359);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ii(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 15], 10, -30611744);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ii(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 6], 15, -1560198380);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ii(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 13], 21, 1309151649);
            _loc4 = com.clubpenguin.crypto.MD5.md5_ii(_loc4, _loc3, _loc2, _loc1, x[_loc5 + 4], 6, -145523070);
            _loc1 = com.clubpenguin.crypto.MD5.md5_ii(_loc1, _loc4, _loc3, _loc2, x[_loc5 + 11], 10, -1120210379);
            _loc2 = com.clubpenguin.crypto.MD5.md5_ii(_loc2, _loc1, _loc4, _loc3, x[_loc5 + 2], 15, 718787259);
            _loc3 = com.clubpenguin.crypto.MD5.md5_ii(_loc3, _loc2, _loc1, _loc4, x[_loc5 + 9], 21, -343485551);
            _loc4 = com.clubpenguin.crypto.MD5.safe_add(_loc4, _loc10);
            _loc3 = com.clubpenguin.crypto.MD5.safe_add(_loc3, _loc9);
            _loc2 = com.clubpenguin.crypto.MD5.safe_add(_loc2, _loc8);
            _loc1 = com.clubpenguin.crypto.MD5.safe_add(_loc1, _loc7);
        } // end of for
        return (new Array(_loc4, _loc3, _loc2, _loc1));
    } // End of the function
    static function md5_cmn(q, a, b, x, s, t)
    {
        return (com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.bit_rol(com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.safe_add(a, q), com.clubpenguin.crypto.MD5.safe_add(x, t)), s), b));
    } // End of the function
    static function md5_ff(a, b, c, d, x, s, t)
    {
        return (com.clubpenguin.crypto.MD5.md5_cmn(b & c | (b ^ 4294967295.000000) & d, a, b, x, s, t));
    } // End of the function
    static function md5_gg(a, b, c, d, x, s, t)
    {
        return (com.clubpenguin.crypto.MD5.md5_cmn(b & d | c & (d ^ 4294967295.000000), a, b, x, s, t));
    } // End of the function
    static function md5_hh(a, b, c, d, x, s, t)
    {
        return (com.clubpenguin.crypto.MD5.md5_cmn(b ^ c ^ d, a, b, x, s, t));
    } // End of the function
    static function md5_ii(a, b, c, d, x, s, t)
    {
        return (com.clubpenguin.crypto.MD5.md5_cmn(c ^ (b | d ^ 4294967295.000000), a, b, x, s, t));
    } // End of the function
    static function core_hmac_md5(key, data)
    {
        var _loc2 = com.clubpenguin.crypto.MD5.str2binl(key);
        if (_loc2.length > 16)
        {
            _loc2 = com.clubpenguin.crypto.MD5.core_md5(_loc2, key.length * com.clubpenguin.crypto.MD5.chrsz);
        } // end if
        var _loc3 = Array(16);
        var _loc4 = Array(16);
        for (var _loc1 = 0; _loc1 < 16; ++_loc1)
        {
            _loc3[_loc1] = _loc2[_loc1] ^ 909522486;
            _loc4[_loc1] = _loc2[_loc1] ^ 1549556828;
        } // end of for
        var _loc5 = com.clubpenguin.crypto.MD5.core_md5(_loc3.concat(com.clubpenguin.crypto.MD5.str2binl(data)), 512 + data.length * com.clubpenguin.crypto.MD5.chrsz);
        return (com.clubpenguin.crypto.MD5.core_md5(_loc4.concat(_loc5), 640));
    } // End of the function
    static function safe_add(x, y)
    {
        var _loc1 = (x & 65535) + (y & 65535);
        var _loc2 = (x >> 16) + (y >> 16) + (_loc1 >> 16);
        return (_loc2 << 16 | _loc1 & 65535);
    } // End of the function
    static function bit_rol(num, cnt)
    {
        return (num << cnt | num >>> 32 - cnt);
    } // End of the function
    static function str2binl(str)
    {
        var _loc3 = new Array();
        var _loc4 = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
        for (var _loc1 = 0; _loc1 < str.length * com.clubpenguin.crypto.MD5.chrsz; _loc1 = _loc1 + com.clubpenguin.crypto.MD5.chrsz)
        {
            _loc3[_loc1 >> 5] = _loc3[_loc1 >> 5] | (str.charCodeAt(_loc1 / com.clubpenguin.crypto.MD5.chrsz) & _loc4) << _loc1 % 32;
        } // end of for
        return (_loc3);
    } // End of the function
    static function binl2str(bin)
    {
        var _loc3 = "";
        var _loc4 = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
        for (var _loc1 = 0; _loc1 < bin.length * 32; _loc1 = _loc1 + com.clubpenguin.crypto.MD5.chrsz)
        {
            _loc3 = _loc3 + String.fromCharCode(bin[_loc1 >> 5] >>> _loc1 % 32 & _loc4);
        } // end of for
        return (_loc3);
    } // End of the function
    static function binl2hex(binarray)
    {
        var _loc3 = com.clubpenguin.crypto.MD5.hexcase ? ("0123456789ABCDEF") : ("0123456789abcdef");
        var _loc4 = "";
        for (var _loc1 = 0; _loc1 < binarray.length * 4; ++_loc1)
        {
            _loc4 = _loc4 + (_loc3.charAt(binarray[_loc1 >> 2] >> _loc1 % 4 * 8 + 4 & 15) + _loc3.charAt(binarray[_loc1 >> 2] >> _loc1 % 4 * 8 & 15));
        } // end of for
        return (_loc4);
    } // End of the function
    static function binl2b64(binarray)
    {
        var _loc6 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var _loc4 = "";
        for (var _loc2 = 0; _loc2 < binarray.length * 4; _loc2 = _loc2 + 3)
        {
            var _loc5 = (binarray[_loc2 >> 2] >> 8 * (_loc2 % 4) & 255) << 16 | (binarray[_loc2 + 1 >> 2] >> 8 * ((_loc2 + 1) % 4) & 255) << 8 | binarray[_loc2 + 2 >> 2] >> 8 * ((_loc2 + 2) % 4) & 255;
            for (var _loc1 = 0; _loc1 < 4; ++_loc1)
            {
                if (_loc2 * 8 + _loc1 * 6 > binarray.length * 32)
                {
                    _loc4 = _loc4 + com.clubpenguin.crypto.MD5.b64pad;
                    continue;
                } // end if
                _loc4 = _loc4 + _loc6.charAt(_loc5 >> 6 * (3 - _loc1) & 63);
            } // end of for
        } // end of for
        return (_loc4);
    } // End of the function
    static var hexcase = 0;
    static var b64pad = "";
    static var chrsz = 8;
} // End of Class
