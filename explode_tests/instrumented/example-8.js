var p = symb(p);
var t = symb(t);

function f(p, t) {
    let customer = { name: "person", role: "user" }
    customer[p] = t;
	Assert(!is_symb(customer.role));
    console.log(`customer.role => ${customer.role}`);
	Assert(!is_symb(customer.toString()));
    console.log(`toString implementation => ${customer.toString()}`);
};

f(p, t);