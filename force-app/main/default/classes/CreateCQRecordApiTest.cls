@isTest
public class CreateCQRecordApiTest {

    @isTest public static void testAPICallToCreateCQObject(){
        Test.setMock(HttpCalloutMock.class, new GetRecordAPIMockOut());
        CreateAccountRecordApi.getDetailAndupdateData();

        List<Umang78__SQX_Part__c> cqList  = [SELECT ID FROM Umang78__SQX_Part__c];
        System.assertNotEquals(0, cqList.size());
    }
}