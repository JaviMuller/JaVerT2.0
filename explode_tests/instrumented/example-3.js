var o = {};
var z = symb_number(z);
var w = symb(w);

o.z = z;
o.w = w;

function f(o) {
    if (o.z > 0) {
        o.y = "2";
		var out = o.y + o.w;
		var ret = !is_symbolic(out);
        //var ret = ret && is_safe(out); 
		Assert(ret);
        //Assume(false);
        return eval(o.y + o.w);
    }
};

f(o);