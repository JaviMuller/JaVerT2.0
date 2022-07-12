var o = {};
var z = symb_number(z);
var w = symb(w);

o.z = z;
o.w = w;

function f(o) {
    if (o.z > 0) {
        o.y = "2";
		Assert(!is_symb(o.y) && !is_symb(o.w));
        return eval(o.y + o.w);
    }
};

f(o);