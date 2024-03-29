/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_kHnGWY5` ON `clientes` (`consecutivo`)"
  ]

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "xfk5xauv",
    "name": "consecutivo",
    "type": "number",
    "required": true,
    "presentable": true,
    "unique": false,
    "options": {
      "min": 1,
      "max": null,
      "noDecimal": true
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  collection.indexes = []

  // remove
  collection.schema.removeField("xfk5xauv")

  return dao.saveCollection(collection)
})
