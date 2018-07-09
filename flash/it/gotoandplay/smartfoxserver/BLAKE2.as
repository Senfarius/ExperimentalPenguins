class it.gotoandplay.smartfoxserver.BLAKE2 {
	function BLAKE2 () {}
	static var _BLAKE2S_IV = [0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19];
	static var _BLAKE2S_SIGMA = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3,11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4,7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8,9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13,2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9,12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11,13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10,6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5,10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0];
	static var _hash = [];
	static var _block = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	static var _pointer = 0;
	static var _counter = 0;
	static var _length = 0;
	static function hash (message) {
		it.gotoandplay.smartfoxserver.BLAKE2.startHash();
		var hashedPassword = it.gotoandplay.smartfoxserver.BLAKE2.update(it.gotoandplay.smartfoxserver.BLAKE2.decodeUTF8(message));
		return it.gotoandplay.smartfoxserver.BLAKE2.hexDigest(hashedPassword);
	}
	static function hexDigest () {
		var hex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];
		var out = [];
		var d = it.gotoandplay.smartfoxserver.BLAKE2.digest();
		for (var i = 0; i < d.length; i++) {
		  out.push(hex[(d[i] >> 4) & 0xf]);
		  out.push(hex[d[i] & 0xf]);
		}
		it.gotoandplay.smartfoxserver.BLAKE2.reset()
		return out.join('');
	}
	static function reset () {
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV = [0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19];
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3,11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4,7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8,9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13,2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9,12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11,13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10,6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5,10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0];
		it.gotoandplay.smartfoxserver.BLAKE2._hash = [];
		it.gotoandplay.smartfoxserver.BLAKE2._block = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		it.gotoandplay.smartfoxserver.BLAKE2._pointer = 0;
		it.gotoandplay.smartfoxserver.BLAKE2._counter = 0;
		it.gotoandplay.smartfoxserver.BLAKE2._length = 0;
	}
	static function startHash () {
		var digestLength = 32;
		it.gotoandplay.smartfoxserver.BLAKE2._hash = [
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[0] ^ it.gotoandplay.smartfoxserver.BLAKE2._get32([digestLength, 0, 0x01, 0x01], 0),
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[1],
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[2],
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[3],
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[4] ^ 0,
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[5] ^ 0,
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[6] ^ 0,
		it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[7] ^ 0
		];
		it.gotoandplay.smartfoxserver.BLAKE2._length = digestLength;
	}
	static function update (data) {
		for (var i = 0; i < data.length; i++) {
		    if (it.gotoandplay.smartfoxserver.BLAKE2._pointer === 64) {
		        it.gotoandplay.smartfoxserver.BLAKE2._counter += it.gotoandplay.smartfoxserver.BLAKE2._pointer;
		        it.gotoandplay.smartfoxserver.BLAKE2._compress(false);
		        it.gotoandplay.smartfoxserver.BLAKE2._pointer = 0;
		    }
		    it.gotoandplay.smartfoxserver.BLAKE2._block[it.gotoandplay.smartfoxserver.BLAKE2._pointer++] = data[i];
		}
		return it.gotoandplay.smartfoxserver.BLAKE2._block;
	}
	static function decodeUTF8 (input) {
		var b = new Array(input.length);
		for (var i = 0; i < input.length; i++) {
			b[i] = input.charCodeAt(i);
		}
		return b;
	}
	static function digest () {
		var result = new Array(_length);
		it.gotoandplay.smartfoxserver.BLAKE2._counter += it.gotoandplay.smartfoxserver.BLAKE2._pointer;
		while (it.gotoandplay.smartfoxserver.BLAKE2._pointer < 64) {
		  it.gotoandplay.smartfoxserver.BLAKE2._block[it.gotoandplay.smartfoxserver.BLAKE2._pointer++] = 0;
		}
		it.gotoandplay.smartfoxserver.BLAKE2._compress(true);
		for (var i = 0; i < it.gotoandplay.smartfoxserver.BLAKE2._length; i++) {
		  result[i] = (it.gotoandplay.smartfoxserver.BLAKE2._hash[i >> 2]) >>> (8 * (i & 3));
		}
		return result;
	}
	static function _rotr (data, shift) {
		return (data >>> shift) ^ (data << (32 - shift));
	}
	static function _get32 (data, index) {
		return data[index++] ^ (data[index++] << 8) ^ (data[index++] << 16) ^ (data[index] << 24);
	}
	static function _gamma (result, a, b, c, d, x, y) {
		result[a] += result[b] + x;
		result[d] = it.gotoandplay.smartfoxserver.BLAKE2._rotr(result[d] ^ result[a], 16);
		result[c] += result[d];
		result[b] = it.gotoandplay.smartfoxserver.BLAKE2._rotr(result[b] ^ result[c], 12);
		result[a] += result[b] + y;
		result[d] = it.gotoandplay.smartfoxserver.BLAKE2._rotr(result[d] ^ result[a], 8);
		result[c] += result[d];
		result[b] = it.gotoandplay.smartfoxserver.BLAKE2._rotr(result[b] ^ result[c], 7);
	}
	static function _compress (isLast) {
		var v = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var m = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var i;
		for (i = 0; i < 8; i++) {
		    v[i] = it.gotoandplay.smartfoxserver.BLAKE2._hash[i];
		    v[i + 8] = it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_IV[i];
		}
		v[12] ^= it.gotoandplay.smartfoxserver.BLAKE2._counter;
		v[13] ^= it.gotoandplay.smartfoxserver.BLAKE2._counter / 0x100000000;
		v[14] = isLast ? ~v[14] : v[14];
		for (i = 0; i < 16; i++) {
		    m[i] = it.gotoandplay.smartfoxserver.BLAKE2._get32(it.gotoandplay.smartfoxserver.BLAKE2._block, i * 4);
		}
		for (i = 0; i < 10; i++) {
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 0, 4, 8, 12, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 1]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 1, 5, 9, 13, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 2]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 3]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 2, 6, 10, 14, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 4]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 5]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 3, 7, 11, 15, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 6]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 7]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 0, 5, 10, 15, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 8]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 9]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 1, 6, 11, 12, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 10]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 11]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 2, 7, 8, 13, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 12]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 13]]);
		    it.gotoandplay.smartfoxserver.BLAKE2._gamma(v, 3, 4, 9, 14, m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 14]], m[it.gotoandplay.smartfoxserver.BLAKE2._BLAKE2S_SIGMA[i * 16 + 15]]);
		}
		it.gotoandplay.smartfoxserver.BLAKE2._hash[0] ^= v[0] ^ v[8];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[1] ^= v[1] ^ v[9];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[2] ^= v[2] ^ v[10];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[3] ^= v[3] ^ v[11];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[4] ^= v[4] ^ v[12];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[5] ^= v[5] ^ v[13];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[6] ^= v[6] ^ v[14];
		it.gotoandplay.smartfoxserver.BLAKE2._hash[7] ^= v[7] ^ v[15];
	}
}