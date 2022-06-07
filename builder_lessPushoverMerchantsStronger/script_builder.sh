#!/bin/bash

TEMPLATE_DIR=./src/script_templates
HEADER_TEMPLATE=$TEMPLATE_DIR/script_header
BODY_TEMPLATE=$TEMPLATE_DIR/script_body
FOOTER_TEMPLATE=$TEMPLATE_DIR/script_footer

LIST_FILE=../actor_lists/trader_list
readarray -t trainerListLines < $LIST_FILE

TEMP_FILE=./tmp/script_tmp
OUTPUT_DIR=../output
OUTPUT_FILE=$OUTPUT_DIR/lessPushoverMerchantsStronger

echo "Running Merchants (stronger) script builder"

if [[ ! -d $OUTPUT_DIR ]]; then
    mkdir $OUTPUT_DIR
fi
touch $OUTPUT_FILE

cat $HEADER_TEMPLATE > $OUTPUT_FILE

for LIST_LINE in "${trainerListLines[@]}"
do
    echo $LIST_LINE
    touch $TEMP_FILE
    cp $BODY_TEMPLATE $TEMP_FILE
    sed -i -e "s/#ACTOR#/$LIST_LINE/g" $TEMP_FILE
    cat $TEMP_FILE >> $OUTPUT_FILE
    rm $TEMP_FILE
done

cat $FOOTER_TEMPLATE >> $OUTPUT_FILE