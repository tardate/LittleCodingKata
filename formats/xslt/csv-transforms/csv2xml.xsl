<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  expand-text="yes">

<xsl:output method="xml" indent="yes"/>

<!-- Parameter -->
<xsl:param name="csv-uri"/>

<xsl:template match="/">
  <rows>
    <xsl:variable name="lines" select="unparsed-text-lines($csv-uri)"/>
    <xsl:variable name="headers" select="tokenize($lines[1], ',')"/>

    <xsl:for-each select="$lines[position() > 1]">
      <row>
        <xsl:variable name="fields" select="tokenize(., ',')"/>

        <xsl:for-each select="1 to count($headers)">
          <xsl:element name="{$headers[current()]}">
            {$fields[current()]}
          </xsl:element>
        </xsl:for-each>
      </row>
    </xsl:for-each>
  </rows>
</xsl:template>

</xsl:stylesheet>
