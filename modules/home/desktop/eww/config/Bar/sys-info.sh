#!/usr/bin/env bash
case "$1" in
    gpu-load)
        cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo 0
        ;;
    vram-usage)
        # Calculates percentage of VRAM used
        vram_mem_used=$(cat /sys/class/drm/card0/device/mem_info_vram_used 2>/dev/null || echo 0)
        vram_mem_total=$(cat /sys/class/drm/card0/device/mem_info_vram_total 2>/dev/null || echo 1)
        echo "scale=0; ($vram_mem_used * 100) / $vram_mem_total" | bc 2>/dev/null || echo 0
        ;;
esac
