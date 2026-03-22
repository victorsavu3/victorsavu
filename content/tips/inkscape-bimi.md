+++
title = "Create a BIMI compatible file from Inkscape"
date = 2026-03-22T21:00:00Z
tags=["inkscape", "BIMI"]
+++

## Background

[BIMI](https://bimigroup.org/) only supports [SVG Tiny Portable/Secure](https://datatracker.ietf.org/doc/html/draft-svg-tiny-ps-abrotman), which is a quite restricted profile. My logo is quite simple, but Adobe Illustrator and Inkscape both create entries that are not compatible with it, mostly by using`style` attributes. Saving an Optimized SVG and editing the resulting file worked from Inkscape.


## Steps

### 1. Add a title

The document should have a title for the format to be valid for BIMI. Add it in Inkscape:

<a href="/inkscape-bimi/metadata.png">
    <img src="/inkscape-bimi/metadata.png" alt="Document Metadata page" style="height: 50vh;"/>
</a>

### 2. Save the right format

Use `Optimized SVG` in the `Save As` dialog:

<a href="/inkscape-bimi/save.png">
    <img src="/inkscape-bimi/save.png" alt="Save As Optimized SVG" style="height: 50vh;"/>
</a>

### 3. Configure export

The precision of the output must be set to `2` and `Collapse groups` should be selected.

<a href="/inkscape-bimi/optimized.png">
    <img src="/inkscape-bimi/optimized.png" alt="Save As Optimized SVG" style="height: 50vh;"/>
</a>

### 4. Edit the resulting SVG

Replace the version attribute of the `svg` node from `version="1.1"` to `version="1.2" baseProfile="tiny-ps"`. As a sed one-liner:

```
sed -e 's|version="1.1"|version="1.2" baseProfile="tiny-ps"|'  
```

You also need to remove the `metadata` section as Inkscapes adds incompatible elements to it (like `rdf:RDF`):

```
 <metadata>
  ...
 </metadata>
```

### 5. Validate the result

Follow the [official instructions](https://bimigroup.org/using-the-rnc-schema-to-validate-bimi-svg-images/) and validate the resulting `svg` file using `jingtrang`. I added this to my [justfile](https://forgejo.victorsavu.eu/victor/victorsavu/src/commit/5a9c06b9d4294164e38af9d564f71eda4affc4a3/justfile#L33).
