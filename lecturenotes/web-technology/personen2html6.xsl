<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
<xsl:value-of select="self::*"/>
</div>
</xsl:template>
</xsl:stylesheet>