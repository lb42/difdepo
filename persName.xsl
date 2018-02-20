<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:template match="t:persName[not(@type)]">
    <!--   
      
      
    oulipiens :
    ajouter les nouveaux
    ajouter les formes
    Prénom Nom
    Nom Prénom
    Nom
    P. Nom
    PN
    
    normaliser les espaces
    supprimer les ponctuations
    passer en minuscule sans accent
    supprimer les ponctuations du thesaurus
    passer en minuscule sans accent
    si persName/text()=therausus, ajouter un ref
    
    
    -->
    <!--   <xsl:value-of select="normalize-space()"/>-->
    <!--  Prénom Nom  -->
    <persName type="prenomnom">
      <xsl:value-of select="."/>
    </persName>
    <!--  Nom Prénom  -->
    <persName type="nomprenom">
      <xsl:value-of select="substring-after(., ' ')"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="substring-before(., ' ')"/>
    </persName>
    <!--   P. Nom -->
    <persName type="pnom"><xsl:value-of select="substring(., 1, 1)"/>. <xsl:value-of select="substring-after(., ' ')"/></persName>
    <!-- Prénom N.-->
    <persName type="prenomn">
      <xsl:value-of select="substring-before(., ' ')"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="substring(substring-after(., ' '), 1, 1)"/>.
    </persName>
    <!--   Nom -->
    <persName type="nom">
      <xsl:value-of select="substring-after(., ' ')"/>
    </persName>
    <!--    Prénom -->
    <persName type="prenom">
      <xsl:value-of select="substring-before(., ' ')"/>
    </persName>
    <!--   PN -->
    <persName type="pn">
      <xsl:value-of select="./parent::t:person/@xml:id"/>
    </persName>
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
