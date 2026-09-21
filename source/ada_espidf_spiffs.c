/*
 *  Copyright (C) 2026, Vadim Godunko
 *
 *  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#include "esp_spiffs.h"

int __ada_sizeof_esp_vfs_spiffs_conf_t = sizeof(esp_vfs_spiffs_conf_t);

void __ada_esp_vfs_spiffs_conf_t_create(void* storage, const char* base_path, const char* partition_label, size_t max_files, bool format_if_mount_failed)
{
    esp_vfs_spiffs_conf_t* result = (esp_vfs_spiffs_conf_t*)storage;
    *result = (esp_vfs_spiffs_conf_t){
        .base_path              = base_path,
        .partition_label        = partition_label,
        .max_files              = max_files,
        .format_if_mount_failed = format_if_mount_failed
    };
}