# Primary text data

The `primary text data` forms the lowest level of resource
representation, corresponding to the minimally analyzed linguistic data:
a strech of untokenized plain text. The presence of at least one such
file is obligatory in every PAULA `document`. Even if the resource to be
annotated originates in spoken data for which a primary recording
exists, its textual transcription forms the primary data. A segment of a
recording is therefore seen to 'take place' in correspondences with a
certain stretch of text (see [Aligned audio/video files](special-scenarios.md#aligned-audiovideo-files) for
details). The primary data follows the schema definition in
`paula_text.dtd`, which must be present. The type of the file is "text",
and by convention the file name ends with the extension `*.text.xml` and
its paula\_id is the same as the file name prefix, ending in `_text`
instead of the file extension `*.text.xml`.
The following example illustrates a `primary text data` file
called `mycorpus.doc1.text.xml`.

**A primary text data file**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_text.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc1_text" type="text"/>

<body>This is an example.</body>

</paula>
```

A PAULA document can also contain more than one `primary text
data` file. There are at least two scenarios where this is recommended,
for which the respective sections should be consulted: [parallel
corpora](special-scenarios.md#parallel-corpora) with aligned texts in multiple languages and
[dialogue data](special-scenarios.md#dialogue-data) with multiple simultaneous speakers.

As with other PAULA XML files, the first segment of text before a period
within the filename of the `primary text data` file can be interpreted
as a PAULA `namespace`. In documents with only one such file, this is
usually not important, but it is possible to use namespaces to group
together text from different languages or speakers in parallel corpora
or dialogue data respectively.