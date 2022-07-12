/**
 * PoC exploits for the example dataset
 */

// ================== Example 0 ==================
const example0 = require("../example-0");
console.log(`Example 0: ${example0("2+2")}`);

// ================== Example 1 ==================
const example1 = require("../example-1");
console.log(`Example 1: ${example1("2+2")}`);

// ================== Example 2 ==================
const example2 = require("../example-2");
console.log(`Example 2: ${example2("2+2")}`);

// ================== Example 3 ==================
const example3 = require("../example-3");
const o = {
    z: 1,
    w: "+2"
};
console.log(`Example 3: ${example3(o)}`);

// ================== Example 4 ==================
const example4 = require("../example-4");
const req = {
    body: {
        param: "2+2"
    },
};
console.log(`Example 4: ${example4(req)}`);

// ================== Example 5 ==================
const example5 = require("../example-5");
console.log(`Example 5: ${example5()}`);

// ================== Example 6 ==================
const example6 = require("../example-6");
console.log(`Example 6: ${example6()}`);

// ================== Example 7 ==================
const example7 = require("../example-7");
console.log(`Example 7: ${example7("2+2")}`);

// ================== Example 8 ==================
const example8 = require("../example-8");
console.log("Example 8.1:");
example8("role", "admin");

function newToString() {
    return "Hacked toString Implementation :)";
}

console.log("Example 8.2:");
example8("__proto__", { toString: newToString });
console.log("Example 8.3:");
example8("toString", newToString);

// ================== Example 9 ==================
const example9 = require("../example-9");
console.log(`Example 9: ${example9("+2", "x")}`);