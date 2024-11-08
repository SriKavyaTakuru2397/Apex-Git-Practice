import { LightningElement, api } from 'lwc';


export default class accountsRelatedObjectCustomDataTable extends LightningElement {
    value = ' ';
    // @api isLoaded='false';
    get options(){
       return [
           {label : 'Contact'  , value : 'Contact'},
           {label : 'Case'  ,  value : 'Case'},
           {label : 'Opportunity' , value : 'Opportunity'}
       ];
    }
    handleChange(event){
       this.value = event.detail.value;
      const sendRes  = new CustomEvent("parent" , { detail : this.value });
       this.dispatchEvent(sendRes);
   }
//    toggle(){
//     this.isLoaded=!this.isLoaded;
//    }

}
