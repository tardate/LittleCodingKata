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
