<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  version="2"
  exclude-result-prefixes="tei xs">
  <xsl:template match="@* | node() |comment() | processing-instruction() | text()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node() |comment() | processing-instruction() | text()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/">
    <xsl:processing-instruction name="xml-model">
      <xsl:text>href="../difdepo.rnc" type="application/relax-ng-compact-syntax"</xsl:text>
    </xsl:processing-instruction>
    <xsl:apply-templates></xsl:apply-templates>
  </xsl:template>
  <xsl:variable name="first_page">
    <xsl:value-of select="substring-before(substring-after(//tei:titleStmt/tei:title, 'pp. '), ' à')"/>
  </xsl:variable>
  <xsl:template match="//*//tei:pb">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
      <xsl:attribute name="n">
        <xsl:value-of select="$first_page + count(preceding::tei:pb)"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
