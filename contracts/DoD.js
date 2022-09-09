const uri = 'http://github.c.git';

const encoded = encodeURI(uri);
console.log(encoded)
try {
    console.log(decodeURI(encoded));
} catch (e) {
    console.error(e);
}