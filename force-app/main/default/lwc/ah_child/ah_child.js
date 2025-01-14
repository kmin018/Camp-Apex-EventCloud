import { LightningElement, api } from 'lwc';

export default class Ah_child extends LightningElement {
    @api message;   //API Variable
    @api recordId; 

    @api
    handleClick(parentMessage, age, name){
        alert('I have been clicked!');
        this.message = parentMessage;
        console.log(age, name);
    }

    handleClickChild(event){
        event.preventDefault();
        // Step 1 - Prepare the event using CustomEvent Interface
        let selectEvent = new CustomEvent('select',{
            detail:{
                message: 'I am from Child Component sent via custom event!',
                age: 30,
                address: "New Delhi",
                recordId: '900',
                recordName: '',
                email: 'asingh@gmail.com'
            }
        });
        // Step 2 - Dispatch the Event using dispatchEvent() method
        this.dispatchEvent(selectEvent);
        // Step 3 - Handle the event in parent component
    }
}