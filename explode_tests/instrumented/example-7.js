var x = symb(x);

function sanitize(s) {
    return s;
};

function f(x) {
	var x1 = sanitize(x);
	var ret = !is_symb(x1);
	Assert(ret);
    return eval(sanitize(x));
};

f(x);