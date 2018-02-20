<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:template name="normalize">
    <xsl:value-of select="translate(translate(translate(lower-case(.), 'àáâãäåæçèéêëìíîïòóôõöœ', 'aaaaaaaceeeeiiiioooooo'), '.-–?,;:!/’«»“”+%=();*  ''\&quot;', ''), '&amp;#20;&amp;#x9;&amp;#xA;&amp;#xD;', '')"/>
  </xsl:template>
  <xsl:template match="t:persName">
    <xsl:variable name="id">
      <xsl:call-template name="normalize"/>
    </xsl:variable>
    <!--   
      
    
    lower case
    remplacer les caractères accentués
    supprimer la ponctuation
    supprimer apostrophe, guillemet
    supprimer les espaces, tabulation, new line

    -->
    <xsl:copy>
      <xsl:for-each select="document('oulipiens.xml')//t:persName">
        <xsl:variable name="thesaurus_id">
          <xsl:call-template name="normalize"/>
        </xsl:variable>
        <xsl:if test="$thesaurus_id = $id">
          <xsl:attribute name="ref">#<xsl:value-of select="./parent::t:person/@xml:id"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>
      <xsl:apply-templates></xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@*|*|processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
