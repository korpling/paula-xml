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
separate, meaningful [namespace](namespaces.md), such as the name of the
language if dealing with a multilingual parallel corpus. Alignment
between elements within parallel texts, including aligned tokens,
[markable spans](spans-and-markables.md) (e.g. sentences or chunks) or [hierarchical
structures](hierarchical-structures.md#structs), is achieved using [pointing
relations](pointing-relations.md). The following example illustrates the
document structure and an alignment for some tokens.

**Directory structure for a document with two parallel texts.**
```
+-- mycorpus/
¦   +-- doc1/
¦   ¦   ¦-- english.doc1.text.xml
¦   ¦   ¦-- english.doc1.tok.xml
¦   ¦   ¦-- german.doc1.text.xml
¦   ¦   ¦-- german.doc1.tok.xml
¦   ¦   ¦-- mycorpus.doc1.align.xml
¦   ¦   ¦-- mycorpus.doc1.anno.xml
... ... ...
```

**Pointing relations aligning the English text to the German text.**
```xml
<?xml version="1.0" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_rel.dtd">


<paula version="1.1">

<header paula_id="mycorpus.doc1_align"/>

<relList xmlns:xlink="http://www.w3.org/1999/xlink" type="align">
    <rel id="rel_1" xlink:href="english.doc1.tok.xml#tok_1" 
    target="german.doc.tok.xml#tok_1"/>
    <rel id="rel_1" xlink:href="english.doc1.tok.xml#tok_2" 
    target="german.doc.tok.xml#tok_3"/>
    <rel id="rel_1" xlink:href="english.doc1.tok.xml#tok_3" 
    target="german.doc.tok.xml#tok_2"/>
</paula>
```

Note that since pointing relations of the same type may not create a
cycle, bidirectional alignment is only possible if the pointing relation
files are given different types, as in the following example. The two
alignment files use the types "align\_g-e" and "align\_e-g" for each
alignment direction.

**Directory structure for a document with bidirectional alignment.**
```
+-- mycorpus/
¦   +-- doc1/
¦   ¦   ¦-- english.doc1.align_e-g.xml
¦   ¦   ¦-- english.doc1.text.xml
¦   ¦   ¦-- english.doc1.tok.xml
¦   ¦   ¦-- german.doc1.align_g-e.xml
¦   ¦   ¦-- german.doc1.text.xml
¦   ¦   ¦-- german.doc1.tok.xml
¦   ¦   ¦-- mycorpus.doc1.anno.xml
... ... ...
```

## Dialogue data

There are two main ways of representing dialog data in PAULA XML: either
each speaker's text and annotations are modeled as a text in a parallel
corpus (see [parallel corpora](#parallel-corpora)) or else a `primary
textual
data` file is created with as many blank characters as necessary for the
representation of all speakers, and this is then used as a common
timeline for the tokens of each speaker. The latter solution is
implemented as follows. Supposing two speakers utter the following two
semi overlapping sentence:

**Dialog data to be modelled in PAULA.**
```
Speaker1:   he thinks so
Speaker2:              I think so too
```

Speaker2 utters the word "I" at the same time as the "o" is uttered in
"so" by Speaker1. In order to model this overlap using only one "text",
the `primary textual data` must contain a sufficient amount of
characters. The text for Speaker1 is 12 characters long, including
spaces, and the text for Speaker2 begins at character 12 of Speaker1 and
extends for a further 14 characters. This means we require 25 characters
in total (not 26, since there is an overlap of one character). The raw
text file can therefore look like this:

**A primary text data file**
```xml
<?xml version="1.0" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_text.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc4_text" type="text"/>

<body>1234567890123456789012345</body>

</paula>
```

The body of the text contains repeating numbers: 1234567890... to make
it easier to count the characters. However it is equally possible to use
25 spaces: the contents of this dummy text file are not important. In a
second step, two tokenizations of the data are carried out: one for each
speaker. The tokenization for Speaker1 is given in the following
example. It is recommended to give each speaker a separate namespace for
easier identifiability.

**Tokenization for Speaker1**
```xml
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

**A `mark` file defining the span of tokens aligned with a multimedia file.**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_mark.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc1_audioFileSeg"/>

<markList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="audioFileSeg" xml:base="mycorpus.doc1.tok.xml">
 <!-- audio file span for the first 50 tokens -->
 <mark id="audioFileSeg_1" 
  xlink:href="#xpointer(id('tok_1')/range-to(id('tok_50')))"/>
</markList>

</paula>
```

**A `feat` file giving the name of the multimedia file.**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_feat.dtd">

<paula version="1.1">
<header paula_id=""mycorpus.doc1_audioFileSeg_audioFile"/>

<featList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="audioFile" xml:base="mycorpus.doc1.audioFileSeg.xml">
  <!-- wav file -->
  <feat xlink:href="#audioFileSeg_1" value="file:/./mycorpus.doc1.wav"/>
</featList>

</paula>
```