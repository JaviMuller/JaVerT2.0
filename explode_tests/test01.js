var o = {}; 
var param = symb_number(param); 
var sth = symb(sth); 

o.param = param; 
o.sth = sth; 

function f(o) {
  if (o.param > 0) {
    //assert(!is_symbolic(o.sth))
	Assert(false);
	eval (o.sth)
  } else {
    Assume (false);
	console.log("banana")
  }
}

f(o);