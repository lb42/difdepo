<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="2" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="node() | @*" name="identity">
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
      <xsl:attribute name="xml:id">
        p<xsl:value-of select="$first_page + count(preceding::tei:pb)"/>
      </xsl:attribute>
      <xsl:attribute name="n">
        <xsl:value-of select="$first_page + count(preceding::tei:pb)"/>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="tei:p[normalize-space() = ''][tei:pb]">
    <xsl:apply-templates select="node() | @*"/>
  </xsl:template>
  <xsl:template match="tei:placeName">
    <xsl:choose>
      <xsl:when test="(. = 'xx') or (. = 'XX') or (./@ref = '#XX') or (./@ref = '#xx')"/>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template><xsl:template match="tei:item[tei:persName] | tei:item[tei:placeName]">
    <xsl:choose>
      <xsl:when test="(./* = 'xx') or (./* = 'XX') or (./*/@ref = '#XX') or (./*/@ref = '#xx')"/>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="
      tei:body//*[(self::tei:persName) or (self::tei:orgName) or (self::tei:name) or (self::tei:title) or (self::tei:term) or (self::tei:unclear) or (self::tei:ref)][node()[last()]
      [self::text()[(substring(., string-length()) = ' ') or (substring(., string-length()) = ' ') or (substring(., string-length()) = ',')]]]">
    <xsl:copy>
      <xsl:value-of select="substring(., 0, string-length())"/>
    </xsl:copy>
    <xsl:value-of select="substring(., string-length())"/>
  </xsl:template>
  <!--  remove space
-->
  <xsl:template match="
      tei:body//*[(self::tei:p) or (self::tei:item) or (self::tei:list) or (self::tei:label) or (self::tei:note)]/node()[last()]
      [self::text()[(substring(., string-length()) = ' ') or (substring(., string-length()) = ' ')]]">
    <xsl:value-of select="substring(., 0, string-length())"/>
  </xsl:template>
  
  <xsl:template match="
    tei:body//*[(self::tei:p) or (self::tei:label)]/node()[1]
    [self::text()[(substring(., 1, 1) = '-') or (substring(., 1, 1) = '–')]]"><xsl:text>– </xsl:text><xsl:value-of select="substring(., 2, string-length())"/></xsl:template>
  <xsl:template match="
    tei:body//*[(self::tei:item)]/node()[1]
    ">
    <xsl:value-of select="replace(., '^[-–]{1,2} ?(.+?)', '$1')"/>
  </xsl:template>
  <xsl:template match="tei:unclear">
    <xsl:choose>
      <xsl:when test="(lower-case(text()) = 'mot illisible') or (lower-case(text()) = '***')">
        <gap/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="text()[following-sibling::*[1][self::tei:unclear]][substring(., string-length()) = '[']">
    <xsl:value-of select="substring(., 1, string-length() - 1)"/>
  </xsl:template>
  <xsl:template match="text()[preceding-sibling::*[last()][self::tei:unclear]][substring(., 1, 1) = ']']">
    <xsl:value-of select="substring(., 2)"/>
  </xsl:template>
  <!--<xsl:template match="tei:p[tei:label][not(text())]">
    <xsl:apply-templates/>
  </xsl:template>-->

</xsl:stylesheet>
