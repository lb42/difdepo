<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  version="2"
  exclude-result-prefixes="tei xs">
  <xsl:template match="@* | node() |comment() | processing-instruction() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="/">
    <xsl:processing-instruction name="xml-model">
      <xsl:text>href="../difdepo.rnc" type="application/relax-ng-compact-syntax"</xsl:text>
    </xsl:processing-instruction>
    <xsl:apply-templates></xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>
