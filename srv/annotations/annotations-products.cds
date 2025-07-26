using {ProductSRV as services} from '../service';


// Alias cabecera de campos
annotate services.Products with {
    product     @title: 'Product';
    productName @title: 'Product Name';
    description @title: 'Description';
    category    @title: 'Category';
    subCategory @title: 'Sub-Cartegory';
    status      @title: 'Status';
    price       @title: 'Price'     @Measures.ISOCurrency: currency;
    rating      @title: 'Average Rating';
    currency    @title: 'Currency'  @Common.IsCurrency;
    supplier    @title: 'Supplier';

};

// Common
annotate services.Products with {
    status      @Common: {
        Text           : status.name,
        TextArrangement: #TextOnly,
    };

    supplier    @Common: {
        Text           : supplier.supplierName,
        TextArrangement: #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
    };

    category    @Common: {
        Text           : category.category,
        TextArrangement: #TextOnly,
    };

    subCategory @Common: {
        Text           : subCategory.subcategory,
        TextArrangement: #TextOnly,
    };

};


// Anotaciones para los campos
annotate services.Products with @(

    Capabilities.FilterRestrictions: {
        $Type : 'Capabilities.FilterRestrictionsType',
        FilterExpressionRestrictions : [
            {
                $Type : 'Capabilities.FilterExpressionRestrictionType',
                Property : productName,
                AllowedExpressions : product,
            },
        ],
    },

    // Filtros 
    UI.SelectionFields: [
        product,
        productName,
        supplier_ID,
        category_ID,
        subCategory_ID,
        status_code
    ],

    // Cabecera
    UI.HeaderInfo       : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Product',
        TypeNamePlural: 'Products'
    },

    UI.LineItem         : [
        {
            $Type: 'UI.DataField',
            Value: product
        },
        {

            $Type: 'UI.DataField',
            Value: productName
        },
        {
            $Type: 'UI.DataField',
            Value: supplier_ID
        },
        {
            $Type: 'UI.DataField',
            Value: category_ID
        },
        {
            $Type: 'UI.DataField',
            Value: subCategory_ID
        },
        {
            $Type                : 'UI.DataFieldForAnnotation',
            Target               : '@UI.DataPoint#Rating',
            Label                : 'Rating',
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : status_code,
            Criticality          : status.criticality,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : price,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            },
        }
    ],

    UI.DataPoint #Rating: {
        $Type        : 'UI.DataPointType',
        Value        : rating,
        Visualization: #Rating,
    }

);
