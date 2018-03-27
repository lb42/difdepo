<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="id">
    <xsl:value-of select="substring(t:TEI/@xml:id, 2, 8)"/>
  </xsl:variable>
  <!--<!-\-supprimer les respStmt si on a l'info dans respStmt.xml
    vérifier les fichiers
  -\->
  <xsl:template match="t:respStmt">
    <xsl:choose>
      <xsl:when test="document('respStmt.xml')//t:TEI[@xml:id = $id]"/>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  <xsl:template match="t:titleStmt">
    <xsl:copy>
      <xsl:apply-templates/>
      <xsl:copy-of select="document('respStmt.xml')//t:TEI[@xml:id=$id]/t:respStmt"></xsl:copy-of>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@* | comment() | processing-instruction() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
