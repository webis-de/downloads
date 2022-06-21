<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--  <xsl:output method="html" encoding="iso-8859-1" indent="yes"/> -->
  <xsl:strip-space elements="*"/>

  <xsl:template match="personen">
    <html>
      <head>
        <title>
          <xsl:text>Personen</xsl:text>
        </title>
        <link rel="stylesheet" type="text/css" href="personen.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="name">
    <p/>
    <div>
      <xsl:text>Name: </xsl:text>
      <xsl:copy-of select="self::*"/>
    </div>
  </xsl:template>

  <xsl:template match="geburtstag"/>
  <xsl:template match="beruf">
    <div>
      <xsl:text>Beruf: </xsl:text>
      <xsl:copy-of select="self::*"/>
    </div>
  </xsl:template>

</xsl:transform>
