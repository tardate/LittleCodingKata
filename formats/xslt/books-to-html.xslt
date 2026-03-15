<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
  <html>
    <body>
      <h2>Book Catalog</h2>
      <ul>
        <xsl:apply-templates select="catalog/book"/>
      </ul>
    </body>
  </html>
</xsl:template>

<xsl:template match="book">
  <li>
    <b><xsl:value-of select="title"/></b>
    — <xsl:value-of select="author"/>
  </li>
</xsl:template>

</xsl:stylesheet>
