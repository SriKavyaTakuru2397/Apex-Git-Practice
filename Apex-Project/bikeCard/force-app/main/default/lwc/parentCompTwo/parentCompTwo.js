import { LightningElement } from 'lwc';
export default class parentCompTwo extends LightningElement {
    resetChildForm() {
        this.template.querySelector('c-child-comp-two').resetForm();
    }
}
