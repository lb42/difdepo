<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:template match="t:titleStmt/t:title">
    <title><xsl:apply-templates/></title>
    <title type="sub">
      <xsl:choose>
        <xsl:when test="//t:text/@type = 'cr'">Compte-rendu de la réunion du </xsl:when>
        <xsl:when test="//t:text/@type = 'cv'">Convocation à une réunion, envoyée le </xsl:when>
        <xsl:otherwise>Ordre du jour de la réunion du </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="//t:bibl//t:date"/>
    </title>
  </xsl:template>
  <xsl:template match="@* | comment() | processing-instruction() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
