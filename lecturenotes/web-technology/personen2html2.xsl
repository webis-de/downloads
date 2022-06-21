<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--  <xsl:output method="html" encoding="iso-8859-1" indent="yes"/> -->
<!--  <xsl:strip-space elements="*"/> -->


  <xsl:template match="personen">
    <p/>
    <xsl:text>Person found: </xsl:text>
    <div style="font-weight:bold">
      <xsl:copy-of select="self::*"/>
    </div>
  </xsl:template>


</xsl:transform>

