import { LightningElement, api, track, wire } from 'lwc';
import welcomeMessage from '@salesforce/apex/AH_HelloWorld.sayHello';
import getContacts from '@salesforce/apex/AH_HelloWorld.getContacts';
import getOpportunities from '@salesforce/apex/AH_HelloWorld.getOpps';

//It's extending another class called LightningElement which we are getting from the base library lwc
//lwc is a module provided by salesforce, which gives us basic classes and decorators that we can utilise and make LWC interactive and connect with Salesforce
//and some other APIs
export default class HelloWorld extends LightningElement {
    message =  '';
    error = '';
    accountId = '001QE000008erkCYAQ';
    salesforceContacts;
    isLoading = false;
    @api recordId; 
    // public variable, 
    // home page, app page, 
    // record page, experience cloud, flow
    
    // reactivenss - any changes made in the backend JavaScript class should refect in HTML
    // objects of object - persons = {{},{},{}}
    // array of object - contactList = [{},{},{}]
    // when using objects of object & array of object, use @track


    //The below variables are known as properties
    youtubeChannelName = 'Welcome to ApexHours!!';
    courseName = 'We are in Salesforce Lightning Web Component Crash Course';
    educator = 'Amit Singh';
    owner = 'Amit Choudhary';
    name;
    age = 30;
    isAdmin = true;
    isFree = true;
    //Anything starting with [] or {} are objects in Javascript
    //Use dot notatation to access object properties
    address = {
        street: '123 Main Street',
        city: 'ABC',
        state: 'UP',
        zip: 'Bharat'
    }
    /**
     pubic class Address{
        public String street;
        public String city;
        public String state; 
        public String zip;
     }
     Address add = new Address();
     add.street;
     * 
     */
    @track contactList = [
        { firstName: '', lastName: '', email: '', id: 1},
        { firstName: '', lastName: '', email: '', id: 3},
        { firstName: '', lastName: '', email: '', id: 2}
    ];
    
    /*
    @wire(welcomeMessage)
    apexData; // apexData: { data: Object, error: Object}
    // apexData: { data: String, error: Object}
    */
    
    @wire(welcomeMessage)
    wiredWelcomeMessage({data, error}){
        if (data) {
            console.log(data);
            this.message = data;
        }else if(error){
            this.error = JSON.stringify(error);
            console.error(error);
        }
    }
    
    @wire(welcomeMessage)
    wiredWelcomeMessage1(result){
        
        // local variables
        const {data, error} =  result; // {data, error} ~= variable deconstruction
        if (data) {
            //accessing class variables by using this keyword
            this.message = data;
        }else if(error){
            this.error = JSON.stringify(error);
            console.error(error);
        }
    }

    @wire (getContacts, {
        accountId: '$accountId',
        email : ''
    })
    wiredContacts(result){
        const {data, error} =  result; // {data, error} ~= variable deconstruction
        if (data) {
            console.log('Contact Data', data);
            this.salesforceContacts = JSON.parse(JSON.stringify(data)); //{...data}
            this.salesforceContacts.forEach((item)=>{
                console.log(item);
                item.Email = 'ryan@gmail.com';
            })
            console.log('salesforceContacts data', this.salesforceContacts);
        }else if(error){
            this.error = JSON.stringify(error);
            console.error(error);
        }    
    }

    handleClick(event){
        //event.preverntDefault();
        this.isLoading = true;
        let buttonComponent = event.currentTarget;
        let button = event.target;
        console.log(buttonComponent);
        console.log(button);
        //alert('Method Clicked!');
        getOpportunities()
        .then((result)=>{
            console.log('Opp Data ', result);
        })
        .catch((error)=>{
            console.error(error);
        })
        .finally(()=>{
            // this will always be executed
            // cleanup logic
            console.log('finally executed');
            this.isLoading = false;
        })
    }

    handleNav(event){
        event.preventDefauilt();
    }
} 