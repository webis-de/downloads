<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Identity template. Copy with recursion. -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!-- Exception to the copying. -->
<xsl:template match="person[name/nachname='Pearl' and name/vorname='Judea']/geburtstag/text()">
<xsl:text>04.09.1936</xsl:text>
</xsl:template>

</xsl:stylesheet>
