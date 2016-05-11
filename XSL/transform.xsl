<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<xsl:apply-templates/>
	
  <xsl:variable name="page_count" select="count(//slide)"/>
  <xsl:result-document href="pres_about.html">
  <html>
  <body>
  Document created by xsl transformation in <xsl:value-of  select="current-dateTime()"/>.
  </body>
  </html>
  </xsl:result-document>
</xsl:template>

<xsl:template match="config"/>
<xsl:template match="meta"/>

<xsl:template match="intro">
	<xsl:result-document href="pres_slide_1.html">
	<html>
	<xsl:call-template name="header"/>
	<body>
	<xsl:call-template name="background"/>
	
	<center>
	<ul display="inline">
	<li style="display:inline;margin-right:5px;"><a href="pres_slide_2.html">next</a></li>
	</ul>
	</center>
	
	<center>
	<h1><xsl:value-of select="//content/meta/title/text()"/></h1>
	<h2>Author: <xsl:value-of select="//content/meta/author/text()"/></h2>
	<h2><xsl:value-of select="//content/meta/company/text()"/></h2>
	<h3><xsl:value-of select="//content/meta/date/text()"/></h3>
	</center>
	<hr></hr>
	
	</body>
	</html>
	</xsl:result-document>
</xsl:template>

<xsl:template match="content_table">
<ul>
	<xsl:for-each select="//section">
		<li>
		<xsl:value-of select="title/text()"/>
		<ul>
		<xsl:for-each select="slide">
			<li><xsl:value-of select="title/text()"/>..........
			<xsl:value-of select="1+../count(preceding-sibling::section/slide)+count(preceding-sibling::slide)+count(//intro)"/>
			</li>
		</xsl:for-each>
		</ul>
		</li>	
</xsl:for-each>
</ul>
</xsl:template>

<xsl:template match="section">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="section/title"/>

<xsl:template match="slide">
<xsl:variable name="page_count" select="count(//slide)+count(//intro)"/>	
<xsl:variable name="page_num" select="1+../count(preceding-sibling::section/slide)+count(preceding-sibling::slide)+count(//intro)"/>

<xsl:result-document href="pres_slide_{$page_num}.html">
<html>
<xsl:call-template name="header"/>
<body>
<xsl:call-template name="background"/>
	<center>
	<ul style="padding-left:0px;">
	<li style="display:inline;margin-right:5px;"><a href="pres_slide_1.html">start</a></li>
	<xsl:if test="$page_num > 1">
		<li style="display:inline;margin-right:5px;" ><a href="pres_slide_{$page_num - 1}.html">previous</a></li>
	</xsl:if> 
	<xsl:if test="($page_num &lt; $page_count)">
		<li style="display:inline;margin-right:5px;"><a href="pres_slide_{$page_num + 1}.html">next</a></li>
	</xsl:if>
	</ul>
	</center>

	<center>
	<h3><xsl:value-of select="ancestor::section/title/text()"/></h3>
	<h2><xsl:value-of select="title/text()"/></h2>
	</center>
	
	<xsl:apply-templates/>
	
	<center>
	<br/>
	Page: <xsl:value-of select="$page_num"/> of <xsl:value-of select="$page_count"/>
	</center>
	<hr/>	
	<xsl:for-each select=".//footnote">
		* <xsl:apply-templates/><br/>
	</xsl:for-each>
</body>
</html>	
</xsl:result-document>
</xsl:template>

<xsl:template match="body">	
	<xsl:apply-templates/>		
</xsl:template>

<xsl:template match="itemize">
	<ul>
	<xsl:for-each select="item">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="enum">
	<ol>
	<xsl:for-each select="item">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:for-each>
	</ol>
</xsl:template>

<xsl:template match="item">
	<xsl:apply-templates/>
</xsl:template>

 <xsl:template match="ln">
	<br/>
 </xsl:template>
 
 
 <xsl:template match="center">
	<center>
		<xsl:apply-templates/>
	</center>
 </xsl:template>
 
 <xsl:template match="bold">
	<b>
		<xsl:apply-templates/>
	</b>
 </xsl:template>
 
 <xsl:template match="ital">
	<i>
		<xsl:apply-templates/>
	</i>
 </xsl:template>
 
 <xsl:template match="emph">
	<em>
		<xsl:apply-templates/>
	</em>
 </xsl:template>
 
 <!--
 <xsl:template match="text()">
	<xsl:
 </xsl:template>
 -->

 <xsl:template name="header">
  <head>
	<style>
		a:hover {
			text-decoration: underline;
		}
		a:link {
			color: #00FF00;
		}
		a:visited {
			color: #00FF00;
		}
		a:active {
			color: #0000FF;
		}
		body {
			width: 50%;
		}
	</style>
  </head>
 </xsl:template>
 
 <xsl:template name="background">
 <xsl:choose>
	<xsl:when test="background">
		<xsl:attribute name="bgcolor">
		<xsl:value-of select="background/color/text()"/>
		</xsl:attribute>
	</xsl:when>
	<xsl:when test="/presentation/config/background">
		<xsl:attribute name="bgcolor">
		<xsl:value-of select="/presentation/config/background/color/text()"/>
		</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
		<xsl:attribute name="bgcolor">
		#444444
		</xsl:attribute>
	</xsl:otherwise>
	</xsl:choose>
 </xsl:template>
 
 <xsl:template match="background"/>
 
 <xsl:template match="footnote">
 *
 </xsl:template>
 
 <xsl:template match="figure">
	<br/>
	<xsl:choose>
	<xsl:when test="centered">
		<center>
			<xsl:call-template name="figure_2"/>
		</center>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="figure_2"/>
	</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>
 
 <xsl:template name="figure_2">
 <img>
		<xsl:attribute name="src">
			<xsl:value-of select="path"/>
		</xsl:attribute>
		<xsl:attribute name="width">
			<xsl:value-of select="width"/>
		</xsl:attribute>
		<xsl:attribute name="height">
			<xsl:value-of select="height"/>
		</xsl:attribute>
	</img>
	<br/>
	<xsl:if test="caption">
		<i><b>Img. <xsl:value-of select="1+count(preceding::figure)"/>: <xsl:value-of select="caption/text()"/></b></i>
		<br/>
	</xsl:if>
 </xsl:template>
 
 <xsl:template match="slide/title"/>
 
 <xsl:template match="url">
	<a>
	<xsl:attribute name="href">
		<xsl:value-of select="text()"/>
	</xsl:attribute>
	<xsl:value-of select="text()"/>
	</a>
 </xsl:template> 
</xsl:stylesheet> 