import { LightningElement, api } from 'lwc';

export default class Ah_contactTile extends LightningElement {
    @api contact; // public variable - we can accept the value of this variable from other component

    handleClick(event){
        event.preventDefault();
        let clickEvent = new CustomEvent('contactclick',
            {
                detail: {
                    contactId: this.contact.id
                },
                bubbles: true,
                composed: false
            }
        );
        this.dispatchEvent(clickEvent);
    }
    // LWC with 4 inputs & a button --> button click --> JS Method --> Apex Method --> DML ->> success/error
}