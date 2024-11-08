import { LightningElement } from 'lwc';

export default class objectDropdownSelectionForm extends LightningElement {
    value=' ';
    get options() {
        return [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        const eventVar = new CustomEvent('selected', {
            detail: this.value,
        });
        this.dispatchEvent(eventVar);
        
    }
    
}