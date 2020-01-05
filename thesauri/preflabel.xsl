<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t ext rdf" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:ext="http://exslt.org/common" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:template match="skos:altLabel[1]">
    <!--  si un id n'a pas de prefLabel, transformer le premier altLabel en prefLabel (j'ai vérifié en amont qu'il n'y a pas plusieurs prefLabel pour un id  -->
    <xsl:choose>
      <xsl:when test="count(../skos:prefLabel)=0"><skos:prefLabel><xsl:apply-templates/></skos:prefLabel></xsl:when>
      <xsl:otherwise>
        <xsl:copy><xsl:apply-templates/></xsl:copy>
      </xsl:otherwise>
    </xsl:choose>   
  </xsl:template>
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template> 
</xsl:stylesheet>
