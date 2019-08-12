# Preamble

*PAULA XML* or *PAULA* for short (*Potsdamer AUstauschformat Linguistischer
Annotationen*, 'Potsdam Exchange Format for Linguistic Annotations') is a
standoff XML format designed to represent a wide range of linguistically
annotated textual and multi-modal corpora. The format was created at
Potsdam University and developed within SFB 632, the collaborative
research centre "Information Structure", subproject D1, "Linguistic
Database" at Potsdam University and Humboldt-Universität zu Berlin (see
Dipper 2005[^Dipper2005], Dipper and Goetze 2005[^DipperGoetze2005], Chiarcos et al. 2008[^ChiarcosEtAl2008]). The description below
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
overview of the overall [data model](datamodel-overview.md) of the current PAULA
format, followed by a chapter on [corpus structure](corpus-structure.md)
for XML files and folders. Further chapters review different file types:
the [minimal necessary files](required-files-and-dtds.md) for PAULA documents,
[metadata](metadata.md), [primary text data](primary-text-data.md),
[tokenizations](spans-and-markables.md#tokenizations-and-token-markables) and [span annotations](spans-and-markables.md),
[hierarchical graphs](hierarchical-structures.md#structs) and [pointing
relations](pointing-relations.md). The final chapters give additional
information on the optional use of [namespaces](namespaces.md), some
special scenarios such as building [parallel
corpora](special-scenarios.md#parallel-corpora), [dialogue corpora](special-scenarios.md#dialogue-data) and
[multimodal corpora](special-scenarios.md#aligned-audiovideo-files), recommendations for [file naming
conventions](naming-conventions.md) and information on [older/deprecated
elements](deprecated.md) of the PAULA XML standard focusing on differences
to the current version.



[^Dipper2005]: Dipper, S. (2005), XML-based Stand-off Representation and
Exploitation of Multi-Level Linguistic Annotation. In: *Proceedings of Berliner XML Tage 2005 (BXML 2005)*. Berlin, Germany, 39-50.


[^DipperGoetze2005]: Dipper, S. & Götze, M. (2005), Accessing Heterogeneous
Linguistic Data - Generic XML-based Representation and Flexible
Visualization . In: *Proceedings of the 2nd Language & Technology Conference: Human Language Technologies as a Challenge for Computer Science and Linguistics*. Poznan, Poland, 206-210.

[^ChiarcosEtAl2008]: Chiarcos, C., Dipper, S., Götze, M., Leser, U.,
Lüdeling, A., Ritz, J. & Stede, M. (2008), A Flexible Framework for
Integrating Annotations from Different Tools and Tag Sets. *Traitment automatique des langues* 49, 271-293.
