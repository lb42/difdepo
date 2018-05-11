<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs t" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="no"/>
  <xsl:template name="normalize">
    <!--  
      clean up named entities forms
    -->
    <!--  
      mode
        default : just remove white space
          => create a readable label
        "transform" : 
          lower-case
          remove everything that is not [a-z0-9]
          => generate an id
          => compare forms
    -->
    <xsl:param name="mode"/>
    <!--  get all child node text, no white space (excluding abbr, orig and sic if children of choice -->
    <xsl:variable name="form">
      <xsl:value-of select="normalize-space(string-join(.//text()[not(ancestor::t:abbr[parent::t:choice] or ancestor::t:orig[parent::t:choice] or ancestor::t:sic[parent::t:choice])]))"/>
    </xsl:variable>   
    <xsl:variable name="form">
      <xsl:choose>
        <xsl:when test="$mode = 'transform'">
          <xsl:value-of select="replace(translate(lower-case($form), 'àáâãäåæçčèéêë∈ìíîïòóôõöœûüù∏π', 'aaaaaaacceeeeeiiiioooooouuupp'),'[^a-z0-9]','')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$form"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--  if id is one character long, add _ (avoid confusion if we have an alphabetical index with an different url for each letter -->
    <xsl:variable name="form">
      <xsl:choose>
        <xsl:when test="string-length($form) = 1 and $mode = 'transform'">
          <xsl:value-of select="concat($form, '_')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$form"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--  if id starts with a number, add "n" (xml:id rule) -->
    <xsl:variable name="form">
      <xsl:choose>
        <xsl:when test="matches($form, '^[0-9]') and $mode = 'transform'">
          <xsl:value-of select="concat('n', $form)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$form"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$form"/>
  </xsl:template>
</xsl:stylesheet>
