<?xml version="1.0" encoding="windows-1252" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- simple test of the tokenize function -->
	<xsl:template match="/">
		<xsl:for-each  select="tokenize('a,b,c',',')">
			<xsl:element name="field">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
