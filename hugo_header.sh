#!/bin/bash

WORKING_DIR=$1
TMP_SUFF=$2

i=1

for file in $(ls $WORKING_DIR/S*)
do 
    #section[$((i++))]=${file#${WORKING_DIR:0}\/}
    section[$((i++))]=$file
done


for index in `seq 1 ${#section[*]}`
do

    SECTION_NAME=${section[$index]%.tmp}
    
    # get next section
    SECTION_NEXT=${section[$((index+1))]%.tmp}
    SECTION_NEXT=${SECTION_NEXT#${WORKING_DIR:0}\/}            # remove leading directory
    SECTION_NEXT=$(tr [A-Z] [a-z] <<< "$SECTION_NEXT")         # convert to lower case

    SECTION_PREV=${section[$((index-1))]%.tmp}
    SECTION_PREV=${SECTION_PREV#${WORKING_DIR:0}\/}
    SECTION_PREV=$(tr [A-Z] [a-z] <<< "$SECTION_PREV")

    SLUG=${SECTION_NAME#${WORKING_DIR:0}\/}
    TITLE=${SLUG//-/ }
    
    cat <<EOF >>$SECTION_NAME.hugo_head
---
Title:       "$TITLE"
Description: "Welcome to the i3 Berlin building manual"
Tags:        [ "manual", "i3-berlin" ]
date:        "$(date +%Y-%m-%d)"
Authors:     "Bram de Vries"
Slug:        "$SLUG"
Prev:        "/manual_i3_berlin/$SECTION_PREV"
Next:        "/manual_i3_berlin/$SECTION_NEXT"
---

EOF

    cat $SECTION_NAME.$TMP_SUFF >> $SECTION_NAME.hugo_head
    rm $SECTION_NAME.$TMP_SUFF
    mv $SECTION_NAME.hugo_head $SECTION_NAME.$TMP_SUFF
done
