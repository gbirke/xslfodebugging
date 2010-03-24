<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  This stylesheet is for postprocessing XSL-FO documents with debuggging attributes.
  
  Copyright (C) 2010 by Gabriel Birke <birke@d-scribe.de>
  License: You can do whatever you want with it a long as you don't sue me.
  Version 1.0
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xmlns:dbg="http://www.lebenplusplus.de/xsldebugging/v1"
      exclude-result-prefixes="xs dbg"
      version="2.0">

  <!-- Include the stlyesheet with the definitions of the elements to debug -->
  <xsl:include href="debugattributes.xsl"/>

  <!-- 
    This rule matches all elements that have a debug class.
    The elements will be copied with all their attributes and 
    child nodes and visual debugging properties (border, background, etc.) 
    will be inserted. 
  -->
  <xsl:template match="*[@dbg:class]">
    <xsl:copy>
      <xsl:variable name="elemname" select="name()"/>
      <xsl:variable name="dbgclass" select="@dbg:class"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="$debugattributes/*[name() = $elemname and @dbg:class = $dbgclass]/@*" mode="insertDebugAttributes"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Remove the debug attribute from the elements -->
  <xsl:template match="@dbg:*"/>
  <xsl:template match="@dbg:*" mode="insertDebugAttributes"/>
  
  <!-- Insert the attributes that will change the element -->
  <xsl:template match="@*" mode="insertDebugAttributes">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- Copy all elements without dbg:class attribute 1:1 -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Copy all other node types 1:1 -->
  <xsl:template match="@*|text()|comment()|processing-instruction()">
    <xsl:copy-of select="."/>
  </xsl:template>
  
</xsl:stylesheet>
