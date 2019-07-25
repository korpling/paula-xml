# Hierarchical structures

Hierarchical structures are used in PAULA for two different purposes:
for the creation of hierarchically nested annotation graphs (e.g. syntax
trees, rhetorical structure annotation, hierarchical topological fields)
and for the definition of structured `annoSet` objects (see
[annoSets](#annoset)). Hierarchical structures express the graph
semantic property that a parent node consists of its children, or in
reverse, that children nodes constitute their parent nodes. The
semantics of hierarchical edges is also called dominance (a parent node
dominates a child node), and they are consequently known as dominance
edges as well. This chapter describes hierarchical annotation graphs.
For non-hierarchical annotations see also [spans and markables](#mark).

## Structs

To form hierarchically nested (i.e. recursive) non-terminal nodes above
the token level, the `struct` element should be used. Directed acyclic
graphs (DAGs) of struct elements may be defined in struct files
according to `paula_struct.dtd`. The `struct` element is embedded within
a `structList` which determines the `@type` for all structs in the file.
It has only one attribute, an `@id` which allows it to become the target
of incoming edges. Outgoing edges are annotated using the child element
`rel`, which has its own `@type` (the type of edge) and an attribute
`@xlink:href` determining the target's id, as well as its own `@id`
attribute for further annotation (see annotating structs and rels). The
following example illustrates a simple syntax tree for the sentence "he
". The correpsonding syntax tree is also visualized in
[figure\_title](#Figure_fish_tree).

    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE paula SYSTEM "paula_struct.dtd">
    
    <paula version="1.1">
    <header paula_id="mycorpus.doc2_phrase"/>
    
    <structList xmlns:xlink="http://www.w3.org/1999/xlink" 
    type="phrase">
    <struct id="phrase_1"> <!-- NP -->
     <!-- he -->
     <rel id="rel_1" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_1"/>
    </struct>
    <struct id="phrase_2"> <!-- VP -->
     <!-- takes -->
     <rel id="rel_2" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_2"/>
     <rel id="rel_3" type="edge" xlink:href="#phrase_3"/>
     <rel id="rel_4" type="edge" xlink:href="#phrase_4"/>
     <rel id="rel_5" type="edge" xlink:href="#phrase_5"/>
    </struct>
    <struct id="phrase_3"> <!-- NP -->
     <!-- people -->
     <rel id="rel_6" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_3"/>
     <!-- _ -->
     <rel id="rel_7" type="secedge" xlink:href="mycorpus.doc2.tok.xml#tok_5"/>
    </struct>
    <struct id="phrase_4"> <!-- PRT -->
     <!-- out -->
     <rel id="rel_8" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_4"/>
    </struct>
    <struct id="phrase_5"> <!-- S -->
     <rel id="rel_9" type="edge" xlink:href="#phrase_6"/>
     <rel id="rel_10" type="edge" xlink:href="#phrase_7"/>
    </struct>
    <struct id="phrase_6"> <!-- NP -->
     <!-- _ -->
     <rel id="rel_11" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_5"/>
    </struct>
    <struct id="phrase_7"> <!-- VP -->
     <!-- to -->
     <rel id="rel_12" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_6"/>
     <rel id="rel_13" type="edge" xlink:href="#phrase_8"/>
    </struct>
    <struct id="phrase_8"> <!-- VP -->
     <!-- fish -->
     <rel id="rel_14" type="edge" xlink:href="mycorpus.doc2.tok.xml#tok_7"/>
    </struct>
    <struct id="phrase_9"> <!-- S -->
     <rel id="rel_15" type="edge" xlink:href="#phrase_1"/> 
     <rel id="rel_16" type="edge" xlink:href="#phrase_2"/> 
    </struct>
    <struct id="phrase_10"> <!-- TOP -->
     <rel id="rel_17" type="edge" xlink:href="#phrase_9"/> 
    </struct>
    </structList>
    
    </paula>

In this example, the individual nodes in the tree from the figure above
are represented by `struct` elements. Each `struct` element contains
`rel` elements which define edge leading to its children. Thus
"phrase\_1" directly dominates a token "tok\_1", corresponding to the
word "he". Note that, since the tokens are in a separate file,
references to the tokens give a full href attribute with the token file
name: mycorpus.doc2.tok.xml\#tok\_1. Phrase nodes dominating other
phrase nodes within the same file do not require any prefix: "phrase\_9"
dominates "\#phrase\_5" directly. Most edges in the tree have been given
the edge `@type` "edge", but one edge, by which the NP above "people"
(marked in red in the figure above) indirectly dominates an empty token
between "out" and "to" (marked in green) with a different `@type`:
"secedge" (a 'secondary' edge). There is no limit to the amount of edge
types used in a document, but XML naming conventions should be followed
in giving type names that are ascii alphanumeric, without spaces and
beginning with an alphabetic character (see [naming
conventions](#naming_conventions)). The node labels ("NP", "VP") and the
edge labels ("SBJ", "PRP") are not defined within the `struct` file, but
are given as separate annotation files: see [annotating structs and
rels](#struct_feat).

## Annotating structs and rels

Hierarchical graphs made of `struct` and `rel` elements may be further
annotated using `feat` elements, much like annotation
[spans](#span_anno). To annotate `struct` nodes, use a `feat` file
pointing to the nodes and give the annotation name in the `@type`
attribute. The following example illustrates the phrase annotations for
the tree in [example\_title](#Example_struct) in the previous section.

    <?xml version="1.0" standalone="no"?>
    
    <!DOCTYPE paula SYSTEM "paula_feat.dtd">
    <paula version="1.1">
    
    <header paula_id="mycorpus.doc2_phrase_cat"/>
    
    <featList xmlns:xlink="http://www.w3.org/1999/xlink" type="cat" 
    xml:base="mycorpus.doc2.phrase.xml">
        <feat xlink:href="#phrase_1" value="NP"/><!-- he -->
        <feat xlink:href="#phrase_2" value="VP"/><!-- takes -->
        <feat xlink:href="#phrase_3" value="NP"/><!-- people _ -->
        <feat xlink:href="#phrase_4" value="PRT"/><!-- out -->
        <feat xlink:href="#phrase_5" value="S"/><!-- _ to fish -->
        <feat xlink:href="#phrase_6" value="NP"/><!-- _ -->
        <feat xlink:href="#phrase_7" value="VP"/><!-- to fish -->
        <feat xlink:href="#phrase_8" value="VP"/><!-- fish -->
        <!-- he takes people out _ to fish -->
        <feat xlink:href="#phrase_9" value="S"/>
        <!-- he takes people out _ to fish -->
        <feat xlink:href="#phrase_10" value="TOP"/>
    </featList>
    
    </paula>

The annotation name is set as "cat" and it applies to the elements
"phrase\_1" to "phrase\_10" in the xml:base file, which contains the
phrase nodes. For conventions how to name the `@paula_id` and XML files,
see [naming conventions](#naming_conventions).

Annotating edges works in a similar way, except that `rel` elements are
references instead of `struct` elements. It is possible to annotate
edges of multiple types in the same XML file, as long as the name of the
annotation being applied to them is identical. The following example
illustrates this using the edges from [example\_title](#Example_struct)
in the preivous section (note that "rel\_7" had the type "secedge" while
the others had "edge", and also that not all edges have been annotated,
which is fine).

    <?xml version="1.0" standalone="no"?>
    
    <!DOCTYPE paula SYSTEM "paula_feat.dtd">
    <paula version="1.1">
    
    <header paula_id="mycorpus.doc2_phrase_func"/>
    
    <featList xmlns:xlink="http://www.w3.org/1999/xlink" type="func" 
    xml:base="mycorpus.doc2.phrase.xml">
        <feat xlink:href="#rel_5" value="PRP"/><!-- _ to fish -->
        <feat xlink:href="#rel_9" value="SBJ"/><!-- _ -->
        <feat xlink:href="#rel_11" value="NONE"/><!-- _ -->
        <feat xlink:href="#rel_15" value="SBJ"/><!-- he -->
    </featList>
    
    </paula>

Just as with markables, it is also possible to specify multiple
annotations for the same nodes in one XML document using multiFeat files
(see [multiFeats](#multifeats) for details).

# Pointing relations

Pointing relations are ahierarchical edges between any two annotation
node elements, that is between any combination of `tok`, `mark` or
`struct`. Unlike [hierarchical edges](#struct), pointing relations do
not express 'dominance' semantics, meaning that the source of the edge
is not understood to 'consist of' the target of the edge. The edge
merely marks a relationship between two nodes. For this reason, pointing
relations are useful in expressing such links as coreference (e.g. a
link between anaphor and antecedent) and syntactic dependencies.
Pointing relations are represented using `rel` elements in rel files,
and obey the definition in `paula_rel.dtd` (see [DTDs](#DTD)). The
following example illustrates rel edges between tokens defined in the
file `mycorpus.doc1.tok.xml`, but the sources and targets of the edges
can also be any `struct` or `mark` within a document.

    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE paula SYSTEM "paula_rel.dtd">
    
    <paula version="1.1">
    
    <header paula_id="mycorpus.doc1_dep"/>
    
    <relList xmlns:xlink="http://www.w3.org/1999/xlink" type="dep" 
    xml:base="mycorpus.doc1.tok.xml">
        <!-- I - 've -->
        <rel id="rel_1" xlink:href="#tok_1" target="#tok_2"/> 
        <!-- 've - picked -->
        <rel id="rel_2" xlink:href="#tok_3" target="#tok_2"/> 
        <!-- the - kids -->
        <rel id="rel_3" xlink:href="#tok_4" target="#tok_5"/> 
        <!-- picked - kids -->
        <rel id="rel_4" xlink:href="#tok_5" target="#tok_3"/> 
        <!-- picked - up -->
        <rel id="rel_5" xlink:href="#tok_6" target="#tok_3"/> 
    </relList>
    
    </paula>

The `rel` file only defines the edges and the `@type` of the `relList`,
in this case "dep". To add an annotation to these edges, for example
grammatical functions, a `feat` file is used, as in the following
example:

    <?xml version="1.0" standalone="no"?>
    
    <!DOCTYPE paula SYSTEM "paula_feat.dtd">
    <paula version="1.1">
    
    <header paula_id="mycorpus.doc1_dep_func"/>
    
    <featList xmlns:xlink="http://www.w3.org/1999/xlink" type="func" 
    xml:base="mycorpus.doc1.dep.xml">
        <feat xlink:href="#rel_1" value="SBJ"/><!-- I - 've -->
        <feat xlink:href="#rel_2" value="VC"/><!-- 've picked -->
        <feat xlink:href="#rel_3" value="NMOD"/><!-- the - kids -->
        <feat xlink:href="#rel_4" value="OBJ"/><!-- picked - kids -->
        <feat xlink:href="#rel_5" value="PRT"/><!-- picked - up -->
    </featList>
    
    </paula>

Each `feat` element points to a `rel` element in the pointing relation
file and gives the annotation value in its `@value` attribute. The name
of the annotation, "func", is determined in the @type attribute of the
`featList`.

Just as with markables, it is also possible to specify multiple
annotations for the same pointing relations in one XML document using
multiFeat files (see [multiFeats](#multifeats) for details).

# Namespaces

Namespaces in PAULA are user-defined strings that may be used to group
together XML files belonging to semantically related annotation layers.
PAULA namespaces are not XML namespaces, but are signaled through a
prefix to the file name which by convention should contain only
alphanumeric ASCII characters and should not begin with a number. The
end of the prefix is marked by a period.

As an example, consider the following [document's](#document) directory
structure:

\+-- mycorpus/ ¦ +-- doc1/ ¦ ¦ ¦-- coref.doc1.discourse.xml ¦ ¦ ¦--
coref.doc1.discourse\_anaphoric.xml ¦ ¦ ¦-- mycorpus.doc1.anno.xml ¦ ¦
¦-- mycorpus.doc1.annoFeat.xml ¦ ¦ ¦-- mycorpus.doc1.text.xml ¦ ¦ ¦--
mycorpus.doc1.tok.xml ¦ ¦ ¦-- syntax.mycorpus.doc1.const.xml ¦ ¦ ¦--
syntax.mycorpus.doc1.const\_cat.xml ¦ ¦ ¦--
syntax.mycorpus.doc1.const\_func.xml ... ... ...

The first two file names being with the prefix "coref". This prefix
groups them together into one namespace, which contains semantically
related annotations, such as some non-terminal "discourse" nodes, and
some annotations or edges defined above these nodes, in this case of the
type "anaphoric" (for conventional relations between node and annotation
file names, see [naming conventions](#naming_conventions)). The last
three files begin with "syntax" and belong to the corresponding "syntax"
namespace. In this case they represent annotations such as those seen in
the examples in [Chapter 7](#struct): nodes of the type "const", an
annotation document of the type "cat" and annother annotation called
"func", which represents annotated edges between the nodes. Finally, the
files in the middle begin with the corpus name "mycorpus", which is
therefore also their namespace. They could also be given a separate
namespace (e.g. "general.mycorpus...."), but there is no rule
prohibiting use of the corpus name as a namespace: this will usually be
the case when following the [naming conventions](#naming_conventions) if
namespaces are not intentionally used (then all annotations have the
same namespace: the corpus name).

There is no necessary graph-topological connection between annotation
layers in the same namespace. Often, nodes and their annotations are
grouped together using a namespace in order to signal their
interdependence. However it is entirely possible to group any
combination of files under one namespace. At present there is no way of
assigning multiple namespaces to a single file: only the string before
the first period in a file name is evaluated as its namespace. It is
recommended to repeat the namespace in the `@paula_id` attribute of each
XML file for consistency, but the filename itself is the deciding factor
in determining the namespace.

# Special scenarios

## Parallel corpora

Parallel corpora can be modelled in PAULA XML in a variety of ways that
are more or less appropriate. For instance, an implicit parallel
alignment can be achieved by treating an aligned text as an annotation
of a source text (each word or group of words is annotated with parallel
words). However, the explicit and recommended representation of parallel
corpora in PAULA is modelled by defining multiple `primary text
data` files within a `document` directory, each with at least one
`tokenization`. In this way, each text is explicitly made independent
from the others and text level alignment is represented by the shared
document folder. It is recommended to give each text and tokenization a
separate, meaningful [namespace](#namespaces), such as the name of the
language if dealing with a multilingual parallel corpus. Alignment
between elements within parallel texts, including aligned tokens,
[markable spans](#mark) (e.g. sentences or chunks) or [hierarchical
structures](#struct), is achieved using [pointing
relations](#pointing_relations). The following example illustrates the
document structure and an alignment for some tokens.

\+-- mycorpus/ ¦ +-- doc1/ ¦ ¦ ¦-- english.doc1.text.xml ¦ ¦ ¦--
english.doc1.tok.xml ¦ ¦ ¦-- german.doc1.text.xml ¦ ¦ ¦--
german.doc1.tok.xml ¦ ¦ ¦-- mycorpus.doc1.align.xml ¦ ¦ ¦--
mycorpus.doc1.anno.xml ... ... ...

\<?xml version="1.0" standalone="no"?\> \<\!DOCTYPE paula SYSTEM
"paula\_rel.dtd"\> \<paula version="1.1"\> \<header
paula\_id="mycorpus.doc1\_align"/\> \<relList
xmlns:xlink="http://www.w3.org/1999/xlink" type="align"\> \<rel
id="rel\_1" xlink:href="english.doc1.tok.xml\#tok\_1"
target="german.doc.tok.xml\#tok\_1"/\> \<rel id="rel\_1"
xlink:href="english.doc1.tok.xml\#tok\_2"
target="german.doc.tok.xml\#tok\_3"/\> \<rel id="rel\_1"
xlink:href="english.doc1.tok.xml\#tok\_3"
target="german.doc.tok.xml\#tok\_2"/\> \</paula\>

Note that since pointing relations of the same type may not create a
cycle, bidirectional alignment is only possible if the pointing relation
files are given different types, as in the following example. The two
alignment files use the types "align\_g-e" and "align\_e-g" for each
alignment direction.

\+-- mycorpus/ ¦ +-- doc1/ ¦ ¦ ¦-- english.doc1.align\_e-g.xml ¦ ¦ ¦--
english.doc1.text.xml ¦ ¦ ¦-- english.doc1.tok.xml ¦ ¦ ¦--
german.doc1.align\_g-e.xml ¦ ¦ ¦-- german.doc1.text.xml ¦ ¦ ¦--
german.doc1.tok.xml ¦ ¦ ¦-- mycorpus.doc1.anno.xml ... ... ...

## Dialogue data

There are two main ways of representing dialog data in PAULA XML: either
each speaker's text and annotations are modeled as a text in a parallel
corpus (see [parallel corpora](#parallel_corpora)) or else a `primary
textual
data` file is created with as many blank characters as necessary for the
representation of all speakers, and this is then used as a common
timeline for the tokens of each speaker. The latter solution is
implemented as follows. Supposing two speakers utter the following two
semi overlapping sentence:

Speaker1: he thinks so Speaker2: I think so too

Speaker2 utters the word "I" at the same time as the "o" is uttered in
"so" by Speaker1. In order to model this overlap using only one "text",
the `primary textual data` must contain a sufficient amount of
characters. The text for Speaker1 is 12 characters long, including
spaces, and the text for Speaker2 begins at character 12 of Speaker1 and
extends for a further 14 characters. This means we require 25 characters
in total (not 26, since there is an overlap of one character). The raw
text file can therefore look like this:

    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE paula SYSTEM "paula_text.dtd">
    
    <paula version="1.1">
    <header paula_id="mycorpus.doc4_text" type="text"/>
    
    <body>1234567890123456789012345</body>
    
    </paula>

The body of the text contains repeating numbers: 1234567890... to make
it easier to count the characters. However it is equally possible to use
25 spaces: the contents of this dummy text file are not important. In a
second step, two tokenizations of the data are carried out: one for each
speaker. The tokenization for Speaker1 is given in the following
example. It is recommended to give each speaker a separate namespace for
easier identifiability.

``` 
<?xml version="1.0" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_mark.dtd">
<paula version="1.1">
                
<header paula_id="mycorpus.doc4_tok"/>
                
<markList xmlns:xlink="http://www.w3.org/1999/xlink" type="tok" 
xml:base="mycorpus.doc4.text.xml">
 <!-- he -->
 <mark id="tok_1" xlink:href="#xpointer(string-range(//body,'',1,2))"/>
 <!-- thinks -->
 <mark id="tok_2" xlink:href="#xpointer(string-range(//body,'',4,6))"/>
 <!-- so -->
 <mark id="tok_3" xlink:href="#xpointer(string-range(//body,'',11,2))"/>
</markList>

</paula>
            
```

Annotations for each speaker can then be added by refering to the
relevant token file and building hierarchical structures above the
tokens.

## Aligned audio/video files

Aligned multimedia files, such as audio or video files, can be added to
a PAULA document by placing them in the relevant document directory. In
order to specify which part of a text is represented in the aligned file
or files, a `mark` element covering the appropriate span of tokens
should be defined and annotated using a `feat` which contains the file
name as in the example below. It is possible to annotate the same `mark`
element with multiple multimedia files.

\<?xml version="1.0" encoding="UTF-8" standalone="no"?\> \<\!DOCTYPE
paula SYSTEM "paula\_mark.dtd"\> \<paula version="1.1"\> \<header
paula\_id="mycorpus.doc1\_audioFileSeg"/\> \<markList
xmlns:xlink="http://www.w3.org/1999/xlink" type="audioFileSeg"
xml:base="mycorpus.doc1.tok.xml"\> \<\!-- audio file span for the first
50 tokens --\> \<mark id="audioFileSeg\_1"
xlink:href="\#xpointer(id('tok\_1')/range-to(id('tok\_50')))"/\>
\</markList\> \</paula\>

\<?xml version="1.0" encoding="UTF-8" standalone="no"?\> \<\!DOCTYPE
paula SYSTEM "paula\_feat.dtd"\> \<paula version="1.1"\> \<header
paula\_id=""mycorpus.doc1\_audioFileSeg\_audioFile"/\> \<featList
xmlns:xlink="http://www.w3.org/1999/xlink" type="audioFile"
xml:base="mycorpus.doc1.audioFileSeg.xml"\> \<\!-- wav file --\> \<feat
xlink:href="\#audioFileSeg\_1" value="file:/./mycorpus.doc1.wav"/\>
\</featList\> \</paula\>

# Naming conventions

*General conventions*

  - File names in a directory other than the DTDs should ideally contain
    their corpus path, or at least the document name, i.e. the name of
    the folder they are in. This ensures that files carry unique names
    that make them easier to identify. For example, the tokenization
    file of the document `doc01/` in the corpus `mycorpus` might be
    called `mycorpus.doc01.tok.xml` or `doc01.tok.xml`.

  - Do not use file or folder names with spaces or non-ascii characters.

  - Do not use file or folder names that begin with a number or
    underscore.

  - When using [namespaces](#namespaces), remember that the string
    before the first period in the file name is construed as the
    namespace. If you do not wish to use namespaces and follow the file
    naming conventions given here, the namespace for all of your files
    will be the corpus name, since files will always be named:
    `mycorpus.*`.

*annoSet, annoFeat, primary text data and tokenization*

  - The `annoSet` and, if used, `annoFeat` files in a document are
    conventionally named using the document path convention above, with
    the suffixes anno.xml and anno\_feat.xml respectively. For example
    they can be called: `mycorpus.doc01.anno.xml` and
    `mycorpus.doc01.anno_feat.xml`.

  - If there is only one `primary text data` file and one
    [`tokenization`](#tokenization), they are usually named similarly,
    but with the suffixes text and tok: `mycorpus.doc01.text.xml` and
    `mycorpus.doc01.tok.xml`.

  - If there are multiple primary text data files or tokenization, their
    distinguishing features may be used as namespaces, e.g. the name of
    the language in a [parallel corpus](#parallel_corpora) documents:
    `english.mycorpus.doc01.text.xml` and
    `english.mycorpus.doc01.tok.xml`. If the namespaces are already
    being used for some other purpose (e.g. names of speakers when using
    a parallel corpus architecture for [dialogue data](#dialogue_data)),
    suffixes distinguishing text and token files may be used before
    "text" and "tok", as in: `speaker1.mycorpus.doc01.english.text.xml`
    and `speaker1.mycorpus.doc01.german.text.xml`, and the same for
    `*.tok.xml` files.

*Anntotation span markables and feature annotations*

  - By convention, annotation span [markable](#mark) files are named
    using the current document name as a prefix, followed by an
    underscore and the markList's type, followed by "\_seg.xml". For
    example, a markable file that marks text segments corresponding to
    discourse referents for further annotation may be named
    `mycorpus.doc01.referent_seg.xml`. This tells us just by looking at
    the file name that the markable `@type` attribute in the `markList`
    element is "referent".

  - The above file may may also be put in a [namespace](#namespaces)
    with some other files relevant to discourse annotation, in which
    case the files receive a common prefix, e.g. the file could be
    named: `discourse.mycorpus.doc01.referent_seg.xml`.

  - A feature annotation of the above file giving the referent segment
    e.g. an annotation called "type" (marking the referent, say, as a
    person or geopolitical entity), will be given a file name identical
    to that of the `_seg` file, but with the annotation name appended
    after a further underscore:
    `discourse.mycorpus.doc01.referent_seg_type.xml`.

*Hierarchical struct nodes and feature annotations*

  - Hierarchical [`struct`](#struct) nodes are placed in files using the
    same general conventions with regard to namespaces and
    corpus/document path above, and carry a suffix corresponding to the
    `@type` attribute in the `structList` element after an underscore,
    as follows. For nodes annotating syntactic constituents of the type
    "const" within the [namespace](#namespaces) "syntax" we may get a
    file called: `syntax.mycorpus.doc01.const.xml`.

  - Annotations of struct nodes are given the same name as the
    corresponding node file, with a suffix consisting of an underscore
    and the annotation's name from the `@type` attribute of the
    `featList` element. For example, an annotation of the above
    constituent nodes giving the syntactic category called "cat" should
    be named: `syntax.mycorpus.doc01.const_cat.xml`.

  - Feature annotations of edges in the same `struct` file should be
    named using the same convention, e.g. a syntactic function
    annotation of the type "func" may be called:
    `syntax.mycorpus.doc01.const_func.xml`.

*Pointing relations and rel annotations*

  - [Pointing relation](#pointing_relations) files are named using the
    same conventions as above, with the edge type used as a suffix after
    the document name, e.g. a coreference edge file of the type "coref"
    in the discourse [namespace](#namespaces) should be named:
    `discourse.mycorpus.doc01.coref.xml`.

  - Feature annotations of pointing relation edges are given the file
    name of the pointing relation file with an underscore and the
    annotation type as a suffix. For example, annotating the "coref"
    edge above with the annotation "type" (e.g. anaphoric or
    appositional) results in the file name:
    `discourse.mycorpus.doc01.coref_type.xml`.

*multiFeat annotations*

  - A `mutliFeat` file has no single annotation type. It is therefore
    usually named using the name of the file to which it adds
    annotations, with the suffix "\_multiFeat". Therefore the name of a
    `multiFeat` file annotation a token file is e.g.
    `mycorpus.doc1.tok_multiFeat.xml`, a `multiFeat` file annotating
    syntactic constituents called "const" might be called
    `mycorpus.doc1.const_multiFeat.xml`, etc.

  - For metadata multiFeat annotations, usually the document path and
    the suffix "meta\_multiFeat" are used, e.g.
    `mycorpus.doc1.meta_multiFeat.xml`.

*The paula\_id attribute*

  - The `@paula_id` attribute of the `header` element in each filed
    should be named like the file name itself without the .xml
    extension, e.g. the paula\_id of `mycorpus.doc01.tok.xml` might be
    `mycorpus.doc01.tok`.

  - If the resulting name has no suffix containing an underscore, it is
    possible to replace the final period in the file name with an
    underscore, e.g. `mycorpus.doc01_tok`.

# Older versions and deprecated components

## Pointing relations in feats

Up to PAULA XML version 1.0 it was possible to create [pointing
relations](#pointing_relations) by assigning a feature annotation to a
source node with the target node's URI as a feature value (in PAULA 0.9
only) or using the now deprecated `@target` attribute of the feat
element (from PAULA 1.0). The use of `@value` for this purpose is
illustrated in the example below.

    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!DOCTYPE paula SYSTEM "paula_feat.dtd">
    
    <paula version="1.1">
     <header paula_id="mycorpus.doc1_coref" />
     <featList type="coref" xml:base="mycorpus.doc1.referent_Seg.xml" 
     xmlns:xlink="http://www.w3.org/1999/xlink">
      <feat xlink:href="#referent_10" value="#referent_8" />
     </featList>
    
    </paula>

The problem with this structure is that it is not unambiguously clear
that the annotation signifies a pointing relation, rather than a label
annotation that happens to resemble a URI (an annotation with the string
value "\#referent\_8" in the example above). As of PAULA 1.1, `rel`
files with their corresponding DTD should be used to define pointing
relations, making the identification of source and target nodes
unambiguous. It is still possible (though deprecated) to use a `feat`
file for this purpose, as long as the pointing relation's target is
marked using `@target` instead of `@value`. However, this will not be
supported in future versions of the PAULA standard.

## Virtual markables

In PAULA XML version 0.9 it was possible to define "virtual markables"
which could span several [markables](#mark), either in the same markable
file or in any number of different markable files applying to the same
tokenization. The following example illustrates such a file, where the
virtual markable, designated by the `@type` "virtual", refers to two
markables within the same file (the path `mycorpus.doc5.referentSeg.xml`
must be specified since `@xml:base` is set to a separate tokenization
file).

\<?xml version="1.0" encoding="UTF-8" standalone="no"?\> \<\!DOCTYPE
paula SYSTEM "paula\_mark.dtd"\> \<paula version="1.1"\> \<header
paula\_id="mycorpus.doc5\_referentSeg"/\> \<markList
xmlns:xlink="http://www.w3.org/1999/xlink" type="referent"
xml:base="mycorpus.doc5.tok.xml"\> \<\!-- audio file span for the first
50 tokens --\> \<mark id="referentSeg\_1"
xlink:href="\#xpointer(id('tok\_1')/range-to(id('tok\_2')))"/\> \<mark
id="referentSeg\_2"
xlink:href="\#xpointer(id('tok\_5')/range-to(id('tok\_8')))"/\> \<mark
id="referentVirt\_1"
xlink:href="(mycorpus.doc5.referentSeg.xml\#referentSeg\_1,
mycorpus.doc5.referentSeg.xml\#referentSeg\_2)" type="virtual"/\>
\</markList\> \</paula\>

Though virtual markables technically appear to be hierarchical
structures by pointing at constituent markables, they are interpreted as
flat spans which apply to exactly the same tokens as those covered by
the constituent markables. Therefore the virtual markable in the example
above is the same as a markable applying to tokens 1-2 and 5-8. The use
of virtual markables has been deprecated and is no longer part of the
current PAULA XML standard. Note that it is possible to create
discontinuous spans using normal markables, by specifying discontinous
ranges of tokens in the `@xlink:href` attribute.

## Synopsis of older PAULA versions and components

This section lists distinctive characteristics of the different PAULA
XML standard versions to date.

*Version 0.9*

  - Use of [virtual markables](#virtual_markables) is possible.

  - Use of `feat` attribute `@value` to specify [pointing
    relation](#pointing_relations) target nodes is possible/

  - No support for [metadata](#metadata).

  - Use of `annoFeat` is mandatory.

*Version 1.0*

  - Use of virtual markables is no longer possible.

  - Use of `feat` attribute `@value` or `@target` to specify pointing
    relation target nodes is possible.

  - No support for metadata.

  - Use of `annoFeat` is mandatory.

*Version 1.1*

  - Use of virtual markables is not possible.

  - Use of `feat` attribute `@value` to specify pointing relation target
    nodes is not possible.

  - Use of `feat` attribute `@target` to specify pointing relation
    target nodes is possible but deprecated.

  - New file type and element `rel` is recommended for the specification
    of pointing relations.

  - Support for metadata on the corpus, subcorpus and document levels.

  - Use of `annoFeat` is optional and deprecated.

  - Support for [parallel corpora](#parallel_corpora) via pointing
    relations.

  - Support for aligned [multimedia files](#multimodal).

