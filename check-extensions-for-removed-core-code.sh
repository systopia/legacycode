#!/bin/bash

USAGE="
Scan CiviCRM-Extensions for depcrecated functions.
By default only the extension name with deprecated code will be listed.
Use -v for a more verbose output: filesnames and codeline.

Usage:
    check-ext-560-compatibility.sh [-h]
    check-ext-560-compatibility.sh [OPTIONS] [ENVIRONMENT]

Options:
    -h          print help message and exit
    -v          verbose output
    -l          list lookup expressions
"

while getopts vlh opt
do
    case $opt in
        v)  OPT_VERBOSE=true;;
        l)  OPT_LIST=true;;
        h)  echo "$USAGE"; exit 0;;
        \?) echo "$USAGE"; exit 1;;
        :)  echo "$USAGE"; exit 2;;
    esac
done

#-------------------------------------------------------------------------------
# List of code snippets to look for.
#-------------------------------------------------------------------------------
DEPRECATED_CODE=(
    CRM_Core_OptionGroup::getValue
    CRM_Contact_BAO_Contact::contactTrashRestore
    CRM_Contact_BAO_Contact::getPhoneDetails
    CRM_Core_DAO::checkFieldExists
    CRM_Core_DAO::createTempTableName
    CRM_Core_OptionGroup::getLabel
    _civicrm_api3_field_names
    CRM_Core_BAO_Location::deleteLocationBlocks
    _ipn_process_transaction
)

#-------------------------------------------------------------------------------
# List pattern for command argument -l.
#-------------------------------------------------------------------------------
if [ -n "$OPT_LIST" ]; then
    for snippet in ${DEPRECATED_CODE[@]}; do
        echo "$snippet"
    done
    exit
fi

#-------------------------------------------------------------------------------
# Check environment argument.
#-------------------------------------------------------------------------------
ENV="${*:$OPTIND:1}"
[ -z "$ENV" ] && { echo "$USAGE"; exit 3; }

#-------------------------------------------------------------------------------
# Build regular expression to look for deprecated function calls in lines not
# starting with '#' or '//'.
#-------------------------------------------------------------------------------
SEARCH_PATTERN="$(printf "|%s" "${DEPRECATED_CODE[@]}")"
SEARCH_PATTERN="^(?!\*)(?!//).*(${SEARCH_PATTERN:1})"

#-------------------------------------------------------------------------------
# Get path to extension folder.
#-------------------------------------------------------------------------------
eval "$(cvi info -C "$ENV" | grep CIV_EXT_PATH)" || exit
if [ ! -d "$CIV_EXT_PATH" ]; then
    echo "[$ENV] Extension folder missing: $CIV_EXT_PATH"
fi

#-------------------------------------------------------------------------------
# Grep in all php-files within the extension path for the search pattern.
#-------------------------------------------------------------------------------
if [ -n "$OPT_VERBOSE" ]; then
    find "$CIV_EXT_PATH" -name '*.php' | xargs grep -P "$SEARCH_PATTERN" | grep -Po "(?<=$CIV_EXT_PATH/).+"
else
    find "$CIV_EXT_PATH" -name '*.php' | xargs grep -P "$SEARCH_PATTERN" | grep -Po "(?<=$CIV_EXT_PATH/)[^/]+" | sort | uniq
fi