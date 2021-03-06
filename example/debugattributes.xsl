<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xmlns:dbg="http://www.lebenplusplus.de/xsldebugging/v1"
      exclude-result-prefixes="xs dbg"
      version="2.0">

  <xsl:variable name="debugattributes">
    <fo:block/> <!-- Leave this element in place -->
    <fo:block dbg:class="p" border="solid 1pt #33cc33" />
    <fo:block-container dbg:class="p" background-color="#aaffaa" />
    <fo:block-container dbg:class="p-upside-down" background-color="#ffaaaa" />
  </xsl:variable>

</xsl:stylesheet>
