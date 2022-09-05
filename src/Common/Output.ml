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
let create_dir () : unit = if (!enabled && not (Sys.file_exists dir)) then Unix.mkdir dir 0o755

(** Prefix for output files *)
let output_prefix = "out_"

(** File extension for output files *)
let output_extension (lvl: t) : string = 
  match lvl with
    | Normal -> "txt"
    | JSON -> "json"

let filename (lvl: t) : string = 
  output_prefix ^ !file ^ "." ^ (output_extension lvl)

let out_normal = ref stdout
let out_json = ref stdout

let wrap_up () : unit = 
  close_out !out_normal;
  close_out !out_json

let open_f() : unit =
  create_dir();
  if (!enabled && (!mode = 1 || !mode = 2)) then 
    out_normal := open_out_gen [Open_creat; Open_text; Open_wronly; Open_trunc] 0o640 (dir ^ (filename Normal));
  if (!enabled && (!mode = 0 || !mode = 2)) then
    out_json := open_out_gen [Open_creat; Open_text; Open_wronly; Open_trunc] 0o640 (dir ^ (filename JSON))


let write lvl (txt : string lazy_t) : unit =
  if (!enabled) then
    let txt = Lazy.force txt in
    let txt = Printf.sprintf "%s\n%!" txt in
    (match lvl with
      | Normal -> if (!mode = 1 || !mode = 2) then output_string !out_normal txt
      | JSON -> if (!mode = 0 || !mode = 2) then 
        output_string !out_json txt)
