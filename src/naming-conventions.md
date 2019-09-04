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
- When using [namespaces](namespaces.md), remember that the string
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
  [`tokenization`](spans-and-markables.md#tokenizations-and-token-markables), they are usually named similarly,
  but with the suffixes text and tok: `mycorpus.doc01.text.xml` and
  `mycorpus.doc01.tok.xml`.
- If there are multiple primary text data files or tokenization, their
  distinguishing features may be used as namespaces, e.g. the name of
  the language in a [parallel corpus](special-scenarios.md#parallel-corpora) documents:
  `english.mycorpus.doc01.text.xml` and
  `english.mycorpus.doc01.tok.xml`. If the namespaces are already
  being used for some other purpose (e.g. names of speakers when using
  a parallel corpus architecture for [dialogue data](special-scenarios.md#dialogue-data)),
  suffixes distinguishing text and token files may be used before
  "text" and "tok", as in: `speaker1.mycorpus.doc01.english.text.xml`
  and `speaker1.mycorpus.doc01.german.text.xml`, and the same for
  `*.tok.xml` files.

*Anntotation span markables and feature annotations*

- By convention, annotation span [markable](spans-and-markables.md) files are named
  using the current document name as a prefix, followed by an
  underscore and the markList's type, followed by "\_seg.xml". For
  example, a markable file that marks text segments corresponding to
  discourse referents for further annotation may be named
  `mycorpus.doc01.referent_seg.xml`. This tells us just by looking at
  the file name that the markable `@type` attribute in the `markList`
  element is "referent".
- The above file may may also be put in a [namespace](namespaces.md)
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

- Hierarchical [`struct`](hierarchical-structures.md#structs) nodes are placed in files using the
  same general conventions with regard to namespaces and
  corpus/document path above, and carry a suffix corresponding to the
  `@type` attribute in the `structList` element after an underscore,
  as follows. For nodes annotating syntactic constituents of the type
  "const" within the [namespace](namespaces.md) "syntax" we may get a
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

- [Pointing relation](pointing-relations.md) files are named using the
  same conventions as above, with the edge type used as a suffix after
  the document name, e.g. a coreference edge file of the type "coref"
  in the discourse [namespace](namespaces.md) should be named:
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
