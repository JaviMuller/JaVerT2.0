
type subst_t = (string * Literal.t) list option

type t = 
    { 
        asrt_str: string; 
        subst: subst_t; 
        types: TypEnv.t option
    }

let error_models : t list ref = ref []

let json_of_type_pair ((var, tp) : (string * Type.t)) : string = 
    Printf.sprintf "\t\t\t\t{\"var\": \"%s\", \"type\": \"%s\"}" var (Type.str tp)

let json_of_var_val_pair ((var, value) : (string * Literal.t)) : string = 
    Printf.sprintf "\t\t\t\t{\"var\": \"%s\", \"val\": \"%s\"}" var (Literal.str value)

let json_of_types (tes : TypEnv.t) : string = 
    let tes_lst = TypEnv.get_var_type_pairs tes in
    String.concat ",\n" (List.map json_of_type_pair tes_lst) 

let json_of_subst (xvs : subst_t) : string = 
    String.concat ",\n" (Option.map_default (List.map json_of_var_val_pair) [] xvs)

let json_of_failing_model (fm : t) : string = 
    Printf.sprintf "\t\t{\n\
                    \t\t\t\"assert_arg\": \"%s\",\n\
                    \t\t\t\"fail_model\": [\n\
                              %s\n\
                    \t\t\t],\n\
                    \t\t\t\"typ_env\": [\n\
                              %s\n\
                    \t\t\t]\n\
                    \t\t}" fm.asrt_str (json_of_subst fm.subst) (Option.map_default json_of_types "" fm.types)

let add_model (asrt_str : string) (subst : subst_t) (types : TypEnv.t option) : unit = 
    error_models := {asrt_str; subst; types} :: !(error_models)

let print_json_models () : string = 
  let error_models_strs = List.map json_of_failing_model (!error_models) in
  Printf.sprintf "{\n\
                    \t\"models\": [\n\
                          %s\n\
                    \t]\n\
                  }" (String.concat ",\n" error_models_strs)