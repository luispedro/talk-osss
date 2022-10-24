module Content exposing (metadata, slides)

import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Chart as C
import Chart.Attributes as CA

import Slides exposing (RawSlide(..), mkSlide, mkIncrementalSlide, mkSteppedSlide, cookSlides)
import HtmlSimple as HS

metadata =
    { title = "Big catalogs and small genes. Tools and techniques for analyzing large-scale sequencing data"
    , shortTitle = "Tools for large-scale metagenomics data"
    }

slides = cookSlides <| List.concat
    [
    intro
    ,summary
    ]


intro =
    [RawSlide { content = Html.div [HtmlAttr.class "slide"]
        [Html.h1
            [HtmlAttr.style "font-size" "72px"]
            [Html.text "Big catalogs and small genes"]
        ,Html.h2
            []
            [Html.text "Tools and approaches for analysing large-scale metagenomic data"]
        ,Html.div
            [HtmlAttr.style "float" "left"
            ,HtmlAttr.style "width" "25%"
            ,HtmlAttr.style "margin" "0px"
            ]
            [Html.h2
                [HtmlAttr.style "padding-top" "0em"
                ,HtmlAttr.style "padding-bottom" "0px"
                ,HtmlAttr.style "margin-bottom" "0px"
                ,HtmlAttr.style "color" "#7570b3"
                ,HtmlAttr.style "font-size" "48px"
                ]
                [Html.text "Luis Pedro Coelho"]
            ,Html.p []
                [Html.text "luispedro@big-data-biology.org"
                ,Html.br [] []
                ,Html.img
                    [HtmlAttr.src "/Media/twitter.png"
                    ,HtmlAttr.style "width" "28px"
                    ,HtmlAttr.style "margin-bottom" "-8px"
                    ,HtmlAttr.style "margin-right" "8px"]
                    []
                ,Html.text "@luispedrocoelho"
                ,Html.br [] []
                ,Html.img
                    [HtmlAttr.src "/Media/twitter.png"
                    ,HtmlAttr.style "width" "28px"
                    ,HtmlAttr.style "margin-bottom" "-8px"
                    ,HtmlAttr.style "margin-right" "8px"]
                    []
                ,Html.text "@BigDataBiology"
                ,Html.p []
                    [Html.img [ HtmlAttr.src "/Media/Fudan-logo.png", HtmlAttr.style "width" "50%" ]
                    []]
                ]
            ]
        ,Html.div
            [ HtmlAttr.style "text-align" "right"
            ]
            [ Html.img [ HtmlAttr.src "/Media/GMGC/c18e6bde-2ba1-4f18-b6fc-294ebdfec07c_starlio_the_earth_made_of_microbes.png"
                                , HtmlAttr.style "width" "480px"
                                , HtmlAttr.style "height" "480px"
                                , HtmlAttr.style "padding-right" "4em" ]
                []
            ]
        ]
     ,slideType = Slides.FirstSlideInGroup }
    ]








summary =
    [mkSlide "Summary"
        [Html.div
            [HtmlAttr.style "float" "right"
            ,HtmlAttr.style "text-align" "right"]
            [Html.h3 [] [Html.text "Think of yourself as part of a community"]
        ,HS.mdToHtml """
- Most projects are small projects
- Most collaboration is within small teams
- Not all contributions are code commits
- Accept small contributions
- Make small contributions
"""]
              ]
    ,RawSlide <| { content =
            Html.div [HtmlAttr.class "slide"]
                [Html.h2 [
                    HtmlAttr.style "padding-top" "50vh"
                    ,HtmlAttr.style "padding-left" "50%"
                    ,HtmlAttr.style "font-size" "64px"] [Html.text "Thank you"]]
     , slideType = Slides.Follower }
    ,RawSlide <| { content =
            Html.div [HtmlAttr.class "slide"]
                [Html.h2 [
                    HtmlAttr.style "padding-top" "50vh"
                    ,HtmlAttr.style "padding-left" "50%"
                    ,HtmlAttr.style "font-size" "64px"] [Html.text "Thank you"]
                ,HS.mdToHtml """
Follow us on Twitter [@BigDataBiology](https://twitter.com/BigDataBiology) or [subscribe to our newsletter](https://bigdatabiology.substack.com/).
                """
                ]
     , slideType = Slides.Follower }
    ]

