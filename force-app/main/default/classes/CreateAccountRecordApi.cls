public class CreateAccountRecordApi  {
    @AuraEnabled
    public static Void getDetailAndupdateData() {
        if(FeatureManagement.checkPermission('Integration Admin')){
            Http httpObj = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint('https://cqparts-3d06.restdb.io/rest/cqpart');
            request.setHeader('Content-type', 'application/json');
            request.setHeader('x-api-key', 'b96d75ce0f9f342d10af6710ef8ea7ed0ad06');
            HttpResponse jsonBody = httpObj.send(request);
            List<Object> accountList = (List<Object>)JSON.deserializeUntyped(jsonBody.getBody());
            
            CreateAccountRecordApi.insertAccountRecord(accountList);
        }
        else {
            throw new ApiAccessException('You do not have permission !!');
        }
    }

    private static void insertAccountRecord(List<Object> accountList) {
        List<Umang78__SQX_Part__c> newCQPart = new List<Umang78__SQX_Part__c>();
        Map<String, Id> highLowVolumeAccountRecords = new Map<String, Id>();
        for(Account acc : [SELECT Id,name 
                            FROM Account 
                            WHERE name in ('High Volume', 'Low Volume')]){
                                highLowVolumeAccountRecords.put(acc.Name,acc.Id);                        

        }

        for(Object accountObj : accountList) {
            Map<String, Object> singleAccountResult = (Map<String, Object>)JSON.deserializeUntyped(accountObj);
            String partName = (String) result.get('Part Name');
            integer totalQuantityShipped = (Integer) result.get('Total Quantity Shipped');
            Id cqId = (Id) result.get('_id');
            if(partName != null && cqId != null) {
                String relatedAccountName;
                if(totalQuantityShipped<99) {
                    relatedAccountName = 'High Volume';
                } else {
                    relatedAccountName = 'Low Volume';
                }
            Umang78__SQX_Part__c cqPart = new Umang78__SQX_Part__c(name=partName, Umang78__Part_Number__c=accountId, Umang78__Active__c=true, 
            Umang78__Related_Account__c = ghighLowVolumeAccountRecords.get(relatedAccountName));
            newCQPart.add(cqPart);
        }
    }

        Database.update(newAccount,false);

    }   
}