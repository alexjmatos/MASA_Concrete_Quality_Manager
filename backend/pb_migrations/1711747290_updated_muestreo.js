/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r6p9bzfjtrs50xk")

  // remove
  collection.schema.removeField("eqxkzpld")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ohjdtxor",
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
  const collection = dao.findCollectionByNameOrId("r6p9bzfjtrs50xk")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "eqxkzpld",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "ry2mslmjxy6sorn",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // remove
  collection.schema.removeField("ohjdtxor")

  return dao.saveCollection(collection)
})
