var y = symb(y);

function f(y) {
    var x = {};
    x.f = y;
    return eval(x.f);
};

f(y);