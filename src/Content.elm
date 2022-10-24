module Content exposing (metadata, slides)

import Html exposing (Html)
import Html.Attributes as HtmlAttr

import Chart as C
import Chart.Attributes as CA

import Slides exposing (RawSlide(..), mkSlide, mkIncrementalSlide, mkSteppedSlide, cookSlides)
import HtmlSimple as HS
import Content.Common exposing (personImage)
import Content.Jug exposing (jugSlides)
import Content.NGLess exposing (nglessSlides)
import Content.SemiBin exposing (semibinSlides)

metadata =
    { title = "Big catalogs and small genes. Tools and techniques for analyzing large-scale sequencing data"
    , shortTitle = "Tools for large-scale metagenomics data"
    }

slides = cookSlides <| List.concat
    [
    intro
    ,gmgcv1SlidesA
    ,nglessSlides
    ,jugSlides
    ,semibinSlides
    ,gmgcv1SlidesB
    ,gmgcv2slides
    ,available
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


gmgcv1SlidesA =
    [
        mkSlide "The global microbiome"
            [HS.img80 "/Media/GMGC/Fig1a-layered_2.svg"
            ,Html.p [HtmlAttr.style "padding-top" "0em"]
                    [Html.text "Coelho "
                    ,Html.em [] [Html.text "et al."]
                    ,Html.text ", Nature, 2022"]
            ]
    , mkSteppedSlide "GMGC generation process"
        (List.range 1 7 |> List.map (\ix ->
            [HS.img80 <| "/Media/GMGC/Generation/GMGC_generation_" ++ String.fromInt ix  ++ ".png"]))
    , mkSteppedSlide "The Global Microbial Gene Catalog (GMGCv1)"
        ([2,4,6] |> List.map (\ix ->
            [HS.img80 <| "/Media/GMGC/Fig1a-layered_" ++ String.fromInt ix ++ ".svg"]))
    ]
gmgcv1SlidesC =
    [ mkSteppedSlide "A catalog of species-level unigenes & more"
           [[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "40%"
                ]
                [HS.img80 "/Media/GMGC/SuppFigure2a.svg"]]
           ,[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "20%"
                ]
                [HS.img80 "/Media/GMGC/SuppFigure2a.svg"]
            ,Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "60%"
                ]
                [HS.mdToHtml """
### GMGCv1 as a resource

- 303 million **unigenes** (both nucleotide & amino acid sequences)
- 32 million **protein families**
- 50 thousand _high-quality_ **metagenome-assembled genomes (MAGs)**
- 13 thousand **metagenomes**
- 86 thousand **isolate genomes** (proGenomes v2)
""" ]]
           ,[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "20%"
                ]
                [HS.img80 "/Media/GMGC/SuppFigure2a.svg"]
            ,Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "60%"
                ]
                [HS.mdToHtml """
### GMGCv1 as a resource

- 303 million **unigenes** (both nucleotide & amino acid sequences)
- 32 million **protein families**
- 50 thousand _high-quality_ **metagenome-assembled genomes (MAGs)**
- 13 thousand **metagenomes**
- 86 thousand **isolate genomes** (proGenomes v2)
"""
            ,Html.h3 [] [Html.text "From data to knowledge"]
            ,Html.p []
                [Html.img [HtmlAttr.src "/Media/b025cb18-dc93-4e8e-a8ec-6abee91855b1_luispedro_httpss.mj.runQguyil__a_mountain_of_biological_data_containing_microbes_from_all_over_the_world_in_th.png"
                      ,HtmlAttr.style "width" "30%"] []
                ,Html.img [HtmlAttr.src "/Media/e6538915-07e9-4400-8aef-2fa876e3e456_luispedro_httpss.mj.runUlabsf__a_mountain_of_biological_data_containing_microbes_from_all_over_the_world.png"
                          ,HtmlAttr.style "padding-left" "1em"
                          ,HtmlAttr.style "width" "30%"] []
                ,Html.br [] []
                ,Html.i [] [Html.text "A mountain of biological data"]
                ]
            ]]]
    , mkSlide "Only a few unigenes are shared between environments (multi-habitat genes)"
            [HS.img80 "/Media/GMGC/gene-flow.svg.png"
            ,HS.p "Little sharing overall, but concentrated on the mammalian guts"
            ]

    ,mkSlide "Unigenes are shared between similar environments"
        [HS.img80 "/Media/GMGC/mammal-flow.svg"
        ,HS.p "Little sharing overall, but concentrated on the mammalian guts"
        ]
    , mkSteppedSlide "Most genes are rare and the global pangenome is open"
        [
            [HS.img80 "/Media/GMGC/submission.2020.04/Figure5-rare.svg"
            ,HS.mdToHtml "This is what is predicted by _models of (nearly-)neutral evolution_ (Baumdicker et al., 2010; see also Wolf et al., 2016) "]
            ,[Html.div
                [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "width" "20%"
                ,HtmlAttr.style "height" "100%"
                ,HtmlAttr.style "padding-right" "2em"
                ]
                [HS.img80 "/Media/GMGC/submission.2020.04/Figure5-rare.svg"
                ,HS.mdToHtml "This is what is predicted by _models of (nearly-)neutral evolution_ (Baumdicker et al., 2010; see also Wolf et al., 2016) "]
            ,Html.div
                [HtmlAttr.style "width" "68%"
                ]
                [Html.h2 [] [Html.text "We can saturate common genes, but global pangenomes is open"]
                ,Html.img [HtmlAttr.src "/Media/GMGC/Fig1d_inset.png"] []
                ,HS.mdToHtml """
The human gut is the most explored model system, but we can still find new genes

Host specific, short-term, evolution has been reported by several studies (Garud et al., 2019; Chen et al., 2022)
"""]]]
    , mkSlide "Most genes and rare ones, in particular, are not under strong positive selection"
        [HS.img80 "/Media/GMGC/Figure6-selection_horizontal.svg"
        ,HS.p "At different levels"
        ,Html.ul []
            [Html.li [] [Html.text " Low levels of selection"]
            ,Html.li [] [Html.text " Increased selection for more prevalent genes"]]
        ]
   , mkSlide "GMGC structure"
            [Html.h4 [ HtmlAttr.style "padding-top" "0em"
                        ,HtmlAttr.style "margin-top" "0em"]
                [Html.text "Most genes group into a (relatively) small number of families"]
            ,HS.img80 "/Media/GMGC/submission.2020.04/Figure2-gf-sizes.svg"
            ]
    ,mkSlide "There is a habitat signature in the ratio of orthologs/unigenes"
        [HS.img80 "/Media/GMGC/submission.2020.04/Figure4-densities-per-species.svg"
        ,HS.p "Frankly, I'm still not sure what is going on here"
        ]

    ,mkSlide "The environmental patterns are a mixture of subpatterns"
        [HS.img80 "/Media/GMGC/Habitat-subpatterns-horizontal.svg"
        ,HS.p "Environmental samples are a mixture of sub-habitats"
        ]
    , mkSteppedSlide "Searching GMGC"
        (List.range 3 4 |> List.map (\ix ->
            [HS.img80 <| "/Media/GMGC/GMGG_embl_de/GMGC_web_" ++ String.fromInt ix ++ ".png"]))
    , mkSlide "GMGC can be accessed through an API"
        [Html.p []
                    [Html.code [] [Html.text "curl https://gmgc.embl.de/api/v1.0/unigene/GMGC10.054_598_380.SCLAV_5304"]]
        ,Html.pre [HtmlAttr.style "font-size" "14px"]
            [Html.text """
{
  "gene_family": "GMGC10.205_457_183.UNKNOWN",
  "cluster": "GMGC10.146_435_694.SCLAV_5304",
  "query": "GMGC10.054_598_380.SCLAV_5304",
  "name": "GMGC10.054_598_380.SCLAV_5304",
  "taxonomy": [
    {
            ...."""]
        ,Html.p []
            [Html.text "All the information is queriable/retrievable automatically"]
        ,Html.div [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "text-align" "left"
                ,HtmlAttr.style "width" "20%"]
            [Html.img
                [HtmlAttr.src "/Media/b76064e1-e495-42ed-ae6c-59de6e487569_luispedro_A_bioinformaticians_sits_at_her_computer_and_analyzes_DNA_from_the_microbes_of_the_whole_planet.png"
                ,HtmlAttr.style "width" "100%"]
                []
            ,Html.br [] []
            ,Html.i [] [Html.text "A bioinformatician sits at her computer and analyzes DNA from the microbes of the whole planet"]
            ]
        ,Html.div [HtmlAttr.style "padding-top" "1em"
                ,HtmlAttr.style "float" "right"
                ,HtmlAttr.style "width" "20%"
                ,HtmlAttr.style "text-align" "right"]
            [Html.img
                [HtmlAttr.style "width" "100%"
                ,HtmlAttr.src "/Media/bd477752-398e-4a79-9177-1f440d109404_luispedro_a_female_scientist_working_at_a_computer_surrounded_by_beakers_in_the_style_of_robert_eggers.png"]
                []
            ,Html.br [] []
            ,Html.i [] [Html.text "A bioinformatician, in the style of Robert Eggers"]]
        ]
    ,mkSlide "All data is available for download"
        [HS.img80 "/Media/GMGC/GMGC10_data.png"
        ,Html.p []
            [Html.a [HtmlAttr.href "https://git.embl.de/coelho/GMGC10.data"]
                [Html.text "https://git.embl.de/coelho/GMGC10.data"]
            ]
        ]
    ]

gmgcv1SlidesB =
    [ mkSlide "GMGCv1 as a resource"
            [HS.mdToHtml """
- 303 million **unigenes** (both nucleotide & amino acid sequences)
- 32 million **protein families**
- 50 thousand _high-quality_ **metagenome-assembled genomes (MAGs)**
- 13 thousand **metagenomes**
- 86 thousand **isolate genomes** (proGenomes v2)
"""
            ,Html.h3 [] [Html.text "From data to knowledge"]
            ,Html.p []
                [Html.img [HtmlAttr.src "/Media/b025cb18-dc93-4e8e-a8ec-6abee91855b1_luispedro_httpss.mj.runQguyil__a_mountain_of_biological_data_containing_microbes_from_all_over_the_world_in_th.png"
                      ,HtmlAttr.style "width" "30%"] []
                ,Html.img [HtmlAttr.src "/Media/e6538915-07e9-4400-8aef-2fa876e3e456_luispedro_httpss.mj.runUlabsf__a_mountain_of_biological_data_containing_microbes_from_all_over_the_world.png"
                          ,HtmlAttr.style "padding-left" "1em"
                          ,HtmlAttr.style "width" "30%"] []
                ,Html.br [] []
                ,Html.i [] [Html.text "A mountain of biological data"]
                ]
            ]
    , mkSlide "Only a few unigenes are shared between environments (multi-habitat genes)"
            [HS.img80 "/Media/GMGC/gene-flow.svg.png"
            ,HS.p "Little sharing overall, but concentrated on the mammalian guts"
            ]

    ,mkSlide "Unigenes are shared between similar environments"
        [HS.img80 "/Media/GMGC/mammal-flow.svg"
        ,HS.p "Little sharing overall, but concentrated on the mammalian guts"
        ]
    , mkSteppedSlide "Searching GMGC"
        (List.range 3 4 |> List.map (\ix ->
            [HS.img80 <| "/Media/GMGC/GMGG_embl_de/GMGC_web_" ++ String.fromInt ix ++ ".png"]))
    , mkSlide "GMGC can be accessed through an API"
        [Html.p []
                    [Html.code [] [Html.text "curl https://gmgc.embl.de/api/v1.0/unigene/GMGC10.054_598_380.SCLAV_5304"]]
        ,Html.pre [HtmlAttr.style "font-size" "14px"]
            [Html.text """
{
  "gene_family": "GMGC10.205_457_183.UNKNOWN",
  "cluster": "GMGC10.146_435_694.SCLAV_5304",
  "query": "GMGC10.054_598_380.SCLAV_5304",
  "name": "GMGC10.054_598_380.SCLAV_5304",
  "taxonomy": [
    {
            ...."""]
        ,Html.p []
            [Html.text "All the information is queriable/retrievable automatically"]
        ,Html.div [HtmlAttr.style "float" "left"
                ,HtmlAttr.style "text-align" "left"
                ,HtmlAttr.style "width" "20%"]
            [Html.img
                [HtmlAttr.src "/Media/b76064e1-e495-42ed-ae6c-59de6e487569_luispedro_A_bioinformaticians_sits_at_her_computer_and_analyzes_DNA_from_the_microbes_of_the_whole_planet.png"
                ,HtmlAttr.style "width" "100%"]
                []
            ,Html.br [] []
            ,Html.i [] [Html.text "A bioinformatician sits at her computer and analyzes DNA from the microbes of the whole planet"]
            ]
        ,Html.div [HtmlAttr.style "padding-top" "1em"
                ,HtmlAttr.style "float" "right"
                ,HtmlAttr.style "width" "20%"
                ,HtmlAttr.style "text-align" "right"]
            [Html.img
                [HtmlAttr.style "width" "100%"
                ,HtmlAttr.src "/Media/bd477752-398e-4a79-9177-1f440d109404_luispedro_a_female_scientist_working_at_a_computer_surrounded_by_beakers_in_the_style_of_robert_eggers.png"]
                []
            ,Html.br [] []
            ,Html.i [] [Html.text "A bioinformatician, in the style of Robert Eggers"]]
        ]
    ,mkSlide "All data is available for download"
        [HS.img80 "/Media/GMGC/GMGC10_data.png"
        ,Html.p []
            [Html.a [HtmlAttr.href "https://git.embl.de/coelho/GMGC10.data"]
                [Html.text "https://git.embl.de/coelho/GMGC10.data"]
            ]
        ]
    ,mkSlide "We are trying to cater to a range of uses"
            [HS.img80 "/Media/GMGC/GMGC-tools-gradient.png"
            ,Html.div
                [HtmlAttr.style "float" "right"
                ,HtmlAttr.style "width" "320px"
                ]
                [Html.img [HtmlAttr.src "/Media/19c27ae2-1b72-4186-8857-007e6f61abc2_luispedro_a_femalescientistworkingatacomputersurroundedbypetridishesinpopartstyle.png"
                    ,HtmlAttr.style "width" "260px"]
                    []
                ,Html.p []
                    [Html.i []
                        [Html.text "a scientist working at her computer, surrounded by petri dishes, in pop art style"]
                    ]
                ]
            ]
    ]


gmgcv2slides =
    [{-mkSlide "The future of GMGC I: More data"
        [HS.img80 "/Media/GMGCv2/GMGCv2.map.png"]
        , -}mkIncrementalSlide "The future of GMGC: Microproteins"
        [

            [HS.mdToHtml """In the work I showed you before, we ignored any
sequences that were _too small_, namely those under 32 amino-acids
(and often <100 AA). Only a few efforts (most notably, [Sberro et al.,
2019](https://doi.org/10.1016/j.cell.2019.07.016)) considered
microproteins at large scale."""]

            ,[HS.mdToHtml """
### Small genes are not just smaller

- Hard to predict
- Hard to assign function by homology
- Modules, families harder to predict
- Evolutionary signals harder to identify
"""]
            ,[personImage "Yiqian Duan" "/Media/BigDataBiology/people/YiqianDuan.jpg"
            ,personImage "Célio Dias Santos-Júnior"
                    "/Media/BigDataBiology/people/CelioDiasSantosJunior.jpg"
            ,HS.mdToHtml """
### First target: antimicrobial peptides (AMPs)

1. short peptides (≤ 100 amino acids)
2. antimicrobial
"""
            ]
    ]
    , mkSlide "Macrel"
        [HS.img80 "/Media/macrel/2020-04/Fig1_touched.svg"
        ,Html.br [] []
        ,Html.p []
            [Html.a [HtmlAttr.href "https://peerj.com/articles/10555/"]
            [Html.text "(Dias Santos-Junior, et al., 2020)"
            ,Html.span [HtmlAttr.style "padding-left" "4em"]
                [Html.a [HtmlAttr.href "https://big-data-biology.org/software/macrel"]
                    [Html.text "https://big-data-biology.org/software/macrel"]
                ]]
            ]
        ]
    ,mkSlide "Evaluation against standard benchmarks"
        [HS.img80 "/Media/macrel/Table_performance.png"
        ]
    ,mkSlide "Sequence identity (homology) does not work"
        [HS.img80 "/Media/macrel/Figure3-slide.svg"]
    {-, mkSlide "Most of the AMPSphere is 25-45 amino acids long"
            [HS.img80 "/Media/AMPsphere/macrel-ampsphere-size.svg"]
    ,mkSlide "We performed in silico QC"
        [HS.img80 "/Media/AMPsphere/ampsphere_qc.svg"
        ,HS.p "We matched to available experimental data (but rarely matched samples)"]
        ]
    ,mkIncrementalSlide "Most of the AMPSphere is novel"
        [[Html.div
            [HtmlAttr.style "width" "45%"
            ,HtmlAttr.style "float" "left"]
            [Html.img [
                HtmlAttr.src "/Media/AMPsphere/ampsphere-homologs.svg"
                ,HtmlAttr.style "width" "100%"]
                []
            ,Html.p
                []
                [Html.a
                    [HtmlAttr.href "https://academic.oup.com/bib/article/19/4/636/2962821?login=true"]
                    [Html.text "smProt: (Hao et al., Briefings in Bioinformatics, 2017)"]
                ,Html.br [] []
                ,Html.a
                    [HtmlAttr.href "https://www.nature.com/articles/s41597-019-0154-y"]
                    [Html.text "DRAMP: (Kang et al., Scientific Data, 2019)"]
                ,Html.br [] []
                ,Html.a
                    [HtmlAttr.href "https://academic.oup.com/bioinformatics/article/35/22/4739/5474901"]
                    [Html.text "starPepDB: (Aguilera-Mendoza et al., Bioinformatics, 2019)"]
                ]
         ]]
        ,[Html.img [
            HtmlAttr.src "/Media/AMPsphere/q_rel.svg",
            HtmlAttr.style "width" "45%"
            ] []
            ]] -}
    , mkSlide "Bacteria in host associated habitats produce more AMPs"
        [Html.img [
            HtmlAttr.src "/Media/AMPsphere/amp-density-per-habitat.svg"
            ,HtmlAttr.style "width" "100%"]
            []]
    {-
    , mkSlide "Habitat overlap is limited"
        [HS.img80 "/Media/AMPsphere/heatmap_environments_overlap.svg"]
    , mkSlide "How can we organize these sequences?"
        [Html.h3 [] [Html.text "Sequence identity based clustering does not work as well"]
        ,HS.img80 "/Media/AMPsphere/alignments_significance.svg"
        ]
     , mkSteppedSlide "Most of our \"families\" are singletons"
        [[HS.img80 "/Media/GMGC/submission.2020.04/Figure2-gf-sizes.svg"]
        ,[Html.img
                [HtmlAttr.src "/Media/GMGC/submission.2020.04/Figure2-gf-sizes.svg"
                ,HtmlAttr.style "height" "100px"
                ,HtmlAttr.style "width" "80%"]
                []
        ,HS.img80 "/Media/AMPsphere/sphere-sizes.svg"
        ,HS.p "At the 75% level, 47% of AMPs are singletons (compared to <5% in GMGCv1)"]
        ]
    , mkIncrementalSlide "Have some of the AMPs broken free from larger proteins?"
        [[HS.p "This is a more speculative story (so far)"
        ,Html.ul [HtmlAttr.style "padding-bottom" "0px"
                 ,HtmlAttr.style "margin-bottom" "0px"]
            [Html.li []
                [Html.text "AMPs are often generated from larger proteins"]
            ,Html.li []
                [Html.text "All of the peptides in the AMPSphere are their own smORF"]
            ]]
        ,[ Html.ul [HtmlAttr.style "padding-top" "0px"
                   ,HtmlAttr.style "margin-top" "0px"]
            [Html.li [] [Html.text "~60 thousand matches (8% of AMPSphere)"]]
            ,personImage "Anna Vines" "/Media/BigDataBiology/people/AnnaVines.jpg"
            ,Html.img [HtmlAttr.src "/Media/AMPsphere/Evolution/position.svg"
                      ,HtmlAttr.style "max-height" "60%"] []
            ]]
    , mkSlide "The AMPs form their own subtree"
        [HS.img80 "/Media/AMPsphere/Evolution/AMP10_000_059_tree.svg"
        ,HS.p "We are currently still following up on this"
        ]-}
    , mkSlide "AMPSphere is available online"
        [Html.img
            [HtmlAttr.style "width" "60%"
            ,HtmlAttr.src "/Media/AMPsphere/AMPSphereWebsite.png"
            ] []
        ,personImage "Hui Chong"
                "/Media/BigDataBiology/people/hui_chong.jpeg"
        ,Html.p []
            [Html.a
                [HtmlAttr.href "https://ampsphere.big-data-biology.org"]
                [Html.text "https://ampsphere.big-data-biology.org"]]
        ]
    ]

gmscSlides =
    [mkSlide "Beyond AMPs, we identified >40m high-quality putative small proteins"
        [HS.img80 "/Media/GMSC/GMSC_qc.svg"]
    ]

ackList : String -> List String -> Html msg
ackList h ts =
    Html.div
        [HtmlAttr.attribute "style" "float: left; padding-left: 1em; "]
        [Html.h4 [] [Html.text h]
        ,HS.textUL ts
        ]


available =
    [mkIncrementalSlide "Final toughts: our software quality commitments"
        [[HS.mdToHtml """
### High-quality tools

1. **Five-year support (from date of publication)**
2. **Standard, easy to install, packages**
3. **High-quality code with continuous integration**
4. **Complete documentation**
5. **Work well, fail well**
6. **Open source, open communication**

The principles are expanded on at [https://www.big-data-biology.org/software/commitments/](https://www.big-data-biology.org/software/commitments/)."""]
        ,[Html.h3 [HtmlAttr.style "padding-top" "2em"] [Html.text "We have a track record of long-term maintenance"]
            ,HS.img50 "/Media/BigDataBiology/long-term-tool-maintenance.svg"
            ,HS.mdToHtml """
- Latest update to SemiBin (v1.1.1) was released _this morning_
- Latest update to NGLess (v1.5.0) was released on the _14th of September_
"""]
    ]]

summary =
    [mkSlide "Summary"
        [Html.div
            [HtmlAttr.style "float" "right"
            ,HtmlAttr.style "text-align" "right"]
            [Html.img
                [HtmlAttr.src "/Media/GMGC/fda6741c-21cf-4d0a-b51b-206306f91f8a_luispedro_httpss.mj.runENbBLx__the_earth_made_of_microbes.png"
                ,HtmlAttr.style "width" "400px"
                ] []]
        ,Html.h3 [] [Html.text "Tools"]
        ,HS.mdToHtml """
- **NGLess**: a domain-specific language for NGS data analysis
- **Jug**: organize computations in Python
- **SemiBin**: semi-supervised binning of metagenomic contigs
- **Macrel**: annotation of antimicrobial peptides
"""
        ,Html.h3 [] [Html.text "Resources"]
        ,HS.mdToHtml """
- **GMGCv1**: a database of 303 million unigenes
- **AMPSphere**: a database of AMPs
"""
        ,Html.h3 [] [Html.text "Ecological results"]
        ,HS.mdToHtml """
- _GMGC: Global Microbial Gene Catalog (v1)_: A lof of genes, mostly habitat specific
- Host-associated microbiomes produce more AMPs than environmental ones
"""
        ,Html.h3 [] [Html.text "Tool development principles"]
        ,HS.mdToHtml """
- Work well, fail well
- Minimize reproduction noise
- Long-term commmitment (with track-record going back >10 years)
"""]
    ,mkSlide "Acknowledgements"
            [HS.floatLeftDiv "30%"
                [ ackList "Global microbiome"
                  [ "Alvaro del Río (Madrid)"
                  , "Renato Alves (EMBL)"
                  , "Pernille Neve Meyers (DTU)"
                  , "Thomas Sebastian Schmidt (EMBL)"
                  , "Jaime Huerta-Cepas (EMBL; Madrid)"
                  , "Henrik Bjorn Nielsen (DTU)"
                  , "Ivica Letunic (Biobyte)"
                  , "Peer Bork (EMBL)"
                    ]
                , ackList "NGLess"
                    [ "Renato Alves (EMBL)"
                    , "Paulo Monteiro (IST, Lisbon, Portugal)"
                    , "Jaime Huerta-Cepas (EMBL, Heidelberg, Germany)"
                    , "Ana Teresa Freitas (IST, Lisbon, Portugal)"
                    , "Peer Bork (EMBL, Heidelberg, Germany)"
                    ]
                , ackList "Jug"
                    [ "Renato Alves (EMBL)" ]
                ]
            ,HS.floatLeftDiv "30%"
                [ ackList "SemiBin"
                    [ "Shaojun Pan (Fudan)"
                    , "Xing-Ming Zhao (Fudan)"
                    ]
                , ackList "Macrel & AMPSphere"
                    [ "Célio Santos Dias-Junior (Fudan)"
                    , "Yiqian Duan (Fudan)"
                    , "Marcelo der Torossian Torre (U. Penn)"
                    , "Thomas Sebastian Schmidt (EMBL)"
                    , "Thea van Rossum (EMBL)"
                    , "Shaojun Pan (Fudan)"
                    , "Alvaro del Río (Madrid)"
                    , "Michael Kuhn (EMBL)"
                    , "Anthony Fullam (EMBL)"
                    , "Xingming Zhao (Fudan)"
                    , "Jaime Huerta-Cepas (Madrid)"
                    , "César de la Fuente (U. Penn)"
                    , "Peer Bork (EMBL)"
                  ]
                ]
            ,HS.floatLeftDiv "30%"
                  [Html.div
                    [HtmlAttr.attribute "style" "float: left; padding-left: 2em; "]
                      [Html.h4 [] [Html.text "Funding"]
                      ,Html.img [HtmlAttr.src "/Media/funding/nsfc.png", HtmlAttr.style "height" "92px"] []
                      ,Html.img [HtmlAttr.src "/Media/funding/jpiamr.jpeg", HtmlAttr.style "height" "92px"] []
                      ,Html.img [HtmlAttr.src "/Media/funding/Idrc-logo-full-name-wordmark.png", HtmlAttr.style "height" "92px"] []
                  ]]]
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

ampCatalogBuild = List.singleton <|
    mkSteppedSlide "Building a catalog of AMPs"
        (List.range 0 9
            |> List.map (\ix ->
                [HS.img80 (String.concat
                            ["/Media/AMPsphere/creation/frame"
                            ,String.fromInt ix
                            ,".png"])
                ,HS.p "We are applying the same general approach as GMGC: process all (meta)genomes with a consistent methodology"
                ]))
