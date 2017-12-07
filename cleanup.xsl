<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>
    <xsl:variable name="docno">
        <xsl:value-of select="substring(substring-after(//t:TEI/@xml:id, 'T1001'), 1, 4)"/>
    </xsl:variable>
    <xsl:variable name="lookups" select="document('keyVals.xml')"/>
    <!-- This file is generated from ead.xml by selecting only the lines containing dao elements 
        and then extracting the four digit dossier number and single character checksum
        from the URI indicated by their @href. The dossier number becomes the <key> and the
        checksum the <val>. It's a hack. -->
    <xsl:key name="checksums" match="keyVal" use="key"/>
    <xsl:variable name="checksum">
        <xsl:for-each select="key('checksums', $docno, $lookups)">
            <xsl:value-of select="val"/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:template match="/">
        <!--   <xsl:message>Processing <xsl:value-of select="$docno"/>
       checksum is <xsl:value-of select="$checksum"/></xsl:message>
-->
        <xsl:apply-templates/>
    </xsl:template>
    <!-- suppress redundant blanks -->
    <xsl:template match="t:body/text()"/>
    <!-- patch together links to page images -->
    <xsl:template match="t:pb">
        <pb>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:attribute name="facs">
                <xsl:text>http://gallica.bnf.fr/ark:/12148/btv1b1001</xsl:text>
                <xsl:value-of select="$docno"/>
                <xsl:value-of select="$checksum"/>
                <xsl:text>/f</xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text>.image</xsl:text>
            </xsl:attribute>
        </pb>
    </xsl:template>
    <!-- suppress redundant change elements -->
    <xsl:template match="t:change[@when]"/>
    <xsl:template match="t:change">
        <change>Conversion docx-tei initiale <xsl:apply-templates/>
        </change>
    </xsl:template>
    <!-- suppress vacuous items in attendance lists -->
    <xsl:template match="t:item[t:persName[string-length(.) = 0 and not(@ref)]]"/>
    <!-- suppress empty lists -->
    <xsl:template match="t:list[@type='present'][not(item)]">
        <gap/>
    </xsl:template>
    <!-- suppress vacuous placenames -->
    <xsl:template match="t:placeName[string-length(.) = 0 and not(@ref)]"/>
    
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
