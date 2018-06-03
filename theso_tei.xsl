<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t skos" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="no"/>
  <!-- 
  insert @ref 
  on persName, orgName, name, title and term elements 
  in a corpus of xml-tei files
  based on 5 thesauri in skos : persons.xml, organizations.xml, events.xml, titles.xml, terms.xml
  
  @ref will point to the skos:Concept if 
    1° the type of the entity corresponds to the thesaurus (persName against persons.xml, orgName against organizations.xml, etc.)
    2° the text content of the element is the same as one of the prefLabel/altLabel of the Concept
  former @ref are overwritten (or removed if there is no match in the current thesaurus)
  -->
  <xsl:import href="normalize.xsl"/>
  <xsl:template match="t:persName | t:orgName | t:name[@type = 'manif'] | t:term | t:text//t:title">
    <!-- get info on the current tei element  -->
    <!-- before comparing forms of the thesaurus and the form in the tei, normalize the later -->
    <xsl:variable name="id">
      <xsl:call-template name="normalize">
        <xsl:with-param name="mode">transform</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <!--  get type  -->
    <xsl:variable name="type" select="name()"/>
    <xsl:copy>
      <xsl:for-each select="collection('thesauri/?select=*.xml')//*[self::skos:altLabel or self::skos:prefLabel]">
        <!-- get info on the current thesaurus entry  -->
        <!-- before comparing forms of the thesaurus and the form in the tei, normalize the former -->
        <xsl:variable name="thesaurus_id">
          <xsl:call-template name="normalize">
            <xsl:with-param name="mode">transform</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <!-- get the thesaurus name and transform to the tei element on which it has authority -->
        <xsl:variable name="filename" select="tokenize(base-uri(), '/')[last()]"/>
        <xsl:variable name="thesaurus_type">
          <xsl:choose>
            <xsl:when test="$filename = 'persons.xml'">persName</xsl:when>
            <xsl:when test="$filename = 'organizations.xml'">orgName</xsl:when>
            <xsl:when test="$filename = 'events.xml'">name</xsl:when>
            <xsl:when test="$filename = 'titles.xml'">title</xsl:when>
            <xsl:when test="$filename = 'terms.xml'">term</xsl:when>
          </xsl:choose>
        </xsl:variable>
        <!--  if we are in the right thesaurus for this element + form is the same, insert @ref pointing to skos:Concept/@rdf:ID  -->
        <xsl:if test="$thesaurus_id = $id and $thesaurus_type = $type">
          <xsl:attribute name="ref">difdepo:<xsl:value-of select="$filename"/>#<xsl:value-of select="./parent::*/@rdf:ID"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>
      <xsl:apply-templates select="* | @type | @role | processing-instruction() | comment() | text()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
