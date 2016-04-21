<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
-->
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
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
  <xsl:template match="tei:p[normalize-space() = ''][tei:pb]">
    <xsl:apply-templates select="node() | @*"/>
  </xsl:template>
  <xsl:template match="tei:item[tei:persName]">
    <xsl:choose>
      <xsl:when test="(./tei:persName = 'xx') or (./tei:persName = 'XX') or (./tei:persName/@ref='#XX') or (./tei:persName/@ref='#xx')"/>

      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:persName|tei:placeName">
    <xsl:choose>
      <xsl:when test="(. = 'xx') or (. = 'XX') or (@ref='#XX') or (@ref='#xx')"/>
      <!--      attribut
-->
      <xsl:when test="(. = ' ') or (. = ' ')">
        <xsl:apply-templates select="node() | @*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:persName[node()[1]
    [self::text()[(substring(., 1, 1)=' ')]]]">
    <xsl:value-of select="substring(., 1, 1)"/>
    <xsl:copy>
      <xsl:value-of select="substring(., 2, string-length())"/>
    </xsl:copy>
    
  </xsl:template>
  <!--<xsl:template match="note[@place='comment']"></xsl:template>-->
  
  <!--  <xsl:template match="*/node()[1]
    [self::text()[(substring(., 1, 1)=' ') or (substring(., 1, 1)=' ')]]">
    
    <xsl:text> </xsl:text><xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
    
  </xsl:template>-->
  <!--  <xsl:template match="*/node()[1]
    [self::text()[(substring(., 1, 1)=' ') or (substring(., 1, 1)=' ')]]">
    <xsl:value-of select="substring(., 1)"/>
  </xsl:template>-->
</xsl:stylesheet>
