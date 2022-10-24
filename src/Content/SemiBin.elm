module Content.SemiBin exposing (semibinSlides)


import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Slides exposing (RawSlide(..), mkSlide, mkSteppedSlide, mkIncrementalSlide)
import Content.Common exposing (personImage)
import HtmlSimple as HS

oneSlideSummary =
    mkSteppedSlide "SemiBin builds MAGs using GMGC data for training a machine learning model"
            [[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "50%"
                ]
                [HS.img80 "/Media/SemiBin/binning.png"]]
            ,[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "15%"
                ]
                [HS.img80 "/Media/SemiBin/binning.png"]
            ,Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "50%"
                ]
                [HS.img80 "/Media/SemiBin/Fig3b.svg"]]
            ,[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "15%"
                ]
                [HS.img80 "/Media/SemiBin/binning.png"
                ,Html.div [HtmlAttr.style "padding-top" "1em"] []
                ,personImage "Shaojun Pan" "/Media/BigDataBiology/people/ShaojunPan.jpg"
                ]
            ,Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "25%"
                ]
                [HS.img80 "/Media/SemiBin/Fig3b.svg"]
            ,Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "60%"
                ]
                [HS.img80 "/Media/SemiBin/Fig5.svg"
                ]
            ]]
semibinSlides =
    [ mkSteppedSlide "SemiBin uses semi-supervised learning to solve the binning problem"
        ([ Html.img [HtmlAttr.src "/Media/SemiBin/binning.png"] []]
        :: [ Html.img [HtmlAttr.src "/Media/SemiBin/binning.png"] []
            , HS.p "This is a clustering problem"
            , Html.div
                [HtmlAttr.style "margin-top" "-400px"]
                [personImage "Shaojun Pan" "/Media/BigDataBiology/people/ShaojunPan.jpg"]
        ] :: ( List.map (\ix ->
                [Html.div
                    [HtmlAttr.style "float" "left"
                    ,HtmlAttr.style "width" "15%"
                    ]
                    [HS.img80 "/Media/SemiBin/binning.png"
                    ,personImage "Shaojun Pan" "/Media/BigDataBiology/people/ShaojunPan.jpg"
                    ]
                , HS.img80 ("/Media/SemiBin/Fig1layered/Fig1layered_" ++ String.fromInt ix ++ ".svg")
                ]
                ) <| List.range 1 9
        ))
    , mkSteppedSlide "SemiBin outperforms other binning methods"
        (let
            left = HS.floatLeftDiv "30%"
                [HS.textUL
                    [ "We compared against other binning methods"
                    , "We used CAMI data (simulated) and real data"
                    , "We counted the number of high-quality MAGs produced (checkM & GUNC)"
                    ]
                ,Html.h4 [] [Html.text "Real datasets used"]
                ,HS.textUL
                    [ "Human gut (82 samples)"
                    , "Dog gut (129 samples)"
                    , "Surface marine (109 samples)"
                    , "Soil (101 samples)"
                    ]
                ]
        in
            [left] :: (List.map (\ix ->
                [ left
                , HS.floatLeftDiv "70%"
                    [ HS.img80 ("/Media/SemiBin/Fig3b_layered/Fig3b_layer_" ++ String.fromInt ix ++ ".svg") ]
                ]) <| List.range 1 3)
        )
    ,mkIncrementalSlide "SemiBin models can be transferred between datasets"
        [
            [HS.floatLeftDiv "30%"
                [HS.textUL
                    [ "SemiBin uses a learned model"
                    , "Generating the data for training is expensive (mmseqs2 is slow)"
                    , "Learning is slow (a GPU helps, but few people have a GPU cluster)"
                    ]
                ]
        ] , [ HS.floatLeftDiv "60%"
                [ HS.img80 "/Media/SemiBin/Fig5.svg"
                , HS.mdToHtml "Models can be learned in _one dataset_ and **transferred** to another, but it works best _within the same habitat_"
                ]
            ]
        ]
    ,mkSteppedSlide "Real data can differ from simulated data"
        (let
            left = HS.floatLeftDiv "30%"
                [HS.p "We tested two options for annotating contigs"
                ,Html.ol []
                    [Html.li [] [Html.text "CAT+NCBI taxonomy" ]
                    ,Html.li [] [Html.text "mmseqs2+GTDB" ]
                    ]
                ]
        in
            [[left]
            ,[left, HS.floatLeftDiv "70%" [Html.img [HtmlAttr.style "width" "100%", HtmlAttr.src "/Media/SemiBin/Supp19a.svg" ] []]]
            ,[left, HS.floatLeftDiv "20%" [Html.img [HtmlAttr.style "width" "100%", HtmlAttr.src "/Media/SemiBin/Supp19a.svg" ] []]
                ,HS.floatLeftDiv "50%" [Html.img [HtmlAttr.style "width" "100%", HtmlAttr.src "/Media/SemiBin/Supp19b.svg" ] []]
                ,HS.mdToHtml "In real data we make **the opposite conclusion** from simulation!"
                    ]
            ])
    ]


