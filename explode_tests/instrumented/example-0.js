var x = symb(x);

function f(x) {
	Assert(!is_symbolic(x));
    return eval(x);
};

f(x);