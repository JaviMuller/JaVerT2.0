const f = function (p, t) {
    let customer = {};
    customer.name = 'person';
    customer.role = 'user';
    let x = p;
    let a = [
        0,
        0
    ];
    a[0] = x;
    const v1 = a[0];
    customer[v1] = t;
    const v2 = console.log;
    const v3 = customer.role;
    const v4 = v2('customer.role => ' + v3);
    v4;
    const v5 = console.log;
    const v6 = customer.toString;
    const v7 = v6();
    const v8 = v5('toString implementation => ' + v7);
    v8;
};
module.exports = f;