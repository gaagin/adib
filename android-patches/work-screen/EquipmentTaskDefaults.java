package com.adib.maintenance;

/** Defaults for newly-created equipment tasks; an explicit quick-add choice still wins. */
final class EquipmentTaskDefaults {
    private EquipmentTaskDefaults() {}

    static String source(String parentId, String explicitChoice) {
        if (parentId != null && !parentId.trim().isEmpty()) return "todo";
        if ("todo".equals(explicitChoice) || "gorulen".equals(explicitChoice)) return explicitChoice;
        return "gorulen";
    }
}
