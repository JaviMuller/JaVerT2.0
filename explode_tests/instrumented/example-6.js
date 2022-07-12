function read() {
    return "2+2";
};

function f() {
    const s = read();
	Assert(!is_symb(s));
    return eval(s);
};

f();