import { LightningElement, wire } from 'lwc';
import createContact from '@salesforce/apex/ContactController.createContact';
import getAccounts from '@salesforce/apex/ContactController.getAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactForm extends LightningElement {
    isFormVisible = true;
    firstName = '';
    lastName = '';
    accountId = ''; 
    accountOptions = [];

    @wire(getAccounts) 
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    showModalBox() {
        this.isFormVisible = true;
    }

    hideModalBox() {
        this.isFormVisible = false;
    }

    handleSubmit(event) {
        event.preventDefault();

        // Check if accountId is an empty string and set to null if so
        const accountIdToSend = this.accountId === '' ? null : this.accountId;

        createContact({
            firstName: this.firstName,
            lastName: this.lastName,
            accountId: accountIdToSend
        })
        .then(contactId => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact created successfully with ID ' + contactId,
                    variant: 'success'
                })
            );
            this.handleCancel(); 
            this.hideModalBox(); 
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating contact',
                    message: error.body ? error.body.message : 'Unknown error',
                    variant: 'error'
                })
            );
        });
    }

    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'accountId') {
            this.accountId = event.target.value;
        }
    }

    handleCancel() {
        this.firstName = '';
        this.lastName = '';
        this.accountId = '';
    }
}
