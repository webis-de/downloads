<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:template match="personen">
    <html><head>
    <title>
      <xsl:text>Personen</xsl:text>
    </title>
  </head>
  <body>
    <h2>Personen</h2>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Vorname</th>
        <th>Nachname</th>
      </tr>
      <xsl:for-each select="/personen/person/name">
<!--      <xsl:for-each select="//name"> -->
        <xsl:sort select="nachname"/>
        <tr>
          <td><xsl:value-of select="vorname"/></td>
          <td><xsl:value-of select="nachname"/></td>
        </tr>
      </xsl:for-each>

<!--      <xsl:for-each select="/personen/person"> -->
<!--        <tr> -->
<!--          <td><xsl:value-of select="name/vorname"/></td> -->
<!--          <td><xsl:value-of select="name/nachname"/></td> -->
<!--        </tr> -->
<!--      </xsl:for-each> -->

      </table>
    </body>
  </html>
  </xsl:template>


</xsl:transform>