var p = symb(p);
,var t = symb(t);
const f = function (p, t) {
	let customer = {};
	customer.name = 'person';
	customer.role = 'user';
	customer[p] = t;
	const v1 = console.log;
	const v2 = customer.role;
	const v3 = v1(`customer.role => ${ v2 }`);
	v3;
	const v4 = console.log;
	const v5 = customer.toString;
	const v6 = v5();
	const v7 = v4(`toString implementation => ${ v6 }`);
	v7;
};
;
f(p,t);
