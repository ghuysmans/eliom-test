[%%shared
open Eliom_lib
]

let _ =
  Eliom_content.Html.F.(
    button ~a:[a_onclick [%client fun _ -> ()]] [txt "Click me!"];
  )
