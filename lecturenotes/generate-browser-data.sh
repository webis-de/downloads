#!/bin/bash

################################################################################
## SETTINGS
################################################################################
OPTIMIZE_PNGS=false

################################################################################
## HELPERS
################################################################################
check_installed() {
  for program in $@
  do
    command -v $program > /dev/null 2>&1 \
      || { echo >&2 "Missing program $program. Please install it."; exit 1; }
  done
}

help() {
  local message=$1

  if [ "$message" != "" ]
  then
    echo "$message"
    echo ""
  fi

  echo "Usage: $0 <unit.pdf> <output-directory>"

  if [ "$message" != "" ]
  then
    exit 1
  else
    exit 0
  fi
}

create_pngs() {
  echo -n "  create pngs         "
  mogrify -format png -scene 1 -density 72 -quality 90 -resize '600x>' *.pdf
  if [ $? -ne 0 ];then
    echo "Your image magick is not allowed to read PDFs"
    echo "Please change the policy in /etc/ImageMagick-6/policy.xml for PDF to at least 'read'"
    exit 2
  fi
  local num_pages=$(ls *.png | wc -l)
  for page in *.png;do
    echo -n "."
  done

  if [ $num_pages -eq 1 ];then
    local image=$(ls *.png)
    mv $image ${image%.png}-1.png
  fi

  echo " ($num_pages)"
}

optimize_pngs() {
  echo -n "  optimize pngs       "
  if [ "$OPTIMIZE_PNGS" == "true" ];then
    for page in *.png;do
      echo -n "."
      pdftotext $page ${page%.pdf}-full.txt
      optipng $page 1> /dev/null
    done
  else 
    echo -n "skipped as per setting"
  fi
  echo ""
}

extract_texts() {
  echo -n "  extract texts       " 

  # create one pdf per page so that we can save the text in separate files
  pdftk *.pdf burst output page-%01d.pdf

  # extract the text from each page
  for page in page-*.pdf;do
    echo -n "."
    pdftotext $page ${page%.pdf}-full.txt
  done
  echo ""
}

second_line_is_list_start() {
  local text_full=$1

  awk 'NR == 2' $text_full | grep -E '^q( .*)?$' | wc -l
}

create_description() {
  local text_full=$1

  if [ $(second_line_is_list_start $text_full) -eq 1 ]
  then
    head -n 1 $text_full
  else
    head -n 2 $text_full | remove_newlines
  fi
}

create_descriptions() {
  echo -n "  create descriptions "

  for page in page-*-full.txt;do
    echo -n "."
    create_description $page > ${page%-full.txt}-descriptions.txt
  done
  echo ""
}

git_sha() {
  local file=$1
  git hash-object $file
}

create_shas() {
  echo -n "  calculate SHA sums  "

  for page in *.png;do
    echo -n "."
    git_sha $page > ${page%.png}-sha.txt
  done

  echo -n "pdf"
  git_sha unit-*.pdf > sha.txt

  echo ""
}

remove_newlines() {
  cat /dev/stdin | awk '{if (NR > 1) {printf " "} printf "%s", $0} END {print ""}'
}

compile_json() {
  local unit=$(ls unit-*.pdf)
  local num_pages=$(ls *.png | wc -l)

  echo '{'
  echo '  "sha":"'$(cat sha.txt)'",'
  echo '  "numpages":'$num_pages','
  echo '  "pages":['
  for page in $(seq 1 $num_pages);do
    local sha=$(cat *-$page-sha.txt)
    local description=$(cat *-$page-descriptions.txt)
    echo -n '    {"page":'$page', "sha":"'$sha'", "description":"'$description'"}'
    if [ $page -lt $num_pages ];then
      echo -n ","
    fi
    echo ""
  done
  echo '  ]'
  echo '}'
}

clean() {
  echo "  cleanup"
  rm *.pdf
  rm *.txt
}

################################################################################
## MAIN
################################################################################
check_installed git head mogrify optipng pdftk pdftotext

if [ $# -ne 2 ]
then
  help "Missing parameters"
fi

unit=$1
output_directory=$2

echo "Generating browser data for $(basename ${unit}) in $output_directory"
if [ -e $output_directory ];then
  echo "Output directory must not yet exist!"
  exit 1
fi

mkdir -p $output_directory
cp $unit $output_directory
pushd $output_directory > /dev/zero
create_pngs
optimize_pngs
extract_texts
create_descriptions
create_shas
echo "  create unit.json"
compile_json > unit.json
clean
popd > /dev/zero

