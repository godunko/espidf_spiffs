--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

private with System.Storage_Elements;

with ESPIDF.C_Strings;

package ESPIDF.SPIFFS is

   type esp_vfs_spiffs_conf_t is limited private;
   --  Configuration structure for `esp_vfs_spiffs_register`.

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      partition_label        : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t;
   --  Create configuration structure for `esp_vfs_spiffs_register`.
   --  @param base_path File path prefix associated with the filesystem.
   --  @param partition_label
   --    Optional, label of SPIFFS partition to use. If set to null, first
   --    partition with subtype=spiffs will be used.
   --  @param max_files Maximum files that could be open at the same time.
   --  @param format_if_mount_failed
   --    If true, it will format the file system if it fails to mount.

   function Create
     (base_path              : ESPIDF.C_Strings.const_char_ptr;
      max_files              : size_t;
      format_if_mount_failed : Boolean) return esp_vfs_spiffs_conf_t;
   --  Create configuration structure for `esp_vfs_spiffs_register`. First
   --  partition with subtype=spiffs will be used.
   --  @param base_path File path prefix associated with the filesystem.
   --  @param max_files Maximum files that could be open at the same time.
   --  @param format_if_mount_failed
   --    If true, it will format the file system if it fails to mount.

   function esp_vfs_spiffs_register
     (conf : esp_vfs_spiffs_conf_t) return esp_err_t
     with Import, Convention => C, External_Name => "esp_vfs_spiffs_register";
   --  Register and mount SPIFFS to VFS with given path prefix.
   --  @param conf Configuration structure
   --  @return
   --    - `ESP_OK` if SPIFFS was registered successfully
   --    - `ESP_ERR_NO_MEM` if objects could not be allocated
   --    - `ESP_ERR_INVALID_STATE` if already mounted or partition is
   --      encrypted
   --    - `ESP_ERR_NOT_FOUND` if partition for SPIFFS was not found
   --    - `ESP_FAIL` if mount or format fails

   procedure esp_vfs_spiffs_register (conf : esp_vfs_spiffs_conf_t);
   --  Register and mount SPIFFS to VFS with given path prefix.
   --  @param conf Configuration structure
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_NO_MEM` if objects could not be allocated
   --    - `ESP_ERR_INVALID_STATE` if already mounted or partition is
   --      encrypted
   --    - `ESP_ERR_NOT_FOUND` if partition for SPIFFS was not found
   --    - `ESP_FAIL` if mount or format fails

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
