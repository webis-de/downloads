<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:template match="person">
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="name">
     <xsl:value-of select="nachname"/>
     <xsl:text>, </xsl:text>
     <xsl:value-of select="vorname"/>
  </xsl:template>

  <xsl:template match="geburtstag"/>
  <xsl:template match="beruf"/>


</xsl:transform>
