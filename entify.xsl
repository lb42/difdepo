<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="entities">
        <profileDesc xmlns="http://www.tei-c.org/ns/1.0">
           <particDesc> <listPerson>
                <xsl:for-each select='entity[@type="persName"]'>
                    <xsl:sort select="@xml:id"/>
                    <person xml:id="{@xml:id}" >
                        <xsl:for-each select="forms/form">
                            <persName>
                                <xsl:apply-templates/>
                            </persName>
                        </xsl:for-each>
                   </person>
                </xsl:for-each>
            </listPerson>
               <listOrg>
                   <xsl:for-each select='entity[@type="orgName"]'>
                       <xsl:sort select="@xml:id"/>
                       
                   <org xml:id="{@xml:id}" >
                       <xsl:for-each select="forms/form">
                           <orgName>
                               <xsl:apply-templates/>
                           </orgName>
                       </xsl:for-each>
                   </org>
               </xsl:for-each></listOrg>
               
           </particDesc>
            <settingDesc>
                <listPlace>
                    <xsl:for-each select='entity[@type="placeName"]'>
                        <xsl:sort select="@xml:id"/>
                        <place xml:id="{@xml:id}" >
                            <xsl:for-each select="forms/form">
                                <placeName>
                                    <xsl:apply-templates/>
                                </placeName>
                            </xsl:for-each>
                        </place>
                    </xsl:for-each>
                </listPlace>
            </settingDesc>
            <textClass>
                <keywords>
                    <xsl:for-each select='entity[@type="term"]'>
                        <xsl:sort select="@xml:id"/>
                        <term xml:id="{@xml:id}" >
                            <xsl:for-each select="forms/form">
                               
                                    <xsl:apply-templates/>
                                
                            </xsl:for-each>
                        </term>
                    </xsl:for-each>
                </keywords>
            </textClass>
            <listBibl>
                <xsl:for-each select='entity[@type="title"]'>
                    <xsl:sort select="@xml:id"/>
                    <bibl xml:id="{@xml:id}" >
                        <xsl:for-each select="forms/form">
                            
                           <title> <xsl:apply-templates/></title>
                            
                        </xsl:for-each>
                    </bibl>
                </xsl:for-each>
            </listBibl>
        </profileDesc>
        
    </xsl:template>
    
   
    
   
    
    <xsl:template match="roles"/>
    
</xsl:stylesheet>