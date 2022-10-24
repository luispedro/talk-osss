module Content.Jug exposing (jugSlides)

import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Slides exposing (mkSlide, mkIncrementalSlide, mkSteppedSlide)
import HtmlSimple as HS
import Result

import SyntaxHighlight exposing (useTheme, gitHub, python, toBlockHtml)


jugExample0 = """
def read_sample_list():
...


def count_gc(s):
...

def combine(partials):
...

def write_final(results, oname):
...

samples = read_sample_list()
partials = []
for s in samples:
    partials.append(count_gc(s))
combined = combine(samples, partials)
write_final(combined, 'output.tsv')
"""
jugExample1 = """
from jug import TaskGenerator
def read_sample_list():
...


@TaskGenerator
def count_gc(s):
...

@TaskGenerator
def combine(partials):
...

@TaskGenerator
def write_final(results, oname):
...

samples = read_sample_list()
partials = []
for s in samples:
    partials.append(count_gc(s))
combined = combine(samples, partials)
write_final(combined, 'output.tsv')
"""

jugSlides =
    [mkSlide "Jug: reproducible pipelines with Python"
        [Html.h3 [] [Html.text "Common general structure"]
        ,Html.ol []
            [Html.li [] [Html.text "Process each sample individually"]
            ,Html.li [] [Html.text "Compute global statistics"]
            ,Html.li [] [Html.text "Re-process each sample relative to the statistics"]
            ]
        ,Html.h3 [] [Html.text "Fan-out / Fan-in structure"]
        ,HS.imgw "30%" "/Media/Jug/fan-out_fan-in.svg"
        ,HS.mdToHtml "This structure _is very common_ and has several _embarassingly parallel_ computations."
        ]
    ,mkSlide "Jug example 0: without Jug (standard Python)"
        [ useTheme gitHub
        , python jugExample0
            |> Result.map (toBlockHtml Nothing)
            |> Result.withDefault
                (Html.pre [] [ Html.code [] [ Html.text jugExample0 ]])
        ]

    ,mkSlide "Jug example II: with Jug"
        [ useTheme gitHub
        , python jugExample1
            |> Result.map (toBlockHtml Nothing)
            |> Result.withDefault
                (Html.pre [] [ Html.code [] [ Html.text jugExample0 ]])
        ]
    ,mkIncrementalSlide "Jug is an embedded DSL in Python"
        [
            [HS.p "We defined a computation graph, but we have not computed anything!"
            ,HS.mdToHtml "`jug execute` will execute it."]
        ,   [Html.div [HtmlAttr.style "text-align" "right"] [ Html.img [HtmlAttr.src "/Media/Jug/demo-time.jpeg" ] [] ] ]

        ]
    ]

