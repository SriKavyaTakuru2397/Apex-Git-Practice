import { LightningElement, wire } from 'lwc';
import createOpportunity from '@salesforce/apex/OpportunityController.createOpportunity';
import getAccounts from '@salesforce/apex/OpportunityController.getAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OpportunityForm extends LightningElement {
    isFormVisible = true;
    opportunityName = '';
    closeDate = '';
    stage = '--None--';
    accountId = '';
    accountOptions = [];

  
    get stageOptions() {
        return [
            { label: '--None--', value: '--None--' },
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            { label: 'Needs Analysis', value: 'Needs Analysis' },
            { label: 'Value Proposition', value: 'Value Proposition' },
            { label: 'Id.Decision Makers', value: 'Id.Decision Makers' },
            { label: 'Perception Analysis', value: 'Perception Analysis' },
            { label: 'Proposal/Price Quote', value: 'Proposal/Price Quote' },
            { label: 'Negotiation/Review', value: 'Negotiation/Review' },
            { label: 'Closed Won', value: 'Closed Won' },
            { label: 'Closed Lost', value: 'Closed Lost' },
        ];
    }

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
        const accountIdToSend = this.accountId === '' ? null : this.accountId;


        createOpportunity({
            opportunityName: this.opportunityName,
            closeDate: this.closeDate,
            stage: this.stage,
            accountId: accountIdToSend
        })
        .then(opportunityId => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity created successfully with ID ' + opportunityId,
                    variant: 'success'
                })
            );
            this.handleCancel(); 
            this.hideModalBox(); 
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating opportunity',
                    message: error.body ? error.body.message : 'Unknown error',
                    variant: 'error'
                })
            );
        });
    }

    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'opportunityName') {
            this.opportunityName = event.target.value;
        } else if (field === 'closeDate') {
            this.closeDate = event.target.value;
        } else if (field === 'accountId') {
            this.accountId = event.target.value;
        }
    }

    handleStageChange(event) {
        this.stage = event.detail.value;
    }

    // handleCancel() {
    //     this.opportunityName = '';
    //     this.closeDate = '';
    //     this.stage = '';
    //     this.accountId = '';
    //     // this.hideModalBox();
    // }
    handleCancel() {
        this.opportunityName = '';
        this.closeDate = '';
        this.stage = '--None--';  // Reset stage to default
        this.accountId = '';
    
        // Clear the date input in the template
        const dateInput = this.template.querySelector('lightning-input[data-id="closeDate"]');
        if (dateInput) {
            dateInput.value = '';  // Reset the date field
        }
    }
    
}
