restructured text howto
=======================

s. http://docutils.sourceforge.net/docs/user/rst/quickref.html

Title 
===== 
Subtitle 
-------- 
Titles are underlined (or over- 
and underlined) with a printing 
nonalphanumeric 7-bit ASCII 
character. Recommended choices 
are "``= - ` : ' " ~ ^ _ * + # < >``". 
The underline/overline must be at 
least as long as the title text. 

A lone top-level (sub)section 
is lifted up to be the document's 
(sub)title.

Bullet lists:
- This is item 1 
  - This is item 2

  - Bullets are "-", "*" or "+". 
      Continuing text must be aligned 
        after the bullet and whitespace.

      Note that a blank line is required 
      before the first item and after the 
      last, but is optional between items.

  Enumerated lists:
3. This is the first item 
 4. This is the second item 
   5. Enumerators are arabic numbers, 
          single letters, or roman numerals 
        6. List items should be sequentially 
                    numbered, but need not start at 1 
                     (although not all formatters will 
                      honour the first index). 
                    #. This item is auto-enumerated

:Authors: 
    Tony J. (Tibs) Ibbs, 
        David Goodger
            (and sundry other good-natured folks)

            :Version: 1.0 of 2001/08/08 
            :Dedication: To my father.


Grid table:

+------------+------------+-----------+ 
| Header 1   | Header 2   | Header 3  | 
+============+============+===========+ 
| body row 1 | column 2   | column 3  | 
+------------+------------+-----------+ 
| body row 2 | Cells may span columns.| 
+------------+------------+-----------+ 
| body row 3 | Cells may  | - Cells   | 
+------------+ span rows. | - contain | 
| body row 4 |            | - blocks. | 
+------------+------------+-----------+

External hyperlinks, like Python_.
.. _Python: http://www.python.org/


   
