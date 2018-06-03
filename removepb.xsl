<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="no"/>
  <xsl:template match="t:pb[following-sibling::*[1]/name() = 'pb']"/>
  <xsl:variable name="firstpb" select="//t:pb[1]/@n"/>
  <xsl:template match="t:pb/@n">
    <xsl:attribute name="n" select="$firstpb + count(preceding::t:pb)"/>
  </xsl:template>
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
