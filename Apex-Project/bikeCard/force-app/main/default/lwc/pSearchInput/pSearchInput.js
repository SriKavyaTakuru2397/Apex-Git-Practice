import { LightningElement, api } from 'lwc';

export default class pSearchInput extends LightningElement {
    searchTerm = '';

    handleInputChange(event) {
        this.searchTerm = event.target.value;
    
        const searchEvent = new CustomEvent('search', {
            detail: this.searchTerm
        });
        this.dispatchEvent(searchEvent);
    }
}
