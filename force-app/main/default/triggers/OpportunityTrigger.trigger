trigger OpportunityTrigger on Opportunity (before insert, after insert) {
    
    OpportunityTriggerHandler h = new OpportunityTriggerHandler();
    
    if (Trigger.isInsert && Trigger.isBefore) {
        h.onBeforeInsert(Trigger.new); 
    }
    else if (Trigger.isInsert && Trigger.isAfter) {
        	h.OnAfterInsert(Trigger.new);
    	
    }
}