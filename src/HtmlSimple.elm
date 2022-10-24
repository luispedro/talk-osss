module HtmlSimple exposing (floatLeftDiv, floatRightDiv, floatClear, textUL, img80, img50, imgw, p, mdToHtml, textTable)

import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Html.Events exposing (..)
import Markdown


floatLeftDiv : String -> List (Html msg) -> Html msg
floatLeftDiv = floatRLDiv "left"

floatRightDiv : String -> List (Html msg) -> Html msg
floatRightDiv = floatRLDiv "right"

floatRLDiv : String -> String -> List (Html msg) -> Html msg
floatRLDiv dir w content =
    Html.div
        [HtmlAttr.style "float" dir
        ,HtmlAttr.style "width" w
        ,HtmlAttr.class "simple-float"]
        content

floatClear : Html msg
floatClear =
    Html.div
        [HtmlAttr.style "clear" "both"]
        []

textUL : List String -> Html msg
textUL = Html.ul [] << List.map (Html.li [] << List.singleton << Html.text)


img50 = imgw "50%"
img80 = imgw "80%"

imgw w src =
    Html.div
        [HtmlAttr.style "text-align" "center"]
        [Html.img
            [HtmlAttr.src src
            ,HtmlAttr.style "width" w]
            []
        ]
p t = Html.p [] [Html.text t]

markdownOptions =
    { githubFlavored = Just { tables = True, breaks = False }
    , defaultHighlighting = Nothing
    , sanitize = False
    , smartypants = False
    }
mdToHtml = Markdown.toHtmlWith markdownOptions []

textTable : List String -> List (List String) -> Html msg
textTable headers content =
    Html.table
        [HtmlAttr.class "text-table"]
        [Html.thead [] [Html.tr [] (List.map (Html.th [] << List.singleton << Html.text) headers)]
        ,Html.tbody [] (List.map (Html.tr [] << List.map (Html.td [] << List.singleton << Html.text)) content)
        ]


