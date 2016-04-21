<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="2" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*" name="identity">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:body//*[(self::tei:persName) or (self::tei:orgName) or (self::tei:name) or (self::tei:title) or (self::tei:term) or (self::tei:unclear) or (self::tei:ref)][node()[1]
    [self::text()[(substring(., 1, 1) = ' ') or (substring(., 1, 1) = ' ')]]]">
    <xsl:value-of select="substring(., 1, 1)"/>
    <xsl:copy>
      <xsl:value-of select="substring(., 2, string-length())"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="
    tei:body//*[(self::tei:p) or (self::tei:item) or (self::tei:list) or (self::tei:label)  or (self::tei:note)]/node()[1]
    [self::text()[(substring(., 1, 1) = ' ') or (substring(., 1, 1) = ' ')]]">
    <xsl:value-of select="substring(., 2, string-length())"/>
  </xsl:template>
  
  <xsl:template match="tei:hi[tei:note]"><xsl:apply-templates></xsl:apply-templates></xsl:template>
       
  
</xsl:stylesheet>
