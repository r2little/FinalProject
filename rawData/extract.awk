function flush() {
  if (seq != "") { if (tag == "") tag = "cds" ++n; print ">" tag " " prod; print seq }
  tag=""; prod=""; seq=""; intrans=0
}
/^[A-Z]/       { flush(); incds=0; next }
/^     [^ ]/   { flush(); incds=($1=="CDS"); next }
incds && intrans { l=$0; gsub(/[ "]/,"",l); seq=seq l; if ($0 ~ /"/) intrans=0; next }
incds && /\/locus_tag=/ { split($0,a,"\""); tag=a[2] }
incds && /\/product=/   { split($0,a,"\""); prod=a[2] }
incds && /\/translation=/ {
  l=$0; sub(/.*\/translation="/,"",l); gsub(/"/,"",l); seq=l
  intrans = ($0 ~ /translation="[^"]*"/) ? 0 : 1
}
END { flush() }
