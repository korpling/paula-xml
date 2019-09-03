# Namespaces

Namespaces in PAULA are user-defined strings that may be used to group
together XML files belonging to semantically related annotation layers.
PAULA namespaces are not XML namespaces, but are signaled through a
prefix to the file name which by convention should contain only
alphanumeric ASCII characters and should not begin with a number. The
end of the prefix is marked by a period.

As an example, consider the following [document's](corpus-structure.md#documents) directory
structure:

**Directory structure for a PAULA corpus**
```
+-- mycorpus/
|   +-- doc1/
|   |   |-- coref.doc1.discourse.xml
|   |   |-- coref.doc1.discourse_anaphoric.xml
|   |   |-- mycorpus.doc1.anno.xml
|   |   |-- mycorpus.doc1.annoFeat.xml
|   |   |-- mycorpus.doc1.text.xml
|   |   |-- mycorpus.doc1.tok.xml
|   |   |-- syntax.mycorpus.doc1.const.xml
|   |   |-- syntax.mycorpus.doc1.const_cat.xml
|   |   |-- syntax.mycorpus.doc1.const_func.xml
... ... ...
```

The first two file names being with the prefix "coref". This prefix
groups them together into one namespace, which contains semantically
related annotations, such as some non-terminal "discourse" nodes, and
some annotations or edges defined above these nodes, in this case of the
type "anaphoric" (for conventional relations between node and annotation
file names, see [naming conventions](naming-conventions.md)). The last
three files begin with "syntax" and belong to the corresponding "syntax"
namespace. In this case they represent annotations such as those seen in
the examples in [Hierarchical structures](hierarchical-structures.md#structs): nodes of the type "const", an
annotation document of the type "cat" and annother annotation called
"func", which represents annotated edges between the nodes. Finally, the
files in the middle begin with the corpus name "mycorpus", which is
therefore also their namespace. They could also be given a separate
namespace (e.g. "general.mycorpus...."), but there is no rule
prohibiting use of the corpus name as a namespace: this will usually be
the case when following the [naming conventions](naming-conventions.md) if
namespaces are not intentionally used (then all annotations have the
same namespace: the corpus name).

There is no necessary graph-topological connection between annotation
layers in the same namespace. Often, nodes and their annotations are
grouped together using a namespace in order to signal their
interdependence. However it is entirely possible to group any
combination of files under one namespace. At present there is no way of
assigning multiple namespaces to a single file: only the string before
the first period in a file name is evaluated as its namespace. It is
recommended to repeat the namespace in the `@paula_id` attribute of each
XML file for consistency, but the filename itself is the deciding factor
in determining the namespace.
