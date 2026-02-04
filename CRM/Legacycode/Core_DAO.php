<?php declare(strict_types = 1);
/*-------------------------------------------------------+
| SYSTOPIA - LEGACY CODE INLINE-REPLACEMENTS             |
+--------------------------------------------------------+
| This program is released as free software under the    |
| Affero GPL license. You can redistribute it and/or     |
| modify it under the terms of this license which you    |
| can read by viewing the included agpl.txt or online    |
| at www.gnu.org/licenses/agpl.html. Removal of this     |
| copyright header is strictly prohibited without        |
| written permission from the original author(s).        |
+--------------------------------------------------------*/

/**
 * This class offers in-line code replacements for deprecated/dropped functions
 *  of the CRM_Core_DAO class
 */
class CRM_Legacycode_Core_DAO {

  /**
   *
   * @return string
   * @deprecated
   * @see CRM_Utils_SQL_TempTable
   */
  public static function createTempTableName(
    string $prefix = 'civicrm',
    bool $addRandomString = TRUE,
    string $string = NULL
  ) {
    CRM_Core_Error::deprecatedFunctionWarning('Use CRM_Utils_SQL_TempTable interface to create temporary tables');
    $tableName = $prefix . '_temp';

    if ($addRandomString) {
      if ($string !== NULL) {
        $tableName .= '_' . $string;
      }
      else {
        $tableName .= '_' . md5(uniqid('', TRUE));
      }
    }
    return $tableName;
  }

}
