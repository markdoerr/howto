
A First Level Header
====================

A Second Level Header
---------------------

Now is the time for all good men to come to
the aid of their country. This is just a
regular paragraph.

The quick brown fox jumped over the lazy
dog's back.

### Header 3

> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote

Some of these words *are emphasized*.
Some of these words _are emphasized also_.

Use two asterisks for **strong emphasis**.
Or, if you prefer, __use two underscores instead__.

Auto chapters
--------------

# My top-level topic

## My first subtopic

## Another subtopic

### A sub-subtopic

## Another top-level topic

# My last numbered topic

to compile this use pandoc ( sudo apt-get install pandoc )

pandoc -t html5 -N < markdown_syntax.md -o markdown_syntax.html

pandoc --number-sections < markdown_syntax.md > markdown_syntax.html

LISTS
------

### Unordered (bulleted) lists use asterisks, pluses, and hyphens (*, +, and -) as list markers. These three markers are interchangable; this:

*   Candy.
*   Gum.
*   Booze.
this:

+   Candy.
+   Gum.
+   Booze.
and this:

-   Candy.
-   Gum.
-   Booze.
all produce the same output:

### Ordered (numbered) lists use regular numbers, followed by periods, as list markers:

1.  Red
2.  Green
3.  Blue

### Auto lists

1. Yellow
1. White
1. Black


If you put blank lines between items, you’ll get <p> tags for the list item text. You can create multi-paragraph list items by indenting the paragraphs by 4 spaces or 1 tab:

*   A list item.

    With multiple paragraphs.

*   Another item in the list.

## LINKS

Markdown supports two styles for creating links: inline and reference. With both styles, you use square brackets to delimit the text you want to turn into a link.

Inline-style links use parentheses immediately after the link text. For example:

This is an [example link](http://example.com/).

Optionally, you may include a title attribute in the parentheses:

This is an [example link](http://example.com/ "With a Title").

Reference-style links allow you to refer to your links by names, which you define elsewhere in your document:

I get 10 times more traffic from [Google][1] than from
[Yahoo][2] or [MSN][3].

[1]: http://google.com/        "Google"
[2]: http://search.yahoo.com/  "Yahoo Search"
[3]: http://search.msn.com/    "MSN Search"

The title attribute is optional. Link names may contain letters, numbers and spaces, but are not case sensitive:

I start my morning with a cup of coffee and
[The New York Times][NY Times].

[ny times]: http://www.nytimes.com/

## IMAGES

Image syntax is very much like link syntax.

Inline (titles are optional):

![alt text](/path/to/img.jpg "Title")
Reference-style:

![alt text][id]

[id]: /path/to/img.jpg "Title"

## CODE

In a regular paragraph, you can create code span by wrapping text in backtick quotes. Any ampersands (&) and angle brackets (< or >) will automatically be translated into HTML entities. This makes it easy to use Markdown to write about HTML example code:

I strongly recommend against using any `<blink>` tags.

I wish SmartyPants used named entities like `&mdash;`
instead of decimal-encoded entites like `&#8212;`.

To specify an entire block of pre-formatted code, indent every line of the block by 4 spaces or 1 tab. Just like with code spans, &, <, and > characters will be escaped automatically.

Markdown:

If you want your page to validate under XHTML 1.0 Strict,
you've got to put paragraph tags in your blockquotes:

    <blockquote>
        <p>For example.</p>
    </blockquote>
    

Tables
------
not yet working with standard markdown (but with GitHub markdown)

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column


    


