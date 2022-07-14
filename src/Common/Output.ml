(** Output types *)
type t =
  | JSON
  | Normal

(** Output enabled *)
let enabled = ref false

(** Output files mode:
      (default) 0: json 
                1: normal (plaintext)
                2: json + normal
*)
let mode = ref 0

(* Program name *)
let file = ref ""


(** Directory to save output files*)
let dir = "./_out/"
let create_dir perm = if not (Sys.file_exists dir) then Unix.mkdir dir perm

(** Prefix for output files *)
let output_prefix = "out_"

(** File extension for output files *)
let output_extension (lvl: t) : string = 
  match lvl with
    | Normal -> "txt"
    | JSON -> "json"

let filename (lvl: t) : string = 
  output_prefix ^ !file ^ "." ^ (output_extension lvl)

let out_normal = ref (open_out (dir ^ (filename Normal)))
let out_json = ref (open_out (dir ^ (filename JSON)))

let wrap_up () : unit = 
  close_out !out_normal;
  close_out !out_json

let json_obj_written = ref false

let open_f() : unit =
  create_dir 0o640;
  if (!enabled && (!mode = 1 || !mode = 2)) then 
    out_normal := open_out_gen [Open_creat; Open_text; Open_wronly] 0o640 (dir ^ (filename Normal));
  if (!enabled && (!mode = 0 || !mode = 2)) then
    out_json := open_out_gen [Open_creat; Open_text; Open_wronly] 0o640 (dir ^ (filename Normal))


let write lvl (txt : string lazy_t) : unit =
  if (!enabled) then
    let txt = Lazy.force txt in
    let txt = Printf.sprintf "%s\n%!" txt in
    (match lvl with
      | Normal -> if (!mode = 1 || !mode = 2) then output_string !out_normal txt
      | JSON -> if (!mode = 0 || !mode = 2) then 
        output_string !out_json txt;
        json_obj_written := true)

let write_json_begin() : unit =
  if (!enabled && (!mode = 0 || !mode = 2)) then
    output_string !out_json (Printf.sprintf "[\n")

let write_json_end() : unit =
  if (!enabled && (!mode = 0 || !mode = 2) && !json_obj_written) then (
    (* Overwrite last comma *)
    seek_out !out_json ((pos_out !out_json) - 2);
    output_string !out_json (Printf.sprintf "\n]\n"))
  else if (!enabled && (!mode = 0 || !mode = 2)) then
    output_string !out_json (Printf.sprintf "]\n")
