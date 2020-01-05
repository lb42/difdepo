<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t ext rdf" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:ext="http://exslt.org/common" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:template match="root">
    <rdf:RDF>
      <xsl:apply-templates/>      
    </rdf:RDF>      
  </xsl:template>
  
  <xsl:template match="row">
    <skos:Concept rdf:ID="{id}">
      <xsl:choose>
        <xsl:when test="label/text()='forme préférée'"><skos:prefLabel><xsl:value-of select="forme"/></skos:prefLabel></xsl:when>
        <xsl:otherwise><skos:altLabel><xsl:value-of select="forme"/></skos:altLabel></xsl:otherwise>
      </xsl:choose>
    </skos:Concept>      
  </xsl:template>  
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>  
  <xsl:template match="/">
    <xsl:variable name="pass1output">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:apply-templates mode="pass2" select="ext:node-set($pass1output)/*"/>
  </xsl:template>
  <xsl:template match="rdf:RDF" mode="pass2">
    <xsl:copy>
      <xsl:for-each-group group-by="@rdf:ID" select="skos:Concept">
        <skos:Concept rdf:ID="{current-grouping-key()}">
          <xsl:for-each select="current-group()"> <!--[not(preceding-sibling::* = .)]-->
<!--            <xsl:choose>
              <xsl:when test="count(preceding::skos:prefLabel[parent::*/@rdf:ID=current-grouping-key()]) != 0">
                <skos:altLabel>
                  <xsl:value-of select="."/>
                </skos:altLabel>
              </xsl:when>
              <xsl:otherwise>-->
                <xsl:copy-of select="* | processing-instruction() | comment()"/>
              <!--</xsl:otherwise>
            </xsl:choose>-->
          </xsl:for-each>
        </skos:Concept>
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>  
  <xsl:template match="@* | * | processing-instruction() | comment()" mode="pass2">
    <xsl:copy>
      <xsl:apply-templates mode="pass2" select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
