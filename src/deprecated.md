# Older versions and deprecated components

## Pointing relations in feats

Up to PAULA XML version 1.0 it was possible to create [pointing
relations](pointing-relations.md) by assigning a feature annotation to a
source node with the target node's URI as a feature value (in PAULA 0.9
only) or using the now deprecated `@target` attribute of the feat
element (from PAULA 1.0). The use of `@value` for this purpose is
illustrated in the example below.

**A deprecated pointing relation `Feat` file.**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_feat.dtd">

<paula version="1.1">
    <header paula_id="mycorpus.doc1_coref" />
    <featList type="coref" xml:base="mycorpus.doc1.referent_Seg.xml" 
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <feat xlink:href="#referent_10" value="#referent_8" />
    </featList>

</paula>
```

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
which could span several [markables](spans-and-markables.md), either in the same markable
file or in any number of different markable files applying to the same
tokenization. The following example illustrates such a file, where the
virtual markable, designated by the `@type` "virtual", refers to two
markables within the same file (the path `mycorpus.doc5.referentSeg.xml`
must be specified since `@xml:base` is set to a separate tokenization
file).

**A `mark` file containing a pseudo-hierarchical markable of the deprecated "virtual" type.**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_mark.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc5_referentSeg"/>

<markList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="referent" xml:base="mycorpus.doc5.tok.xml">
 <!-- audio file span for the first 50 tokens -->
 <mark id="referentSeg_1" 
  xlink:href="#xpointer(id('tok_1')/range-to(id('tok_2')))"/>
 <mark id="referentSeg_2" 
  xlink:href="#xpointer(id('tok_5')/range-to(id('tok_8')))"/>
 <mark id="referentVirt_1"
  xlink:href="(mycorpus.doc5.referentSeg.xml#referentSeg_1,
  mycorpus.doc5.referentSeg.xml#referentSeg_2)" type="virtual"/>
</markList>

</paula>
```

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

### Version 0.9

- Use of [virtual markables](#virtual-markables) is possible.
- Use of `feat` attribute `@value` to specify [pointing
  relation](pointing-relations.md) target nodes is possible/
- No support for [metadata](metadata.md).
- Use of `annoFeat` is mandatory.

### Version 1.0

- Use of virtual markables is no longer possible.
- Use of `feat` attribute `@value` or `@target` to specify pointing
  relation target nodes is possible.
- No support for metadata.
- Use of `annoFeat` is mandatory.

### Version 1.1

- Use of virtual markables is not possible.
- Use of `feat` attribute `@value` to specify pointing relation target
  nodes is not possible.
- Use of `feat` attribute `@target` to specify pointing relation
  target nodes is possible but deprecated.
- New file type and element `rel` is recommended for the specification
  of pointing relations.
- Support for metadata on the corpus, subcorpus and document levels.
- Use of `annoFeat` is optional and deprecated.
- Support for [parallel corpora](special-scenarios.md#parallel-corpora) via pointing
  relations.
- Support for aligned [multimedia files](special-scenarios.md#aligned-audiovideo-files).

