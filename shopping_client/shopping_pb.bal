import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128025205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A06737461747573180620012809520673746174757322540A045573657212160A06757365724964180120012809520675736572496412120A046E616D6518022001280952046E616D6512200A0B6163636F756E7454797065180320012809520B6163636F756E745479706522340A08436172744974656D12160A06757365724964180120012809520675736572496412100A03736B751802200128095203736B7522450A054F7264657212160A06757365724964180120012809520675736572496412240A0870726F647563747318022003280B32082E50726F64756374520870726F647563747322330A0B50726F647563744C69737412240A0870726F647563747318012003280B32082E50726F64756374520870726F647563747332A7030A0F53686F7070696E675365727669636512340A0A61646450726F6475637412082E50726F647563741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512230A0D75706461746550726F6475637412082E50726F647563741A082E50726F64756374123B0A0D72656D6F766550726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0C2E50726F647563744C697374123D0A156C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A0C2E50726F647563744C697374121A0A0A6372656174655573657212052E557365721A052E5573657212370A0D73656172636850726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A082E50726F6475637412340A09616464546F4361727412092E436172744974656D1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512320A0A706C6163654F7264657212062E4F726465721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function addProduct(Product|ContextProduct req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addProductContext(Product|ContextProduct req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function updateProduct(Product|ContextProduct req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function updateProductContext(Product|ContextProduct req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function removeProduct(string|wrappers:ContextString req) returns ProductList|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function removeProductContext(string|wrappers:ContextString req) returns ContextProductList|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function listAvailableProducts() returns ProductList|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function listAvailableProductsContext() returns ContextProductList|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function createUser(User|ContextUser req) returns User|grpc:Error {
        map<string|string[]> headers = {};
        User message;
        if req is ContextUser {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/createUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <User>result;
    }

    isolated remote function createUserContext(User|ContextUser req) returns ContextUser|grpc:Error {
        map<string|string[]> headers = {};
        User message;
        if req is ContextUser {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/createUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <User>result, headers: respHeaders};
    }

    isolated remote function searchProduct(string|wrappers:ContextString req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function searchProductContext(string|wrappers:ContextString req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function addToCart(CartItem|ContextCartItem req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        CartItem message;
        if req is ContextCartItem {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addToCartContext(CartItem|ContextCartItem req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        CartItem message;
        if req is ContextCartItem {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function placeOrder(Order|ContextOrder req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        Order message;
        if req is ContextOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function placeOrderContext(Order|ContextOrder req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        Order message;
        if req is ContextOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }
}

public type ContextProductList record {|
    ProductList content;
    map<string|string[]> headers;
|};

public type ContextOrder record {|
    Order content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextCartItem record {|
    CartItem content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Order record {|
    string userId = "";
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductList record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type User record {|
    string userId = "";
    string name = "";
    string accountType = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartItem record {|
    string userId = "";
    string sku = "";
|};

