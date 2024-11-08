import { LightningElement, wire, api } from 'lwc';
import getContactsByAccountId from "@salesforce/apex/AccountContactTable.getContactsByAccountId";
// import getColumn from "@salesforce/apex/AccountContactTable.getColumn";

import { NavigationMixin } from 'lightning/navigation';

export default class contactsCustomDataTable extends NavigationMixin(LightningElement) {
      

    
    @api recordId; 
    contacts = [];
   
   columnMetaData=[];
    dataColumnLabels=[];
    totalContacts;
   
    
    tableColumns;
    ccon=[];
    isEditing=false;
  
  
  
    handleLinkClick(event) {
        const contactId = event.currentTarget.dataset.contactId; 
        console.log('contactId', contactId);
        
          
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: contactId,
                    actionName: 'view',
                    objectApiName : 'Contact'
                }
            });
        } 
        @wire(getContactsByAccountId, { accountId: '$recordId' })
        wiredContacts({ error, data }) {
            if (data) {
                console.log('data---',data);
                const metadataList = data[0].metadata;
                console.log('metadataList---',metadataList);
                this.columnMetaData = metadataList.map(meta => ({
                    columnName: meta.Column__c,
                    colAPIName: meta.Column_Api_Name__c
                }));
                metadataList.forEach(meta => {
                    console.log('Metadata Id:', meta.Id);
                });
                const contactList = data[1].contacts;
                console.log('contactList---',contactList);
                this.contacts = contactList;
                if (this.columnMetaData && this.contacts.length > 0) {
                    this.totalPages = Math.ceil(this.contacts.length / this.pageSize);
                    this.structuredData = this.contacts.map(contact => {
                        let contactObj = {};
                        contactObj.Id = contact.Id;
                        contactObj.record = this.buildRecord(contact);
                        return contactObj;
                    });
                    this.updatePaginatedContacts();
                }
            } else if (error) {
                console.error('Error fetching contacts or metadata:', error);
            }
        }
        buildRecord(contact) {
            return this.columnMetaData.map(column => {
                return contact[column.colAPIName];
            });
        }
    
    
    
    
    
        
        // updatePaginatedContacts() {
        //     // Pagination logic here
        // }
        
        
    // @wire (getColumn)
    // getData({ error, data }) {
    //     if (data) {
    //         this.tableColumns = data;
    //        // console.log('this.columns',this.columns);
    //     }
    //     // if (data) {
    //     //     this.tableColumns = data.map(column => ({
    //     //         label: column.Column__c,
    //     //         fieldApiName: column.Column_Api_Name__c
    //     //     }));
    //     //     console.log(this.tableColumns);
    //     // } else if (error) {
    //     //     console.error('Error fetching columns:', error);
    //     // }
    // }

    
    // handleEdit(event) {
    //     const contactId = event.target.dataset.contactId;
    //     console.log('contactId',contactId);
    //     const updatedContacts = this.contacts.map(contact => 
    //         contact.Id === contactId ? { ...contact, isEditing: true } : { ...contact, isEditing: false }
    //     );
        
    // }
    handleEdit(event){
        const contactId = event.target.dataset.contactId;
        console.log('contactId', contactId);
        
      
        this.contacts = this.contacts.map(contact => 
            contact.Id === contactId ? {...contact, isEditing: true } : { ...contact, isEditing: false }
        );
        console.log(`isEditing....`,isEditing);
        
        this.updatePaginatedContacts();
    }
    
    
    
    handleFieldChange(event) {
        const contactId = event.target.dataset.contactId;
        console.log('contactId-->',contactId);
        const field = event.target.dataset.field;
        console.log('field',field);
        const newValue = event.target.value;
        console.log('newValue',newValue);
       
        this.contacts = this.contacts.map(contact => 
            contact.Id === contactId ? { ...contact, [field]: newValue } : contact
        );
    }
    handleSave(event) {
        const contactId = event.target.dataset.contactId;
        const contactToUpdate = this.contacts.find(contact => contact.Id === contactId);
        if (contactToUpdate) {
            updateContacts({ contactsToUpdate: [contactToUpdate] })
                .then(() => {
                    
                    this.contacts = this.contacts.map(contact => 
                        contact.Id === contactId ? { ...contact, isEditing: false } : contact
                    );
                })
                .catch(error => {
                    console.error('Error updating contacts', error);
                });
        }
    }
    handleCancel(event) {
        const contactId = event.target.dataset.contactId;
        this.contacts = this.contacts.map(contact => 
            contact.Id === contactId ? { ...contact, isEditing: false } : contact
        );
    }

   
    updatePaginatedContacts() {
        const startIdx = (this.pageNumber - 1) * this.pageSize;
        console.log('startIdx',startIdx);
        const endIdx = startIdx + this.pageSize;
        console.log('endIdx',endIdx);
        this.paginatedContacts = this.structuredData.slice(startIdx, endIdx); 
        console.log(JSON.stringify(this.paginatedContacts));
    }
    get canGoToPreviousPage() {
        return this.pageNumber === 1;
    }

    get canGoToNextPage() {
        return this.pageNumber === this.totalPages;
    }

    
  handlePreviousPage() {
        if (this.pageNumber > 1) {
            
            this.pageNumber -= 1;
            this.updatePaginatedContacts();
            console.log('this.pageNumber------',this.pageNumber);
        }
      
    }

   


    handleNextPage() {
        console.log(this.totalPages,this.pageNumber);
        console.log('this.pageNumber',this.pageNumber < this.totalPages);
        
        if (this.pageNumber < this.totalPages) {
            this.pageNumber += 1;
            this.updatePaginatedContacts();
            console.log('this.pageNumber-++++-',this.pageNumber);
        }
    }
} 