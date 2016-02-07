<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:param name="filename"/>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="//tei:bibl/tei:title">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
       Réunion du <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0"> <xsl:attribute name="when">
        <!--récupérer la date du cr qui est dans le même mois
              --> <xsl:value-of select="document(concat('../tei/', substring($filename, 1, string-length($filename) - 6), 'CR.xml'))//tei:bibl//tei:date/@when"/>
        <!--cv toujours antérieur au cr
              récupérer la date du cr qui suit la cv--> </xsl:attribute> </xsl:element>
    </xsl:copy>
  </xsl:template>
  <!--  -->
</xsl:stylesheet>
