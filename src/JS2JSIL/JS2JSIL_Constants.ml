open CCommon

let small_tbl_size = 31
let medium_tbl_size = 101

let line_numbers_extension = "_line_numbers.txt"

type js_symbolic_constructs_type = {
	js_assume      : string; 
	js_assert      : string; 
	js_symb        : string;
	js_fresh_symb  : string; 
	js_symb_number : string; 
	js_symb_string : string;
	js_symb_bool   : string; 
	js_is_symb     : string; 
}

let js_symbolic_constructs = {
	js_assume      = "Assume"; 
	js_assert      = "Assert"; 
	js_symb        = "symb";
	js_fresh_symb  = "fresh_symb";
	js_symb_number = "symb_number"; 
	js_symb_string = "symb_string";
	js_symb_bool   = "symb_bool"; 
	js_is_symb     = "is_symbolic"; 
}

let js2jsil_imports = [
	"Array.jsil"; "Boolean.jsil"; "Date.jsil"; "Function.jsil"; "Global.jsil"; 
	"Init.jsil"; "Internals.jsil"; "Math.jsil"; "Number.jsil"; "Object.jsil"; 
	"RegExp.jsil"; "String.jsil"; "Errors.jsil"
]

let js2jsil_imports_cosette = [
	"Array.jsil"; "Boolean.jsil"; "Date.jsil"; "Function.jsil"; "Global.jsil"; 
	"InitFantine.jsil"; "Internals.jsil"; "Math.jsil"; "Number.jsil"; "Object.jsil"; 
	"RegExp.jsil"; "String.jsil"; "Errors.jsil"
]

let js2jsil_logic_imports = [
	"javert_internal_functions.jsil"; 
	"javert_logic_macros.jsil"
]

let js2jsil_imports_bi = [
	"bi_javert_predicates.jsil"; "BiArray.jsil"; "BiBoolean.jsil"; "BiDate.jsil"; "BiFunction.jsil"; "BiGlobal.jsil"; 
	"BiInitFantine.jsil"; "BiInternals.jsil"; "BiMath.jsil"; "BiNumber.jsil"; "BiObject.jsil"; 
	"BiRegExp.jsil"; "BiString.jsil"; "BiErrors.jsil"
]


let setupHeapName = "setupInitialHeap"

let _callPropName              = "@call"
let _constructPropName         = "@construct"
let _scopePropName             = "@scope"
let _classPropName             = "@class"
let _extensiblePropName        = "@extensible"
let _internalProtoFieldName    = "@proto"
let _erFlagPropName            = "@er"

let locGlobName        = "$lg"
let locObjPrototype    = "$lobj_proto"
let locFunObjPrototype = "$lfun_proto"
let locArrPrototype    = "$larr_proto"
let locTErrPrototype   = "$lterr_proto"
let locSErrPrototype   = "$lserr_proto"
let locRErrPrototype   = "$lrerr_proto"
let locErrPrototype    = "$lerr_proto"


let toBooleanName                     = "i__toBoolean"                   (* 9.2               *)
let getValueName                      = "i__getValue"                    (* 8.7.1             *)
let isReservedName                    = "i__isReserved"
let putValueName                      = "i__putValue"                    (* 8.7.2             *)
let createDefaultObjectName           = "create_default_object"          (* 15.2.2.1          *)
let toObjectName                      = "i__toObject"                    (* 9.9               *)
let toStringName                      = "i__toString"                    (* 9.8               *)
let toStringComputedName              = "i__toStringComputed"            (* ???               *)
let deletePropertyName                = "deleteProperty"                 (* 8.12.7            *)
let syntaxErrorName                   = "SyntaxError"                    (* 15.1.4.13         *)
let typeErrorName                     = "TypeError"                      (* 15.1.4.14         *)
let createFunctionObjectName          = "create_function_object"
let isCallableName                    = "i__isCallable"
let checkObjectCoercibleName          = "i__checkObjectCoercible"
let jsTypeOfName                      = "i__typeOf"                      (* 11.4.3 - Table 20 *)
let toNumberName                      = "i__toNumber"                    (* 9.3 - Table 12    *)
let toPrimitiveName                   = "i__toPrimitive"                 (* 9.1 - Table 10    *)
let toInt32Name                       = "i__toInt32"                     (* 9.5               *)
let toUInt32Name                      = "i__toUint32"                    (* 9.6               *)
let abstractComparisonName            = "i__abstractComparison"          (* 11.8.5            *)
let hasPropertyName                   = "hasProperty"                    (* 8.12.6            *)
let abstractEqualityComparisonName    = "i__abstractEquality"            (* 11.9.3            *)
let strictEqualityComparisonName      = "i__strictEquality"              (* 11.9.6            *)
let defineOwnPropertyName             = "defineOwnProperty"              (* 8.12.9            *)
let checkAssignmentErrorsName         = "i__checkAssignmentErrors"
let checkParametersName               = "i__checkParameters"
let getEnumFieldsName                 = "i__getAllEnumerableFields"
let createArgsName                    = "create_arguments_object"
let dynamicScoper                     = "resolveVariable"
let isNativeErrorName                 = "isNativeError"
let deleteObjAndMetadata              = "i__purge"
let deleteErrorObjects                = "i__deleteErrors"

(* N.B. Keep the list updated when adding new special spec vars: *)

let var_this        = "x__this"
let var_scope       = "x__scope"
let var_scope_final = "x__scope_f"
let var_se          = "x__se"
let var_te          = "x__te"
let var_args        = "x__args"
let var_er          = "x__er"
let var_er_metadata = "x__er_m"
let var_sc_first    = "x__sc_fst"

let js2jsil_spec_vars = [ var_this; var_scope; var_scope_final; var_se; var_te; var_er ]
let reserved_vars     = [ var_this; var_scope; var_scope_final; var_se; var_te; var_er; var_er_metadata; var_sc_first; Flag.return_variable ]

let main_fid        = "main"

let macro_GPVF_name   = "GPVFold"
let macro_GPVU_name   = "GPVUnfold"
let pi_predicate_name = "Pi"

(** Various abbreviations *)
let lit_num n = Expr.Lit (Num n)
let lit_str s = Expr.Lit (String s)
let lit_loc l = Expr.Lit (Loc l)
let lit_typ t = Expr.Lit (Type t)
let lit_refv = lit_str "v"
let lit_refo = lit_str "o"
let rtype r = Expr.BinOp (r, LstNth, lit_num 0.)
let base  r = Expr.BinOp (r, LstNth, lit_num 1.)
let field r = Expr.BinOp (r, LstNth, lit_num 2.)

(**
 *  Fresh identifiers
 *)
let fresh_sth (name : string) : (unit -> string) =
  let counter = ref 0 in
  let rec f () =
    let v = name ^ (string_of_int !counter) in
    counter := !counter + 1;
    v
  in f

let fresh_var                 : (unit -> string) = fresh_sth "x_"
let fresh_scope_chain_var     : (unit -> string) = fresh_sth "x_sc_"
let fresh_found_var           : (unit -> string) = fresh_sth "x_found_"
let fresh_fun_var             : (unit -> string) = fresh_sth "x_f_"
let fresh_obj_var             : (unit -> string) = fresh_sth "x_o_"
let fresh_er_var              : (unit -> string) = fresh_sth "x_er_"
let fresh_err_var             : (unit -> string) = fresh_sth "x_error_"
let fresh_this_var            : (unit -> string) = fresh_sth "x_this_"
let fresh_case_var            : (unit -> string) = fresh_sth "x_case_"
let fresh_desc_var            : (unit -> string) = fresh_sth "x_desc_"
let fresh_body_var            : (unit -> string) = fresh_sth "x_body_"
let fresh_fscope_var          : (unit -> string) = fresh_sth "x_fscope_"
let fresh_xfoundb_var         : (unit -> string) = fresh_sth "x_found_b_"
let fresh_label               : (unit -> string) = fresh_sth "lab_"
let fresh_next_label          : (unit -> string) = fresh_sth "next_"
let fresh_then_label          : (unit -> string) = fresh_sth "then_"
let fresh_else_label          : (unit -> string) = fresh_sth "else_"
let fresh_endif_label         : (unit -> string) = fresh_sth "fi_"
let fresh_end_label           : (unit -> string) = fresh_sth "end_"
let fresh_end_switch_label    : (unit -> string) = fresh_sth "end_switch_"
let fresh_end_case_label      : (unit -> string) = fresh_sth "end_case_"
let fresh_default_label       : (unit -> string) = fresh_sth "default_"
let fresh_b_cases_label       : (unit -> string) = fresh_sth "b_cases_"
let fresh_logical_variable    : (unit -> string) = fresh_sth "#x"
let fresh_break_label         : (unit -> string) = fresh_sth "break_"
let fresh_loop_head_label     : (unit -> string) = fresh_sth "loop_h_"
let fresh_loop_cont_label     : (unit -> string) = fresh_sth "loop_c_"
let fresh_loop_guard_label    : (unit -> string) = fresh_sth "loop_g_"
let fresh_loop_body_label     : (unit -> string) = fresh_sth "loop_b_"
let fresh_loop_end_label      : (unit -> string) = fresh_sth "loop_e_"
let fresh_tcf_finally_label   : (unit -> string) = fresh_sth "finally_"
let fresh_tcf_end_label       : (unit -> string) = fresh_sth "end_tcf_"
let fresh_tcf_err_try_label   : (unit -> string) = fresh_sth "err_tcf_t_"
let fresh_tcf_err_catch_label : (unit -> string) = fresh_sth "err_tcf_c_"
let fresh_tcf_ret             : (unit -> string) = fresh_sth "ret_tcf_"

let fresh_loop_vars () =
	let head = fresh_loop_head_label () in
	let end_loop = fresh_loop_end_label () in
	let cont = fresh_loop_cont_label () in
	let guard = fresh_loop_guard_label () in
	let body = fresh_loop_body_label () in
	head, guard, body, cont, end_loop

let number_of_tcfs = ref 0
let fresh_tcf_vars () =
	let err1 = fresh_tcf_err_try_label () in
	let err2 = fresh_tcf_err_catch_label () in
	let end_l = fresh_tcf_end_label () in
	let finally = fresh_tcf_finally_label () in
	let fresh_abnormal_finally = fresh_sth ("abnormal_finally_" ^ (string_of_int !number_of_tcfs) ^ "_") in
	number_of_tcfs := (!number_of_tcfs) + 1;
	let ret = fresh_tcf_ret () in
	err1, err2, finally, end_l, fresh_abnormal_finally, ret

let fresh_name =
  let counter = ref 0 in
  let rec f name =
    let v = name ^ (string_of_int !counter) in
    counter := !counter + 1;
    v
  in f

let fresh_anonymous () : string =
  fresh_name "anonymous"

let fresh_catch_anonymous () : string =
  fresh_name "catch_anonymous"

let fresh_named n : string =
  fresh_name n

let fresh_anonymous_eval () : string =
	fresh_name "___$eval___"

let fresh_catch_anonymous_eval () : string =
  fresh_name "___$eval___catch_anonymous_"

let fresh_named_eval n : string =
  fresh_name ("___$eval___" ^ n ^ "_")


let is_get_value_var x =
	match (x : Expr.t) with
	| PVar x_name ->
		let x_name_len = String.length x_name in
		if ((x_name_len > 2) && ((String.sub x_name (x_name_len - 2) 2) = "_v"))
			then Some x_name else None
	| _ -> None

let val_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_v"
	| Lit l -> (fresh_var ()) ^ "_v"
	| _ -> raise (Failure "val_var_of_var expects a variable or a literal"))

let number_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_n"
	| Lit l -> (fresh_var ()) ^ "_n"
	| _ -> raise (Failure "number_var_of_var expects a variable"))

let boolean_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_b"
	| Lit l -> (fresh_var ()) ^ "_b"
	| _ -> raise (Failure "boolean_var_of_var expects a variable"))

let primitive_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_p"
	| Lit l -> (fresh_var ()) ^ "_p"
	| _ -> raise (Failure "primitive_var_of_var expects a variable"))

let string_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_s"
	| Lit l -> (fresh_var ()) ^ "_s"
	| _ -> raise (Failure "string_var_of_var expects a variable"))

let i32_var_of_var x =
	(match (x : Expr.t) with
	| PVar x_name -> x_name ^ "_i32"
	| Lit l -> (fresh_var ()) ^ "_i32"
	| _ -> raise (Failure "string_var_of_var expects a variable"))

let fresh_err_label : (unit -> string) = fresh_sth "err_"

let fresh_ret_label : (unit -> string) = fresh_sth "ret_"


type loop_list_type      = (string option * string * string option * bool) list

type translation_context = {
	tr_offset_converter:   int -> int;
	tr_fid:                string;
	tr_er_fid:             string;
	tr_sc_var:             string;
	tr_vis_list:           string list;
	tr_loop_list:          loop_list_type;
	tr_previous:           Expr.t option;
	tr_js_lab:             string option;
	tr_ret_lab:            string;
	tr_err_lab:            string;
	tr_use_cc:             bool;
	tr_inside_assign:      bool 
}


let make_translation_ctx ?(loop_list=[]) ?(previous=None) ?(js_lab=None) offset_converter fid vis_list sc_var =
	{
		tr_inside_assign = false; 
		tr_offset_converter = offset_converter;
		tr_fid        = fid;
		tr_er_fid     = fid;
		tr_sc_var     = sc_var;
		tr_vis_list   = vis_list;
		tr_loop_list  = loop_list;
		tr_previous   = previous;
		tr_js_lab     = js_lab;
		tr_ret_lab    = "rlab";
		tr_err_lab    = "elab";
		tr_use_cc     = true
	}

let update_tr_ctx ?ret_lab ?err ?loop_list ?previous ?lab ?vis_list ?er_fid ?sc_var ?use_cc tr_ctx =
	(* err *)

	let new_ret_lab   = Option.default tr_ctx.tr_ret_lab   ret_lab   in (* return   *)
	let new_err_lab   = Option.default tr_ctx.tr_err_lab   err       in (* pre-err  *)
	let new_vis_list  = Option.default tr_ctx.tr_vis_list  vis_list  in (* vis_list *)
	let new_loop_list = Option.default tr_ctx.tr_loop_list loop_list in(* loop_list *)
	let new_previous  = Option.default tr_ctx.tr_previous  previous  in (* previous *)
	let new_lab       = Option.default tr_ctx.tr_js_lab    lab       in (* lab      *)
	let new_er_fid    = Option.default tr_ctx.tr_er_fid    er_fid    in (* er_fid   *)
	let new_sc_var    = Option.default tr_ctx.tr_sc_var    sc_var    in (* sc_var   *)
	let new_use_cc    = Option.default tr_ctx.tr_use_cc    use_cc    in (* use_cc   *)
	{ 
		tr_ctx with
		tr_ret_lab   = new_ret_lab;
	    tr_err_lab   = new_err_lab;
	    tr_vis_list  = new_vis_list;
	    tr_loop_list = new_loop_list;
		tr_previous  = new_previous;
		tr_js_lab    = new_lab;
		tr_er_fid    = new_er_fid;
		tr_sc_var    = new_sc_var;
		tr_use_cc    = new_use_cc;
	}



(********************************************)
(********************************************)
(***         Compilation Tables           ***)
(********************************************)
(********************************************)

type fun_tbl_type        = (string, string * string list * JSParserSyntax.exp option * (Spec.t option)) Hashtbl.t
type pre_fun_tbl_type    = (string, string * string list * JSParserSyntax.exp option * (JSParserSyntax.annotation list * string list * ((string, string) Hashtbl.t))) Hashtbl.t
type var_to_fid_tbl_type = (string, string) Hashtbl.t
type cc_tbl_type         = (string, var_to_fid_tbl_type) Hashtbl.t
type vis_tbl_type        = (string, (string list)) Hashtbl.t


let get_scope_table (cc_tbl : cc_tbl_type) (fid : string) =
  try Hashtbl.find cc_tbl fid
    with _ ->
      let msg = Printf.sprintf "var tbl of function %s is not in cc-table" fid in
      L.fail msg

let get_vis_list (vis_tbl : vis_tbl_type) (fid : string) =
  try Hashtbl.find vis_tbl fid
    with _ ->
      let msg = Printf.sprintf "vis-list of function %s is not in vis-table" fid in
      L.fail msg
