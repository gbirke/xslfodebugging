# Visually debugging XSL-FO stylesheets

When developing XSL-FO stylesheets sooner or later you will see something that doesn't look as intended: It has the wrong margin, padding, line height, floats in the wrong place, etc. If you have no fancy visual debugging tool, the quickest way to check is setting a border or background attribute on the element in question. 

I had several gripes with this ad-hoc approach:

*   I have to remember to take out the debugging attributes
*   I have to search all over my stylesheet when elements reside in different templates
*   Removing attributes can be a bit error-prone: You have to select excactly the right characters with the mouse or press several keys. You run the risk of leaving whitespace behind or deleting parts of other attributes
*   Sometimes borders and backgrounds are deliberate. How do you tell debugging attributes and "real" attributes apart?

My solution: *Insert a special debugging attribute (from a separate namespace) into the elements you want to debug and **postprocess** your XSL-FO output with a stylesheet that replaces the debugging attribute with the desired debug formatting!* When your debug work is finished, you can leave the debugging attributes where they are and turn off the postprocessing.

Using a separate stylesheet will ensure that you can group the debugging requirements neatly in one stylesheet. To make this even easier, the debugging attributes are placed in a separate stylesheet, `debugattributes.xsl`. The code for postprocessing is in the `debugging.xsl` stylesheet and doesn't need to be changed. 

## How to use the xsldebug stylesheet

### Step 1: Enable debugging in the stylesheet

Suppose you want to debug the following template:

    <xsl:template match="p">
        <fo:block-container>
            <fo:block font-size="100%" space-after="1em" text-align="justify">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>
    

Just add the debugging namespace `http://lebenplusplus.de/xsldebug` to your stylesheet header:

    <xsl:stylesheet 
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
       xmlns:fo="http://www.w3.org/1999/XSL/Format"
       xmlns:h="http://www.w3.org/TR/REC-html40"
       xmlns:xs="http://www.w3.org/2001/XMLSchema"
       xmlns:dbg="http://www.lebenplusplus.de/xsldebugging/v1"
       exclude-result-prefixes="xs dbg"
       >

Now add the attribute `dbg:class` to each element you want to modify. You can freely choose the name of the debug class.   
Tip 1: Choose a debug class that fits the `match` or `name` attribute of your template.   
Tip 2: Liberally sprinkle your stylehseet with debugging attributes, you'll never know when you need them!

    <xsl:template match="p">
        <fo:block-container dbg:class="p">
            <fo:block font-size="100%" dbg:class="p" space-after="1em" text-align="justify">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>
    

### Step 2: Define styles for the debugging attributes

Open the file `debugattributes.xsl` and put `fo:` elements in the `debugattributes` variable definition.

    <xsl:variable name="debugattributes">
        <fo:block border="solid 1pt #33aa22" dbg:class="comment" />
        <fo:block-container border="solid 1pt #aa3322" dbg:class="comment" />
    </xsl:variable>
    

You don't need to define an element you don't want to debug - the debugging stylesheet will remove all debug attributes from the elements.

You can put non-empty elements inside `$debugattributes`, but the stylesheet will only copy the attributes, all other content is ignored.

### Step 3: Integrate debugging into your workflow

If you are using the [Saxon][1] XSLT processor, you can integrate debugging in two easy steps:

1.  Add the saxon namespace to your namespace declarations: 
        <xsl:stylesheet 
          xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
           xmlns:fo="http://www.w3.org/1999/XSL/Format"
           xmlns:h="http://www.w3.org/TR/REC-html40"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:dbg="http://www.lebenplusplus.de/xsldebugging/v1"
           xmlns:saxon="http://saxon.sf.net/"
           exclude-result-prefixes="xs"
           >

2.  Add a postprocessing attribute to your `<xsl:output>` tag: 
        <xsl:output method="xml" indent="no" saxon:next-in-chain="debugging.xsl"/>

If you use Ant or a Makefile for your workflow, add an additional task that processes the output of your regular XSLT transformation with the `debugattributes.xsl` stylesheet.

If you are already using a [XProc][2] tool I don't need to tell you how to integrate the postprocessing :-)

When you are done debugging, but not done developing your stylesheet, you can simply leave `$debugattributes` empty until the need for debugging arises again. 

## What next?

I have created the stylesheet to scratch a personal itch. If it's useful for you or if you want to improve it, feel free.

Some ideas of what could be useful in the future:

*   Debug id attributes
*   Insert debugging elements
*   Output debug messages with `<xsl:message>`
*   Turn the stylesheet into a general-purpose postprocessing-for-debugging tool for other dialects than XSL-FO?

 [1]: http://saxon.sourceforge.net/
 [2]: http://xproc.org/

