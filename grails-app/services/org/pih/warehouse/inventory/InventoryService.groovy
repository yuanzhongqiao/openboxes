package org.pih.warehouse.inventory;

import java.util.Map;

import org.pih.warehouse.inventory.Transaction;
import org.pih.warehouse.inventory.InventoryItem;
import org.pih.warehouse.inventory.Warehouse;
import org.pih.warehouse.product.Product;

class InventoryService {
	
	boolean transactional = true
	
	List<Warehouse> getAllWarehouses() {
		return Warehouse.list()
	}
	
	List<Transaction> getAllTransactions(Warehouse warehouse) {
		return Transaction.withCriteria { eq("thisWarehouse", warehouse) }
	}
	
	Inventory getInventory(Warehouse warehouse) {
		return Inventory.withCriteria { eq("warehouse", warehouse) }
	}
	
	Map getProductMap(Long id) { 		
		// Get a warehouse specific product map
		//def warehouse = Warehouse.get(id);		
		
		return Product.getAll().groupBy { it.productType } 
	}
	
	
	/**
	 * @param productId
	 * @return a list of inventory items 
	 */
	List getInventoryItemsByProduct(Product productInstance) { 
		if (!productInstance) 
			throw new Exception("errors.product.ProductNotFoundException")
		def results = InventoryItem.findAllByProduct(productInstance)					
		return results;
	}
	
	List getTransactionEntriesByProduct(Product productInstance) { 		
		def results = TransactionEntry.findAllByProduct(productInstance)		
		return results;
	}
	
	
	Map getInventoryMap(Long id) { 
		return Warehouse.get(id)?.inventory?.inventoryItems.groupBy { it.product } 
	}

	Map getInventoryLevelMap(Long id) { 
		return Warehouse.get(id)?.inventory?.inventoryLevels.groupBy { it.product } 
	}
		
	
	Warehouse getWarehouse(Long id) { 
		return Warehouse.get(id);
	}
}
