# Metadata

Metadata encompasses annotations that apply to an entire object in the
corpus structure, i.e. to a corpus, subcorpus or document. The metadata
does not annotate specific elements within a text, but rather
characterizes the entire container object. In PAULA XML metadata is
realized in lists of `feat` elements (features), which refer to the
`annoSet` of the relevant object (see [annoSets](corpus-structure.md#annosets)). It is also
possible for metadata annotations to carry a [namespace](namespaces.md),
just like any other form of annotation.

## Corpus and subcorpus metadata

Corpus and subcorpus level metadata can optionally be added to any
corpus or subfolder containing an `annoSet`. It is not possible to add
metadata to a folder not containing an `annoSet`. The following example
illustrates a metadata annotation for the corpus `mycorpus`.

**Metadata for the corpus `mycorpus`**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_feat.dtd">
<paula version="1.1">

<header paula_id="mycorpus.meta_lang"/>

<featList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="lang" xml:base="mycorpus.anno.xml">
    <feat xlink:href="#anno_1" value="eng"/><!-- English -->
</featList>

</paula>
```

Since the name of the metadata attribute is determined in the the
`@type` attribute of the `featList` element, it is necessary to define a
separate `feat` file for each metadata annotation, unless
[multiFeat](#using-multifeats-in-metadata) metadata files are used. Note also that in
this example the feat is only pointing at the `struct` element "anno\_1"
from the `annoSet` file `mycorpus.anno.xml`. It is also possible to have
multiple `feat` elements, pointing to each one of the `struct` elements
in the `annoSet`. In the current version of PAULA this makes no
difference: once a metadata annotation has been applied to any `struct`
element in the `annoSet`, it applies to the entire object described by
the `annoSet`.

## Document metadata

Document metadata works exactly like corpus metadata: it is defined
within a `feat` file which has the annotation name in the `featList`
`@type` attribute and the value in the `feat` `@value` attribute. The
`feat` element should point at a `struct` element from the document's
`annoSet`. It is possible but not necessary to annotate all `struct`
elements in the `annoSet`. The following example demonstrates this.

**Metadata for the document `mycorpus/doc1`**
```xml
<?xml version="1.0" standalone="no"?>

<!DOCTYPE paula SYSTEM "paula_feat.dtd">
<paula version="1.1">

<header paula_id="mycorpus.doc1.meta_year"/>

<featList xmlns:xlink="http://www.w3.org/1999/xlink" type="year" 
xml:base="mycorpus.doc1.anno.xml">
    <feat xlink:href="#anno_1" value="1999"/><!-- year 1999 -->
</featList>

</paula>
```

If the `annoSet` of doc1 contains several structs names "anno\_1",
"anno\_2" etc., it is possible to annotate them all using multiple
`feat` elements. This is identical to annotating just one of the
elements, as in the example above: the metadata annotation "year" has
been applied to the document and given the value "1999".

## Using multifeats in metadata

When using a large number of metadata annotations, it is sometimes more
convenient to use just one XML document to define all meta annotations.
This is made possible by using `multiFeat` files. The following example
illustrates the use of `multiFeat` annotations to define metadata. For
more detailed information on `multiFeat` annotations see also [multiFeat
annotations](spans-and-markables.md#multifeats).

**Multiple metadata annotations in one file using `multiFeat`
elements.**
```xml
<?xml version="1.0" standalone="no"?>
<!DOCTYPE paula SYSTEM "paula_multiFeat.dtd">

<paula version="1.1">
<header paula_id="mycorpus.doc1.meta_multiFeat"/>
    
<multiFeatList xmlns:xlink="http://www.w3.org/1999/xlink" 
type="multiFeat" xml:base="mycorpus.doc1.anno.xml">

    <multiFeat xlink:href="#anno_1"> 
        <feat name="year" value="2012"/>
        <feat name="language" value="English"/>
        <feat name="source_format" value="PAULA XML"/>
        <!-- ... -->
    </multiFeat>
    
</multiFeatList>

</paula>
```

## AnnoFeats

Each PAULA document may optionally contain an `annoFeat` file listing
the types of all annotation files including `mark`, `feat`, `struct` and
`rel` files, for validation purposes. Not including an `annofeat` file
means that the annotation layers available within the files specified in
the `annoSet` cannot be validated, though it may make it easier to
update annotation layers dynamically. The following example illustrates
the use of the `annoFeat` file in reference to the [first example in the previous section](corpus-structure.html#annosets).

**An `annoFeat` file for doc1 in mycorpus**
```xml
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!DOCTYPE paula SYSTEM "paula_feat.dtd">
    
    <paula version="1.1">
     <header paula_id="mycorpus.doc1.annoFeat" />
     <featList type="annoFeat" xml:base="mycorpus.doc1.anno.xml" 
    xmlns:xlink="http://www.w3.org/1999/xlink">
      <feat xlink:href="#rel_1" value="annoFeat" />
      <feat xlink:href="#rel_2" value="text" />
      <feat xlink:href="#rel_3" value="tok" />
      <feat xlink:href="#rel_4" value="pos" />
      <feat xlink:href="#rel_5" value="lemma" />
      <feat xlink:href="#rel_6" value="phrase" />
      <feat xlink:href="#rel_7" value="cat" />
      <feat xlink:href="#rel_8" value="func" />
     </featList>
    
    </paula>
```

Note that since the value of the `feat` is a string and not an ID, it is
possible for multiple rels to refer to the same annotation type name. In
order to disambiguate in such cases, it is possible to use
[namespaces](namespaces.md), provided that these have been used in the
corresponding annotation files. The value then takes the form
"namespace:anno\_name", e.g. "stts:pos".

The `annoFeat` file cannot be used in corpus and subcorpus directories.