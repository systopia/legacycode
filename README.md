# CiviCRM Legacy Code

This extension offers in-line replacements for deprecated and abandoned CiviCRM Core functions

The extension is licensed under [AGPL-3.0](LICENSE.txt).

## Purpose

The purpose of *this* extension is to offer in-line replacements for functions
that have been deprecated or even removed from the CiviCRM Core.

Of course, in an ideal world we'd be resolving this by replacing these function
calls with a well-designed piece of code to exactly the same thing that the old
function did, but in a clean and up-to-date way. Since that might be a lot of work,
we designed this extension to offer a quick, temporary solution to your
extensions' compatibility issues.

## Requirements

* PHP v7.4+
* CiviCRM 5.45+

## Find out if your extension might have a compatibility problem:

1. Check out your extension from a repository
2. Open a shell and navigate into your extension's folder
3. Run the following command:
```
grep -r -E "(CRM_Core_OptionGroup::getValue|CRM_Contact_BAO_Contact::contactTrashRestore|CRM_Contact_BAO_Contact::getPhoneDetails|CRM_Core_DAO::checkFieldExists|CRM_Core_DAO::createTempTableName|CRM_Core_OptionGroup::getLabel|_civicrm_api3_field_names|CRM_Core_BAO_Location::deleteLocationBlocks|_ipn_process_transaction|CRM_Core_Error::debug_log_message)" *
```
4. Investigate each match and replace the calls according to the table below.
5. Review your changes and create a commit
6. If you made any changes to your extension, make sure the ``lagacycode`` extension
is part of it's dependencies, i.e. add the following to your extensions' ``info.xml``:
```
<requires>
  <ext>legacycode</ext>
</requires>
```
7. Create a new release for your extension.

## Function Replacements

| Function                                         |             Replacement              | Deprecated Since | Dropped Since |
|--------------------------------------------------|:------------------------------------:|-----------------:|---------------|
| ``CRM_Core_OptionGroup::getValue``               | CRM_Legacycode_OptionGroup::getValue |                ? | 5.60          |
| ``CRM_Contact_BAO_Contact::contactTrashRestore`` |                 todo                 |                ? | 5.60          |
| ``CRM_Core_DAO::checkFieldExists``               |                 todo                 |                ? | 5.60          |
| ``CRM_Core_Error::debug_log_message``            |         Civi::log()->debug           |                ? | not yet       |
| (more to come)                                   |                 todo                 |                  |               |

