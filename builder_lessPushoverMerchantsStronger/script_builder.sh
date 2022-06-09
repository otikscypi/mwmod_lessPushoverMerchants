#!/bin/bash

TEMPLATE_DIR=./src/script_templates
README_TEMPLATE=../script_readme_template
HEADER_TEMPLATE=$TEMPLATE_DIR/script_header
BODY_TEMPLATE=$TEMPLATE_DIR/script_body
FOOTER_TEMPLATE=$TEMPLATE_DIR/script_footer

masters_arr=("Vanilla" "TamrielRebuilt")

for MASTER in "${masters_arr[@]}"
do
    SCRIPT_PREFIX=otk_

    LIST_FILE=../actor_lists/$MASTER/trader_list
    readarray -t trainerListLines < $LIST_FILE

    TEMP_FILE=./tmp/script_tmp
    OUTPUT_DIR=../output
    OUTPUT_FILE=$OUTPUT_DIR/$MASTER/lessPushoverMerchantsStronger

    SCRIPT_SUFFIX=""
    if [[ "$MASTER" == TamrielRebuilt ]]; then
        SCRIPT_SUFFIX="_TR"
    fi

    echo "Running Merchants (stronger) script builder"

    if [[ ! -d $OUTPUT_DIR ]]; then
        mkdir $OUTPUT_DIR
    fi

    if [[ ! -d $OUTPUT_DIR/$MASTER ]]; then
        mkdir $OUTPUT_DIR/$MASTER
    fi

    touch $OUTPUT_FILE

    cat $README_TEMPLATE > $OUTPUT_FILE
    cat $HEADER_TEMPLATE >> $OUTPUT_FILE

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

    sed -i -e "s/#SCRIPT_PREFIX#/$SCRIPT_PREFIX/g" $OUTPUT_FILE
    sed -i -e "s/#SCRIPT_SUFFIX#/$SCRIPT_SUFFIX/g" $OUTPUT_FILE
done