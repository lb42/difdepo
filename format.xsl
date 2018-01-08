<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="type"><xsl:value-of select="//t:text/@type"/></xsl:variable>
  <xsl:template match="//t:titleStmt/t:title[contains(., '() : version TEI')]">
    <title><xsl:value-of select="substring-before(., '() : version TEI')"/>(<xsl:value-of select="$type"/>) : version TEI</title></xsl:template>

  <xsl:template match="@* | comment() | processing-instruction() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
