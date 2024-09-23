import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    while true {
        io:println("Welcome to the Shopping Service!");
        io:println("Please select your role: ");
        io:println("1. Admin");
        io:println("2. Customer");
        io:println("3. Exit");

        string userInput = check io:readln();
        int userRole = check int:fromString(userInput);

        if userRole == 1 {
            check adminOperations();
        } else if userRole == 2 {
            check customerOperations();
        } else if userRole == 3 {
            io:println("Exiting the Shopping Service. Goodbye!");
            break;
        } else {
            io:println("Invalid choice. Please try again.");
        }
    }
}


function adminOperations() returns error? {
    while true {
        io:println("\nAdmin Menu:");
        io:println("1. Add a product");
        io:println("2. Update a product");
        io:println("3. Remove a product");
        io:println("4. List available products");
        io:println("5. Go back to the main menu");

        string adminInput = check io:readln();
        int adminChoice = check int:fromString(adminInput);

        match adminChoice {
            1 => {
                Product addProductRequest = getProductInput();
                string addProductResponse = check ep->addProduct(addProductRequest);
                io:println("Add Product Response: ", addProductResponse);
            }
            2 => {
                Product updateProductRequest = getProductInput();
                Product updateProductResponse = check ep->updateProduct(updateProductRequest);
                io:println("Update Product Response: ", updateProductResponse);
            }
            3 => {
                io:println("Enter the name of the product you want to remove:");
                string removeProductName = check io:readln();
                ProductList removeProductResponse = check ep->removeProduct(removeProductName);
                io:println("Remove Product Response: ", removeProductResponse);
            }
            4 => {
                ProductList listAvailableProductsResponse = check ep->listAvailableProducts();
                if listAvailableProductsResponse.products.length() > 0 {
                    io:println("Available Products: ", listAvailableProductsResponse);
                } else {
                    io:println("No products available in the store.");
                }
                string _ = check io:readln();
            }
            5 => {
                return;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }

        io:println("Do you want to perform another admin operation? (y/n):");
        string continueAdmin = check io:readln();
        if continueAdmin.toLowerAscii() != "y" {
            break;
        }
    }
}


function customerOperations() returns error? {
    while true {
        io:println("\nCustomer Menu:");
        io:println("1. List available products");
        io:println("2. Search for a product by name");
        io:println("3. Add a product to cart");
        io:println("4. Place an order");
        io:println("5. Go back to the main menu");

        string customerInput = check io:readln();
        int customerChoice = check int:fromString(customerInput);

        match customerChoice {
            1 => {
                ProductList listAvailableProductsResponse = check ep->listAvailableProducts();
                if listAvailableProductsResponse.products.length() > 0 {
                    io:println("Available Products: ", listAvailableProductsResponse);
                } else {
                    io:println("No products available in the store.");
                }
                string _ = check io:readln();
            }
            2 => {
                while true {
                    io:println("Enter the name of the product to search:");
                    string searchProductName = check io:readln();
                    Product|error searchProductResponse = ep->searchProduct(searchProductName);
                    if searchProductResponse is Product {
                        io:println("Product found: ", searchProductResponse);
                    } else {
                        io:println("Product not found.");
                    }
                    io:println("Do you want to search again? (y/n):");
                    string searchAgain = check io:readln();
                    if searchAgain.toLowerAscii() != "y" {
                        break;
                    }
                }
            }
            3 => {
                io:println("Enter your user ID:");
                string customerId = check io:readln();
                io:println("Enter the name of the product to add to cart:");
                string cartProductName = check io:readln();
                CartItem addToCartRequest = {userId: customerId, sku: cartProductName};
                string addToCartResponse = check ep->addToCart(addToCartRequest);
                io:println("Add to Cart Response: ", addToCartResponse);
            }
            4 => {
                io:println("Enter your user ID:");
                string orderUserId = check io:readln();
                io:println("Enter the name of the product to order:");
                string orderProductName = check io:readln();
                Product orderProduct = {name: orderProductName, description: "", price: 0.0, stock_quantity: 0, sku: "", status: ""};
                Order placeOrderRequest = {userId: orderUserId, products: [orderProduct]};
                string placeOrderResponse = check ep->placeOrder(placeOrderRequest);
                io:println("Place Order Response: ", placeOrderResponse);
            }
            5 => {
                return;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }

        io:println("Do you want to perform another customer operation? (y/n):");
        string continueCustomer = check io:readln();
        if continueCustomer.toLowerAscii() != "y" {
            break;
        }
    }
}


function getProductInput() returns Product {
    io:println("Enter product name:");
    string productName = check io:readln();
    
    io:println("Enter product description:");
    string productDescription = check io:readln();
    
    io:println("Enter product price:");
    string priceInput = check io:readln();
    float productPrice = 0.0;
    var priceResult = float:fromString(priceInput);
    if priceResult is float {
        productPrice = priceResult;
    } else {
        io:println("Invalid price. Please enter a valid number.");
        return getProductInput();
    }
    
    io:println("Enter stock quantity:");
    string quantityInput = check io:readln();
    int productStockQuantity = 0;
    var quantityResult = int:fromString(quantityInput);
    if quantityResult is int {
        productStockQuantity = quantityResult;
    } else {
        io:println("Invalid quantity. Please enter a valid integer.");
        return getProductInput();
    }
    
    io:println("Enter product SKU:");
    string productSku = check io:readln();
    
    io:println("Enter product status (available/out_of_stock):");
    string productStatus = check io:readln();
    
    return {
        name: productName,
        description: productDescription,
        price: productPrice,
        stock_quantity: productStockQuantity,
        sku: productSku,
        status: productStatus
    };
}
