#!/usr/bin/awk

# headlines
/Java|ruby 1|ApacheBench/ { 
  print
}

# results
/^testing/ {
  # use same decimal delimiters everywhere
  gsub(/\./, ",", $0);
  
  # remove unnecessary chars
  gsub(/^testing[ ]*/, "", $0)
  gsub(/[()]/, "", $0);
  gsub(/[ ]+/, ";", $0);
  
  print  
}

/Time taken for tests:/ {
  print "ab;;;;" $5
}
