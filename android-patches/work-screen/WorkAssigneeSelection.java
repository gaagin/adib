package com.adib.maintenance;
import java.util.*;
/** Shared selection model: filtering never drops checked employees. */
final class WorkAssigneeSelection {
 final List<String> options=new ArrayList<>();final LinkedHashSet<String> selected=new LinkedHashSet<>();
 WorkAssigneeSelection(Collection<String> choices,Collection<String> assigned){for(String name:choices)addOption(name);for(String name:assigned){addOption(name);if(name!=null&&!name.trim().isEmpty())selected.add(name.trim());}}
 void addOption(String name){if(name!=null&&!name.trim().isEmpty()&&!options.contains(name.trim()))options.add(name.trim());}
 void choose(String name,boolean checked){if(!options.contains(name))throw new IllegalArgumentException("Unknown employee");if(checked)selected.add(name);else selected.remove(name);}
 List<String> visible(String query){String q=query==null?"":query.trim().toLowerCase(Locale.ROOT);List<String> result=new ArrayList<>();for(String name:options)if(name.toLowerCase(Locale.ROOT).contains(q))result.add(name);return result;}
 List<String> values(){return new ArrayList<>(selected);}
}
