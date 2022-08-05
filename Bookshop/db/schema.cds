using {
    Currency,
    managed,
    sap
} from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Books : managed {
    key ID       : Integer;
        title    : localized String(111);
        descr    : localized String(1111);
        author   : Association to Authors;
        genre    : Association to Genres;
        stock    : Integer;
        price    : Decimal;
        currency : Currency;
        image    : LargeBinary @Core.MediaType : 'image/png';
}

//  remarks
entity Authors : managed {
    key ID           : Integer;
        name         : String(111);
        dateOfBirth  : Date;
        dateOfDeath  : Date;
        placeOfBirth : String;
        placeOfDeath : String;
        books        : Association to many Books
                           on books.author = $self;
}

/**
 * Hierarchically organized Code List for Genres
 */
entity Genres : sap.common.CodeList {
    key ID       : Integer;
        parent   : Association to Genres;
        children : Composition of many Genres
                       on children.parent = $self;
}

entity Orders : managed {
    key ID      : UUID;
        OrderNo : String @title : 'Order Number';
        Items   : Composition of many OrderItems
                      on Items.parent = $self;
}

entity OrderItems {
    key ID     : UUID;
        parent : Association to Orders;
        book   : Association to Books;
        amount : Integer;
}

entity Movies {
    key ID : UUID;
}
