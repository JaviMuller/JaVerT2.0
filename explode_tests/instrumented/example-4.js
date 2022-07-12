var req = {};
var body = {};
var param = symb(param);

body.param = param;
req.body = body;

function f(req) {
    const x = req.body;
    x.a = 2;
	Assert(!is_symb(x.param));
    return eval(x.param);
}

f(req);