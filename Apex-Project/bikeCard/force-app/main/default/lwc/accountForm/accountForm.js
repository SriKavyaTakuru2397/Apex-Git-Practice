import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/AccountController.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountForm extends LightningElement {
    isFormVisible = true;
    accountName = '';
    phone = '';
    annualRevenue;

   
    showModalBox() {
        this.isFormVisible = true;
    }

 
    hideModalBox() {
        this.isFormVisible = false;
    }

   
    handleSubmit(event) {
        event.preventDefault();

        createAccount({ 
            accountName: this.accountName, 
            phone: this.phone, 
            annualRevenue: this.annualRevenue 
        })
        .then(accountId => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created successfully with ID ' + accountId,
                    variant: 'success'
                })
            );
            this.handleCancel(); 
            this.hideModalBox(); 
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating account',
                    message: error.body ? error.body.message : 'Unknown error',
                    variant: 'error'
                })
            );
        });
    }

    
    handleInputChange(event) {
        const field = event.target.name;

        if (field === 'accountName') {
            this.accountName = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        } else if (field === 'annualRevenue') {
            this.annualRevenue = parseFloat(event.target.value) || 0;
        }
    }

    
    handleCancel() {
        this.accountName = '';
        this.phone = '';
        this.annualRevenue = '';
        
    }
}
