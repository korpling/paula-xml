# Pointing relations

Pointing relations are ahierarchical edges between any two annotation
node elements, that is between any combination of `tok`, `mark` or
`struct`. Unlike [hierarchical edges](hierarchical-structures.md#structs), pointing relations do
not express 'dominance' semantics, meaning that the source of the edge
is not understood to 'consist of' the target of the edge. The edge
merely marks a relationship between two nodes. For this reason, pointing
relations are useful in expressing such links as coreference (e.g. a
link between anaphor and antecedent) and syntactic dependencies.
Pointing relations are represented using `rel` elements in rel files,
and obey the definition in `paula_rel.dtd` (see [DTDs](required-files-and-dtds.md#additional-dtds)). The
following example illustrates rel edges between tokens defined in the
file `mycorpus.doc1.tok.xml`, but the sources and targets of the edges
can also be any `struct` or `mark` within a document.

**Pointing relations between token nodes to annotate dependencies of type "dep"**
```xml
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
```

The `rel` file only defines the edges and the `@type` of the `relList`,
in this case "dep". To add an annotation to these edges, for example
grammatical functions, a `feat` file is used, as in the following
example:

**Annotating the grammatical function "func" for dependency pointing relations**
```xml
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
```

Each `feat` element points to a `rel` element in the pointing relation
file and gives the annotation value in its `@value` attribute. The name
of the annotation, "func", is determined in the @type attribute of the
`featList`.

Just as with markables, it is also possible to specify multiple
annotations for the same pointing relations in one XML document using
multiFeat files (see [multiFeats](spans-and-markables.md#multifeats) for details).