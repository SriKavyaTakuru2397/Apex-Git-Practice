import { LightningElement, api, wire } from 'lwc';
import getRecords from '@salesforce/apex/RelatedAccountObjectsSelection.getRelatedObjectsById';

export default class PaccountsRelatedObjectCustomDataTable extends LightningElement {
    @api recordId; // The ID of the Account record
    selectedobj; // The object type selected from parent
    columnData = []; // To store column definitions
    allRowData = []; // To store all row data fetched
    displayedRowData = []; // To store currently displayed data
    pageSize = 5; // Number of rows to display per page
    pageNumber = 1; // Current page number
    totalPages; // Total number of pages
    isRecordsExist = false; // To check if records exist
    error; // To store error messages
    searchTerm = ''; // To store search query
    isMoreThanFiveRecords = false; // To check if more than five records exist
    isObjectSelected = false; // To check if an object is selected

    async handleParent(event) {
        this.selectedobj = event.detail;
        this.pageNumber = 1; // Reset page number when a new object is selected
        this.isObjectSelected = true;
        try {
            await this.fetchRecords();
        } catch (error) {
            console.error('Error in handleParent:', error);
        }
    }

    async fetchRecords() {
        try {
            // Fetch records using Apex method
            const data = await getRecords({
                accountId: this.recordId,
                selectedObject: this.selectedobj
            });

            console.log('Data:', JSON.stringify(data));

            // Check if metadata and relatedObjectRecords are valid
            if (data && data.metadata && data.relatedObjectRecords) {
                this.columnData = data.metadata.map(col => ({
                    label: col.Field_Config__r.Label,
                    fieldApi: col.Field_Config__r.Field_Api_Name__c
                }));
                console.log('ColumnData:', JSON.stringify(this.columnData));

                const recordsMap = data.relatedObjectRecords;
                this.allRowData = Object.keys(recordsMap).map(recordId => {
                    let obj = {
                        Id: recordId,
                        record: this.buildRecord(recordsMap[recordId]) // Build the record here
                    };
                    return obj;
                });
                console.log('allRowData:', JSON.stringify(this.allRowData));

                this.isRecordsExist = this.allRowData.length > 0;
                this.isMoreThanFiveRecords = this.allRowData.length > 5;
                this.totalPages = Math.ceil(this.allRowData.length / this.pageSize);

                // Update displayed records after fetching
                await this.updateDisplayedRecords();
            } else {
                console.error('Invalid data structure:', data);
                this.isRecordsExist = false;
            }
        } catch (error) {
            this.error = error;
            console.error('Error fetching records:', error);
        }
    }

    buildRecord(value) {
        // Build record array based on the selected columns
        let record = [];
        this.columnData.forEach(column => {
            record.push(value[column.fieldApi]); // Use fieldApi to access the record data
        });
        console.log('record-->', record);
        return record;
    }

    async updateDisplayedRecords() {
        try {
            const filteredData = this.searchTerm
                ? this.allRowData.filter(object => {
                    return object.record.some(value =>
                        String(value).toLowerCase().includes(this.searchTerm.toLowerCase())
                    );
                })
                : this.allRowData;

            const startIndex = (this.pageNumber - 1) * this.pageSize;
            const endIndex = this.pageNumber * this.pageSize;

            this.displayedRowData = filteredData.slice(startIndex, endIndex);
            this.totalPages = Math.ceil(filteredData.length / this.pageSize);
        } catch (error) {
            console.error('Error updating displayed records:', error);
        }
    }

    get isPreviousDisabled() {
        return this.pageNumber === 1;
    }

    handlePreviousPage() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.updateDisplayedRecords();
        }
    }

    get isNextDisabled() {
        return this.pageNumber === this.totalPages;
    }

    handleNextPage() {
        if (this.pageNumber < this.totalPages) {
            this.pageNumber++;
            this.updateDisplayedRecords();
        }
    }

    handleSearchTerm(event) {
        this.searchTerm = event.detail;
        this.pageNumber = 1; // Reset to the first page on search
        this.updateDisplayedRecords();
    }
}
