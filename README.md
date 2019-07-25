# PAULA XML: Interchange Format for Linguistic Annotations

_**PAULA XML**_ or *PAULA* for short (*Potsdamer AUstauschformat Linguistischer Annotationen*, 'Potsdam Exchange Format for Linguistic Annotations') is a standoff XML format designed to represent a wide range of linguistically annotated textual and multi-modal corpora. The format was created at Potsdam University and developed within SFB 632 "Information Structure", in subproject D1, "Linguistic Database" at Potsdam University and Humboldt-Universität zu Berlin. 

The standoff nature of PAULA refers to the fact that each layer of linguistic annotation, such as partof- speech annotations, lemmatizations, syntax trees, coreference annotation etc. are stored in separate XML files which refer to the same raw data. In this manner annotations can easily be added, deleted and updated without disturbing independent annotation layers, and discontinuous or hierarchically conflicting structures can be represented. Additionally the format ensures the retainment of unaltered raw data, including white space and other elements often lost due to restrictions of the encoding format.

As a generalized XML format, PAULA is indifferent to particular names or semantics of annotation structures. It concentrates instead on the representation of corpus data as a set of arbitrarily labeled directed acyclic graphs (so called multi-DAGs, wherein annotation projects may contain cycles as long as these are on different annotation levels).

## Online version of the documentation

See the current PAULA documentation: [PAULA version 1.1](http://www.sfb632.uni-potsdam.de/images/doc/PAULA_P1.1.2013.1.21a.pdf)

## Compile the documentation

**Note that the markdown files in this repository are work in progress! If you just need the released documentation use the link to the PDF file above.**

The old documentation was written in Docbook but we are now migrating to Markdown and mdBook.

You will need [mdBook](https://github.com/rust-lang-nursery/mdBook) installed (at least version 0.3.1) which you can get from their [release page](https://github.com/rust-lang-nursery/mdBook/releases).

Execute mdBook to build a HTML version of the documentation in the `book/` subdirectory.
```bash
mdbook build
```

See the [mdBook User Guide](https://rust-lang-nursery.github.io/mdBook/) for more instructions on how to build this documentation. For smaller changes (e.g. typos), you can also just edit the Markdown files in the `src/` folder directly on GitHub. Changes are automatically deployed to [https://korpling.github.io/paula-xml/next/](https://korpling.github.io/paula-xml/next/).
