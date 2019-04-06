<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t ext skos rdf" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:ext="http://exslt.org/common" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="no"/>
  <!-- 
  insert skos:Concept with @rdf:ID, prefLabel and altLabel in a set of thesauri (persons.xml, organizations.xml, events.xml, titles.xml, terms.xml)
  based on a collection of xml tei files annotated with persName, orgName, name, title and term elements 
  former concepts are preserved, even if they do not appear in the corpus anymore
  forms that differ only by the ponctuation are inserted as differents labels of the same concept
  forms that are strictly smilar are merged under the same concept
  -->
  <xsl:import href="normalize.xsl"/>
  <xsl:variable name="thesaurus" select="/"/>
  <!-- get thesaurus type and corresponding tei element name -->
  <xsl:variable name="filename" select="tokenize(base-uri(), '/')[last()]"/>
  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="$filename = 'persons.xml'">persName</xsl:when>
      <xsl:when test="$filename = 'organizations.xml'">orgName</xsl:when>
      <xsl:when test="$filename = 'events.xml'">name</xsl:when>
      <xsl:when test="$filename = 'titles.xml'">title</xsl:when>
      <xsl:when test="$filename = 'terms.xml'">term</xsl:when>
      <xsl:when test="$filename = 'team_members.xml'">name</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ancestor">
    <xsl:choose>
      <xsl:when test="$filename = 'persons.xml'">TEI</xsl:when>
      <xsl:when test="$filename = 'organizations.xml'">text</xsl:when>
      <xsl:when test="$filename = 'events.xml'">text</xsl:when>
      <xsl:when test="$filename = 'titles.xml'">text</xsl:when>
      <xsl:when test="$filename = 'terms.xml'">text</xsl:when>
      <xsl:when test="$filename = 'team_members.xml'">titleStmt</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:template match="rdf:RDF">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
      <xsl:for-each select="collection('Current/?select=*.xml')//t:*[name() = $type][ancestor::t:*[name()=$ancestor]]">
        <!--[not(@ref)]-->
        <!--    [not(parent::t:titleStmt or parent::t:bibl)]    -->
        <!--  get info on the current form  -->
        <!--  create a readable label  -->
        <xsl:variable name="form">
          <xsl:call-template name="normalize">
            <xsl:with-param name="mode"/>
          </xsl:call-template>
        </xsl:variable>
        <!--   generate an id (used as an id, and to compare with other forms)  -->
        <xsl:variable name="id">
          <xsl:call-template name="normalize">
            <xsl:with-param name="mode">transform</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="not($thesaurus//skos:altLabel[replace(translate(lower-case(.), 'àáâãäåæçčèéêë∈ìíîïòóôõöœûüù∏π', 'aaaaaaacceeeeeiiiioooooouuupp'),'[^a-z0-9]','') = replace(translate(lower-case($form), 'àáâãäåæçčèéêë∈ìíîïòóôõöœûüù∏π', 'aaaaaaacceeeeeiiiioooooouuupp'),'[^a-z0-9]','')] | $thesaurus//skos:prefLabel[replace(translate(lower-case(.), 'àáâãäåæçčèéêë∈ìíîïòóôõöœûüù∏π', 'aaaaaaacceeeeeiiiioooooouuupp'),'[^a-z0-9]','') = replace(translate(lower-case($form), 'àáâãäåæçčèéêë∈ìíîïòóôõöœûüù∏π', 'aaaaaaacceeeeeiiiioooooouuupp'),'[^a-z0-9]','')])">
          <!--  if the form is already registered, do nothing, otherwise insert a new concept  -->
          <skos:Concept rdf:ID="{$id}">
            <skos:prefLabel>
              <xsl:value-of select="$form"/>
            </skos:prefLabel>
          </skos:Concept>
        </xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>
  <!-- 
    Pass 2 : 
      group forms with the same id under the same concept, 
      remove duplicate forms
  -->
  <xsl:template match="/">
    <xsl:variable name="pass1output">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:apply-templates mode="pass2" select="ext:node-set($pass1output)/*"/>
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
          <xsl:for-each select="current-group()[not(preceding-sibling::* = .)]">
            <xsl:choose>
              <xsl:when test="count(preceding::skos:prefLabel[parent::*/@rdf:ID=current-grouping-key()]) != 0">
                <skos:altLabel>
                  <xsl:value-of select="."/>
                </skos:altLabel>
              </xsl:when>
              <xsl:otherwise>
                <xsl:copy-of select="* | processing-instruction() | comment()"/>
              </xsl:otherwise>
            </xsl:choose>
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
