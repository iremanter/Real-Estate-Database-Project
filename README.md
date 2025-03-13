# Real-Estate-Database-Project

**DATABASE DESIGN FOR A REAL ESTATE AGENCY:**

The explanation of all attributes of all entities are provided below:

** Agents: **
- agent_id: This is the primary key for the “Agents” table. All entries of this attribute are unique and represent each agent in the real estate agency.
- name: This attribute stores the agent's full name.
- phone_number: This attribute stores the agent's contact number.
- email: This attribute stores the agent's email address.
Properties
- property_id: This is the primary key for the “Properties” table. All entries of this attribute are unique and represent each property in the real estate agency.
- address: This attribute stores the property's location.
- city: This attribute stores the city where the property is located.
- zip_code: This attribute stores the postal code of the property’s location.
- type_purpose: This attribute stores whether the property is for “Residential” or
“Commercial” use. These kinds of attributes are called enumeration (ENUM), which
indicates that the column has only specific values.
- type_property: This attribute stores whether the property is a “House” or “Apartment”
so, it’s also an ENUM field.
- price_sell: This attribute stores the selling price of the property.
- price_rent: This attribute stores the rental price of the property.
- status: This ENUM attribute stores the current availability status of the property, such as
“Available”, “Sold”, or “Rented”.
- listed_date: This attribute stores the date when the property was listed.
- agent_id: This is a foreign key that referencing the “Agents” table. This attribute shows
which agent is responsible for the property.

** Clients: **
- client_id: This is the primary key for the “Clients” table. All entries of this attribute are unique and represent each client.
- name: This attribute stores the client's full name.
- phone_number: This attribute stores the client's contact number.
- email: This attribute stores the client's email address.
- client_type: This ENUM attribute stores whether the client is “Buyer”, “Seller”,
“Tenant”, or “Landlord”.
Transactions
- transaction_id: This is the primary key for the “Transactions” table. All entries of this attribute are unique and represent each transaction.
- property_id: This is the foreign key of the “Properties” table. This shows which property is involved in the transaction.
- client_id: This is the foreign key of the “Clients” table. This shows which client is involved in the transaction.
- agent_id: This is the foreign key of the “Agents” table. This shows which agent is involved in the transaction.
- transaction_date: This attribute stores the dates when the transaction took place.
- transaction_amount: This attribute stores monetary values for the transaction of sales
and rents.
- transaction_type: This ENUM attribute stores whether the transaction is a “Sale” or a “Rent”.

**Relationships:**
- Properties and Agents: While each property is managed by a single agent, one agent can be responsible for more than one property. Therefore, the relationship is one-to-many and can be reached from the “Properties” table, where “agent_id” is the foreign key.
- Properties and Transactions : Each property can have multiple transactions such as “sold”,” rented”, or “listed”. The Foreign Key “property_id” in the “Transactions” table links each transaction to a specific property. The relationship is one-to-many.
- Clients and Transactions: A client can have multiple transactions, but each transaction involves a single client. The Foreign Key “client_id” in the “Transactions” table links each transaction to a specific client. Therefore, the relationship is one-to-many.
- Agents and Transactions: Only one agent can be responsible for each transaction, but an agent can perform multiple transactions. The Foreign Key “agent_id” in the “Transactions” table links each transaction to a specific agent. Therefore, the relationship is one-to-many.
  
**Key points of ER Design:**
Normalization: The database is normalized to the third normal form (3NF). In order to prevent redundancy, each component of data such as agent information, client information, transaction details and property information, is stored in seperate tables which are “Agents” table, “Clients” table, “Transaction” table and “Properties” table. Moreover, foreign keys are used to link between those tables without duplicating any entries.
Foreign Keys: Foreign key provides the ER design with consistency of the tables. For example, a transaction cannot be inserted to the table without a valid property, client, and agent because of the foreign key constraints. In short, foreign keys are crucial for data integrity.
ENUM Fields: The use of ENUM fields for attributes like type_purpose, type_property, status, and transaction_type ensure that only valid values can be inserted. 
Therefore, built-in data validation for specific fields has been provided.

**DATABASE IMPLEMENTATION:**
A database named “Berealty” has been created and all tables related to the real estate agency have been saved in this database. 
Agents table has been created by determining the length of each attribute and the primary key has been set.

Similarly, “Properties”, “Clients” and “Transactions” tables have been created by defining the attribute types and their lengths. Also, primary keys and the foreign keys have been set.

Similarly, all the entries of the attributes of “Properties”, “Clients” and “Transactions” tables have been inserted.

The information of the properties which are available have been listed by using the “ where status=’Available’ ” command line to show the potential properties to the future clients.

The SQL query retrieves property details such as address, city, and price from the “Properties” table. It has joined the “Agents” table by using “agent_id” and an inner join method has been applied to extract the entries which are common in both tables.

“Transaction” table has joined to this joined table and left join applied to retrieve the transaction information of the main table. After the joining part, the filter has been applied by using the “where status= ‘Available’ ” command to retrieve only available properties.

Another SQL query retrieves client information such as name, contact details, type from “Clients” table by left joining “Transaction” table on the client_id and adding transaction details if available.

The right join method has been applied to retrieve the property information of each agent. While the main table is the “Agents” table, the added table is the “Properties” table. 

“Transactions” and “Agents” tables have been joined.

The average selling price and average rental price for each type of property have been calculated using the AVERAGE and GROUP BY functions. As shown, the average selling prices of houses and apartments are 860.000 and 636.666 Euros, respectively, while the average rental prices for houses and apartments are 27.000 and 18.666 Euros, respectively.

After joining two tables which are “Clients” and “Transactions” tables, the sum of transaction amount and the number of transactions of each client type have been calculated by using SUM, COUNT and GROUP BY functions. In “Screenshot 26”, it is shown that while the transaction amounts of buyers, tenants and sellers are 2.188.000, 24.000 and 880.000 Euros respectively, the number of transactions of buyers, tenants and sellers are 4, 1 and 1 respectively.

The update_property_status trigger automatically updates the status of a property in the “Properties” table. 

When a new transaction is added with a type of either "Sell" or "Rent," the trigger changes the property’s status to "Sold" or "Rented" accordingly. 
The new property is inserted, and a new transaction involving this property is added. 

By comparing the property’s status before and after this transaction, it is shown that the status changed from "Available" to "Sold" due to the trigger function.

**CAP Theorem:**

The real estate database setup, system designers would likely focus on Availability and Partition Tolerance. In other words, even if there is a slight delay in updating information, property listings should always be accessible to the clients and agents. For example, the status of a property might take a little time to change to "Sold" in all systems, but the property listing will still be available for viewing because of the alignment with the CAP theorem.
