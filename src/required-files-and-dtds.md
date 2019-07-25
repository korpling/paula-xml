# Required files and DTDs

## Minimal document structure

Every document within a PAULA corpus requires at least one instance of
each of the following three XML file types: a `primary text data` file,
a [`tokenization`](spans-and-markables.md#tokenizations-and-token-markables), and an `annoSet` file. These
accordingly define the raw data, a basic segmentation of the data into
minimal units and a list of the files in the directory (see
documentation of the individual file types for details).

Additionally, the relevant DTDs must be added which define these file
types. At a minimum, the DTDs necessary for the required files above
are:

  - `paula_header.dtd`

  - `paula_struct.dtd`

  - `paula_mark.dtd`

  - `paula_text.dtd`

The DTDs may be repeated in each document to simplify moving and adding
documents at any point in the corpus structure (as in the examples in
this documentation), or else DTDs can be saved in one folder (e.g. the
corpus root) and referred to from each document using a relative path.

## Additional DTDs

Beyond the DTDs in the previous section, if the document contains any
`feat` annotations or an `annoFeat` file, it will require the DTD
`paula_feat.dtd`, and if it contains [pointing
relations](pointing-relations.md) using the `rel` element, the file
`paula_rel.dtd` will also be necessary. A further DTD,
`paula_multiFeat.dtd`, is needed if multiple feat annotations should be
defined in one XML file, see [multifeats](spans-and-markables.md#multifeats).

Usually the necessary DTDs are repeatedly included in every document
folder for validation purposes, though it is possible to include them in
only one folder and refer to them from each document using a relative
path (cf. the previous section). It is not necessary to include
`paula_rel.dtd` or `paula_feat.dtd` for corpora or documents that do not
contain pointing relations, even if some other documents in the corpus
do, though it may be recommended to have the same DTDs or DTD references
in all folders in case pointing relations or feature annotations are
added to further corpus documents later on. The following full list of
DTDs may therefore be included in every document:

  - `paula_header.dtd`

  - `paula_struct.dtd`

  - `paula_mark.dtd`

  - `paula_text.dtd`

  - `paula_feat.dtd`

  - `paula_rel.dtd`

  - `paula_multiFeat.dtd`