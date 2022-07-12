var y = symb(y);

function f(y) {
    var x = {};
    x.f = y;
    var o = x;
	Assert(!is_symb(o.f));
    return eval(o.f);
};

f(y);