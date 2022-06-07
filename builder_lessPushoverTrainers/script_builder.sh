#!/bin/bash

TEMPLATE_DIR=./src/script_templates
HEADER_TEMPLATE=$TEMPLATE_DIR/script_header
BODY_TEMPLATE=$TEMPLATE_DIR/script_body
FOOTER_TEMPLATE=$TEMPLATE_DIR/script_footer

LIST_FILE=../actor_lists/trainer_list
readarray -t trainerListLines < $LIST_FILE

TEMP_FILE=./tmp/script_tmp
OUTPUT=../output/lessPushoverTrainers

echo "Running Trainers (safer) script builder"

touch $OUTPUT

cat $HEADER_TEMPLATE > $OUTPUT

for LIST_LINE in "${trainerListLines[@]}"
do
    echo $LIST_LINE
    touch $TEMP_FILE
    cp $BODY_TEMPLATE $TEMP_FILE
    sed -i -e "s/#ACTOR#/$LIST_LINE/g" $TEMP_FILE
    cat $TEMP_FILE >> $OUTPUT
    rm $TEMP_FILE
done

cat $FOOTER_TEMPLATE >> $OUTPUT