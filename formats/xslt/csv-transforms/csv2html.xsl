<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  expand-text="yes">

<xsl:output method="html" indent="yes"/>

<!-- Parameter -->
<xsl:param name="csv-uri"/>

<xsl:template match="/">
  <html>
    <body>
      <h2>CSV Table</h2>

      <xsl:variable name="lines" select="unparsed-text-lines($csv-uri)"/>
      <xsl:variable name="headers" select="tokenize($lines[1], ',')"/>

      <table border="1">
        <tr>
          <xsl:for-each select="$headers">
            <th>{.}</th>
          </xsl:for-each>
        </tr>

        <xsl:for-each select="$lines[position() > 1]">
          <tr>
            <xsl:for-each select="tokenize(., ',')">
              <td>{.}</td>
            </xsl:for-each>
          </tr>
        </xsl:for-each>
      </table>

    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
