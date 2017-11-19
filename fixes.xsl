<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="2.0">
    
   
    <xsl:variable name="fName"><!-- filename -->
        <xsl:value-of select="substring-before(base-uri(),'.xml')"/>
    </xsl:variable>
    <xsl:variable name="idno"><!-- identifier -->
        <xsl:value-of select="concat('T100',substring-after($fName, 'T100'))"/>
    </xsl:variable>
    
    <xsl:variable name="tType"><!-- text type -->
        <xsl:value-of select="substring($idno,string-length($idno)-1)"/>
    </xsl:variable>
    
    <xsl:variable name="mId"><!-- meeting ID -->
        <xsl:value-of select="substring($idno,1,string-length($idno)-3)"/>
    </xsl:variable>
    
    <xsl:variable name="docDate">date perdu</xsl:variable>
    <xsl:variable name="exp">nom perdu</xsl:variable>
    <xsl:variable name="dest"/>
    
    <xsl:template match="/">
       <!-- <xsl:message>Processing <xsl:value-of select="base-uri()" /></xsl:message>
        <xsl:message>Filename <xsl:value-of select="$fName"/></xsl:message>      
        <xsl:message>Identifier <xsl:value-of select="$idno"/></xsl:message>              
        <xsl:message>Type is  <xsl:value-of select="$tType"/></xsl:message>
        <xsl:message>mId is  <xsl:value-of select="$mId"/></xsl:message>      
-->        <xsl:apply-templates/>
    </xsl:template>
  
    
    <!-- remove ambiguous pb@xml:id -->
<xsl:template match="t:pb/@xml:id"/>
    
    <!-- improve title -->
<xsl:template match="t:title[starts-with(.,'DOCUMENT')]">
     <xsl:choose>
        <xsl:when test='$tType = "CR"'>
        <meeting xml:id="{$mId}">
            <date><xsl:value-of select="$docDate"/></date>
            <placeName/>
            <list type="present"><item/></list>
        </meeting>
    </xsl:when>       
    <xsl:when test='$tType = "CV"'>
        <title>Convocation à <ref target="#{$mId}">une réunion Oulipo</ref>, envoyée le <date><xsl:value-of select="$docDate"/></date> par <persName
                role="expéditeur">
                <xsl:value-of select="$exp"/>
            </persName>
            <xsl:if test="string-length($dest) gt 1"> Destinataire : <persName role="destinataire">
                <xsl:value-of select="$dest"/>
            </persName>
            </xsl:if></title>
    </xsl:when>
    <xsl:when test='$tType = "OJ"'>
        <title>Ordre de jour de <ref target="#{$mId}">la réunion Oulipo</ref> de <date><xsl:value-of select="$docDate"/></date>
        </title>
    </xsl:when>
       <xsl:otherwise>
        <title>DOCUMENT DE TYPE IMPREVU : LES METADONNEES RISQUENT D'ETRE FAUTIVES </title>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>
    
  <!-- make identifier usage consistent -->
    <xsl:template match="t:TEI/@xml:id">
        <xsl:attribute name="xml:id"> <xsl:value-of select="$idno"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="t:sourceDesc/t:bibl/t:idno">
        <idno><xsl:value-of select="$idno"/></idno>
    </xsl:template>
    <xsl:template match="t:sourceDesc/t:bibl/t:meeting/@xml:id">
        <xsl:attribute name="xml:id"><xsl:value-of select="$mId"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="t:sourceDesc/t:bibl/t:title/t:ref/@target[starts-with(.,'difdepo:')]">
        <xsl:attribute name="target">#T<xsl:value-of select="substring-after(.,'difdepo:t')"/></xsl:attribute>
    </xsl:template>
    
  <!-- remove vacuous elements -->
   <xsl:template match="//persName[@role='invité'][string-length(.) lt 1]"/>
    
    <!-- fix missing text@type -->
    
  <xsl:template match="t:text[@type='']">
      <xsl:element name="text">
          <xsl:attribute name="type">
              <xsl:value-of select="$tType"/>
          </xsl:attribute>
          <xsl:apply-templates/>
      </xsl:element> 
  </xsl:template>

    
    <!-- and copy everything else -->
<xsl:template match="@* | comment() | processing-instruction() | text()">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
