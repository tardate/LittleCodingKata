# #431 XSLT

About Extensible Stylesheet Language Transformations (XSLT), with a simple example on macOS. Also a discussion of the current state of support and the pending removal of XSLT support from browsers.

## Notes

XSLT (Extensible Stylesheet Language Transformations) is a language originally designed for transforming XML documents into other XML documents, or other formats such as HTML or plain text.

XSLT has been particularly supported over the years by "back-end" technology players such as Microsoft, IBM, Oracle, and the Apache Software Foundation.

XSLT lost its prominence around 2008 with APIs moving towards JSON, and the rise of application-Language templating (Rails, Django, Handlebars), and browser support stagnated.

XSLT has been back in the news recently,
as XSLT support is being removed from browsers - see
the reporting in [Security Now 1051](https://www.grc.com/sn/sn-1051.htm) for example.

[Google Chrome - Removing XSLT for a more secure browser](https://developer.chrome.com/docs/web-platform/deprecating-xslt) has already been announced,
with many expecting Safari/WebKit and Mozilla/Firefox to follow.
There has been significant push-back however, as many government and legal applications reply on browser-based XSLT support.

### XSLT In a Nutshell

* XSLT (Extensible Stylesheet Language Transformations) is a declarative language for transforming XML documents into other formats (XML, HTML, or text).
* Works by applying templates to nodes in an XML document.
* Uses pattern matching + tree transformation rather than procedural steps.
* Navigation and selection are done using XPath.
* Standardized by the World Wide Web Consortium.
    * XSLT 1.0 (1999): first recommendation, widely supported, basic transformations
    * XSLT 2.0: sequences, regex, stronger typing
    * Current Version: [XSLT 3.0](https://www.w3.org/TR/xslt-30/) (2017): streaming, functions, packages
* Core Processing Model: XML tree → match templates → build result tree
* XSLT processors include implementations such as Saxon and Xalan.

### Minimal Stylesheet

```xml
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <body>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
```

### Core Elements

#### Template

Defines how nodes should be transformed.

```xml
<xsl:template match="book">
  <p><xsl:value-of select="title"/></p>
</xsl:template>
```

#### Apply Templates

Processes child nodes.

```xml
<xsl:apply-templates select="book"/>
```

#### Value Output

Outputs text value.

```xml
<xsl:value-of select="title"/>
```

#### Loop

```xml
<xsl:for-each select="catalog/book">
  <li><xsl:value-of select="title"/></li>
</xsl:for-each>
```

#### Conditional

```xml
<xsl:if test="price &gt; 20">
  <expensive/>
</xsl:if>
```

#### Choose / Case

```xml
<xsl:choose>
  <xsl:when test="price &lt; 10">cheap</xsl:when>
  <xsl:otherwise>normal</xsl:otherwise>
</xsl:choose>
```

#### Variables

```xml
<xsl:variable name="tax" select="0.2"/>
```

Immutable once set.

#### Parameters (External Input)

```xml
<xsl:param name="currency"/>
```

#### XPath Basics

Common selectors used inside XSLT:

| Expression       | Meaning              |
| ---------------- | -------------------- |
| `/`              | root                 |
| `book`           | child elements       |
| `//book`         | anywhere in document |
| `@id`            | attribute            |
| `book/title`     | child path           |
| `book[price>10]` | filtered nodes       |

Examples:

```xpath
book[1]
book[@category='fiction']
sum(book/price)
```

#### Sorting

```xml
<xsl:apply-templates select="book">
  <xsl:sort select="title"/>
</xsl:apply-templates>
```

#### Creating Elements

```xml
<xsl:element name="item">
  <xsl:value-of select="title"/>
</xsl:element>
```

Or literal result:

```xml
<li><xsl:value-of select="title"/></li>
```

#### Attribute Creation

```xml
<xsl:attribute name="class">highlight</xsl:attribute>
```

#### Output Control

```xml
<xsl:output method="html" indent="yes"/>
```

Methods:

* `xml`
* `html`
* `text`

#### Template Matching Patterns

| Pattern  | Matches       |
| -------- | ------------- |
| `/`      | document root |
| `*`      | any element   |
| `book`   | book elements |
| `@*`     | any attribute |
| `text()` | text nodes    |

Example:

```xml
<xsl:template match="text()"/>
```

(suppresses raw text)

### Example: HTML Book Catalog Generation

This is a simple example of transforming an XML catalog of book records into HTML.

The source records are in [books.xml](./books.xml):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<catalog>
  <book isbn="9798707512940">
    <title>Diary of a War Crime</title>
    <author>Simon McCleave</author>
  </book>
  <book isbn="9780063250864">
    <title>Yellowface</title>
    <author>R.F. Kuang</author>
  </book>
</catalog>

```

The transformation is defined in [books-to-html.xslt](./books-to-html.xslt):

```xslt
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
  <html>
    <body>
      <h2>Book Catalog</h2>
      <ul>
        <xsl:apply-templates mode="toc"/>
      </ul>
      <hr/>
        <xsl:apply-templates select="catalog/book"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="book" mode="toc">
  <li>
    <a href="#{generate-id()}"><xsl:value-of select="title"/></a><br/>
  </li>
</xsl:template>

<xsl:template match="book">
  <h3 id="{generate-id()}"><xsl:value-of select="title"/></h3>
  <p>
  Author: <xsl:value-of select="author"/>
  <br/>
  ISBN: <xsl:value-of select="@isbn"/>
  </p>
</xsl:template>

</xsl:stylesheet>
```

I am running this on macOS, and using
[xsltproc](https://linux.die.net/man/1/xsltproc), which is installed by default as part of the
[libxslt](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/libxslt.3.html).
I use this to perform the transformation:

```sh
xsltproc books-to-html.xslt books.xml > books.html
```

The result is captured in [books.html](./books.html):

```html
<html><body>
<h2>Book Catalog</h2>
<ul>
  <li>
<a href="#id1">Diary of a War Crime</a><br>
</li>
  <li>
<a href="#id2">Yellowface</a><br>
</li>
</ul>
<hr>
<h3 id="id1">Diary of a War Crime</h3>
<p>
  Author: Simon McCleave<br>
  ISBN: 9798707512940</p>
<h3 id="id2">Yellowface</h3>
<p>
  Author: R.F. Kuang<br>
  ISBN: 9780063250864</p>
</body></html>
```

## Credits and References

* <https://en.wikipedia.org/wiki/XSLT>
* <https://www.w3.org/TR/xslt-30/>
* [xsltproc](https://linux.die.net/man/1/xsltproc)
* [Mastering XSLT](../../books/mastering-xslt/), by Chuck White. First published January 1, 2002.
