(*i camp4deps: "parsing/grammar.cma" i*)

DECLARE PLUGIN "P1"

open Stdarg

VERNAC COMMAND EXTEND Idle CLASSIFIED AS QUERY
| [ "Idle" ] -> [
    Printf.printf "nothing happens.\n"
]
| [ "Printr" constr(c) ] -> [
    Printr.print_constrexpr c
]
END;;