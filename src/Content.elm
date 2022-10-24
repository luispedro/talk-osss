module Content exposing (metadata, slides)

import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Chart as C
import Chart.Attributes as CA

import Slides exposing (RawSlide(..), mkSlide, mkIncrementalSlide, mkSteppedSlide, cookSlides)
import HtmlSimple as HS

metadata =
    { title = "Open source software in science"
    , shortTitle = "OSS in science"
    }

slides = cookSlides <| List.concat
    [
    intro
    ,content
    ,summary
    ]


intro =
    [RawSlide { content = Html.div [HtmlAttr.class "slide"]
        [Html.h1
            [HtmlAttr.style "font-size" "72px"]
            [Html.text metadata.title]
        ,Html.h2
            []
            [Html.text "Some thoughts on the use of open source software in science"]
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

textTableR : List String -> List (List String) -> Html msg
textTableR headers tcontent =
    Html.table
        [HtmlAttr.class "text-table"]
        [Html.thead [] [Html.tr [] (List.map (Html.th [] << List.singleton << Html.text) headers)]
        ,let
            mkTR c = case c of
                (first::rest) -> Html.tr [] (Html.td [] [Html.text first] :: List.map (Html.td [HtmlAttr.class "right"] << List.singleton << Html.text) rest)
                [] -> Html.tr [] [] -- Should never happen
        in Html.tbody [] (List.map mkTR tcontent)
        ]

content =
    [mkSlide "A little about myself"
        [HS.img80 "/Media/BDB-Lab_tools_timeline.svg"
        ,HS.textUL
            [ "Computational biologist (working on the microbiome)"
            , "Released several tools throughout the years"
            , "Contributed to open source projects prior to working in science"
            ]
        ]
    ,mkSteppedSlide "Different types of code"
       [[Html.h3 [] [Html.text "1. One off analyses"]
        ,Html.h3 [] [Html.text "2. Supporting a publication (Extended Methods)"]
        ,Html.h3 [] [Html.text "3. Tools"]
        ,Html.div [HtmlAttr.style "padding-top" "1em"]
            [HS.p "As a rule of thumb, each level is 5-10x more effort" ]
         ]
        ,[Html.h3 [] [Html.text "1. One off analyses"]
        ,HS.textUL
            ["To show at a group meeting"
            ,"Quick-n-dirty"
            ,"No documentation is needed"
            ,"Should be correct most of the time, but often wrong"
            ]
        ,Html.h3 [] [Html.text "2. Supporting a publication (Extended Methods)"]
        ,Html.h3 [] [Html.text "3. Tools"]
        ,Html.div [HtmlAttr.style "padding-top" "1em"]
            [HS.p "As a rule of thumb, each level is 5-10x more effort" ]
        ]
        ,[Html.h3 [] [Html.text "1. One off analyses"]
        ,Html.h3 [] [Html.text "2. Supporting a publication (Extended Methods)"]
        ,HS.textUL
            ["To generate the figures/statements in a paper"
            ,"Needs to be understandable"
            ,"Design can be minimal"
            ,"Basic correctness checks are necessary, but automated checking may not be worthwhile"
            ,"Can be inflexible and brittle"
            ,"Fast enough is good enough (once only run a single number of times in total)"
            ]
        ,Html.h3 [] [Html.text "3. Tools"]
        ,Html.div [HtmlAttr.style "padding-top" "1em"]
            [HS.p "As a rule of thumb, each level is 5-10x more effort" ]
        ] ,[Html.h3 [] [Html.text "1. One off analyses"]
        ,Html.h3 [] [Html.text "2. Supporting a publication (Extended Methods)"]
        ,Html.h3 [] [Html.text "3. Tools"]
        ,HS.mdToHtml """
- To be used by others (hopefully many, **plan for success**)
- Automated checking is definitely worthwhile
- Documentation is important
- Even small optimizations are often worth it
"""
        ,Html.div [HtmlAttr.style "padding-top" "1em"]
            [HS.p "As a rule of thumb, each level is 5-10x more effort" ]
        ]]

    ,mkIncrementalSlide "Optimizing SemiBin"
        [   [HS.mdToHtml """
SemiBin is a tool to bin contigs in metagenomics using semi-supervised learning<br/>
(if you have no clue what that means, it is not important for this talk)."""]
        ,   [HS.p "I spent ~4 days optimizing the most common usage & saved about 9 or 10 minutes per run (15 minutes → 5 minutes)"]
        ,   [HS.p "Was it worth it?"]
        ,   [HS.mdToHtml """
**Plan for success**: if ~1,000 papers use it and each paper uses it 10 times, that's 10,000 runs.
In total, 10 minutes × 10,000 runs is ~70 days.
""" ]
        ]

    ,mkSlide "Most projects are small"
        [
        Html.h3 [] [Html.text "Number of contributors"]
        ,textTableR
            ["Project"
            ,"Total"
            ,"Effective"]

            [ [ "Mahotas", "30", "1.4" ]
            , [ "Jug", "17", "1.5" ]
            , [ "SemiBin", "5", "2.2" ]
            , [ "NGLess", "9", "2.2" ]
            , [ "Megahit", "14", "2.3" ]
            , [ "Macrel", "5", "2.9" ]
            , [ "Seaborn", "175", "3.3" ]
            , [ "Scikit-bio", "82", "13.1" ]
            , [ "Python (CPython)", "2,152", "77.1" ]
            , [ "Scikit-learn", "2,755", "157.8" ]
            ]
        ,HS.mdToHtml "`Effective = exp(H)`, where `H` is the entropy of the number of commits per contributor."
        ]

    ,mkIncrementalSlide "Projects are embedded in a larger ecosystem"
        [[HS.mdToHtml """
- Python data stack contains many projects, big (Scikit-learn) and small (Seaborn), which still act together
- Scientific projects are often similar
- Important to **give credit where credit is due**
"""
        ], [ Html.h3 [] [Html.text "Make small contributions"]
           ,HS.textUL
                ["See a typo in the docs? Fix it!"
                ,"Wrappers (e.g. for Galaxy)"
                ,"Improve error messages"
                ,"Add testing"
                ]
        ],[Html.h3 [] [Html.text "Contributions are not just code"]
        ,HS.textUL
            ["A small documentation fix is a contribution"
            ,"A test is a contribution"
            ,"A bug report is a contribution"
            ]
        ]]

    ]


summary =
    [mkSlide "Summary: think of yourself as part of a community"
        [HS.mdToHtml """
- Most projects are small projects
- Most collaboration is within small teams (that may know each other IRL)
- Think about what is _worthwhile for your project_
- Accept small contributions
- Make small contributions
- Not all contributions need to be code commits
"""
        ,Html.h3 [] [Html.text "Acknowledgements"]
        ,HS.textUL
            ["All the users who reported bugs and gave feedback"
            ,"All the co-authors on the different projects (too many to name)"
            ]
        ]
    ,RawSlide <| { content =
            Html.div [HtmlAttr.class "slide"]
                [Html.h2 [
                    HtmlAttr.style "padding-top" "50vh"
                    ,HtmlAttr.style "padding-left" "50%"
                    ,HtmlAttr.style "font-size" "64px"] [Html.text "Thank you"]]
     , slideType = Slides.Follower }
    ]

