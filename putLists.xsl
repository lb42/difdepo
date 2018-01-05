<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    <xsl:output indent="yes" encoding="UTF-8"/>
    <!-- This script...
        * replaces <gap> elements in <meeting> with correct attendance list
        *  which is generated by running getLists.xsl over Final_driver.tei
      LB 2017-12-28 -->
    <xsl:variable name="meetingId">
        <xsl:value-of select="//t:meeting[t:gap]/@xml:id"/>
    </xsl:variable>
  <xsl:template match="t:teiHeader//t:gap|t:teiHeader//t:list">
        <xsl:message>gap found in <xsl:value-of select="$meetingId"/></xsl:message>
        <xsl:choose>
            <xsl:when test="document('attendanceLists.xml')//*:list[@id = $meetingId]">
                <xsl:for-each select="document('attendanceLists.xml')//*:list[@id = $meetingId]">
                    <list type="present">
                        <xsl:apply-templates/>
                    </list>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <gap/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- suppress redundant blanks -->
    <xsl:template match="t:body/text()"/>
    <xsl:template match="t:fileDesc/text()"/>
    <!-- add new change message -->
    <xsl:template match="t:listChange">
        <listChange>
            <xsl:if test="document('attendanceLists.xml')//*:list[@id = $meetingId]">
                <change when="2018-01-02">restore accidentally deleted attendance lists</change>
            </xsl:if>
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
