[%%shared
open Eliom_lib
open Eliom_content
open Html.D
]

module Test_app =
  Eliom_registration.App (
  struct
    let application_name = "test"
    let global_data_path = None
  end)

let main_service =
  Eliom_service.create
    ~path:(Eliom_service.Path [])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

[%%client
open Js_of_ocaml
let ct = ref 0
]

let () =
  Test_app.register
    ~service:main_service
    (fun () () ->
       let status = p [txt ""] in
       Lwt.return
         (Eliom_tools.F.html
            ~title:"test"
            ~css:[["css";"test.css"]]
            Html.F.(body [
              button ~a:[a_onclick [%client fun _ ->
                incr ct;
		let p = Eliom_content.Html.To_dom.of_p ~%status in
		p##.textContent := Js.(some (string (string_of_int !ct)))
              ]] [txt "Click me!"];
              status;
            ])))

let () = exit 0
