--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

private with System.Storage_Elements;

with ESPIDF.C_Strings;

package ESPIDF.SPIFFS is

   type esp_vfs_spiffs_conf_t is limited private;

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      partition_label        : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t;

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t;

   function esp_vfs_spiffs_register
     (conf : esp_vfs_spiffs_conf_t) return esp_err_t
     with Import, Convention => C, External_Name => "esp_vfs_spiffs_register";

   procedure esp_vfs_spiffs_register (conf : esp_vfs_spiffs_conf_t);

private

   sizeof_esp_vfs_spiffs_conf_t : constant int
      with Import, Convention => C,
           Link_Name => "__ada_sizeof_esp_vfs_spiffs_conf_t";

   type esp_vfs_spiffs_conf_t is
     new System.Storage_Elements.Storage_Array
       (1 .. System.Storage_Elements.Storage_Count
               (sizeof_esp_vfs_spiffs_conf_t))
       with Convention => C, Default_Component_Value => 0;

end ESPIDF.SPIFFS;
