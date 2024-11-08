import { LightningElement,api} from 'lwc';

export default class childComp extends LightningElement {
   @api message;  

   
    // handleInputChange(event) {
    //     this.message = event.target.value;  
    //     const messageEvent = new CustomEvent('messagechange', {
    //         detail: this.message 
    //     });

    //     this.dispatchEvent(messageEvent);
    // }
}
