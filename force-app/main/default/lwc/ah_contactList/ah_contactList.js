import { LightningElement, track } from 'lwc';

export default class Ah_contactList extends LightningElement {

    @track contacts=[
        {
          "location": "9617 tara street, dublin, westmeath, 66909",
          // con.address = {}
          // con.address.street = 9617 tara street
          "address":{
            "street":"9617 tara street",
            "city":"dublin",
            "state":"westmeath",
            "postalCode":"66909"
          },
          "email": "britney.sims@example.com",
          // con.address =  [ variable environment ]
          // con.address.street ~= undefined.street === Error 
          "cell": "881-136-4597",
          "picture": "https://randomuser.me/api/portraits/women/62.jpg",
          "id": 1,
          "first_name": "britney",
          "last_name": "sims"
        },
        {
          "location": "7394 durham street, dunedin, canterbury, 21471",
          "email": "imogen.edwards@example.com",
          "cell": "(283)-969-5160",
          "picture": "https://randomuser.me/api/portraits/women/95.jpg",
          "id": 2,
          "first_name": "imogen",
          "last_name": "edwards"
        },
        {
          "location": "1317 ormond quay, ballinasloe, cork city, 87859",
          "email": "lillian.simmons@example.com",
          "cell": "801-513-7697",
          "picture": "https://randomuser.me/api/portraits/women/74.jpg",
          "id": 3,
          "first_name": "lillian",
          "last_name": "simmons"
        },
        {
          "location": "3685 the grove, city of london, humberside, H4C 6ES",
          "email": "jessica.torres@example.com",
          "cell": "0731-375-908",
          "picture": "https://randomuser.me/api/portraits/women/63.jpg",
          "id": 4,
          "first_name": "jessica",
          "last_name": "torres"
        },
        {
          "location": "5568 calle de tetuán, lorca, navarra, 40670",
          "email": "noelia.suarez@example.com",
          "cell": "662-049-873",
          "picture": "https://randomuser.me/api/portraits/women/82.jpg",
          "id": 5,
          "first_name": "noelia",
          "last_name": "suarez"
        },
        {
          "location": "goethestraße 171, heitersheim, thüringen, 83070",
          "email": "susanna.nast@example.com",
          "cell": "0179-7114996",
          "picture": "https://randomuser.me/api/portraits/women/39.jpg",
          "id": 6,
          "first_name": "susanna",
          "last_name": "nast"
        },
        {
          "location": "rosenweg 112, erfurt, berlin, 96006",
          "email": "christa.lehmann@example.com",
          "cell": "0162-2134865",
          "picture": "https://randomuser.me/api/portraits/women/2.jpg",
          "id": 7,
          "first_name": "christa",
          "last_name": "lehmann"
        }
      ]
      
}
