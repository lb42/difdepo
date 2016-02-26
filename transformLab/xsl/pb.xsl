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
</xsl:stylesheet>
