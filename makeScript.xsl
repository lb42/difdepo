<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    <xsl:output indent="no"   method="text" encoding="UTF-8"/>

    <!-- This script...
        * makes a shell script to run a conversion on some subset of files
      LB 2017-12-28 -->     

    
    
    <xsl:variable name="script">putLists.xsl</xsl:variable>
   <xsl:variable name="fromDir">Current</xsl:variable>
    <xsl:variable name="toDir">Updates</xsl:variable>
    
   <xsl:template match="/">
       <xsl:apply-templates select="//t:gap"/>
   </xsl:template>
    
<xsl:template match="t:meeting/t:gap">
    <xsl:variable name="source">
        <xsl:value-of select="ancestor::t:TEI/@xml:id"/>
    </xsl:variable>
     
   <xsl:text> saxon </xsl:text>
    <xsl:value-of select="concat($fromDir, '/', $source,'.xml',' ')"/>
    <xsl:value-of select="$script"/>
    <xsl:value-of select="concat(' >',$toDir, '/', $source,'.xml')"/>
    <xsl:text>
</xsl:text>
</xsl:template>   

    <!-- and copy everything else -->
   <!-- <xsl:template match="@* | comment() | processing-instruction() | text()">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
        </xsl:copy>
    </xsl:template>-->
</xsl:stylesheet>
