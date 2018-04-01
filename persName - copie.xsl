<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="no"/>
  <xsl:template name="normalize">
    <xsl:param name="mode"/>
    <!--  on prend tous les nœuds texte enfants, sans white space, en excluant abbr, orig et sic  -->
    <xsl:variable name="text">
      <xsl:value-of select="normalize-space(string-join(.//text()[not(parent::t:abbr or parent::t:orig or parent::t:sic[parent::t:choice])]))"/>
    </xsl:variable>
    <!--  si c'est un persName, couper après le premier espace (on ne garde que le nom de famille) -->
    <xsl:variable name="text">
      <xsl:choose>
        <xsl:when test="$mode = 'substring' and substring-after($text, ' ')">
          <xsl:value-of select="substring-after($text, ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$text"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--  
    on renvoie ce texte avec :
    lower case
    remplacer les caractères accentués
    supprimer la ponctuation
    supprimer apostrophe, guillemet
    supprimer les espaces, tabulation, new line 
    -->
    <xsl:value-of select="translate(translate(translate(lower-case($text), 'àáâãäåæçèéêëìíîïòóôõöœ', 'aaaaaaaceeeeiiiioooooo'), '.-–?,;:!/’«»“”+%=();*  ''\&quot;', ''), '&amp;#20;&amp;#x9;&amp;#xA;&amp;#xD;', '')"/>
  </xsl:template>
  <xsl:template match="t:persName[not(@ref)] | t:orgName[not(@ref)] | t:name[@type = 'manif'][not(@ref)] | t:term[not(@ref)] | t:text//t:title[not(@ref)]">
    <!--  pour les oulipiens : seulement persName  -->
    <!--  supprimer [not(@ref)] pour overwrite  -->
    <xsl:variable name="name">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="self::t:persName">
          <xsl:call-template name="normalize">
            <xsl:with-param name="mode">substring</xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="normalize"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:copy>
      <!--   cas général : on ajoute systématiquement l'attribut  -->
            <xsl:attribute name="ref">#<xsl:value-of select="$id"/></xsl:attribute>
      <!--   Oulipiens : si la forme est présent dans le thésaurus des oulipiens   -->
      <!--<xsl:for-each select="document('oulipiens.xml')//t:persName">
        <xsl:variable name="thesaurus_id">
          <xsl:call-template name="normalize"/>
        </xsl:variable>
        <xsl:if test="$thesaurus_id = $id">
          <xsl:attribute name="ref">#<xsl:value-of select="./parent::t:person/@xml:id"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>-->
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@* | * | processing-instruction() | comment()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text() | processing-instruction() | comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
