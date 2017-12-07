<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="2.0">
   
 <xsl:output indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />
    <!--
    <xsl:variable name="docno">
        <xsl:value-of select="substring(substring-after(//t:TEI/@xml:id,'T1001'),1,4)"/>
    </xsl:variable>
    
    <xsl:variable name="lookups" select="document('keyVals.xml')"/>
      
    <xsl:key name="checksums" match="keyVal" use="key" />
    
       <xsl:variable name="checksum">
        <xsl:for-each select="key('checksums',$docno,$lookups)">
            <xsl:value-of select="val"/>
        </xsl:for-each>
    </xsl:variable>
    
   -->
   <xsl:template match="/">
       
       
      <!-- <xsl:message>Processing <xsl:value-of select="$docno"/>
       checksum is <xsl:value-of select="$checksum"/></xsl:message>
   -->    
       <xsl:apply-templates select="//c"/>             
    </xsl:template>
    
    
    <xsl:template match="c">
        
        <xsl:variable name="fileId">
            <xsl:value-of select="substring(substring-after(dao/@href,'v1b100'),1,4)"/>
        </xsl:variable>
        <xsl:message>
            <xsl:value-of select="$fileId"/></xsl:message>
        
        <xsl:for-each select="scopecontent/list/item">  
             <xsl:choose>
                <xsl:when test="starts-with(.,'Compte')">
                    <item corresp="{$fileId}-CR">
                        <xsl:value-of select="."/>
                    </item>
                </xsl:when>
                 <xsl:when test="starts-with(.,'Convocation')">
                     <item corresp="{$fileId}-CV">
                         <xsl:value-of select="."/>
                     </item>
                 </xsl:when>
                 <xsl:when test="starts-with(.,'Ordre')">
                     <item corresp="{$fileId}-OJ">
                         <xsl:value-of select="."/>
                     </item>
                 </xsl:when>
            </xsl:choose>
        </xsl:for-each>
        
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
