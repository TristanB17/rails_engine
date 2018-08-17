# Rails Engine - Tristan Bambauer & Lucas Alderfer
  - This repository is a versioned API that produces output in the form of JSON.  To access the JSON for a specific endpoint the user must clone this repository and follow the directions below to instantiate the database, import the data, and host the API on a local server.This repository is designed to conduct business intelligence using objects seeded in the database from a collection of CSVs containing Customers, Merchants, Invoices, Items, Invoice Items and Transactions.

* Ruby version: 2.4.1
* Rails version: 5.1.6

* Database: Postgresql

* Database initialization:
  - Please use the `bundle` command in the terminal while in the project directory, after cloning this repository, to ensure the local environment will not be in conflict with any required gems or  gem versions.
  - The following command will both run the import command and set up the database: `rake db:{drop,create,migrate} && rake import_csv_data:all`
  - The rake command following the ampersands(`rake import_csv_data:all`) seeds objects into database from CSVs in the CSV folder.

* Database Information
  - Each object type contains timestamp attributes corresponding to their respective created and last updated date-times.
  - Each object type is created with a unique id (:id).
  - Customer objects are created with a first name (:first_name), and a last name (:last_name).
    + Customers have a direct relationship to both invoices and transactions and these relationships can be viewed through relationship endpoints.
  - Merchant objects are created with a name (:name).
    + Merchants have a direct relationship to both invoices and items and these relationships can be viewed through relationship endpoints.
  - Item objects are created with a name (:name), a description (:description), a unit price, meant to serve as a standard price for the item, but unit prices in a sale are derived from the invoice item for that invoice (:unit_price), and a merchant id, which corresponds to the unique id for the merchant selling that item (:merchant_id).
    + Items have a direct relationship to both invoice items and merchants and these relationships can be viewed through relationship endpoints.
  - Invoice objects are created with a unique customer id corresponding to the customer making the purchase (:customer_id), a unique merchant id corresponding to the merchant making the sale for this invoice (:merchant_id), and a status indicating the stage of completion for the invoice (:status).
    + Invoices have a direct relationship to invoice items, a merchant, a customer, items, and transactions and these relationships can be viewed through relationship endpoints.
  - Invoice Item objects are a joining object for invoices and items, and therefore are created with a unique invoice id corresponding to the invoice that this invoice item is on (:invoice_id), a unique item id corresponding to the item that is being sold (:item_id), a unit price indicating the price that each instance of the item was sold for at this time, not to be confused with the unit price from the item object (:unit_price), and a quantity indicating how many of the item was sold on the invoice at the given unit price (:quantity).
    + Invoice Items have a direct relationship to both an invoice, and an item and these relationships can be viewed through relationship endpoints.
  - Transaction objects are created with an invoice id corresponding to a unique invoice (:invoice_id), a credit card number (:credit_card_number), a credit card expiration date (:credit_card_expiration_date), and a result, indicating whether the transaction was successful or a failure (:result)
    + Transactions have a direct relationship to an invoice and this relationship can be viewed through a relationship endpoint.


* Hosting a local server
  - After setting up the database and importing the data, run the terminal command `rails s` which will locally host a server from which this API can be accessed through a browser on one's machine.  This server will be accessible through any browser at http://localhost:3000/.

  - By appending the following URIs to the localhost url provided above, one can visit a page displaying the corresponding JSON output:
    + /api/v1/merchants - This page displays all merchants
    + /api/v1/merchants/1 - This page displays the information for a specific merchant
    + /api/v1/merchants/find?**parameters** - In the place of **parameters** one can place any attribute of the merchant object to search the merchants by that attribute and value ('/api/v1/merchants/find?name=bobs burgers' would display JSON data for a merchant with the name 'bobs burgers')
    + /api/v1/merchants/find_all?**parameters** - This URI type functions the same way as the above type, however it returns JSON data for any and all objects of the provided type (here merchants) that meet the given parameters.
    + api/v1/merchants/random - This page displays JSON data for a random merchant.

     - The above 5 URIs are examples of the record endpoints for the merchant object type, and can be used for customers, invoices, items, invoice items, and transactions in the same fashion.

    + Object relationships can also be specified by providing an object's Id in the URI followed by the type of object relationship desired. (/api/v1/merchants/1/items would display item data for all items of the merchant with an Id of 1)


    + Business Intelligence Endpoints are outlined below:

      - /api/v1/merchants/most_revenue?quantity=x
        + This URI returns the top x merchants ranked by total revenue.

      - /api/v1/merchants/most_items?quantity=x
        + This URI returns the top x merchants ranked by total number of items sold.

      - /api/v1/merchants/revenue?date=x
        + This URI returns the total revenue for date x across all merchants.  The dates are formatted as 'YYYY-MM-DD'.

      - /api/v1/merchants/:id/revenue
        + This URI returns the total revenue for that merchant across successful transactions.

      - /api/v1/merchants/:id/revenue?date=x
        + This URI returns the total revenue for that merchant for a specific invoice date x.  The dates are formatted as 'YYYY-MM-DD'.

      - /api/v1/merchants/:id/favorite_customer
        + This URI returns the customer who has conducted the most total number of successful transactions.

      - /api/v1/merchants/:id/customers_with_pending_invoices
        + This URI returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of success. This means all transactions are failed.

      - /api/v1/items/most_revenue?quantity=x
        + This URI returns the top x items ranked by total revenue generated.

      - /api/v1/items/most_items?quantity=x
        + This URI returns the top x item instances ranked by total number sold.

      - /api/v1/items/:id/best_day
        + This URI returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

      - /api/v1/customers/:id/favorite_merchant
        + This URI returns a merchant where the customer has conducted the most successful transactions.
