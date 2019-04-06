exception UnknownKind of string

open Constr

let rec print_econstr (env: Environ.env) (sigma: Evd.evar_map) (ec: EConstr.constr) (indent: int): unit =
    (*
    | Rel of int
    | Var of Names.Id.t
    | Meta of metavariable
    | Evar of 'constr pexistential
    | Sort of 'sort
    | Cast of 'constr * cast_kind * 'types
    | Prod of Names.Name.t * 'types * 'types
    | Lambda of Names.Name.t * 'types * 'constr
    | LetIn of Names.Name.t * 'constr * 'types * 'constr
    | App of 'constr * 'constr array
    | Const of (Names.Constant.t * 'univs)
    | Ind of (Names.inductive * 'univs)
    | Construct of (Names.constructor * 'univs)
    | Case of case_info * 'constr * 'constr * 'constr array
    | Fix of ('constr, 'types) pfixpoint
    | CoFix of ('constr, 'types) pcofixpoint
    | Proj of Names.Projection.t * 'constr
    *)
    let str_of_constr = Pp.string_of_ppcmds Printer.(pr_econstr_env env sigma ec) in
    let print_current_line s =
        let indent = String.make (indent * 2) ' ' in
        Printf.printf "%s<%s : %s>\n\r" indent s str_of_constr
    in
    match (EConstr.kind sigma ec) with
    | Rel _ -> print_current_line "rel"
    | Var _ -> print_current_line "var"
    | Meta _ -> print_current_line "meta"
    | Evar _ -> print_current_line "evar"
    | Sort _ -> print_current_line "sort"
    | Cast _ -> print_current_line "cast"
    | Prod _ -> print_current_line "prod"
    | Lambda _ -> print_current_line "lambda"
    | LetIn _ -> print_current_line "letin"
    | App (func, args) -> begin
        print_current_line "app";
        print_econstr env sigma func (indent + 1);
        let _ = Array.map (fun ec -> print_econstr env sigma ec (indent + 1)) args in
        ()
    end
    | Const (_) -> print_current_line "const"
    | Ind _ -> print_current_line "ind"
    | Construct (_, _) -> print_current_line "construct"
    | Case _ -> print_current_line "case"
    | _ -> raise (UnknownKind str_of_constr)

let print_constrexpr (c:Constrexpr.constr_expr) : unit =
    let sigma, env = begin
        if Proof_global.there_are_pending_proofs () then
            Pfedit.get_current_goal_context () 
        else
            let env = Global.env () in
            Evd.from_env env, env
    end in
    let (sigma, t) = (Constrintern.interp_open_constr env sigma c) in
    print_econstr env sigma t 0