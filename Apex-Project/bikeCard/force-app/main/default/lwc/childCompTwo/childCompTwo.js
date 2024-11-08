import { LightningElement , api} from 'lwc';
export default class childCompTwo extends LightningElement {
    name = '';
    email = '';
    @api resetForm() { 
        this.name = '';
        this.email = '';
    }
    handleNameChange(event) {
        this.name = event.target.value;
    }
    handleEmailChange(event) {
        this.email = event.target.value;
    }
}
