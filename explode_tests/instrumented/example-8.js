var p = symb(p);
var t = symb(t);

function f(p, t) {
    let customer = { name: "person", role: "user" }
    customer[p] = t;
	var ret1 = !is_symb(customer.role);
	Assert(ret1);
    console.log(`customer.role => ${customer.role}`);
	var x = customer.toString();
	var ret2 = !is_symb(x);
	Assert(ret2);
    console.log(`toString implementation => ${customer.toString()}`);
};

f(p, t);