// Ajuda

const read = require("./aux-files/external-read");

function f() {
    const s = read();
	Assert(!is_symb(s));
    return eval(s);
};

f();