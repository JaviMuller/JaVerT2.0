
type subst_t = (string * Literal.t) list

type t = 
    { 
        asrt_str: string; 
        subst: subst_t; 
        types: TypEnv.t
    }

let error_models : t list ref = ref []

let json_of_type_pair ((var, tp) : (string * Type.t)) : string = 
    Printf.sprintf "\t\t\t{\"var\": \"%s\", \"type\": \"%s\"}\n" var (Type.str tp)

let json_of_var_val_pair ((var, value) : (string * Literal.t)) : string = 
    Printf.sprintf "\t\t\t{\"var\": \"%s\", \"val\": \"%s\"},\n" var (Literal.str value)

let json_of_types (tes : TypEnv.t) : string = 
    let tes_lst = TypEnv.get_var_type_pairs tes in
    String.concat ",\n" (List.map json_of_type_pair tes_lst) 

let json_of_subst (xvs : subst_t) : string = 
    String.concat ",\n" (List.map json_of_var_val_pair xvs)

let json_of_failing_model (failing_model : t) : string = 
    Printf.sprintf "{ 
      \"failing_models\": %s     
    }" "{}"

let add_model (asrt_str : string) (subst : subst_t) (types : TypEnv.t) : unit = 
    error_models := {asrt_str; subst; types} :: !(error_models)

let print_json_models () : string = 
  let error_models_strs = List.map json_of_failing_model (!error_models) in
  Printf.sprintf "{ models: [ %s ] }" (String.concat ",\n" error_models_strs)



(*

 let rec json_fm_aux fm : string = 
            (match fm with
            | [] -> "\t\t],\n"
            | hd :: tl -> (
              let (var, value) = hd in
              if (tl = []) then
                (Printf.sprintf "\t\t\t{\"var\": \"%s\", \"val\": \"%s\"}\n" (Var.str var) (Val.str value)) ^ (json_fm_aux tl)
              else
                (Printf.sprintf "\t\t\t{\"var\": \"%s\", \"val\": \"%s\"},\n" (Var.str var) (Val.str value)) ^ (json_fm_aux tl)
            )) in
          let json_fm       = "\t\t\"fail_model\": [\n" ^ (json_fm_aux fm_list) in
          let rec json_te_aux te : string =
            (match te with
            | [] -> "\t\t]\n"
            | hd :: tl -> (
              let (var, tp) = hd in
              if (tl = []) then
                (Printf.sprintf "\t\t\t{\"var\": \"%s\", \"type\": \"%s\"}\n" var  (Type.str tp)) ^ (json_te_aux tl)
              else
                (Printf.sprintf "\t\t\t{\"var\": \"%s\", \"type\": \"%s\"}, \n" var (Type.str tp)) ^ (json_te_aux tl)
              )) in
          let json_te       = "\t\t\"typ_env\": [\n" ^ (json_te_aux tenv_list) in
          let json          = Printf.sprintf "\t{\n\t\t\"type\": \"assert_fail\",\n\t\t\"assert_arg\": \"%s\",\n%s%s\t},\n" (Formula.str f') json_fm json_te in


*)