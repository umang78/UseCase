import { LightningElement } from 'lwc';
import factPermission from '@salesforce/customPermission/Fact';
import getDetailAndupdateData from'@salesforce/apex/CreateAccountRecordApi.getDetailAndupdateData';

export default class CQSyncProcess extends LightningElement {
    handleGetCQSyncProcess(){
        if(factPermission == 'Integration Admin'){
            getDetailAndupdateData().then((data)=>{
                const event = new ShowToastEvent({
                    title: 'Success',
                    message: 'Success',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
            }).catch((e)=>{
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: e.body.message,
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
            })
        } else{
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'You do not have permission',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
        }
       
    }

    get perm(){
        return (factPermission == 'Integration Admin');
    }
}