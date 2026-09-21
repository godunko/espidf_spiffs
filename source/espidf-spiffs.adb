--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.SPIFFS is

   procedure Imported_Create
     (Storage                : System.Address;
      base_path              : ESPIDF.C_Strings.const_char_ptr;
      partition_label        : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : bool)
     with Import, Convention => C,
          External_Name => "__ada_esp_vfs_spiffs_conf_t_create";

   ------------
   -- Create --
   ------------

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      partition_label        : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t
   is
   begin
      return Result : esp_vfs_spiffs_conf_t do
         Imported_Create
           (Result'Address,
            base_path,
            partition_label,
            max_files,
            bool (format_if_mount_failed));
      end return;
   end Create;

   ------------
   -- Create --
   ------------

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t is
   begin
      return Result : esp_vfs_spiffs_conf_t do
         Imported_Create
           (Result'Address,
            base_path,
            null,
            max_files,
            bool (format_if_mount_failed));
      end return;
   end Create;

   -----------------------------
   -- esp_vfs_spiffs_register --
   -----------------------------

   procedure esp_vfs_spiffs_register (conf : esp_vfs_spiffs_conf_t) is
   begin
      Ada_ESP_Check_Error (esp_vfs_spiffs_register (conf));
   end esp_vfs_spiffs_register;

end ESPIDF.SPIFFS;
