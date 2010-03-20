<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    This is just a totally nonsensical stylesheet for totally nonsensical content.
    It demonstrates the use of the xsl debugging technique
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xmlns:dbg="http://www.lebenplusplus.de/xsldebugging/v1"
      xmlns:saxon="http://saxon.sf.net/"

      exclude-result-prefixes="xs dbg saxon"
      version="2.0">

    <xsl:output saxon:next-in-chain="debugging.xsl"/>

    <xsl:template match="/">
        <fo:root >
        
          <fo:layout-master-set>
              <fo:simple-page-master master-name="pagemaster">
                  <fo:region-body margin="2.5cm" />
              </fo:simple-page-master>
          </fo:layout-master-set>
          
          <fo:page-sequence master-reference="pagemaster">
              <fo:flow flow-name="xsl-region-body">
                  <xsl:apply-templates select="html/body"/>
              </fo:flow>
          </fo:page-sequence>

        </fo:root>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="h1">
        <fo:block font-size="200%" font-weight="bold" dbg:class="h1" space-after="3em">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="h2">
        <fo:block font-size="150%" font-weight="bold" dbg:class="h2" space-after="2em" keep-with-next="always">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="p[count(preceding-sibling::p) mod 2 = 1]">
        <fo:block-container reference-orientation="180" dbg:class="p-upside-down">
            <fo:block font-size="100%" dbg:class="p-upside-down" space-after="1em" text-align="justify">
            <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>
    
    <xsl:template match="p">
        <fo:block-container dbg:class="p">
            <fo:block font-size="100%" dbg:class="p" space-after="1em" text-align="justify">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>


</xsl:stylesheet>
