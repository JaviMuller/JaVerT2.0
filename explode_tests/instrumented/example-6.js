function read() {
    return "2+2";
};

function f() {
    const s = read();
	var ret = !is_symbolic(s);
	Assert(ret);
    return eval(s);
};

f();