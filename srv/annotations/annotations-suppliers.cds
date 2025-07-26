using {ProductSRV as services} from '../service';


annotate services.Suppliers with {
    @title : 'Suppliers'
    ID @Common : {  
        Text : supplierName,
        TextArrangement : #TextOnly,
    }
};

