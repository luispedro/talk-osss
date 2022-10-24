module Content.Common exposing (personImage)

import Html exposing (Html)
import Html.Attributes as HtmlAttr


personImage name pic =
    Html.div
        [HtmlAttr.style "float" "right"
        ,HtmlAttr.style "max-width" "180px"
        ,HtmlAttr.style "padding-right" "4em"
        ]
        [Html.img
            [HtmlAttr.src pic
            ,HtmlAttr.style "max-width" "200px"]
            []
        ,Html.br [] []
        ,Html.strong [HtmlAttr.style "font-family" "sans-serif"] [Html.text name]]
