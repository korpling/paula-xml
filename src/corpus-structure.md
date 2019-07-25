# Corpus structure

## Corpus and subcorpus

In PAULA a corpus structure is defined by means of a file system folder
structure. The name of the corpus is determined by the name of the top
level directory of the folder structure. The top level directory may
contain further directories. If these directories contain subdirectories
themselves, then they are considered to be subcorpora. Subcorpora are
generally used to provide meaningful subdivisions of a corpus, e.g.
based on genre, period, language etc. These may be accompanied by
appropriate [metadata](metadata.md).

Each subcorpus carries the name of its directory. It is possible, but
not recommended, to repeat subcorpus names at different levels of
nesting. A directory cannot contain two identically named
subdirectories, and therefore it is impossible for two sibling
subcorpora to have the same name. Under \*NIX systems it is possible to
have directories with identical names except for capitalization. This is
not recommended for compatibility with other operating systems. In
addition to directories, a top level corpus or a subcorpus may contain
an `annoSet` file, which lists the set of subfolders in the same
directory (see [annoSets](#annosets)). This is not required unless the
corpus or subcorpus should receive metadata annotations (see
[metadata](metadata.md)).

**Directory structure for a PAULA corpus**
```
+-- mycorpus/
¦   +-- subcorpus1/
¦   ¦   +-- doc1/
¦   ¦   +-- doc2/
¦   ¦   +-- doc3/
¦   +-- subcorpus2/
¦   ¦   +-- doc4/
¦   ¦   +-- doc5/
¦   ¦   +-- ...
¦   +-- subcorpus3/
... ...
```

A subdirectory which contains no further directories is a document.
Every corpus and subcorpus must contain at least one document (possibly
nested within a lower level folder), empty corpora or subcorpora are not
allowed. The minimal structure for a PAULA corpus is therefore a corpus
folder containing a document folder, which must contain the minimal
document structure described under [documents](#documents).

## Documents

A PAULA `document` is a terminal directory within the directoy structure
of the PAULA `corpus`, i.e. it is a folder that contains no subfolders.
Usually documents corresponds to coherent texts (e.g. an article), but
in some contexts other divisions may be sensible (e.g. chapters of a
book as individual documents). The primary consideration is whether or
not annotations need to cross boundaries between segments of the
annotated texts, since annotation nodes and edges can only exist within
a document. It is not possible for an element in one document to refer
to or include an element from another document.

The name of the document is determined by the name of the folder
representing it. A document must contain at least a `primary text data`
file, a [`tokenization`](spans-and-markables.md#tokenizations-and-token-markables), an `annoSet` file and the
relevant [DTDs](required-files-and-dtds.md#additional-dtds) used in the document, unless these are stored in a
separate folder and refered to with appropriate relative paths. If the
document contains no [tokenization](spans-and-markables.md#tokenizations-and-token-markables) or other annotations,
then these will be `paula_text.dtd`, `paula_struct.dtd` and
`paula_header.dtd`. Typically, however, a document almost always
contains a tokenization of the primary text data and some annotations,
meaning at least `paula_mark.dtd` and `paula_feat.dtd` (see [DTDs](required-files-and-dtds.md#additional-dtds)
for more information). It is generally advisable to contain all DTDs
used in a corpus in every document, as redundant DTDs do not disrupt
processing or validation.

By convention, all XML files within a document (i.e. all files except
DTDs) share the document name as part of the file name, which appears
first except for possible [namespaces](namespaces.md), and is followed by
annotation layer-specific elements. For more information about
recommended naming practices see [naming
conventions](naming-conventions.md).

## AnnoSets

Each PAULA `document` must contain an `annoSet` file which describes the
set of annotations contained in the document. The `annoSet` conforms
with the [DTD](required-files-and-dtds.md#additional-dtds)) `paula_struct.dtd` and contains a `structList`
element which contains one or more `struct` elements, each of which
contains one or more `rel` elements (these are the same elements used
for the description of [hierarchical annotations](hierarchical-structures.md#structs) as well).
Every XML file within the document directory (but not DTDs and not the
`annoSet` file itself) must be the `@xlink:href` attribute of some `rel`
in the `annoSet`, including the special `annoFeat` file if it has been
included (see [Annofeats](metadata.md#annofeats)). There are therefore as many `rel`
elements in the `annoSet` as there are XML files in the directory, minus
one (since the `annoSet` itself is not referenced). Different structs
can be used to group together files belonging to one logical annotation
layer, such as the `primary text
data` and its `tokenization`, or related annotations such as part of
speech and lemma. The following example shows some typical groupings
following the PAULA [naming conventions](naming-conventions.md).

**An `annoSet` file for doc1 in mycorpus**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_struct.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc1.anno" />
    
<structList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="annoSet">
    <struct id="anno_1">
    <rel id="rel_1" xlink:href="mycorpus.doc1.anno_feat.xml" />
    </struct>
    <struct id="anno_2">
    <rel id="rel_2" xlink:href="mycorpus.doc1.text.xml" />
    <rel id="rel_3" xlink:href="mycorpus.doc1.tok.xml" />
    </struct>
    <struct id="anno_3">
    <rel id="rel_4" xlink:href="mycorpus.doc1.tok_pos.xml" />
    <rel id="rel_5" xlink:href="mycorpus.doc1.tok_lemma.xml" />
    </struct>
    <struct id="anno_4">
    <rel id="rel_6" xlink:href="mycorpus.doc1.phrase.xml" />
    <rel id="rel_7" xlink:href="mycorpus.doc1.phrase_cat.xml" />
    <rel id="rel_8" xlink:href="mycorpus.doc1.phrase_func.xml" />
    </struct>
    </structList>

</paula>
```

Annotation layers within the same struct are often interdependent, such
that removing one of the files from the document may disrupt the
annotation graph shared with the others. Also note that since
[namespaces](namespaces.md) are also used to group related annotation
layers together, often (but not necessarily always) layers with the same
namespace will also be in the same `struct` in the `annoSet`.

A second function of annoSets is to list the contents of corpora or
subcorpora. AnnoSets within subcorpus or corpus folders are optional,
though if they are missing, the contents of the folder cannot be
validated against a list. AnnoSets in corpora or subcorpora are only
required if the corpus or subcorpus should receive metadata annotations,
in which case an `annoSet` to which the metadata features must point is
required (see [metadata](metadata.md) for more information). An `annoSet`
for a subcorpus or corpus can look like the following example.

**An `annoSet` file for the corpus mycorpus with three documents**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_struct.dtd">
    
<paula version="1.1">
<header paula_id="mycorpus.anno" />
     
<structList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="annoSet">
    <struct id="anno_1">
    <rel id="rel_1" xlink:href="doc1/" />
    <rel id="rel_2" xlink:href="doc2/" />
    <rel id="rel_3" xlink:href="doc3/" />
    </struct>
    </structList>

</paula>
```

Corpus or subcorpus annoSets generally place all child subcorpora or
documents within one `struct` element as in the example above, though it
is not prohibited to group some items into different `struct` elements.
It is also possible to mix subcorpora and documents within the same
corpus or subcorpus level folder. There is no difference in notation and
all immediate subfolders in the file system are simply listed:
`subcorpus1/`, `doc1/` etc.