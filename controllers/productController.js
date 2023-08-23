const Product = require('../models/product.model')
const User = require('../models/user.model');

class productController {
    static async getProducts(req, res, next){
        //getting all products 
        try {
            const products = await Product.find()
            res.status(200).json(products)
        }
        catch(err){
            res.status(500).json({message: err.message});
        }
    }
    static async addCart(req, res, next){
        //adding product id into the user's product list array of user
        try {
            const user = User.findOne({userId: req.body.userId})
            user.products.push(req.body.productId)
            await user.save()
            res.status(200).json({message: "Product added to cart"})
        }
        catch(err){
            res.status(500).json({message: err.message});
        }
    }

}

module.exports = productController;


