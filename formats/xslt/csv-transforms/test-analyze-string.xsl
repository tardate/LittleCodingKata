<?xml version="1.0" encoding="windows-1252" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <!-- this demonstrates simple use of analyze-string function -->
  <xsl:template match="/">
  <xsl:analyze-string select="'a,b,c'" regex=",">
    <xsl:matching-substring/>
      <xsl:non-matching-substring>
        <xsl:element name="field">
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:non-matching-substring>
  </xsl:analyze-string>
  </xsl:template>
</xsl:stylesheet>
