# CiviCRM Legacy Code

This extension offers in-line replacements for deprecated and abandoned CiviCRM Core functions

The extension is licensed under [AGPL-3.0](LICENSE.txt).

## Purpose

The purpose of *this* extension is to offer replacements for functions
that have been deprecated or even removed from the CiviCRM Core.

Of course, you *should* resolving this by replacing these function
calls with a well-designed piece of code to exactly the same thing that the old
function did for you, but in a clean and up-to-date way.
Since that might be a lot of work, we designed this extension to offer a quick,
temporary solution to your extensions' compatibility issues.

## Requirements

* PHP v7.4+
* CiviCRM 5.45+

## Find out if your extension might have a compatibility problem:

1. Check out your extension from a repository
2. Open a shell and navigate into your extension's folder
3. Run a simple scan command. This one should find all calls that are *removed* from current CiviCRM versions:
```
grep -r -E "(CRM_Utils_Token::replaceOrgTokens|CRM_Activity_Form_Task_PDFLetterCommon|PDFLetterCommon::postProcess|CRM_Core_OptionGroup::getValue|CRM_Core_OptionGroup::getLabel|CRM_Contact_BAO_Contact::contactTrashRestore|CRM_Contact_BAO_Contact::getPhoneDetails|CRM_Core_DAO::checkFieldExists|CRM_Contact_BAO_Contact::getPhoneDetails|CRM_Core_DAO::createTempTableName|civicrm_api3_field_names|ation::deleteLocationBlocks|ipn_process_transaction|CRM_Core_Form_Date::buildDateRange|CRM_Core_Form_Date::returnDateRangeSelector|CRM_Core_Form_Date::addDateRangeToForm|CRM_Core_DAO::executeSql)" *
```
You can also run this one, to find *all* problematic calls, i.e. deprecated *and* removed:
```
grep -r -E "(CRM_Utils_Token::replaceOrgTokens|CRM_Activity_Form_Task_PDFLetterCommon|PDFLetterCommon::postProcess|CRM_Core_OptionGroup::getValue|CRM_Core_OptionGroup::getLabel|CRM_Contact_BAO_Contact::contactTrashRestore|CRM_Contact_BAO_Contact::getPhoneDetails|CRM_Core_DAO::checkFieldExists|CRM_Contact_BAO_Contact::getPhoneDetails|CRM_Core_DAO::createTempTableName|civicrm_api3_field_names|ation::deleteLocationBlocks|ipn_process_transaction|CRM_Core_Form_Date::buildDateRange|CRM_Core_Form_Date::returnDateRangeSelector|CRM_Core_Form_Date::addDateRangeToForm|CRM_Core_Error::debug_log_message|CRM_Core_DAO::executeSql)" *
```

## How to fix your extension

### Alternative 1: Use this extension **as a dependency**
1. Investigate each match and replace all calls in your extension according to the table below.
2. Add the ``lagacycode`` extension as part of it's dependencies, i.e. add the following to your extensions' ``info.xml``:
    ```
    <requires>
      <ext>legacycode</ext>
    </requires>
    ```
3. Review your changes and create a commit
4. If you made any changes to your extension, make sure the ``lagacycode`` extension
```
<requires>
  <ext>legacycode</ext>
</requires>
```
5. Create a new release for your extension.
6. **Advantage**: minimally invasive
7. **Disadvantage**: extension dependency

### Alternative 2: Copy the replacment code into your extension
1. Investigate each match in the table below and find out which class provides the discontinued function, e.g. ``CRM_Legacycode_OptionGroup::getValue``
2. Copy that class into your extension, e.g. into ``CRM/EXTENSION/Legacycode/OptionGroup.php``, where 'EXTENSION' should be your extension's namespace.
3. Adjust the class name accordingly, e.g. ``CRM_Mything_Legacycode_OptionGroup``
4. Replace all calls in your extension, e.g. ``CRM_Mything_Legacycode_OptionGroup::getValue``
5. Create a new release for your extension.
6. **Advantage**: no extension dependency
7. **Disadvantage**: more work

You can find an example [here](https://github.com/Project60/org.project60.membership/pull/67/commits/9c7c07b80f50872907f45f1c2632c7bdd334e31c)


## Function Replacements

| Function                                         |                 Replacement                  | Deprecated Since | Dropped Since |
|--------------------------------------------------|:--------------------------------------------:|-----------------:|---------------|
| ``CRM_Core_DAO::executeSql``                     |                     todo                     |                ? | [no idea, but old](https://github.com/civicrm/civicrm-core/commits/master/CRM/Core/DAO.php)          |
| ``PDFLetterCommon::postProcess``                 |                     todo                     |                ? | 5.57          |
| ``CRM_Activity_Form_Task_PDFLetterCommon``       |                     todo                     |                ? | 5.57          |
| ``CRM_Utils_Token::replaceOrgTokens``            |                     todo                     |                ? | 5.57          |
| ``CRM_Core_OptionGroup::getValue``               |     CRM_Legacycode_OptionGroup::getValue     |                ? | 5.60          |
| ``CRM_Core_OptionGroup::getLabel``               |     CRM_Legacycode_OptionGroup::getLabel     |                ? | 5.60          |
| ``CRM_Contact_BAO_Contact::contactTrashRestore`` |                     todo                     |                ? | 5.60          |
| ``CRM_Core_DAO::checkFieldExists``               |                     todo                     |                ? | 5.60          |
| ``CRM_Contact_BAO_Contact::getPhoneDetails``     |                     todo                     |                ? | 5.60          |
| ``CRM_Core_DAO::createTempTableName``            | CRM_Legacycode_Core_DAO::createTempTableName |                ? | 5.60          |
| ``civicrm_api3_field_names``                     |                     todo                     |                ? | 5.60          |
| ``CRM_Core_BAO_Location::deleteLocationBlocks``  |                     todo                     |                ? | 5.60          |
| ``ipn_process_transaction``                      |                     todo                     |                ? | 5.60          |
| ``CRM_Core_Form_Date::buildDateRange``           |     CRM_Legacycode_Date::buildDateRange      |                ? | 5.61          |
| ``CRM_Core_Form_Date::returnDateRangeSelector``  | CRM_Legacycode_Date::returnDateRangeSelector |                ? | 5.61          |
| ``CRM_Core_Form_Date::addDateRangeToForm``       |   CRM_Legacycode_Date::addDateRangeToForm    |                ? | 5.61          |
| ``CRM_Core_Error::debug_log_message``            |              Civi::log()->debug              |                ? | not yet       |
| (more to come)                                   |                     todo                     |                  |               |
