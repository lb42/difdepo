<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t xi" version="2.0">
    <xsl:output exclude-result-prefixes="#all" indent="no" omit-xml-declaration="yes"/>
    
    <!-- extract attendance lists mistakenly deleted by earlier version of cleanup.xsl 
        and save them for reintroduction into the metadata by means of putLists.xsl 
        -->
    
    <xsl:template match="/">
        <lists>
        <xsl:apply-templates select="//t:meeting/t:list[@type='present']"/>
        </lists>
    </xsl:template>
    
    <xsl:template match="t:meeting/t:list[@type='present']">
        <xsl:variable name="mId">
            <xsl:value-of select="upper-case(parent::t:meeting/@xml:id)"/>       
        </xsl:variable>
        <xsl:variable name="T">
            <xsl:if test="starts-with($mId,'1')">T</xsl:if>
        </xsl:variable>
        <xsl:variable name="meetingId"><xsl:value-of select="concat($T,$mId)"/></xsl:variable>
         <list type="present" id="{$meetingId}">
            <xsl:apply-templates/>
        </list>       
    </xsl:template>
   
<xsl:template match="t:item[t:persName[string-length(.)=0 and not(@ref)]]"/>


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
