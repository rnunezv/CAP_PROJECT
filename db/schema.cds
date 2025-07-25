namespace com.logali;


// Inclusion de Aspectos
using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';


// Definicion de tipos de datos
type decimal : Decimal(5, 3);


// Definicion de Entidades
entity Products : cuid, managed {
    product       : String(8);
    productName   : String(80);
    description   : LargeString;
    category      : Association to Categories;
    subCategory   : Association to SubCategories;
    status        : Association to Status; //stataus status_code
    price         : Decimal(8, 2);
    rating        : Decimal(3, 2);
    currency      : String;
    detail        : Association to ProductDetails; //detail  detail_ID
    supplier      : Association to Suppliers;
    toReviews     : Association to Reviews
                        on toReviews.product = $self;
    toInventories : Association to Inventories
                        on toInventories.product = $self;
    toSales       : Association to Sales
                        on toSales.product = $self;
};

entity Suppliers : cuid {
    supplier     : String(10);
    supplierName : String(40);
    webAddress   : String(250);
    contact      : Association to Contacts;
};

entity Contacts : cuid {
    fullName    : String(40);
    email       : String(80);
    phoneNumber : String(14);
};

entity Reviews : cuid {
    rating     : decimal(3, 2);
    date       : Date;
    reviewText : LargeString;
    user       : String(20);
    product    : Association to Products; // product_ID
};

entity Inventories : cuid {
    stockNumber : String(7);
    department  : Association to Departments;
    min         : Integer;
    max         : Integer;
    target      : Integer;
    quantity    : Decimal(4, 3);
    baseUnit    : String default 'EA';
    product     : Association to Products;
};

entity Sales : cuid {
    monthCode     : String(3);
    month         : String(20);
    quantitySales : Integer;
    year          : String(4);
    product       : Association to Products;
};


entity ProductDetails : cuid {
    baseUnit   : String default 'EA';
    width      : decimal;
    height     : decimal;
    depth      : decimal;
    weight     : decimal;
    unitVolume : String default 'CM';
    unitWeight : String default 'KG';
};

// Value Helps

entity Categories : cuid {
    category        : String(80);
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self;
};

entity SubCategories : cuid {
    subcategory : String(80);
    category    : Association to Categories; // category category_ID
};

entity Departments : cuid {
    department : String(40);
};


/**  Code List**/

/* criticatily */
// 1 = Rojo
// 2 = Amarillo
// 3 = Verde
entity Status : CodeList {
    key code        : String(20) enum {
            InStock = 'In Stock';
            OutOfStock = 'Out of Stock';
            LowAvailability = 'Low Availability';
        };
        criticality : Int16;
};
