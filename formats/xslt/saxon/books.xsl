<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="urn:func"
  expand-text="yes">

<xsl:output method="html" indent="yes"/>

<!-- XSLT 3.0: mode declaration -->
<xsl:mode on-no-match="shallow-skip"/>

<!-- XSLT 2.0+: function -->
<xsl:function name="f:slugify" xmlns:f="urn:func">
  <xsl:param name="s"/>
  <xsl:sequence select="
    replace(lower-case(normalize-space($s)), '[^a-z0-9]+', '-')"/>
</xsl:function>

<xsl:template match="/">
  <html>
    <body>
      <h2>Book Catalog</h2>

      <!-- XSLT 2.0: for-each-group (group by first letter) -->
      <ul>
        <xsl:for-each-group select="catalog/book"
                            group-by="upper-case(substring(title,1,1))">
          <li>
            <b>{current-grouping-key()}</b>
            <ul>
              <!-- XSLT 2.0: sort -->
              <xsl:for-each select="current-group()">
                <xsl:sort select="title"/>
                <li>
                  <a href="#{f:slugify(title)}">{title}</a>
                </li>
              </xsl:for-each>
            </ul>
          </li>
        </xsl:for-each-group>
      </ul>

      <hr/>

      <!-- XSLT 3.0: apply-templates unchanged but benefits from mode -->
      <xsl:apply-templates select="catalog/book"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="book">
  <!-- XSLT 2.0: computed attribute with function -->
  <h3 id="{f:slugify(title)}">{title}</h3>

  <p>
    Author: {author}<br/>

    <!-- XSLT 2.0: conditional expression -->
    ISBN: { if (@isbn) then @isbn else 'N/A' }
    <br/>

    <!-- XSLT 2.0: sequence + string-join -->
    Title words: { string-join(tokenize(title, '\s+'), ', ') }
  </p>
</xsl:template>

</xsl:stylesheet>
