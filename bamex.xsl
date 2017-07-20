<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="2.0">
    <xsl:template match="/">
        <xsl:apply-templates select="//dao"/>
    </xsl:template>
    <xsl:template match="dao">
        <ids>
            <idno type="ark">
                <xsl:value-of select="@href"/>
            </idno>
            <idno type="ead">
                <xsl:value-of select="parent::c[1]/@id"/>
            </idno>
            <idno type="cote">
                <xsl:value-of select="preceding::unitid[@type = 'cote'][1]"/>
            </idno>
            <idno type="scan">
                <xsl:value-of select="substring(substring-after(@href, 'btv1b'), 1, 8)"/>
            </idno>
            <xsl:variable name="date">
                <xsl:value-of select="preceding::unittitle[1]"/>
            </xsl:variable>
            <xsl:variable name="month">
                <xsl:choose>
                    <xsl:when test="starts-with($date, 'Janvier')">1</xsl:when>
                    <xsl:when test="starts-with($date, 'Fevrier')">2</xsl:when>
                    <xsl:when test="starts-with($date, 'Mars')">3</xsl:when>
                    <xsl:when test="starts-with($date, 'Avril')">4</xsl:when>
                    <xsl:when test="starts-with($date, 'Mai')">5</xsl:when>
                    <xsl:when test="starts-with($date, 'Juin')">6</xsl:when>
                    <xsl:when test="starts-with($date, 'Juillet')">7</xsl:when>
                    <xsl:when test="starts-with($date, 'Août')">8</xsl:when>
                    <xsl:when test="starts-with($date, 'Septembre')">9</xsl:when>
                    <xsl:when test="starts-with($date, 'Octobre')">10</xsl:when>
                    <xsl:when test="starts-with($date, 'Novembre')">11</xsl:when>
                    <xsl:when test="starts-with($date, 'Décembre')">12</xsl:when>
                    <xsl:otherwise>?</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <idno type="date">
                <xsl:value-of select="concat('19',substring(substring-after($date, '19'), 1, 2), '-',$month)"/>
            </idno>
           
        </ids>
    </xsl:template>
</xsl:stylesheet>
