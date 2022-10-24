module Content.NGLess exposing (nglessSlides)

import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Slides exposing (mkSlide, mkIncrementalSlide)
import SyntaxHighlight exposing (useTheme, gitHub, python, toBlockHtml)
import HtmlSimple as HS

nglessExample = """ngless "1.5"
import "gmgc" version "1.0"

## (1) LOAD DATA
input = load_fastq_directory("input")

# Preprocess the data
input = preprocess(input) using |r|:
    r = substrim(r, min_quality=25)
    if len(r) < 45:
        discard

## (2) MAP AGAINST GENE CATALOG
### gmgc mapping 1 map to the chosen subcatalog
mapped = map(input, reference="gmgc:human-gut:no-rare")

### gmgc mapping 2: filter out bad hits
mapped = select(mapped) using |mr|:
    mr = mr.filter(min_match_size=45, min_identity_pc=95, action={unmatch})

## (3) Count for 'eggNOG Orthologous group'
counts_eggNOG_OGs = count(mapped,
                             features=["eggNOG_OGs"],
                             multiple={dist1})
write(counts_eggNOG_OGs, ofile="output/ngless.out.dist1.eggNOG_OGs.tsv.gz")
"""

nglessSlides : List (Slides.RawSlide msg)
nglessSlides =
    [ mkSlide "NGLess: a Domain Specific Language for NGS data processing"
        [ Html.ul []
            [Html.li []
                [ Html.text "NGLess is a domain-specific language for NGS data analysis" ]
            ,Html.li []
                [ Html.text "We developed it for our own needs, but we hope it will be useful for others" ]
            ]
        ]
    , mkIncrementalSlide "What do we want from our (bioinformatics) pipelines"
        [
            [Html.h3 [] [Html.text "Usability"]]
        ,   [HS.floatLeftDiv "40%"
                [ HS.textUL
                    [ "Work out of the box"
                    , "Single click/single command"
                    , "Usable by domain experts"
                    ]
                ]
            ,HS.floatLeftDiv "40%"
                [ HS.textUL
                    [ "Highly flexible (adapt to specific domain)"
                    , "Integratable into many settings"
                    , "Friendly to bioinformaticians"
                    ]
                ]
            ] , [
            HS.floatClear
            ,Html.h3 [] [Html.text "Stability"]
            , HS.floatLeftDiv "40%"
                [HS.textUL
                    ["Reproducible"
                    ,"Stable over many years"
                    ]
                ]
            , HS.floatLeftDiv "40%"
                [HS.textUL
                    ["Evolve with time (agile)"
                    ,"New versions coming out fast"
                    ]
                ]
            ] , [
            HS.floatClear
            ,Html.h3 [] [Html.text "Performance"]
            , HS.floatLeftDiv "40%"
                [HS.textUL
                    ["Fast"
                    ,"Scalable"
                    ]
                ]
            , HS.floatLeftDiv "40%"
                [HS.textUL
                    ["The slowest element is the user"
                    ]
                ]
            ]
        ]
    , mkSlide "NGLess is a domain-specific programming language"
        [ Html.ul []
            [Html.li []
                [ Html.text "Imperative style (as are most widely used languages in bioinformatics, see "
                , Html.a [HtmlAttr.href "https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005871"]
                    [Html.text "Carey et al., 2018"]
                ,Html.text ")"]
            ,Html.li [] [Html.text "Python/Ruby inspired-syntax" ]
            ,Html.li [] [Html.text "Statically-typed, but with inferred types"]
            ,Html.li [] [Html.text "Limited functionality (not Turing-complete)"]
            ,Html.li [] [Html.text "Interpreter implemented in Haskell"]
            ]
        ]
    , mkSlide "NGLess Example"
        [ useTheme gitHub
        , python nglessExample
            |> Result.map (toBlockHtml Nothing)
            |> Result.withDefault
                (Html.pre [] [ Html.code [] [ Html.text nglessExample ]])
        ]

    , mkSlide "Adapted to bioinformatics (specifically NGS)"
        [ Html.h3 [] [Html.text "Types"]
        , HS.textUL
            [ "ShortRead"
            , "ShortReadSet"
            , "InputFile"
            , "OutputFile"
            , "..."
            ]
        , HS.p "Many types correspond to file types, not in-memory object types."
        ]
    , mkIncrementalSlide "Avoiding reproduction noise by defining what you are computing"
        [[Html.blockquote
            [HtmlAttr.style "background" "#eeeeee"
            ,HtmlAttr.style "width" "80%"
            ,HtmlAttr.style "padding" "1em"
            ,HtmlAttr.style "color" "maroon"
            ,HtmlAttr.style "border-radius" "20px"
            ,HtmlAttr.style "font-size" "48px"
            ]
            [Html.em []
                [Html.text "Reproduction noise"]
            , Html.text " is the difference between running the same code on the same data on different machines/environments/versions"]
            ],
            [Html.p []
                [Html.text "Fundamental problem is that "
                , Html.code []
                    [Html.text "results = machine(code, data, "
                    ,Html.strong [] [Html.text "environment, config"]
                    ,Html.text ")"]
                ]
            ,HS.mdToHtml "One solution is to _freeze the environment &amp; config_."
            ],
            [HS.p "We aim instead to define the computation precisely:"
            ,Html.code []
                [Html.text "results = machine(code, data)"]
            ]]
    , mkSlide "Separate out \"incidental information\""
        [HS.img50 "/Media/NGLess/everything-tweet.svg"
        ,Html.ul []
            [Html.li []
                [ Html.text "If it changes the results, it must be reflected "
                , Html.strong [] [Html.text "in the script"]
                ]
            ,Html.li []
                [ Html.text "Otherwise, it is configuration:"
                , HS.textUL
                    [ "Where to store temporary files"
                    , "How many threads to use"
                    , "..."
                    ]
                ]
            ]
        ,HS.mdToHtml "_Incidental information_ is everything that does not **change the results**."
        ]
    , mkSlide "NGLess fails well"
        [Html.blockquote [] [Html.text "Too many tools work well, but fail badly"]
        ,HS.img50 "/Media/NGLess/error-messages.png"
        ,Html.p []
            [Html.text "Most time in software development is used in debugging"
            ,Html.sup [] [Html.text "[CITATION NEEDED]"]
            ,Html.text "."]
        ]
    , mkSlide "We treated bad error messages as bugs"
        [ HS.img50 "/Media/NGLess/bad-error-messages-are-bugs.png"
        ,HS.p "Sometimes, these are the hardest bugs to fix!"
        ,HS.p "Still, please report bad error messages."
        ]
    , mkSlide "Fail clearly"
        [HS.img50 "/Media/NGLess/no-errors.png"
        ,HS.textUL
            [ "Never output wrong results"
            , "Never output partial results"
            , "Fail as fast as possible"
            ]
        ]
    , mkSlide "Check inputs/outputs"
        [HS.img50 "/Media/NGLess/create-outputs.png"
        ,HS.textUL
            [ "Input/output arguments are annotated as such"
            , "Checks can be performed early"
            ]
        ]
    , mkSlide "NGLess Example (redux)"
        [ useTheme gitHub
        , python nglessExample
            |> Result.map (toBlockHtml Nothing)
            |> Result.withDefault
                (Html.pre [] [ Html.code [] [ Html.text nglessExample ]])
        ]
    , mkSlide "NGLess is faster than alternatives at large-scale metagenomics processing"
        [Html.ul []
            [Html.li []
                [ Html.text "This was not our main goal, but it is a nice side-effect" ]
            ]
        ,HS.img80 "/Media/NGLess/Figure2-benchmark.svg"]
    ]

