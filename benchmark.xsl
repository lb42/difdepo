<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>
<!-- this script...
        * adds a new change message
        * removes redundant whitespace
     LB 2017-12-08 -->     

  
    <!-- suppress redundant blanks -->
    <xsl:template match="t:body/text()"/>
    <xsl:template match="t:fileDesc/text()"/>
    
    <!-- add new change message -->
    <xsl:template match="t:listChange">
        <listChange>
            <change when="2017-12-09">script "cleanup.xsl" appliqué</change>
            <xsl:apply-templates/>
        </listChange>
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
