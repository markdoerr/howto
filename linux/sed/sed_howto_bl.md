
# sed howto

## substitute

most simple replacement:

sed 's/day/night/' old >new

replace in the same file:

sed -i 's/day/night/' filename

sed -i "s/\"/ /g" *_plate_layout_*.csv

removing something and print:

sed  's/'$target_spec_dir'//p' 

multiple substitutions with one sed command

sed -i "s/MDO_growth_//; s/_OD600.*/ /" *.DAT 

remove MDO_varioskan_ and _ from MDO_varioskan_0638_

sed "s/MDO_varioskan_//; s/_\s/  /" 

-i : in-place edit

echo "This is just a test" | sed -e 's/ /_/g' -> This_is_just_a_test

## multi line replace

  see http://austinmatzko.com/2008/04/26/sed-multi-line-search-and-replace/
  
  will 
  <p>previous text</p>
  <h2>
  <a href="http://some-link.com">A title here</a>
  </h2>
   <p>following text</p>
   
  change to

  <p>previous text</p>
  No title here
  <p>following text</p>

sed -n '1h;1!H;${;g;s/<h2.*</h2>/No title here/g;p;}' sample.php > sample-edited.php;

sed -n '1h;1!H;${;g;s/string_to_replace/replacement_str/g;p;}' sample.php > sample-edited.php;

