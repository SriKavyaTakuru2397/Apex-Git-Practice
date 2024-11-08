import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/Contactsparenttochild.contactptoc';

export default class parentContact extends LightningElement {
    contacts;      
    error;        
    selectedContact; 

    
    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }

   
    handleSelect(event) {
        const contactId = event.target.dataset.id;
        this.selectedContact = this.contacts.find(contact => contact.Id === contactId);
    }
}
