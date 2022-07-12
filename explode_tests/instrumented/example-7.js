var x = symb(x);

function sanitize(s) {
    return s;
};

function f(x) {
	Assert(!is_symb(sanitize(x)));
    return eval(sanitize(x));
};

f(x);