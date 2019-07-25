# Preamble

*PAULA XML* or *PAULA* for short (*Potsdamer AUstauschformat Linguistischer
Annotationen*, 'Potsdam Exchange Format for Linguistic Annotations') is a
standoff XML format designed to represent a wide range of linguistically
annotated textual and multi-modal corpora. The format was created at
Potsdam University and developed within SFB 632, the collaborative
research centre "Information Structure", subproject D1, "Linguistic
Database" at Potsdam University and Humboldt-Universität zu Berlin (see
Dipper2005, DipperGoetze2005, ChiarcosEtAl2008). The description below
represents the normative documentation for PAULA version 1.1, with some
notes on previous versions of PAULA. For the latest documentation always
check the PAULA Website which also contains an online HTML version of
this documentation.

The standoff nature of PAULA refers to the fact that each layer of
linguistic annotation, such as part-of-speech annotations,
lemmatizations, syntax trees, coreference annotation etc. are stored in
separate XML files which refer to the same raw data. In this manner
annotations can easily be added, deleted and updated without disturbing
independent annotation layers, and discontinuous or hierarchically
conflicting structures can be represented. Additionally the format
ensures the retainment of unaltered raw data, including white space and
other elements often lost due to restrictions of the encoding format. As
a generalized XML format, PAULA is indifferent to particular names or
semantics of annotation structures. It concentrates instead on the
representation of corpus data as a set of arbitrarily labeled directed
acyclic graphs (so called multi-DAGs, wherein annotation projects may
contain cycles as long as these are on different annotation levels).

This documentation is structured as follows: the next chapter gives an
overview of the overall [data model](#datamodel) of the current PAULA
format, followed by a chapter on [corpus structure](#corpus_structure)
for XML files and folders. Further chapters review different file types:
the [minimal necessary files](#required_files) for PAULA documents,
[metadata](#metadata), [primary text data](#primary_text_data),
[tokenizations](#tokenization) and [span annotations](#mark),
[hierarchical graphs](#struct) and [pointing
relations](#pointing_relations). The final chapters give additional
information on the optional use of [namespaces](#namespaces), some
special scenarios such as building [parallel
corpora](#parallel_corpora), [dialogue corpora](#dialogue_data) and
[multimodal corpora](#multimodal), recommendations for [file naming
conventions](#naming_conventions) and information on [older/deprecated
elements](#versions) of the PAULA XML standard focusing on differences
to the current version.
