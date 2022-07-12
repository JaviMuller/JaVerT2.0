function f(y) {
    var x = {};
    x.f = y;
    return eval(x.f);
};

var y = symb(y);

f(y) 