<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- remove div -->
    <xsl:template match="t:div[@type = 'incipit']">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:div[@type = 'incipit']/t:p">
        <p rend="incipit">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="t:div">
        <xsl:apply-templates/>
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
