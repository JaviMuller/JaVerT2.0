const esprima = require("esprima-next");
const yargs = require("yargs");
const fs = require("fs");
const generate = require("escodegen").generate

const argv = yargs
  .option("input", { alias: "i", description: "JS input file", type: "string" })
  .option("output", {
    alias: "o",
    description: "ECMA-SL output file",
    type: "string",
  })
  .demandOption("input")
  .usage("Usage: $0 -i [filepath]")
  .help()
  .alias("help", "h").argv;

  function ast2str (e) { 
    try { 
      const option = {
        format : {
          quotes : 'single',
          indent : {
            style : '\t'
          }
        }
      }; 
      return generate(e, option);
     } catch (err) { 
      if ((typeof e) === "object") { 
        console.log("converting the following ast to str:\n" + e); 
      } else { 
        console.log("e is not an object!!!")
      }
      throw "ast2str failed."; 
     }
}


fs.readFile(argv.input, "utf-8", (err, data) => {
  if (err) throw err;
  const FUNC_NAME = argv.name ? argv.name : "buildAST";

  let prog;
  try {
    progObj = esprima.parseScript(data);
    console.log(progObj);
    console.log(generate(progObj))



  } catch (ex) {
    console.log("error")
  }
})
