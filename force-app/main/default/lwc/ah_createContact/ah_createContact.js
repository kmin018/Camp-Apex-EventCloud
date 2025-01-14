import { LightningElement, api } from 'lwc';
import createContact from '@salesforce/apex/AH_ContactServices.createContact';
import createContacts from '@salesforce/apex/AH_ContactServices.createContacts';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class Ah_createContact extends NavigationMixin(LightningElement) {

    isSpinner;
    @api recordId;
    @api objectApiName;



    contactRecord = {
        /*
        firstName: '',
        lastName: '',
        email: '',
        phone: ''
        */
    }

    handleSearch(event){
        event.preventDefault();
        let name = event.target.name;
        let value = event.target.value;
        this.contactRecord[name] = value;
        /*
            name == firstName
            this.contactRecord['firstName'] = 'Amit'
        */
    }

    handleClick(event){
        event.preventDefault();
        this.isSpinner = true;
        //console.log(this.contactRecord);
        console.log(JSON.stringify(this.contactRecord));
        this.contactRecord.accountId = this.recordId;
        createContacts({
             input : this.contactRecord

        })
        .then((result)=>{
            console.log(JSON.stringify(result));
            this.dispatchEvent(new ShowToastEvent({
                title: "Success",
                message: "Contact Created",
                variant: "success"
            }));
            this[NavigationMixin.Navigate]({
                type: "standard__recordPage",
                attributes: {
                    actionName: "view",
                    recordId: result.Id,
                    objectApiName: "Contact"
                }
            });

        })
        .catch((error)=>{
            console.error(JSON.stringify(error));
            let errorEvent = new ShowToastEvent({
                title: "Error Occured while creating contact record!",
                message: JSON.stringify(error),
                variant: "error"
            });
            this.dispatchEvent(errorEvent);
        })
        .finally(()=>{
            this.isSpinner = false;
        })

        /*
        createContact({
            firstName: this.contactRecord.firstName,
            lastName: this.contactRecord.lastName,
            email: this.contactRecord.email,
            phone: this.contactRecord.phone

        })
        .then((result)=>{
            console.log(JSON.stringify(result));
        })
        .catch((error)=>{
            console.error(JSON.stringify(error));
        })
        .finally(()=>{
            this.isSpinner = false;
        }) */


    }
}