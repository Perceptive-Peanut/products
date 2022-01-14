const express = require('express');
const router = express.Router();
const {
    handleGetAllProducts,
    handleGetProductById,
    handleGetStylesByProductId,
    handleGetRelatedByProductId
} = require('../controllers/products');

router.get('/', handleGetAllProducts);
router.get('/:product_id', handleGetProductById);
router.get('/:product_id/styles', handleGetStylesByProductId);
router.get('/:product_id/related', handleGetRelatedByProductId);


module.exports = router;
