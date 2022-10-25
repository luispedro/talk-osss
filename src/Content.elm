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
    ,highlevel
    ,casestudy
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

highlevel =
    [mkSlide "A little about myself and my group"
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
            ,"Use of existing tools is encouraged to the maximum extent"
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
- Dependencies bring costs
"""
        ,Html.div [HtmlAttr.style "padding-top" "1em"]
            [HS.p "As a rule of thumb, each level is 5-10x more effort" ]
        ]]

    ,mkIncrementalSlide "Case Study I: Optimizing SemiBin"
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

casestudy =
    [mkIncrementalSlide "Case study II: NGLess"
        [[HS.img50 "/Media/BDB-Lab_tools_timeline.svg"]
        ,[
            HS.floatRightDiv "60%" [HS.img80 "/Media/NGLess/NGLess-code-example_small.png"]
            ,HS.mdToHtml """
### Focus on NGLess

Tool to analyze NGS data (e.g. metagenomics) in a reproducible way<br/>
(also not that terribly important for this presentation)
"""
        ],[HS.p "Why did it take so long to mature?"]
        ]
    ,mkIncrementalSlide "Make a robust tool requires real-world usage"
        [[Html.h3 [] [Html.text "A weird crash"]
        ,HS.floatRightDiv "40%"
            [HS.imgw "50%" "/Media/19c27ae2-1b72-4186-8857-007e6f61abc2_luispedro_a_femalescientistworkingatacomputersurroundedbypetridishesinpopartstyle.png"
            ,Html.br [] []
            ,HS.imgw "50%" "/Media/2fcb3983-8f34-42f6-919b-294f47acf240_luispedro_a_femalescientistworkingatacomputerinpopartstyle.png"
            ]
        ,HS.mdToHtml """
1. A user reported a weird crash
2. It seemed very trivial use, which we had tested
3. Turns out that the had a corrupt file (a chunk of zero Bytes in the middle)"""]
        ,[Html.h3 [] [Html.text "A slight inconsistency"]
        ,HS.mdToHtml """
1. The language had a slight inconsistency
2. It was not a big deal for us internally, but made it complex to teach
3. We fixed it, but without running a tutorial, we would not have noticed"""
        ]
        ,[Html.h3 [] [Html.text "A bug in a dependency"]
        ,HS.mdToHtml """
1. A bug in a dependency gave incorrect results
2. The dependency was open source, so we could fix it there and require the new version
3. We did not notice the bug until a user reported it"""
        ]
        ]
    ,mkIncrementalSlide "Case study III: Jug"
        [[HS.img50 "/Media/BDB-Lab_tools_timeline.svg"]
        ,[HS.floatRightDiv "60%" [Html.img [HtmlAttr.src "/Media/Jug/jug-example-short.png"] []]
        , HS.mdToHtml """
### Focus on Jug

- Tool to run workflows in Python
- Scratch an itch tool
- Not particularly successful at attracting users/contributors
- Still very successful at solving my problems
"""],[ HS.mdToHtml """
### A couple of derived tools

- [Gridjug](https://github.com/andsor/gridjug)
- [Jug-schedule](https://pypi.org/project/jug-schedule/)

In an ecosystem, it is hard to tell what is a contribution to any project.
Contribute _to the ecosystem_!

"""] ]
    ,mkIncrementalSlide "Software ecosystems enable working together apart"
    [[Html.h3 [] [Html.text "Old model: projects are self contained"]
     ,HS.floatRightDiv "20%" [HS.img80 "/Media/luispedro_a_computer_programmer_working_a_glass_bubble_in_pop_a_fa431846-0359-478b-9482-485a3c5b403b.png"]
     ,HS.mdToHtml """
- Others are competitors (scooping is a risk)
- No sharing of data, code, ... without a contract!
"""]
    ,[Html.h3 [HtmlAttr.style "padding-top" "2em"] [Html.text "Utopia: everyone works together in a flat hierarchy"]
     ,HS.mdToHtml """
- Share everything
- It does not matter where you are (geographically, hierarchically, disciplinarily, ...)
- Credit doesn't matter
"""]

    ,[Html.h3 [HtmlAttr.style "padding-top" "2em"] [Html.text "Ecosystems reality: projects are independent but part of larger ecosystems"]
     ,HS.floatRightDiv "20%" [HS.img80 "/Media/luispedro_many_programmers_working_together_in_a_scientific_pro_a645b24d-9a50-4aac-ac96-8ba1b692cf93.png"]
     ,HS.mdToHtml """
- Collaborate with other in multiscale ways: closely work with small number of people; loosely collaborate across the world
- Credit where credit is due
"""]]
    ]

summary =
    [mkSlide "Summary: think of yourself as part of a community"
        [HS.mdToHtml """
- Multiscale collaboration (tight within small team, but still collaborating with everyone)
- Think about what is _worthwhile for your project_
- Accept small contributions
- Make small contributions
- Not all contributions need to be code commits
- Credit where credit is due (_e.g._, in scientific publications, cite everyone)
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
    ,RawSlide <| { content =
            Html.div [HtmlAttr.class "slide"]
                [Html.h2 [
                    HtmlAttr.style "padding-top" "50vh"
                    ,HtmlAttr.style "padding-left" "50%"
                    ,HtmlAttr.style "font-size" "64px"] [Html.text "Thank you"]
                    ,HS.mdToHtml """
Feel free to follow up on Twitter (@luispedrocoelho) or Email (luis@luispedro.org) or join my **open office hours on Thursday**: [https://bit.ly/2022-10-27-lpc-office-hours] (https://bit.ly/2022-10-27-lpc-office-hours)
                    """
                ]
     , slideType = Slides.Follower }
    ]

