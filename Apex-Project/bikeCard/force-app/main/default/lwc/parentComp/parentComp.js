import { LightningElement, track } from 'lwc';
export default class parentComp extends LightningElement {
    @track message = '';
    handleInputChange(event) {
        this.message = event.target.value;
    }
}