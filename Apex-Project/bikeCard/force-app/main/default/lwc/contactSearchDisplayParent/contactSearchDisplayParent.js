import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/Contactsparenttochild.contactptoc';

export default class contactSearchDisplayParent extends LightningElement {
    contacts;
    error;    
    selectedContacts = []; 
    searchKey = '';
   
    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data; 
            this.error = undefined;
            console.log("data---", this.contacts);
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }

    handleInputChange(event) {
        this.searchKey = event.target.value; 
    }

    handleSelectContact() {
        if (this.contacts && this.searchKey) {
            const filteredContacts = this.contacts.filter(contact => 
                contact.Name.toLowerCase().startsWith(this.searchKey.toLowerCase())
            );
            console.log("filteredContacts---", filteredContacts);
            this.selectedContacts = filteredContacts; 
            console.log("selectedContacts---", this.selectedContacts);
        }
    }
}
