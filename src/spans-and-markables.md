# Spans and markables

## Introduction to spans and markables

In PAULA it is possible to define spans of data for further annotation.
Spans are defined using the `mark` element, which stands for markable
and has two primary functions: defining a [tokenization](#tokenizations-and-token-markables)
for a primary text data and defining a non-terminal [annotation
span](#annotation-span-markables) node above the token level.

## Tokenizations and token markables

A `tokenization` forms a minimal level of analysis that segments a
`primary text data` file into units that can be annotated further. It is
not possible to directly annotate text that is not tokenized, and every
PAULA document must contain at least one `tokenization`. It is possible
to include whitespace characters within the primary data and then ignore
these characters while tokenizing, so that adjacent tokens are not
interrupted by any characters on the tokenized level.
The following example illustrates this principle.

**Tokenization of the `primary text data` "This is an example."**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_mark.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc1_tok"/>

<markList xmlns:xlink="http://www.w3.org/1999/xlink" type="tok" 
xml:base="mycorpus.doc1.text.xml">
    <mark id="tok_1" 
    xlink:href="#xpointer(string-range(//body,'',1,4))"/><!-- This -->
    <mark id="tok_2" 
    xlink:href="#xpointer(string-range(//body,'',6,2))"/><!-- is -->
    <mark id="tok_3" 
    xlink:href="#xpointer(string-range(//body,'',9,2))"/><!-- an -->
    <mark id="tok_4" 
    xlink:href="#xpointer(string-range(//body,'',12,7))"/><!--example-->
    <mark id="tok_5" 
    xlink:href="#xpointer(string-range(//body,'',19,1))"/><!-- . -->
</markList>
</paula>
```

The first token element with the id "tok\_1" begins at the first
character of the text (the letter "T") and goes covering a total of 4
character: "This". Character 5 is a space, which has not been tokenized.
The next token, "tok\_2", begins at character 6, covering 2 characters:
"is". It is also possible to define tokens with no textual extension,
i.e. empty tokens. Such tokens have a string range spanning zero
characters. However, they must still have an anchor position within the
text. The following example illustrates an empty token in the sentence
"he takes people out to fish", where the unrealized subject of "to fish"
is tokenized between "out" and "to" with a character span of zero
characters.

**Tokenization of the primary data "he takes people out to fish"**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_mark.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc2_tok"/>

<markList xmlns:xlink="http://www.w3.org/1999/xlink" type="tok" 
xml:base="mycorpus.doc2.text.xml">
<mark id="tok_1" 
    xlink:href="#xpointer(string-range(//body,'',1,2))"/><!-- he -->
<mark id="tok_2" 
    xlink:href="#xpointer(string-range(//body,'',4,5))"/><!-- takes -->
<mark id="tok_3" 
    xlink:href="#xpointer(string-range(//body,'',10,6))"/><!--people-->
<mark id="tok_4" 
    xlink:href="#xpointer(string-range(//body,'',17,3))"/><!-- out -->
<mark id="tok_5" 
    xlink:href="#xpointer(string-range(//body,'',21,0))"/><!--   -->
<mark id="tok_6" 
    xlink:href="#xpointer(string-range(//body,'',22,2))"/><!-- to -->
<mark id="tok_7" 
    xlink:href="#xpointer(string-range(//body,'',25,4))"/><!--fish-->
</markList>
</paula>
```

Although a PAULA tokenization file is defined with reference to the
general markable DTD `paula_mark.dtd`, it is distinguished from other
types of markables, specifically [annotation markables](#annotation-span-markables), in
two ways. Firstly, the `@type` attribute of the element `markList`,
which must be set to the value `tok`. Secondly, tokenization can only
refer to a `primary text data` file. It is not possible to define a
token pointing to a more complex structure (e.g. another markable or
token).

As of PAULA version 1.1 it is possible to have multiple `primary
text data` files, each of which must then be tokenized. Multiple
tokenizations of the same `primary text data` are not possible in PAULA
1.1, but are planned as part of a future version of PAULA XML.

## Annotation span markables

The element `mark` may be used to group together a set of
[tokens](#tokenizations-and-token-markables) for further annotation. This is usually done in
order to annotate a certain feature-value pair which applies to these
tokens. Span annotations therefore have the semantics of attribution
within the graph structure, i.e. stating that an area of the data has a
certain property or attribute. These attributes are realized in PAULA
using `feat` annotation files, one or more of which can apply to any
span defined by a markable. Span markables are defined with reference to
the DTD `paula_mark.dtd`. The type of markable being annotated (e.g. a
referent or referring expression in a discourse, a chunk for chunking
annotation, etc.) is given by the `@type` attribute of the `markList`
element, and may be any string value other than "tok" which is reserved
for [tokenizations](#tokenizations-and-token-markables). Other values are not ruled out by
the format, but it is recommended to use types that follow XML element
naming conventions, i.e. strings that contain only alphanumeric ascii
characters with no spaces and beginning with an alphabetic character.

Markables may be continuous or discontinuous, i.e. they may apply to a
set of consecutive tokens or to non-consecutive tokens. The following
example illustrates both types of markables in a single file with the
type "chunk".

**Markables of the type "chunk" above a set of six tokens "I" "'ve
"picked" "the" "kids" "up"**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_mark.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc1_chunk_seg"/>

<markList xmlns:xlink="http://www.w3.org/1999/xlink" type="chunk" 
xml:base="mycorpus.doc1.tok.xml">
    <!-- I -->
    <mark id="chunk_1" xlink:href="#tok_1"/>
    <!-- 've picked...up -->
    <mark id="chunk_2" 
    xlink:href="(#xpointer(id('tok_2')/range-to(id('tok_3'))),#tok_6)"/>
    <!-- the kids -->
    <mark id="chunk_3" 
    xlink:href="#xpointer(id('tok_3')/range-to(id('tok_4')))"/>
</markList>

</paula>
```

In the example, three markables have been defined which refer to six
tokens in the token file `mycorpus.doc1.tok.xml`, as entered in the
`markList` element's `@xml:base` attribute. The first markable,
"chunk\_1" points to "\#tok\_1" in the token file which covers the
string "I". The third markable, "chunk\_3", points to a range of
consecutive tokens, from "tok\_3" to "tok\_4", which covers the words
"the kids". The chunk in the middle, "chunk\_2", points to a
discontinuous set of tokens, namely a range "tok\_2" to "tok\_3" and a
further individual token "tok\_6", corresponding to the tokens "'ve
picked" and a later token "up". These markables cannot be annotated
further within this file (e.g. with the type of chunk as nominal,
verbal, etc.). Further annotation of the markables beyond the markable
list `@type` must be added in separate files as `feat` annotations.

Note that the markable type is set once in the `markList` element for
all markables in the file. To define markables of a different type, a
separate markable file must be generated. Separate files are not
required to have the same segmentations and constitute independent
layers of annotation.

## Feats

The element `feat` and corresponding feat files represent arbitrary
key-value feature annotations which may be applied to a variety of
elements, such as parts of speech or syntactic categories, but also
metadata. They can be applied to mark elements to annotate [spans of
tokens](#annotation-span-markables) or even [tokens](#tokenizations-and-token-markables) directly, but also
to [`struct`](hierarchical-structures.md#structs) elements as part of non-hierarchical annotations
or metadata annotation of `annoSet` elements. The following two examples
illustrate feature annotation of spans and tokens. For other uses see
[metadata](metadata.md) and [annotating structs](hierarchical-structures.md#annotating-structs-and-rels). 
In the next example a `featList` with the `@type` "pos"
contains six `feat` elements, each annotating a single token with its
part of speech in the `@value` attribute.

**Annotating tokens with `feat` annotations for part of speech**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_feat.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc1_pos"/>

<featList xmlns:xlink="http://www.w3.org/1999/xlink" type="pos" 
xml:base="mycorpus.doc1.tok.xml">
    <feat xlink:href="#tok_1" value="PP"/><!-- I -->
    <feat xlink:href="#tok_2" value="VBP"/><!-- 've -->
    <feat xlink:href="#tok_3" value="VBN"/><!-- picked -->
    <feat xlink:href="#tok_4" value="DT"/><!-- the -->
    <feat xlink:href="#tok_5" value="NNS"/><!-- kids -->
    <feat xlink:href="#tok_6" value="RP"/><!-- up -->
</featList>

</paula>
```

It is also possible to annotate more than one token at a time by using
[annotation span markables](#annotation-span-markables), which cover one or more tokens
each. In this case the features do not refer to a token file, but to a
markable file which refers to some tokens in itself. The following
example illustrates the annotation of such spans, which works in much
the same way as the annotation of tokens.

**Annotating spans from a markable file with `feat` annotations for chunk type**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_feat.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc1_chunk_seg_chunk_type"/>

<featList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="chunk_type" xml:base="mycorpus.doc1.chunk_seg.xml">
    <feat xlink:href="#chunk_1" value="N"/><!-- I -->
    <feat xlink:href="#chunk_2" value="V"/><!-- 've picked _ up -->
    <feat xlink:href="#chunk_3" value="N"/><!-- the kids -->
</featList>

</paula>
```

In this case, three features of the type "chunk\_type" have been
assigned to three markables in the file `mycorpus.doc1.chunk_seg.xml`.
The "chunk\_type" of the first markable is given the value "N". The
second markable receives the "chunk\_type" "V" and the third is "N"
again. Note that the tokens covered by the respective markables are not
defined here, though comments to the right of each element can help keep
track of the text covered by each annotation. The actual tokens covered
by each markable are defined in the separate file
`mycorpus.doc1.chunk_seg.xml`. There is also no necessary connection
between the type of feature and the type of markable, though in many
cases it makes sense to give them similar names, e.g. markables called
"chunk" and an annotation "chunk\_type" (see also [naming
conventions](#naming_conventions)).

## Multifeats

In cases where multiple annotations always apply to the same nodes, it
may be more economic to specify multiple, usually related annotations in
the same file. This is made possible by the use of `multiFeat` files,
together with the associated `paula_multiFeat.dtd`. Each multiFeat
contains multiple feat annotations applying to the element specified in
the `@xlink:href` attribute of the `multiFeat` element. Since the
`multiFeat` itself is not an actual annotation, but a container for
other annotations, the `multiFeatList` element is conventionally given
the type "multiFeat". The example below illustrates the use of multiFeat
annotations.

**Annotating multiple annotations using `multiFeat` elements.**
```xml
<?xml version="1.0" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_multiFeat.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc1.tok_multiFeat"/>
    
<multiFeatList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="multiFeat" xml:base="mycorpus.doc1.tok.xml">

    <multiFeat xlink:href="#tok_1"> <!-- I -->
        <feat name="pos" value="PPER"/>
        <feat name="lemma" value="I"/>
    </multiFeat>
    <multiFeat xlink:href="#tok_2"> <!-- 've -->
        <feat name="pos" value="VBP"/> 
        <feat name="lemma" value="have"/>
    </multiFeat>
    <!-- ... -->
    
</multiFeatList>

</paula>
```

Note that there is no difference from the data model point of view
between the use of multiple `feat` files or one `multiFeat` file
specifying the same annotation types. Note also that when using
[namespaces](namespaces.md), all annotations in a `multiFeat` have the
same namespace, determined by the `multiFeat` file name. While it is
possible to have different annotation in different `multiFeat` elements
in the same file, it is recommended to avoid this, as it can quickly
become confusing. The use of `multiFeat` annotations can also make it
potentially difficult to add, remove and edit annotations after the
fact, since separate annotation layers are mixed in one XML file.