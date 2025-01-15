import { MessageContext, publish } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import ComrevoCHannel from '@salesforce/messageChannel/ComrevoChannel__c';

export default class PublisherComponent extends LightningElement {

    name = '';

    @wire (MessageContext) messageContext;

    handleChange(event)
    {
        this.name = event.target.value;
    }

    handleClick(event)
    {
        //code to pass message to subscriber
        let payload={name:this.name};
        publish(this.messageContext, ComrevoCHannel, payload)
    }

}